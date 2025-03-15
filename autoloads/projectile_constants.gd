extends Node

var HURTBOX_PRELOAD: PackedScene = load("res://projectiles/components/hurtbox/projectile_hurtbox.tscn")
var STUN_HURTBOX_PRELOAD: PackedScene = load("res://projectiles/components/stun_hurtbox/projectile_stun_hurtbox.tscn")

enum ProjectileIDs {
	TEST_SINGLE_HIT_BULLET,
	BLACK_MARBLE_LVL_1,
	BLACK_MARBLE_LVL_2,
	BISMUTH_LVL_1,
	TEST_TOWER_PROJECTILE
}

enum SingleHitBullets {
	BLACK_MARBLE_LVL_1
}

enum SingleHitMissiles {
	BISMUTH_LVL_1
}

enum TargetedRicochetBullets {
	BLACK_MARBLE_LVL_2,
	TEST_TOWER_PROJECTILE
}

var SINGLE_HIT_BULLET_LOADS: Dictionary = {
	SingleHitBullets.BLACK_MARBLE_LVL_1: load("res://towers/buildable_towers/black_marble/level_1/tower_bullet.tscn")
}

var TARGETED_RICOCHET_BULLET_LOADS: Dictionary = {
	TargetedRicochetBullets.BLACK_MARBLE_LVL_2: load("res://towers/buildable_towers/black_marble/level_2/bm_lvl_2_bullet.tscn"),
	TargetedRicochetBullets.TEST_TOWER_PROJECTILE: load("res://towers/test_tower/test_tower_projectile.tscn")
}

var SINGLE_HIT_MISSILE_LOADS: Dictionary = {
	SingleHitMissiles.BISMUTH_LVL_1: load("res://towers/buildable_towers/bismuth/level_1/bismuth_lvl_1_missile.tscn")
}
