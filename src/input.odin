package main

// Input manager. Broadcasts input events.

import rl "vendor:raylib"

@(private = "file")
@(rodata)
rl_to_key := #sparse[rl.KeyboardKey]Key {
	.KEY_NULL      = .Invalid,
	.BACK          = .Back,
	.MENU          = .Menu,
	.VOLUME_UP     = .Invalid,
	.VOLUME_DOWN   = .Invalid,
	.APOSTROPHE    = .Apostrophe, // Key: '
	.COMMA         = .Comma, // Key: ,
	.MINUS         = .Dash, // Key: -
	.PERIOD        = .Dot, // Key: .
	.SLASH         = .F_Slash, // Key: /
	.ZERO          = .N0, // Key: 0
	.ONE           = .N1, // Key: 1
	.TWO           = .N2, // Key: 2
	.THREE         = .N3, // Key: 3
	.FOUR          = .N4, // Key: 4
	.FIVE          = .N5, // Key: 5
	.SIX           = .N6, // Key: 6
	.SEVEN         = .N7, // Key: 7
	.EIGHT         = .N8, // Key: 8
	.NINE          = .N9, // Key: 9
	.SEMICOLON     = .Semicolon, // Key: ;
	.EQUAL         = .Equals, // Key: =
	.A             = .A, // Key: A | a
	.B             = .B, // Key: B | b
	.C             = .C, // Key: C | c
	.D             = .D, // Key: D | d
	.E             = .E, // Key: E | e
	.F             = .F, // Key: F | f
	.G             = .G, // Key: G | g
	.H             = .H, // Key: H | h
	.I             = .I, // Key: I | i
	.J             = .J, // Key: J | j
	.K             = .K, // Key: K | k
	.L             = .L, // Key: L | l
	.M             = .M, // Key: M | m
	.N             = .N, // Key: N | n
	.O             = .O, // Key: O | o
	.P             = .P, // Key: P | p
	.Q             = .Q, // Key: Q | q
	.R             = .R, // Key: R | r
	.S             = .S, // Key: S | s
	.T             = .T, // Key: T | t
	.U             = .U, // Key: U | u
	.V             = .V, // Key: V | v
	.W             = .W, // Key: W | w
	.X             = .X, // Key: X | x
	.Y             = .Y, // Key: Y | y
	.Z             = .Z, // Key: Z | z
	.LEFT_BRACKET  = .L_Bracket, // Key: [
	.BACKSLASH     = .B_Slash, // Key: '\'
	.RIGHT_BRACKET = .R_Bracket, // Key: ]
	.GRAVE         = .Grave, // Key: `
	// Function keys
	.SPACE         = .Space, // Key: Space
	.ESCAPE        = .Pause, // Key: Esc (no direct mapping, using Pause as placeholder)
	.ENTER         = .Enter, // Key: Enter (using keypad enter, adjust if needed)
	.TAB           = .Tab, // Key: Tab
	.BACKSPACE     = .Backspace, // Key: Backspace
	.INSERT        = .Insert, // Key: Ins
	.DELETE        = .Delete, // Key: Del
	.RIGHT         = .Right, // Key: Cursor right
	.LEFT          = .Left, // Key: Cursor left
	.DOWN          = .Down, // Key: Cursor down
	.UP            = .Up, // Key: Cursor up
	.PAGE_UP       = .PgUp, // Key: Page up
	.PAGE_DOWN     = .PgDown, // Key: Page down
	.HOME          = .Home, // Key: Home
	.END           = .End, // Key: End
	.CAPS_LOCK     = .CapsLock, // Key: Caps lock
	.SCROLL_LOCK   = .ScrollLock, // Key: Scroll down
	.NUM_LOCK      = .NumLock, // Key: Num lock
	.PRINT_SCREEN  = .PrintScreen, // Key: Print screen
	.PAUSE         = .Pause, // Key: Pause
	.F1            = .F1, // Key: F1
	.F2            = .F2, // Key: F2
	.F3            = .F3, // Key: F3
	.F4            = .F4, // Key: F4
	.F5            = .F5, // Key: F5
	.F6            = .F6, // Key: F6
	.F7            = .F7, // Key: F7
	.F8            = .F8, // Key: F8
	.F9            = .F9, // Key: F9
	.F10           = .F10, // Key: F10
	.F11           = .F11, // Key: F11
	.F12           = .F12, // Key: F12
	.LEFT_SHIFT    = .L_Shift, // Key: Shift left
	.LEFT_CONTROL  = .L_Ctrl, // Key: Control left
	.LEFT_ALT      = .L_Alt, // Key: Alt left
	.LEFT_SUPER    = .Super, // Key: Super left
	.RIGHT_SHIFT   = .R_Shift, // Key: Shift right
	.RIGHT_CONTROL = .R_Ctrl, // Key: Control right
	.RIGHT_ALT     = .R_Alt, // Key: Alt right
	.RIGHT_SUPER   = .Super, // Key: Super right
	.KB_MENU       = .Menu, // Key: KB menu
	// Keypad keys
	.KP_0          = .KP0, // Key: Keypad 0
	.KP_1          = .KP1, // Key: Keypad 1
	.KP_2          = .KP2, // Key: Keypad 2
	.KP_3          = .KP3, // Key: Keypad 3
	.KP_4          = .KP4, // Key: Keypad 4
	.KP_5          = .KP5, // Key: Keypad 5
	.KP_6          = .KP6, // Key: Keypad 6
	.KP_7          = .KP7, // Key: Keypad 7
	.KP_8          = .KP8, // Key: Keypad 8
	.KP_9          = .KP9, // Key: Keypad 9
	.KP_DECIMAL    = .KP_Dot, // Key: Keypad .
	.KP_DIVIDE     = .KP_Slash, // Key: Keypad /
	.KP_MULTIPLY   = .KP_Asterisk, // Key: Keypad *
	.KP_SUBTRACT   = .KP_Dash, // Key: Keypad -
	.KP_ADD        = .KP_Plus, // Key: Keypad +
	.KP_ENTER      = .KP_Enter, // Key: Keypad Enter
	.KP_EQUAL      = .KP_Equals, // Key: Keypad =
}

@(private = "file")
@(rodata)
key_to_rl := #sparse[Key]rl.KeyboardKey {
	.Invalid      = .KEY_NULL,
	.L_AngBracket = .KEY_NULL,
	.R_AngBracket = .KEY_NULL,
	.L_Paren      = .KEY_NULL,
	.R_Paren      = .KEY_NULL,
	.L_Brace      = .KEY_NULL,
	.R_Brace      = .KEY_NULL,
	.Question     = .KEY_NULL,
	.Pipe         = .KEY_NULL,
	.Underscore   = .KEY_NULL,
	.Plus         = .KEY_NULL,
	.Colon        = .KEY_NULL,
	.Quotes       = .KEY_NULL,
	.Tilde        = .KEY_NULL,
	.Exclamation  = .KEY_NULL,
	.At           = .KEY_NULL,
	.Pound        = .KEY_NULL,
	.Dollar       = .KEY_NULL,
	.Percent      = .KEY_NULL,
	.Carat        = .KEY_NULL,
	.Ampersand    = .KEY_NULL,
	.Asterisk     = .KEY_NULL,
	// Next
	.Back         = .BACK,
	.Menu         = .MENU,
	.Apostrophe   = .APOSTROPHE,
	.Comma        = .COMMA,
	.Dash         = .MINUS,
	.Dot          = .PERIOD,
	.F_Slash      = .SLASH,
	.N0           = .ZERO,
	.N1           = .ONE,
	.N2           = .TWO,
	.N3           = .THREE,
	.N4           = .FOUR,
	.N5           = .FIVE,
	.N6           = .SIX,
	.N7           = .SEVEN,
	.N8           = .EIGHT,
	.N9           = .NINE,
	.Semicolon    = .SEMICOLON,
	.Equals       = .EQUAL,
	.A            = .A,
	.B            = .B,
	.C            = .C,
	.D            = .D,
	.E            = .E,
	.F            = .F,
	.G            = .G,
	.H            = .H,
	.I            = .I,
	.J            = .J,
	.K            = .K,
	.L            = .L,
	.M            = .M,
	.N            = .N,
	.O            = .O,
	.P            = .P,
	.Q            = .Q,
	.R            = .R,
	.S            = .S,
	.T            = .T,
	.U            = .U,
	.V            = .V,
	.W            = .W,
	.X            = .X,
	.Y            = .Y,
	.Z            = .Z,
	.L_Bracket    = .LEFT_BRACKET,
	.B_Slash      = .BACKSLASH,
	.R_Bracket    = .RIGHT_BRACKET,
	.Grave        = .GRAVE,
	.Space        = .SPACE,
	.Pause        = .ESCAPE, // Note: ambiguous, adjust if needed
	.Enter        = .ENTER,
	.Tab          = .TAB,
	.Backspace    = .BACKSPACE,
	.Insert       = .INSERT,
	.Delete       = .DELETE,
	.Right        = .RIGHT,
	.Left         = .LEFT,
	.Down         = .DOWN,
	.Up           = .UP,
	.PgUp         = .PAGE_UP,
	.PgDown       = .PAGE_DOWN,
	.Home         = .HOME,
	.End          = .END,
	.CapsLock     = .CAPS_LOCK,
	.ScrollLock   = .SCROLL_LOCK,
	.NumLock      = .NUM_LOCK,
	.PrintScreen  = .PRINT_SCREEN,
	.F1           = .F1,
	.F2           = .F2,
	.F3           = .F3,
	.F4           = .F4,
	.F5           = .F5,
	.F6           = .F6,
	.F7           = .F7,
	.F8           = .F8,
	.F9           = .F9,
	.F10          = .F10,
	.F11          = .F11,
	.F12          = .F12,
	.L_Shift      = .LEFT_SHIFT,
	.L_Ctrl       = .LEFT_CONTROL,
	.L_Alt        = .LEFT_ALT,
	.Super        = .LEFT_SUPER,
	.R_Shift      = .RIGHT_SHIFT,
	.R_Ctrl       = .RIGHT_CONTROL,
	.R_Alt        = .RIGHT_ALT,
	.KP0          = .KP_0,
	.KP1          = .KP_1,
	.KP2          = .KP_2,
	.KP3          = .KP_3,
	.KP4          = .KP_4,
	.KP5          = .KP_5,
	.KP6          = .KP_6,
	.KP7          = .KP_7,
	.KP8          = .KP_8,
	.KP9          = .KP_9,
	.KP_Dot       = .KP_DECIMAL,
	.KP_Slash     = .KP_DIVIDE,
	.KP_Asterisk  = .KP_MULTIPLY,
	.KP_Dash      = .KP_SUBTRACT,
	.KP_Plus      = .KP_ADD,
	.KP_Enter     = .KP_ENTER,
	.KP_Equals    = .KP_EQUAL,
	.KP_Menu      = .KP_ENTER,
}

@(private = "file")
@(rodata)
rl_to_mouse := [rl.MouseButton]MouseButton {
	.LEFT    = .Left,
	.RIGHT   = .Right,
	.MIDDLE  = .Middle,
	.SIDE    = .Side,
	.EXTRA   = .Extra,
	.FORWARD = .Forward,
	.BACK    = .Back,
}

@(private = "file")
@(rodata)
mouse_to_rl := [MouseButton]rl.MouseButton {
	.Left    = .LEFT,
	.Right   = .RIGHT,
	.Middle  = .MIDDLE,
	.Side    = .SIDE,
	.Extra   = .EXTRA,
	.Forward = .FORWARD,
	.Back    = .BACK,
}

Key :: enum {
	Invalid,
	// Alpha
	A,
	B,
	C,
	D,
	E,
	F,
	G,
	H,
	I,
	J,
	K,
	L,
	M,
	N,
	O,
	P,
	Q,
	R,
	S,
	T,
	U,
	V,
	W,
	X,
	Y,
	Z,
	Space,
	// Numbers
	N0,
	N1,
	N2,
	N3,
	N4,
	N5,
	N6,
	N7,
	N8,
	N9,
	// Keypad
	KP0,
	KP1,
	KP2,
	KP3,
	KP4,
	KP5,
	KP6,
	KP7,
	KP8,
	KP9,
	KP_Slash,
	KP_Asterisk,
	KP_Plus,
	KP_Enter,
	KP_Dot,
	KP_Equals,
	KP_Dash,
	KP_Menu,
	// Symbols
	Dot,
	Comma,
	L_AngBracket,
	R_AngBracket,
	L_Paren,
	R_Paren,
	L_Bracket,
	R_Bracket,
	L_Brace,
	R_Brace,
	Question,
	F_Slash, // ha ha
	B_Slash,
	Pipe,
	Dash,
	Underscore,
	Equals,
	Plus,
	Semicolon,
	Colon,
	Apostrophe,
	Quotes,
	Grave,
	Tilde,
	Exclamation,
	At,
	Pound,
	Dollar,
	Percent,
	Carat,
	Ampersand,
	Asterisk,
	// F
	F1,
	F2,
	F3,
	F4,
	F5,
	F6,
	F7,
	F8,
	F9,
	F10,
	F11,
	F12,
	// Modifier
	L_Shift,
	R_Shift,
	L_Ctrl,
	R_Ctrl,
	Super,
	L_Alt,
	R_Alt,
	CapsLock,
	// Misc,
	Up,
	Down,
	Left,
	Right,
	Backspace,
	Enter,
	Tab,
	NumLock,
	ScrollLock,
	PrintScreen,
	End,
	Home,
	PgUp,
	PgDown,
	Insert,
	Delete,
	Pause,
	Menu,
	Back,
}

MouseButton :: enum {
	Left,
	Right,
	Middle,
	Side,
	Extra,
	Forward,
	Back,
}

MouseEvent :: struct {
	mouse_action : enum {
		Pressed,
		Released,
		Down,
	},
	button :       MouseButton,
	position :     [2]f32,
	delta :        [2]f32,
}

KeyEvent :: struct {
	key_action : enum {
		Pressed,
		Released,
		Repeat,
		Down,
	},
	key :        Key,
}

// TODO: Modifier
poll_input :: proc() {
	for rl_key in rl.KeyboardKey {
		if rl.IsKeyPressed(rl_key) {
			key := rl_to_key[rl_key]
			if key != .Invalid {
				event := KeyEvent{.Pressed, key}
				broadcast("key_event", &event)
			}
		}

		if rl.IsKeyReleased(rl_key) {
			key := rl_to_key[rl_key]
			if key != .Invalid {
				event := KeyEvent{.Released, key}
				broadcast("key_event", &event)
			}
		}

		if rl.IsKeyPressedRepeat(rl_key) {
			key := rl_to_key[rl_key]
			if key != .Invalid {
				event := KeyEvent{.Repeat, key}
				broadcast("key_event", &event)
			}
		}

		if rl.IsKeyDown(rl_key) {
			key := rl_to_key[rl_key]
			if key != .Invalid {
				event := KeyEvent{.Down, key}
				broadcast("key_event", &event)
			}
		}
	}

	for rl_mouse in rl.MouseButton {
		if rl.IsMouseButtonDown(rl_mouse) {
			event := MouseEvent {
				.Down,
				rl_to_mouse[rl_mouse],
				rl.GetMousePosition(),
				rl.GetMouseDelta(),
			}
			broadcast("mouse_event", &event)
		}

		if rl.IsMouseButtonPressed(rl_mouse) {
			event := MouseEvent {
				.Pressed,
				rl_to_mouse[rl_mouse],
				rl.GetMousePosition(),
				rl.GetMouseDelta(),
			}
			broadcast("mouse_event", &event)
		}

		if rl.IsMouseButtonReleased(rl_mouse) {
			event := MouseEvent {
				.Released,
				rl_to_mouse[rl_mouse],
				rl.GetMousePosition(),
				rl.GetMouseDelta(),
			}
			broadcast("mouse_event", &event)
		}
	}
}

is_key_down :: proc(key : Key) -> bool {
	return rl.IsKeyDown(key_to_rl[key])
}

is_key_pressed :: proc(key : Key) -> bool {
	return rl.IsKeyPressed(key_to_rl[key])
}

key_2_axis :: proc(x : struct {
		pos : Key,
		neg : Key,
	}, y : struct {
		pos : Key,
		neg : Key,
	}) -> Vec2 {
	x_axis : f32 = 0.0
	x_axis -= 1.0 if is_key_down(x.neg) else 0.0
	x_axis += 1.0 if is_key_down(x.pos) else 0.0

	y_axis : f32 = 0.0
	y_axis -= 1.0 if is_key_down(y.neg) else 0.0
	y_axis += 1.0 if is_key_down(y.pos) else 0.0

	return Vec2{x_axis, y_axis}
}

get_scroll_movement :: rl.GetMouseWheelMove

get_scroll_vector :: rl.GetMouseWheelMoveV

get_mouse_position :: rl.GetMousePosition

is_mouse_down :: proc(button : MouseButton) -> bool {
	return rl.IsMouseButtonDown(mouse_to_rl[button])
}

