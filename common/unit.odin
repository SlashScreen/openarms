package common

import sm "../slot_map"

UnitID :: distinct sm.Key(uint, 32, 32)

Unit :: struct {
    archetype: u32,
    transform: Transform,
    target: Vec2i,
}
