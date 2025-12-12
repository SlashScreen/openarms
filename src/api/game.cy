use math

const SET_UNIT_TARGET_COMMAND = @set_unit_target

type MessageCallback = fn (payload *void)

type Options enum:
	.inverted_camera_scroll

type UnitSetTargetInfo(id UnitID, math.Vector2)

#[bind] broadcast(message string, payload *void)
#[bind] subscribe(message string, userdata ?*void, callback MessageCallback)

#[bind] fn setting(o Option, %T type) -> T
