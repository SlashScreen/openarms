package client

import cm "../common"
import rl "vendor:raylib"

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
	.ENTER         = .KP_Enter, // Key: Enter (using keypad enter, adjust if needed)
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
	position :     [2]int,
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
				cm.broadcast("key_event", &event)
			}
		}

		if rl.IsKeyReleased(rl_key) {
			key := rl_to_key[rl_key]
			if key != .Invalid {
				event := KeyEvent{.Released, key}
				cm.broadcast("key_event", &event)
			}
		}

		if rl.IsKeyPressedRepeat(rl_key) {
			key := rl_to_key[rl_key]
			if key != .Invalid {
				event := KeyEvent{.Repeat, key}
				cm.broadcast("key_event", &event)
			}
		}

		if rl.IsKeyDown(rl_key) {
			key := rl_to_key[rl_key]
			if key != .Invalid {
				event := KeyEvent{.Down, key}
				cm.broadcast("key_event", &event)
			}
		}
	}

	for rl_mouse in rl.MouseButton {
		if rl.IsMouseButtonDown(rl_mouse) {
			event := MouseEvent {
				.Down,
				rl_to_mouse[rl_mouse],
				[2]int{int(rl.GetMouseX()), int(rl.GetMouseY())},
			}
			cm.broadcast("mouse_event", &event)
		}

		if rl.IsMouseButtonPressed(rl_mouse) {
			event := MouseEvent {
				.Pressed,
				rl_to_mouse[rl_mouse],
				[2]int{int(rl.GetMouseX()), int(rl.GetMouseY())},
			}
			cm.broadcast("mouse_event", &event)
		}

		if rl.IsMouseButtonReleased(rl_mouse) {
			event := MouseEvent {
				.Released,
				rl_to_mouse[rl_mouse],
				[2]int{int(rl.GetMouseX()), int(rl.GetMouseY())},
			}
			cm.broadcast("mouse_event", &event)
		}
	}
}

