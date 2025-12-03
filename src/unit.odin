package main

// Is unit file. Is unit. Are you jokester?
// Contains no logic.

import sm "slot_map"

UnitID :: distinct sm.Key(uint, 32, 32)

Unit :: struct {
	team :      u8,
	archetype : u32,
	transform : Transform,
	target :    Vec2i,
	moving :    bool,
}

