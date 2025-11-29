package client

import cm "../common"
import sm "../slot_map"
import c "core:c"
import queue "core:container/queue"
import "core:fmt"
import la "core:math/linalg"
import "core:mem/virtual"
import rl "vendor:raylib"

Color :: rl.Color

Resource :: union {
	Mesh,
	Model,
	Material,
}

Mesh :: rl.Mesh
Model :: rl.Model
Material :: rl.Material

ResourceID :: distinct sm.Key(uint, 32, 32)
BatchKey :: struct {
	mesh:     ResourceID,
	material: ResourceID,
}
BatchEntry :: struct {
	mesh:      ResourceID,
	material:  ResourceID,
	positions: [dynamic]# row_major matrix[4, 4]f32,
}

RenderCommand3D :: struct {
	color:   Color,
	command: CommandUnion3D,
}

CommandUnion3D :: union {
	DrawMesh,
}

DrawMesh :: struct {
	mesh:      ResourceID,
	material:  ResourceID,
	transform: cm.Transform,
}

cameras_3d: [dynamic]rl.Camera3D
main_camera: uint
render_queue_3D: queue.Queue(RenderCommand3D)
resources: sm.DynamicSlotMap(Resource, ResourceID)
render_texture: rl.RenderTexture2D
batch_map: map[BatchKey]BatchEntry

renderer_init :: proc(w, h: uint) {
	render_texture = rl.LoadRenderTexture(c.int(w), c.int(h))
	cameras_3d = make([dynamic]rl.Camera3D)
	resources = sm.dynamic_slot_map_make(Resource, ResourceID)

	append(
		&cameras_3d,
		rl.Camera3D {
			cm.Vec3{10.0, 10.0, 10.0},
			cm.Vec3{0.0, 0.0, 0.0},
			cm.Vec3{0.0, 1.0, 0.0},
			45.0,
			.PERSPECTIVE,
		},
	)
	main_camera = 0

	batch_map = make(map[BatchKey]BatchEntry)
	cm.subscribe("enqueue_3D", cm.NIL_USERDATA, renderer_enqueue_3D)
}

renderer_deinit :: proc() {
	rl.UnloadTexture(render_texture.texture)
	delete(cameras_3d)

	sm.dynamic_slot_map_delete(&resources)

	for _, v in batch_map {
		delete(v.positions)
	}
	delete(batch_map)
}

renderer_enqueue_3D :: proc(_: ^int, command: ^RenderCommand3D) {
	queue.enqueue(&render_queue_3D, command^)
}

// Resources

create_cube_mesh :: proc(extents: cm.Vec3) -> (ResourceID, bool) #optional_ok {
	mesh := rl.GenMeshCube(extents.x, extents.y, extents.z)
	res: Resource = mesh
	return sm.dynamic_slot_map_insert_set(&resources, res)
}

create_material_default :: proc() -> ResourceID {
	mat := rl.LoadMaterialDefault()
	res: Resource = mat
	return sm.dynamic_slot_map_insert_set(&resources, res)
}

// Consumes mesh
create_model_from_mesh :: proc(mesh: ResourceID) -> (ResourceID, bool) #optional_ok {
	res, ok_a := sm.dynamic_slot_map_get_ptr(&resources, mesh)
	if !ok_a {
		fmt.eprintln("Cannot create a model from an invalid ID")
		return ResourceID{}, false
	}
	mesh_data, ok_b := res.(Mesh)
	if !ok_b {
		fmt.eprintln("Cannot create a model from a non-mesh resources")
		return ResourceID{}, false
	}

	sm.dynamic_slot_map_remove(&resources, mesh)

	mdl := rl.LoadModelFromMesh(mesh_data)
	resource: Resource
	resource = mdl
	return sm.dynamic_slot_map_insert_set(&resources, resource)
}

// Drawing

draw :: proc() {
	rl.BeginTextureMode(render_texture)
	{
		rl.ClearBackground(rl.WHITE)
		draw_3d()
	}
	rl.EndTextureMode()

	cm.broadcast("render_texture_present", &render_texture)
}


draw_3d :: proc() {
	rl.BeginMode3D(cameras_3d[main_camera])
	{
		for command, ok := queue.pop_front_safe(&render_queue_3D); ok; {
			col: Color = command.color
			switch com in command.command {
			case DrawMesh:
				b_key := BatchKey{com.mesh, com.material}

				if entry, ok := batch_map[b_key]; ok {
					append(&entry.positions, (# row_major matrix[4, 4]f32)(com.transform))
				} else {
					entry := BatchEntry {
						com.mesh,
						com.material,
						make([dynamic]# row_major matrix[4, 4]f32),
					}

					append(&entry.positions, (# row_major matrix[4, 4]f32)(com.transform))
					batch_map[b_key] = entry
				}
			}
		}

		for _, &v in batch_map {
			mesh := sm.dynamic_slot_map_get(&resources, v.mesh) or_continue
			material := sm.dynamic_slot_map_get(&resources, v.material) or_continue
			rl.DrawMeshInstanced(
				mesh.(Mesh) or_continue,
				material.(Material) or_continue,
				raw_data(v.positions),
				c.int(len(v.positions)),
			)
			clear_dynamic_array(&v.positions)
		}
	}
	rl.EndMode3D()
}
