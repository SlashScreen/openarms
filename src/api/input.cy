use math

type Range(pos, neg Key)

type KeyBinding enum:
	case camera_sprint
	case camera_forward
	case camera_backward
	case camera_left
	case camera_right

type Key enum:
	case invalid
	case a
	case b
	case c
	case d
	case e
	case f
	case g
	case h
	case i
	case j
	case k
	case l
	case m
	case n
	case o
	case p
	case q
	case r
	case s
	case t
	case u
	case v
	case w
	case x
	case y
	case z
	case space
	case n0
	case n1
	case n2
	case n3
	case n4
	case n5
	case n6
	case n7
	case n8
	case n9
	case kp0
	case kp1
	case kp2
	case kp3
	case kp4
	case kp5
	case kp6
	case kp7
	case kp8
	case kp9
	case kp_slash
	case kp_asterisk
	case kp_plus
	case kp_enter
	case kp_dot
	case kp_equals
	case kp_dash
	case kp_menu
	case dot
	case comma
	case l_ang_bracket
	case r_ang_bracket
	case l_paren
	case r_paren
	case l_bracket
	case r_bracket
	case l_brace
	case r_brace
	case question
	case f_slash -- ha ha
	case b_slash
	case pipe
	case dash
	case underscore
	case equals
	case plus
	case semicolon
	case colon
	case apostrophe
	case quotes
	case grave
	case tilde
	case exclamation
	case at
	case pound
	case dollar
	case percent
	case carat
	case ampersand
	case asterisk
	case f1
	case f2
	case f3
	case f4
	case f5
	case f6
	case f7
	case f8
	case f9
	case f10
	case f11
	case f12
	case l_shift
	case r_shift
	case l_ctrl
	case r_ctrl
	case super
	case l_alt
	case r_alt
	case caps_lock
	case up
	case down
	case left
	case right
	case backspace
	case enter
	case tab
	case num_lock
	case scroll_lock
	case print_screen
	case end
	case home
	case pg_up
	case pg_down
	case insert
	case delete
	case pause
	case menu
	case back

type MouseButton enum:
	case left
	case right
	case middle
	case side
	case extra
	case forward
	case back

type KeyAction enum:
	case pressed
	case released
	case repeat
	case down

type MouseAction enum:
	case pressed
	case released
	case down

type KeyEvent:
	key_action KeyAction
	key Key

type MouseEvent:
	mouse_action MouseAction
	button MouseButton
	position math.Vector2
	delta math.Vector2

-- Keys

#[bind] fn binding(b KeyBinding) -> Key
#[bind] fn axis2(x, y Range) -> math.Vector2
#[bind] fn key_down(k Key) -> bool

-- Mouse

--| Get scroll delta.
#[bind] fn scroll_movement() -> f32
