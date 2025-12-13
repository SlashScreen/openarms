use math
use meta

type Options enum:
	.inverted_camera_scroll

type UnitSetTargetInfo(id UnitID, math.Vector2)

#[bind] -host_setting(o Option, )
fn setting(o Option, %T type) -> T:
	return host_setting(o, meta.type.id(T))


-- Game loop

type Event(tag symbol, info Ptr[void])

#[bind] init()
#[bind] gather_updates() -> []Event
#[bind] get_delta() -> f32
#[bind] update_simulation(dt f32)
#[bind] draw()
#[bind] should_be_running() -> bool
#[bind] shutdown()
