extends Node

var HURTBOX_PRELOAD: PackedScene = load("res://projectiles/components/hurtbox/projectile_hurtbox.tscn")
var STUN_HURTBOX_PRELOAD: PackedScene = load("res://projectiles/components/stun_hurtbox/projectile_stun_hurtbox.tscn")

enum ProjectileIDs {
	TEST_SINGLE_HIT_BULLET,
	BLACK_MARBLE_LVL_1,
	BLACK_MARBLE_LVL_2,
	BLACK_MARBLE_LVL_3,
	BISMUTH_LVL_1,
	TEST_RANDOM_RICOCHET_BULLET,
	TEST_TARGETED_RICOCHET_MISSILE,
}

enum SingleHitBullets {
	BLACK_MARBLE_LVL_1
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

var SINGLE_HIT_MISSILE_LOADS: Dictionary = {
	SingleHitMissiles.BISMUTH_LVL_1: load("res://towers/buildable_towers/bismuth/level_1/bismuth_lvl_1_missile.tscn")
}

var SINGLE_HIT_BULLET_LOADS: Dictionary = {
	SingleHitBullets.BLACK_MARBLE_LVL_1: load("res://towers/buildable_towers/black_marble/level_1/tower_bullet.tscn")
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
	BulletsForSpawner.TEST_RANDOM_RICOCHET_BULLET: "res://projectiles/bullets/multi_hit/random_ricochet/test_bullet/test_rrb.tscn",
}

enum BulletsForSpawner {
	BLACK_MARBLE_LVL_1,
	BLACK_MARBLE_LVL_2,
	BLACK_MARBLE_LVL_3,
	TEST_RANDOM_RICOCHET_BULLET,
}


# ********
# MISSILES
# ********

enum TargetedRicochetMissiles{
	TEST_TARGETED_RICOCHET_MISSILE,
}

var TARGETED_RICOCHET_MISSILE_LOADS: Dictionary = {
	TargetedRicochetMissiles.TEST_TARGETED_RICOCHET_MISSILE: load("res://projectiles/missiles/multi_hit/targeted_ricochet/test_missile/test_targeted_ricochet_missile.tscn"),
}