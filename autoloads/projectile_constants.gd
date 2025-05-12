extends Node

var HURTBOX_PRELOAD: PackedScene = load("res://projectiles/components/hurtbox/projectile_hurtbox.tscn")
var STUN_HURTBOX_PRELOAD: PackedScene = load("res://projectiles/components/stun_hurtbox/projectile_stun_hurtbox.tscn")
var RETARGET_HURTBOX_PRELOAD: PackedScene = load("res://projectiles/components/retarget_hurtbox/retarget_hurtbox.tscn")

enum ProjectileIDs {
	TEST_SINGLE_HIT_BULLET,
	BLACK_MARBLE_LVL_1,
	BLACK_MARBLE_LVL_2,
	BLACK_MARBLE_LVL_3,
	BISMUTH_LVL_1,
	LARIMAR_LVL_1,
	SUNSTONE_LVL_1,
}

enum SingleHitBullets {
	BLACK_MARBLE_LVL_1,
	LARIMAR_LVL_1,
	SUNSTONE_LVL_1,
}

enum SingleHitMissiles {
	BISMUTH_LVL_1
}

enum TargetedRicochetBullets {
	BLACK_MARBLE_LVL_3,
}

enum RandomRicochetBullets {
	TEST_RANDOM_RICOCHET_BULLET,
	BLACK_MARBLE_LVL_2,
}

enum BulletsForSpawner {
	BLACK_MARBLE_LVL_1,
	BLACK_MARBLE_LVL_2,
	BLACK_MARBLE_LVL_3,
	LARIMAR_LVL_1,
	SUNSTONE_LVL_1,
}

var SINGLE_HIT_BULLET_LOADS: Dictionary = {
	SingleHitBullets.BLACK_MARBLE_LVL_1: load("res://towers/buildable_towers/black_marble/level_1/tower_bullet.tscn"),
	SingleHitBullets.LARIMAR_LVL_1: load("res://towers/buildable_towers/laminar/level_1/larimar_lvl_1_bullet.tscn"),
	SingleHitBullets.SUNSTONE_LVL_1: load("res://towers/buildable_towers/sunstone/level_1/sunstone_lvl_1_bullet.tscn"),
}

var TARGETED_RICOCHET_BULLET_LOADS: Dictionary = {
	TargetedRicochetBullets.BLACK_MARBLE_LVL_3: load("res://towers/buildable_towers/black_marble/level_3/black_marble_lvl_3_bullet.tscn")
}

var RANDOM_RICOCHET_BULLET_LOADS: Dictionary = {
	RandomRicochetBullets.TEST_RANDOM_RICOCHET_BULLET: load("res://projectiles/bullets/multi_hit/random_ricochet/test_bullet/test_rrb.tscn"),
	RandomRicochetBullets.BLACK_MARBLE_LVL_2: load("res://towers/buildable_towers/black_marble/level_2/bm_lvl_2_bullet.tscn"),
}

var BULLET_PATHS: Dictionary = {
	BulletsForSpawner.BLACK_MARBLE_LVL_1: "res://towers/buildable_towers/black_marble/level_1/tower_bullet.tscn",
	BulletsForSpawner.BLACK_MARBLE_LVL_2: "res://towers/buildable_towers/black_marble/level_2/bm_lvl_2_bullet.tscn",
	BulletsForSpawner.BLACK_MARBLE_LVL_3: "res://towers/buildable_towers/black_marble/level_3/black_marble_lvl_3_bullet.tscn",
	BulletsForSpawner.LARIMAR_LVL_1: "res://towers/buildable_towers/laminar/level_1/larimar_lvl_1_bullet.tscn",
	BulletsForSpawner.SUNSTONE_LVL_1: "res://towers/buildable_towers/sunstone/level_1/sunstone_lvl_1_bullet.tscn",
}


# ********
# MISSILES
# ********

enum TargetedRicochetMissiles{
	TEST_TARGETED_RICOCHET_MISSILE,
}

enum MissilesForSpawner {
	BISMUTH_LVL_1,
	TEST_TARGETED_RICOCHET_MISSILE,
}

var TARGETED_RICOCHET_MISSILE_LOADS: Dictionary = {
	TargetedRicochetMissiles.TEST_TARGETED_RICOCHET_MISSILE: load("res://projectiles/missiles/multi_hit/targeted_ricochet/test_missile/test_targeted_ricochet_missile.tscn"),
}

var MISSILE_PATHS = {
	MissilesForSpawner.BISMUTH_LVL_1: "res://towers/buildable_towers/bismuth/level_1/bismuth_lvl_1_missile.tscn",
	MissilesForSpawner.TEST_TARGETED_RICOCHET_MISSILE: "res://projectiles/missiles/multi_hit/targeted_ricochet/test_missile/test_targeted_ricochet_missile.tscn",
}

var SINGLE_HIT_MISSILE_LOADS: Dictionary = {
	SingleHitMissiles.BISMUTH_LVL_1: load("res://towers/buildable_towers/bismuth/level_1/bismuth_lvl_1_missile.tscn")
}