package common

import "core:fmt"
import "core:encoding/cbor"
import la "core:math/linalg"

Vec2i :: [2]int
Vec3 :: [3]f32
Transform :: matrix[4, 4]f32

m4_get_translation :: proc(mat: Transform) -> la.Vector3f32 {
	return mat[3].xyz
}

MoveCommand :: struct {
	units:  []UnitID,
	target: Vec2i,
}

CreateUnitCommand :: struct {
	team:      u8,
	unit_id:   UnitID,
	archetype: u32,
	transform: Transform,
	target:    Vec2i,
}

DestroyUnitCommand :: struct {
	unit_id: UnitID,
}

KeyframeData :: struct {
	unit_id: UnitID,
	unit:    Unit,
}

KeyframeCommand :: struct {
	unit_data: []KeyframeData,
}

HelloCommand :: struct {
}

NetCommand :: union {
	MoveCommand,
	CreateUnitCommand,
	DestroyUnitCommand,
	KeyframeCommand,
	HelloCommand,
}


// Remember to free the buffer.
serialize_command_packet :: proc(packet: NetCommand) -> ([]byte, cbor.Marshal_Error) {
    data, err := cbor.marshal_into_bytes(packet)
	return data, err
}

deserialize_command_packet :: proc(buff: []u8) -> (NetCommand, cbor.Unmarshal_Error) {
	packet := NetCommand{}
	err := cbor.unmarshal_from_bytes(buff, &packet)
	return packet, err
}
