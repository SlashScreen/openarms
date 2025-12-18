use math
use meta
use input

type UnitID = r64

type Options enum:
	case inverted_camera_scroll

type UnitSetTargetInfo(id UnitID, pos math.Vector2)

#[bind] -fn host_setting(o Options, t i64)
fn setting(o Options, %T type) -> !T:
	return host_setting(o, meta.type.id(T))

-- Game loop

type EventPacket enum:
	case key input.KeyEvent
	case mouse input.MouseEvent

#[bind] fn init()
#[bind] fn gather_updates() -> []EventPacket
#[bind] fn get_delta() -> f32
#[bind] fn update_simulation(dt f32)
#[bind] fn draw()
#[bind] fn should_be_running() -> bool
#[bind] fn shutdown()
