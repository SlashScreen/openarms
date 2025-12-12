package main

import "clay"
import "core:c"

@(private = "file")
FONT_DEFAULT :: 0

@(private = "file")
clay_memory : [^]u8

@(private = "file")
error_text_style : clay.TextElementConfig = {
	fontId    = FONT_DEFAULT,
	fontSize  = 48,
	textColor = clay.Color{255, 255, 255, 255},
}

error_screen_init :: proc() {
	min_memory_size : c.size_t = cast(c.size_t)clay.MinMemorySize()
	clay_memory = make([^]u8, min_memory_size)
	arena : clay.Arena = clay.CreateArenaWithCapacityAndMemory(min_memory_size, clay_memory)
	clay.Initialize(arena, {f32(WIDTH), f32(HEIGHT)}, {handler = error_handler})
	clay.SetMeasureTextFunction(clay.measure_text, nil)

	// Loading

	load_font(FONT_DEFAULT, 64, "fonts/Quicksand-Semibold.ttf")
}

error_screen_draw :: proc(dt : f32) {
	defer free_all(context.temp_allocator)

	if is_key_pressed(.Equals) {
		debug_views ~= {.UI}
		clay.SetDebugModeEnabled(.UI in debug_views)
	}

	clay.SetPointerState(get_mouse_position(), is_mouse_down(.Left))
	clay.UpdateScrollContainers(false, get_scroll_vector(), dt)
	clay.SetLayoutDimensions({f32(WIDTH), f32(HEIGHT)})

	commands := error_screen_layout()

	clay.clay_raylib_render(&commands)
}

error_screen_deinit :: proc() {
	free(clay_memory)
}

@(private = "file")
error_screen_layout :: proc() -> clay.ClayArray(clay.RenderCommand) {
	clay.BeginLayout()

	if clay.UI(clay.ID("OuterContainer"))(
	{
		layout = {layoutDirection = .TopToBottom, sizing = {clay.SizingGrow(), clay.SizingGrow()}},
		backgroundColor = clay.Color{0, 0, 0, 255},
	},
	) {
		clay.Text("No games found...", &error_text_style)
	}

	return clay.EndLayout()
}

