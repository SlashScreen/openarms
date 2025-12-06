package main

// The renderer. Handles render queue, drawing to a render texture, and renderer asset management.
// Does not present to screen.

import c "core:c"
import queue "core:container/queue"
import sm "slot_map"
import rl "vendor:raylib"

Color :: rl.Color

Resource :: union {
	Mesh,
	Model,
	Material,
	Texture,
}

Mesh :: rl.Mesh
Model :: rl.Model
Material :: rl.Material
Texture :: rl.Texture2D

ResourceID :: distinct sm.Key(uint, 32, 32)
BatchKey :: struct {
	mesh :     ResourceID,
	material : ResourceID,
}
BatchEntry :: struct {
	mesh :      ResourceID,
	material :  ResourceID,
	positions : [dynamic]rl.Matrix,
}

RenderCommand3D :: union {
	DrawMesh,
	DrawWireCube,
}

DrawMesh :: struct {
	mesh :           ResourceID,
	material :       ResourceID,
	transform :      Transform,
	use_instancing : bool,
}

DrawWireCube :: struct {
	position : Vec3,
	extents :  Vec3,
	color :    Color,
}

cameras_3d : [dynamic]rl.Camera3D
main_camera : uint
render_queue_3D : queue.Queue(RenderCommand3D)
resources : sm.DynamicSlotMap(Resource, ResourceID)
render_texture : rl.RenderTexture2D
batch_map : map[BatchKey]BatchEntry

// Builtins

MISSING_TEXTURE_FP :: "missing_texture.png"
missing_texture : ResourceID
INSTANCING_WORKS :: false

renderer_init :: proc(w, h : uint) {
	render_texture = rl.LoadRenderTexture(c.int(w), c.int(h))
	cameras_3d = make([dynamic]rl.Camera3D)
	resources = sm.dynamic_slot_map_make(Resource, ResourceID)
	queue.init(&render_queue_3D)

	append(
		&cameras_3d,
		rl.Camera3D {
			Vec3{10.0, 10.0, 10.0},
			Vec3{0.0, 0.0, 0.0},
			Vec3{0.0, 1.0, 0.0},
			45.0,
			.PERSPECTIVE,
		},
	)
	main_camera = 0

	batch_map = make(map[BatchKey]BatchEntry)
	subscribe("enqueue_3D", NIL_USERDATA, renderer_enqueue_3D)

	load_builtin_resources()
}

renderer_deinit :: proc() {
	rl.UnloadTexture(render_texture.texture)
	delete(cameras_3d)

	for i := resources.size; i > 0; i -= 1 do resource_destroy(resources.keys[i])

	sm.dynamic_slot_map_delete(&resources)

	for _, v in batch_map {
		delete(v.positions)
	}
	delete(batch_map)

	queue.destroy(&render_queue_3D)
}

renderer_enqueue_3D :: proc(_ : ^int, command : ^RenderCommand3D) {
	if ok, err := queue.enqueue(&render_queue_3D, command^); !ok {
		log_err("[RENDERER] enqueue error: %q", err)
	}
}

unwrap_resource_handle :: proc(id : ResourceID) -> (^Resource, bool) #optional_ok {
	return sm.dynamic_slot_map_get_ptr(&resources, id)
}

resource_destroy :: proc(id : ResourceID) {
	res, ok := sm.dynamic_slot_map_get_ptr(&resources, id)
	if !ok do return

	switch r in res {
	case Texture:
		rl.UnloadTexture(r)
	case Mesh:
		rl.UnloadMesh(r)
	case Material:
		rl.UnloadMaterial(r)
	case Model:
		rl.UnloadModel(r)
	}

	sm.dynamic_slot_map_remove(&resources, id)
}

// Resources

load_builtin_resources :: proc() {
	image := asset_db_load_image(MISSING_TEXTURE_FP)
	defer asset_destroy(image)

	tex, ok := create_texture_from_image(image)
	assert(ok)
	missing_texture = tex
}

create_texture_from_image :: proc(asset_id : AssetID) -> (ResourceID, bool) #optional_ok {
	handle, ok := unwrap_asset_handle(asset_id)
	if !ok {
		log_err("tried to use an invalid asset to create a texture: %v", asset_id)
		return ResourceID{}, false
	}
	#partial switch asset in handle {
	case Image:
		tex := rl.LoadTextureFromImage(asset)
		tex_key, tok := sm.dynamic_slot_map_insert_set(&resources, tex)
		if !tok {
			log_err("out of memory inserting texture from image")
			return ResourceID{}, false
		}
		return tex_key, true
	case:
		log_err("tried to use a non-image asset to create a texture: %v", asset_id)
		return ResourceID{}, false
	}
}

create_cube_mesh :: proc(extents : Vec3) -> (ResourceID, bool) #optional_ok {
	mesh := rl.GenMeshCube(extents.x, extents.y, extents.z)
	res : Resource = mesh
	return sm.dynamic_slot_map_insert_set(&resources, res)
}

create_heightmap_mesh :: proc(
	heightmap : AssetID,
	bounds : Vec3,
) -> (
	ResourceID,
	bool,
) #optional_ok {
	hmap_image, ok := unwrap_asset_handle(heightmap).(Image)
	if !ok do return ResourceID{}, false

	mesh := rl.GenMeshHeightmap(hmap_image, bounds)
	res : Resource = mesh
	return sm.dynamic_slot_map_insert_set(&resources, res)
}

create_material_default :: proc() -> (ResourceID, bool) #optional_ok {
	mat := rl.LoadMaterialDefault()
	res : Resource = mat
	return sm.dynamic_slot_map_insert_set(&resources, res)
}

// Consumes mesh
create_model_from_mesh :: proc(
	mesh : ResourceID,
	consumes_mesh : bool = true,
) -> (
	ResourceID,
	bool,
) #optional_ok {
	res, ok_a := sm.dynamic_slot_map_get_ptr(&resources, mesh)
	if !ok_a {
		log_err("Cannot create a model from an invalid ID")
		return ResourceID{}, false
	}
	mesh_data, ok_b := res.(Mesh)
	if !ok_b {
		log_err("Cannot create a model from a non-mesh resources")
		return ResourceID{}, false
	}

	if consumes_mesh do sm.dynamic_slot_map_remove(&resources, mesh)

	mdl := rl.LoadModelFromMesh(mesh_data)
	resource : Resource
	resource = mdl
	return sm.dynamic_slot_map_insert_set(&resources, resource)
}

// Modifying

set_material_albedo :: proc(material, texture : ResourceID) -> bool {
	res, r_ok := sm.dynamic_slot_map_get_ptr(&resources, material)
	if !r_ok {
		log_err("Unknown asset with ID %v", material)
		return false
	}
	mat, m_ok := (&res.(Material))
	if !m_ok {
		log_err("Asset with ID %v not a material", material)
		return false
	}

	if tex_res, tr_ok := sm.dynamic_slot_map_get(&resources, texture); tr_ok {
		tex, t_ok := tex_res.(Texture)
		if t_ok {
			log("Setting texture to ID. %v", texture)
			rl.SetMaterialTexture(mat, .ALBEDO, tex)
		} else {
			log_warn("Asset with ID %v not a texture, replacing with missing texture", texture)
			tex = sm.dynamic_slot_map_get(&resources, missing_texture).(Texture)
			rl.SetMaterialTexture(mat, .ALBEDO, tex)
		}
	} else {
		log_warn("Unknown asset with ID %v, replacing with missing texture", texture)
		tex := sm.dynamic_slot_map_get(&resources, missing_texture).(Texture)
		rl.SetMaterialTexture(mat, .ALBEDO, tex)
	}
	return true
}

set_material_color :: proc(material : ResourceID, color : Color) -> bool {
	res := sm.dynamic_slot_map_get_ptr(&resources, material) or_return
	mat := (&res.(Material)) or_return

	mat.maps[rl.MaterialMapIndex.ALBEDO].color = color

	return true
}

// Drawing

draw :: proc() {
	rl.BeginTextureMode(render_texture)
	{
		rl.ClearBackground(rl.WHITE)
		draw_3d()
	}
	rl.EndTextureMode()

	broadcast("render_texture_present", &render_texture)
}

draw_3d :: proc() {
	rl.UpdateCamera(&cameras_3d[main_camera], .ORBITAL)

	rl.BeginMode3D(cameras_3d[main_camera])
	{
		for command, ok := queue.pop_front_safe(&render_queue_3D);
		    ok;
		    command, ok = queue.pop_front_safe(&render_queue_3D) {
			switch com in command {
			case DrawMesh:
				if com.use_instancing {
					// This does rudimentary batching
					b_key := BatchKey{com.mesh, com.material}

					if entry, ok := &batch_map[b_key]; ok {
						append(&entry.positions, (rl.Matrix)(com.transform))
					} else {
						entry := BatchEntry{com.mesh, com.material, make([dynamic]rl.Matrix)}

						append(&entry.positions, (rl.Matrix)(com.transform))
						batch_map[b_key] = entry
					}
				} else {
					mesh, msh_ok := sm.dynamic_slot_map_get_ptr(&resources, com.mesh)
					if !msh_ok {
						log_err("Unable to fetch mesh with id %v", com.mesh)
						continue
					}
					material, mat_ok := sm.dynamic_slot_map_get_ptr(&resources, com.material)
					if !mat_ok {
						log_err("Unable to fetch material with id %v", com.material)
						continue
					}
					rl.DrawMesh(mesh^.(Mesh), material^.(Material), (rl.Matrix)(com.transform))
				}
			case DrawWireCube:
				rl.DrawCubeWiresV(com.position, com.extents, com.color)
			case:
				log_warn(
					"Unknown command %s. Are you constructing the command properly?",
					typeid_of(type_of(com)),
				)
			}
		}

		for _, &v in batch_map {
			mesh := sm.dynamic_slot_map_get_ptr(&resources, v.mesh) or_continue
			material := sm.dynamic_slot_map_get_ptr(&resources, v.material) or_continue
			when INSTANCING_WORKS {
				rl.DrawMeshInstanced(
					mesh^.(Mesh),
					material^.(Material),
					raw_data(v.positions),
					c.int(len(v.positions)),
				)
			} else {
				//Instancing is bugged rn
				for t in v.positions {
					rl.DrawMesh(mesh^.(Mesh), material^.(Material), t)
				}
			}
			clear_dynamic_array(&v.positions)
		}

		rl.DrawGrid(16, 1.0)
	}
	rl.EndMode3D()
}

// Utils

get_screen_dimensions :: proc() -> [2]int {
	return [2]int{int(rl.GetScreenWidth()), int(rl.GetScreenWidth())}
}

get_main_camera :: proc() -> ^rl.Camera3D {
	return &cameras_3d[main_camera]
}

get_camera_forward :: rl.GetCameraForward

get_screen_to_world_ray :: rl.GetScreenToWorldRay

get_world_to_screen :: rl.GetWorldToScreen

