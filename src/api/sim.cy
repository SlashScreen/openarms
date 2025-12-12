use math

const set_unit_target_command string = "set_unit_target"

type UnitID = r64

type UnitSelectTargetInfo:
	id UnitID
	point math.Vector2
