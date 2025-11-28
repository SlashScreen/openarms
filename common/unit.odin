package common

import sm "../slot_map"

UnitID :: distinct sm.Key(uint, 32, 32)

Unit :: struct {
    team: u8,
    archetype: u32,
    transform: Transform,
    target: Vec2i,
}
