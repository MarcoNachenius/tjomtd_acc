extends Node

var HURTBOX_PRELOAD: PackedScene = load("res://projectiles/components/hurtbox/projectile_hurtbox.tscn")

enum ProjectileIDs {
	TEST_SINGLE_HIT_BULLET,
	BLACK_MARBLE_LVL_1,
	BLACK_MARBLE_LVL_2,
	BISMUTH_LVL_1,
}

enum SingleHitBullets {
	BLACK_MARBLE_LVL_1
}

enum Missiles {
	BISMUTH_LVL_1
}

enum TargetedRicochetBullets {
	BLACK_MARBLE_LVL_2
}

var SINGLE_HIT_BULLET_LOADS: Dictionary = {
	SingleHitBullets.BLACK_MARBLE_LVL_1: load("res://towers/buildable_towers/black_marble/level_1/tower_bullet.tscn")
}

var TARGETED_RICOCHET_BULLET_LOADS: Dictionary = {
	TargetedRicochetBullets.BLACK_MARBLE_LVL_2: load("res://towers/buildable_towers/black_marble/level_2/bm_lvl_2_bullet.tscn")
}

var MISSILE_PRELOADS: Dictionary = {
	Missiles.BISMUTH_LVL_1: load("res://towers/buildable_towers/bismuth/level_1/bismuth_lvl_1_missile.tscn")
}

