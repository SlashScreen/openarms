package main

import "base:runtime"
import clay "clay"
import "core:c"
import "core:strings"
import rl "vendor:raylib"

@(private = "file")
FONT_DEFAULT :: 0
@(private = "file")
COLOR_TEAL :: clay.Color{111, 173, 162, 255}

@(private = "file")
clay_memory : [^]u8

error_handler :: proc "c" (errorData : clay.ErrorData) {
	context = runtime.default_context()
	err_text := strings.string_from_ptr(errorData.errorText.chars, int(errorData.errorText.length))

	log_err("UI Error: %s", err_text)
}

hud_init :: proc() {
	min_memory_size : c.size_t = cast(c.size_t)clay.MinMemorySize()
	clay_memory = make([^]u8, min_memory_size)
	arena : clay.Arena = clay.CreateArenaWithCapacityAndMemory(min_memory_size, clay_memory)
	clay.Initialize(arena, {f32(WIDTH), f32(HEIGHT)}, {handler = error_handler})
	clay.SetMeasureTextFunction(clay.measure_text, nil)

	// Loading

	load_font(FONT_DEFAULT, 64, "fonts/Quicksand-Semibold.ttf")
}

hud_draw :: proc(dt : f32) {
	defer free_all(context.temp_allocator)

	if is_key_pressed(.Equals) {
		debug_views ~= {.UI}
		clay.SetDebugModeEnabled(.UI in debug_views)
	}

	clay.SetPointerState(get_mouse_position(), is_mouse_down(.Left))
	clay.UpdateScrollContainers(false, get_scroll_vector(), dt)
	clay.SetLayoutDimensions({f32(WIDTH), f32(HEIGHT)})

	commands := create_layout()

	clay.clay_raylib_render(&commands)
}

hud_deinit :: proc() {
	free(clay_memory)
}

create_layout :: proc() -> clay.ClayArray(clay.RenderCommand) {
	clay.BeginLayout()

	{
		if clay.UI(clay.ID("OuterContainer"))(
		{
			layout = {
				layoutDirection = .TopToBottom,
				sizing = {clay.SizingPercent(0.2), clay.SizingGrow()},
			},
			backgroundColor = COLOR_TEAL,
		},
		) {
			clay.Text(
				"Hello",
				&{
					fontId = FONT_DEFAULT,
					fontSize = 64,
					textColor = clay.Color{255, 255, 255, 255},
				},
			)
		}
	}

	return clay.EndLayout()
}

load_font :: proc(fontId : u16, fontSize : u16, path : string) {
	font_path, ok := vfs_find(path)
	if !ok {
		log_err("Unable to find font at %s", path)
		return
	}
	defer delete(font_path)

	assign_at(
		&clay.raylib_fonts, // bad design choice I think lol
		fontId,
		clay.Raylib_Font {
			font = rl.LoadFontEx(
				strings.unsafe_string_to_cstring(font_path),
				i32(fontSize) * 2,
				nil,
				0,
			),
			fontId = cast(u16)fontId,
		},
	)
	rl.SetTextureFilter(clay.raylib_fonts[fontId].font.texture, rl.TextureFilter.TRILINEAR)
}

