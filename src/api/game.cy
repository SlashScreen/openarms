use math

const SET_UNIT_TARGET_COMMAND = @set_unit_target

type MessageCallback = fn (payload Ptr[void])

type Options enum:
	.inverted_camera_scroll

type UnitSetTargetInfo(id UnitID, math.Vector2)

#[bind] broadcast(message string, payload Ptr[void])
#[bind] subscribe(message string, userdata ?Ptr[void], callback MessageCallback)

#[bind] fn setting(o Option, %T type) -> T

-- Meta

type Event(tag symbol, info Ptr[void])

#[bind] init()
#[bind] gather_updates() -> []Event
#[bind] get_delta() -> f32
#[bind] update_simulation(dt f32)
#[bind] draw()
#[bind] should_be_running() -> bool
#[bind] shutdown()
