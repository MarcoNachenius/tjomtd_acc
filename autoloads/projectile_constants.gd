extends Node


# ******************************************************************************************************************
#                                            PROJECTILE COMPONENT LOADS
# ******************************************************************************************************************
var HURTBOX_PRELOAD: PackedScene = load("res://projectiles/components/hurtbox/projectile_hurtbox.tscn")
var STUN_HURTBOX_PRELOAD: PackedScene = load("res://projectiles/components/stun_hurtbox/projectile_stun_hurtbox.tscn")
var RETARGET_HURTBOX_PRELOAD: PackedScene = load("res://projectiles/components/retarget_hurtbox/retarget_hurtbox.tscn")


# ******************************************************************************************************************
#                                                 PROJECTILE ENUMS
# ******************************************************************************************************************
enum ProjectileIDs {
	TEST_SINGLE_HIT_BULLET,
	BLACK_MARBLE_LVL_1,
	BLACK_MARBLE_LVL_2,
	BLACK_MARBLE_LVL_3,
	BISMUTH_LVL_1,
	LARIMAR_LVL_1,
	SUNSTONE_LVL_1,
	SUNSTONE_LVL_2,
	SUNSTONE_LVL_3,
	LARIMAR_LVL_2,
	SPINEL_LVL_1,
	SPINEL_LVL_2,
	KUNZITE_LVL_1,
	KUNZITE_LVL_2,
	KUNZITE_LVL_3,
	KUNZITE_LVL_4,
	KUNZITE_LVL_5,
	BISMUTH_LVL_2,
	BISMUTH_LVL_3,
	BISMUTH_LVL_4,
	BISMUTH_LVL_5,
	TOMBSTONE_LVL_1,
	BLACK_MARBLE_LVL_4,
	BLACK_MARBLE_LVL_5,
	SUNSTONE_LVL_4,
	SUNSTONE_LVL_5,
	SAM_SITE_LVL_1,
	LARIMAR_LVL_3,
	LARIMAR_LVL_4,
	LARIMAR_LVL_5,
	SPINEL_LVL_3,
	SPINEL_LVL_4,
	SPINEL_LVL_5,
	TOMBSTONE_LVL_2,
	TOMBSTONE_LVL_3,
	SAM_SITE_LVL_3,
}

# ******************************************************************************************************************
#                                                    BULLET ENUMS
# ******************************************************************************************************************
enum SingleHitBullets {
	BLACK_MARBLE_LVL_1,
	LARIMAR_LVL_1,
	SUNSTONE_LVL_1,
	SUNSTONE_LVL_2,
	SUNSTONE_LVL_3,
	KUNZITE_LVL_2,
	KUNZITE_LVL_4,
	LARIMAR_LVL_4
}

enum TargetedRicochetBullets {
	BLACK_MARBLE_LVL_3,
	BLACK_MARBLE_LVL_5
}

enum RandomRicochetBullets {
	TEST_RANDOM_RICOCHET_BULLET,
	BLACK_MARBLE_LVL_2,
	BLACK_MARBLE_LVL_4
}

enum BulletsForSpawner {
	BLACK_MARBLE_LVL_1,
	BLACK_MARBLE_LVL_2,
	BLACK_MARBLE_LVL_3,
	LARIMAR_LVL_1,
	SUNSTONE_LVL_1,
	SUNSTONE_LVL_2,
	SUNSTONE_LVL_3,
	KUNZITE_LVL_2,
	KUNZITE_LVL_4,
	BLACK_MARBLE_LVL_4,
	BLACK_MARBLE_LVL_5,
	LARIMAR_LVL_4
}


# ******************************************************************************************************************
#                                             MISSILES ENUMS
# ******************************************************************************************************************
enum SingleHitMissiles {
	BISMUTH_LVL_1,
	LARIMAR_LVL_2,
	SPINEL_LVL_1,
	SPINEL_LVL_2,
	KUNZITE_LVL_1,
	KUNZITE_LVL_3,
	KUNZITE_LVL_5,
	BISMUTH_LVL_2,
	BISMUTH_LVL_4,
	BISMUTH_LVL_5,
	SUNSTONE_LVL_4,
	SAM_SITE_LVL_1,
	LARIMAR_LVL_3,
	LARIMAR_LVL_5,
	SPINEL_LVL_3,
	SPINEL_LVL_4,
	SPINEL_LVL_5,
	SAM_SITE_LVL_3,
}

enum TargetedRicochetMissiles{
	TEST_TARGETED_RICOCHET_MISSILE,
	BISMUTH_LVL_3
}

enum RandomRicochetMissiles {
	TOMBSTONE_LVL_1,
	SUNSTONE_LVL_5,
	TOMBSTONE_LVL_2,
	TOMBSTONE_LVL_3,
}

enum MissilesForSpawner {
	BISMUTH_LVL_1,
	TEST_TARGETED_RICOCHET_MISSILE,
	SPINEL_LVL_1,
	SPINEL_LVL_2,
	KUNZITE_LVL_1,
	KUNZITE_LVL_3,
	KUNZITE_LVL_5,
	BISMUTH_LVL_2,
	BISMUTH_LVL_3,
	BISMUTH_LVL_4,
	BISMUTH_LVL_5,
	TOMBSTONE_LVL_1,
	SUNSTONE_LVL_4,
	SUNSTONE_LVL_5,
	SAM_SITE_LVL_1,
	LARIMAR_LVL_3,
	LARIMAR_LVL_5,
	SPINEL_LVL_3,
	SPINEL_LVL_4,
	SPINEL_LVL_5,
	TOMBSTONE_LVL_2,
	TOMBSTONE_LVL_3,
	SAM_SITE_LVL_3
}


# ******************************************************************************************************************
#                                               BULLET VARS
# ******************************************************************************************************************
var SINGLE_HIT_BULLET_LOADS: Dictionary[SingleHitBullets, PackedScene] = {
	SingleHitBullets.BLACK_MARBLE_LVL_1: load("res://towers/buildable_towers/black_marble/level_1/tower_bullet.tscn"),
	SingleHitBullets.LARIMAR_LVL_1: load("res://towers/buildable_towers/laminar/level_1/larimar_lvl_1_bullet.tscn"),
	SingleHitBullets.SUNSTONE_LVL_1: load("res://towers/buildable_towers/sunstone/level_1/sunstone_lvl_1_bullet.tscn"),
	SingleHitBullets.SUNSTONE_LVL_2: load("res://towers/buildable_towers/sunstone/level_2/sunstone_lvl_2_bullet.tscn"),
	SingleHitBullets.SUNSTONE_LVL_3: load("res://towers/buildable_towers/sunstone/level_3/sunstone_lvl_3_bullet.tscn"),
	SingleHitBullets.KUNZITE_LVL_2: load("res://towers/buildable_towers/kunzite/level_2/kunzite_lvl_2_bullet.tscn"),
	SingleHitBullets.KUNZITE_LVL_4: load("res://towers/buildable_towers/kunzite/level_4/kunzite_lvl_4_bullet.tscn"),
	SingleHitBullets.LARIMAR_LVL_4: load("res://towers/buildable_towers/laminar/level_4/larimar_lvl_4_bullet.tscn")
}

var TARGETED_RICOCHET_BULLET_LOADS: Dictionary[TargetedRicochetBullets, PackedScene] = {
	TargetedRicochetBullets.BLACK_MARBLE_LVL_3: load("res://towers/buildable_towers/black_marble/level_3/black_marble_lvl_3_bullet.tscn"),
	TargetedRicochetBullets.BLACK_MARBLE_LVL_5: load("res://towers/buildable_towers/black_marble/level_5/black_marble_lvl_5_bullet.tscn")
}

var RANDOM_RICOCHET_BULLET_LOADS: Dictionary[RandomRicochetBullets, PackedScene] = {
	RandomRicochetBullets.TEST_RANDOM_RICOCHET_BULLET: load("res://projectiles/bullets/multi_hit/random_ricochet/test_bullet/test_rrb.tscn"),
	RandomRicochetBullets.BLACK_MARBLE_LVL_2: load("res://towers/buildable_towers/black_marble/level_2/bm_lvl_2_bullet.tscn"),
	RandomRicochetBullets.BLACK_MARBLE_LVL_4: load("res://towers/buildable_towers/black_marble/level_4/black_marble_lvl_4_bullet.tscn")
}

const BULLET_PATHS: Dictionary = {
	BulletsForSpawner.BLACK_MARBLE_LVL_1: "res://towers/buildable_towers/black_marble/level_1/tower_bullet.tscn",
	BulletsForSpawner.BLACK_MARBLE_LVL_2: "res://towers/buildable_towers/black_marble/level_2/bm_lvl_2_bullet.tscn",
	BulletsForSpawner.BLACK_MARBLE_LVL_3: "res://towers/buildable_towers/black_marble/level_3/black_marble_lvl_3_bullet.tscn",
	BulletsForSpawner.BLACK_MARBLE_LVL_4: "res://towers/buildable_towers/black_marble/level_4/black_marble_lvl_4_bullet.tscn",
	BulletsForSpawner.BLACK_MARBLE_LVL_5: "res://towers/buildable_towers/black_marble/level_5/black_marble_lvl_5_bullet.tscn",
	BulletsForSpawner.LARIMAR_LVL_1: "res://towers/buildable_towers/laminar/level_1/larimar_lvl_1_bullet.tscn",
	BulletsForSpawner.SUNSTONE_LVL_1: "res://towers/buildable_towers/sunstone/level_1/sunstone_lvl_1_bullet.tscn",
	BulletsForSpawner.SUNSTONE_LVL_2: "res://towers/buildable_towers/sunstone/level_2/sunstone_lvl_2_bullet.tscn",
	BulletsForSpawner.SUNSTONE_LVL_3: "res://towers/buildable_towers/sunstone/level_3/sunstone_lvl_3_bullet.tscn",
	BulletsForSpawner.KUNZITE_LVL_2: "res://towers/buildable_towers/kunzite/level_2/kunzite_lvl_2_bullet.tscn",
	BulletsForSpawner.KUNZITE_LVL_4: "res://towers/buildable_towers/kunzite/level_4/kunzite_lvl_4_bullet.tscn",
	BulletsForSpawner.LARIMAR_LVL_4: "res://towers/buildable_towers/laminar/level_4/larimar_lvl_4_bullet.tscn"
	
}


# ******************************************************************************************************************
#                                              MISSILE VARS
# ******************************************************************************************************************
var TARGETED_RICOCHET_MISSILE_LOADS: Dictionary = {
	TargetedRicochetMissiles.TEST_TARGETED_RICOCHET_MISSILE: load("res://projectiles/missiles/multi_hit/targeted_ricochet/test_missile/test_targeted_ricochet_missile.tscn"),
	TargetedRicochetMissiles.BISMUTH_LVL_3: load("res://towers/buildable_towers/bismuth/level_3/bismuth_lvl_3_missile.tscn")
}

var RANDOM_RICOCHET_MISSILE_LOADS: Dictionary[RandomRicochetMissiles, PackedScene] = {
	RandomRicochetMissiles.TOMBSTONE_LVL_1: load("res://towers/upgrade_towers/tombstone/level_1/tombstone_lvl_1_missile.tscn"),
	RandomRicochetMissiles.SUNSTONE_LVL_5: load("res://towers/buildable_towers/sunstone/level_5/sunstone_lvl_5_missile.tscn"),
	RandomRicochetMissiles.TOMBSTONE_LVL_2: load("res://towers/upgrade_towers/tombstone/level_2/tombstone_lvl_2_missile.tscn"),
	RandomRicochetMissiles.TOMBSTONE_LVL_3: load("res://towers/upgrade_towers/tombstone/level_3/tombstone_lvl_3_missile.tscn")
}

const MISSILE_PATHS: Dictionary[MissilesForSpawner, String] = {
	MissilesForSpawner.BISMUTH_LVL_1: "res://towers/buildable_towers/bismuth/level_1/bismuth_lvl_1_missile.tscn",
	MissilesForSpawner.TEST_TARGETED_RICOCHET_MISSILE: "res://projectiles/missiles/multi_hit/targeted_ricochet/test_missile/test_targeted_ricochet_missile.tscn",
	MissilesForSpawner.SPINEL_LVL_1: "res://towers/buildable_towers/spinel/level_1/spinel_lvl_1_missile.tscn",
	MissilesForSpawner.SPINEL_LVL_2: "res://towers/buildable_towers/spinel/level_2/spinel_lvl_2_missile.tscn",
	MissilesForSpawner.SPINEL_LVL_3: "res://towers/buildable_towers/spinel/level_3/spinel_lvl_3_missile.tscn",
	MissilesForSpawner.SPINEL_LVL_4: "res://towers/buildable_towers/spinel/level_4/spinel_lvl_4_missile.tscn",
	MissilesForSpawner.SPINEL_LVL_5: "res://towers/buildable_towers/spinel/level_5/spinel_lvl_5_missile.tscn",
	MissilesForSpawner.KUNZITE_LVL_1: "res://towers/buildable_towers/bismuth/level_1/bismuth_lvl_1_missile.tscn",
	MissilesForSpawner.KUNZITE_LVL_3: "res://towers/buildable_towers/kunzite/level_3/kunzite_lvl_3_missile.tscn",
	MissilesForSpawner.KUNZITE_LVL_5: "res://towers/buildable_towers/kunzite/level_5/kunzute_lvl_5_missile.tscn",
	MissilesForSpawner.BISMUTH_LVL_2: "res://towers/buildable_towers/bismuth/level_2/bismuth_lvl_2_missile.tscn",
	MissilesForSpawner.BISMUTH_LVL_3: "res://towers/buildable_towers/bismuth/level_3/bismuth_lvl_3_missile.tscn",
	MissilesForSpawner.BISMUTH_LVL_4: "res://towers/buildable_towers/bismuth/level_4/bismuth_lvl_4_missile.tscn",
	MissilesForSpawner.BISMUTH_LVL_5: "res://towers/buildable_towers/bismuth/level_5/bismuth_lvl_5_missile.tscn",
	MissilesForSpawner.TOMBSTONE_LVL_1: "res://towers/upgrade_towers/tombstone/level_1/tombstone_lvl_1_missile.tscn",
	MissilesForSpawner.SUNSTONE_LVL_4: "res://towers/buildable_towers/sunstone/level_4/sunstone_lvl_4_missile.tscn",
	MissilesForSpawner.SUNSTONE_LVL_5: "res://towers/buildable_towers/sunstone/level_5/sunstone_lvl_5_missile.tscn",
	MissilesForSpawner.SAM_SITE_LVL_1: "res://towers/upgrade_towers/sam_site/level_1/sam_site_lvl_1_missile.tscn",
	MissilesForSpawner.LARIMAR_LVL_3: "res://towers/buildable_towers/laminar/level_3/larimar_lvl_3_missile.tscn",
	MissilesForSpawner.LARIMAR_LVL_5: "res://towers/buildable_towers/laminar/level_5/larimar_lvl_5_missile.tscn",
	MissilesForSpawner.TOMBSTONE_LVL_2: "res://towers/upgrade_towers/tombstone/level_2/tombstone_lvl_2_missile.tscn",
	MissilesForSpawner.TOMBSTONE_LVL_3: "res://towers/upgrade_towers/tombstone/level_3/tombstone_lvl_3_missile.tscn",
	MissilesForSpawner.SAM_SITE_LVL_3: "res://towers/upgrade_towers/sam_site/level_3/sam_site_lvl_3_missile.tscn"
	
}

var SINGLE_HIT_MISSILE_LOADS: Dictionary[SingleHitMissiles, PackedScene] = {
	SingleHitMissiles.BISMUTH_LVL_1: load("res://towers/buildable_towers/bismuth/level_1/bismuth_lvl_1_missile.tscn"),
	SingleHitMissiles.LARIMAR_LVL_2: load("res://towers/buildable_towers/laminar/level_2/larimar_lvl_2_missile.tscn"),
	SingleHitMissiles.SPINEL_LVL_1: load("res://towers/buildable_towers/spinel/level_1/spinel_lvl_1_missile.tscn"),
	SingleHitMissiles.SPINEL_LVL_2: load("res://towers/buildable_towers/spinel/level_2/spinel_lvl_2_missile.tscn"),
	SingleHitMissiles.KUNZITE_LVL_1: load("res://towers/buildable_towers/bismuth/level_1/bismuth_lvl_1_missile.tscn"),
	SingleHitMissiles.KUNZITE_LVL_3: load("res://towers/buildable_towers/kunzite/level_3/kunzite_lvl_3_missile.tscn"),
	SingleHitMissiles.KUNZITE_LVL_5: load("res://towers/buildable_towers/kunzite/level_5/kunzute_lvl_5_missile.tscn"),
	SingleHitMissiles.BISMUTH_LVL_2: load("res://towers/buildable_towers/bismuth/level_2/bismuth_lvl_2_missile.tscn"),
	SingleHitMissiles.BISMUTH_LVL_4: load("res://towers/buildable_towers/bismuth/level_4/bismuth_lvl_4_missile.tscn"),
	SingleHitMissiles.BISMUTH_LVL_5: load("res://towers/buildable_towers/bismuth/level_5/bismuth_lvl_5_missile.tscn"),
	SingleHitMissiles.SUNSTONE_LVL_4: load("res://towers/buildable_towers/sunstone/level_4/sunstone_lvl_4_missile.tscn"),
	SingleHitMissiles.SAM_SITE_LVL_1: load("res://towers/upgrade_towers/sam_site/level_1/sam_site_lvl_1_missile.tscn"),
	SingleHitMissiles.LARIMAR_LVL_3: load("res://towers/buildable_towers/laminar/level_3/larimar_lvl_3_missile.tscn"),
	SingleHitMissiles.LARIMAR_LVL_5: load("res://towers/buildable_towers/laminar/level_5/larimar_lvl_5_missile.tscn"),
	SingleHitMissiles.SPINEL_LVL_3: load("res://towers/buildable_towers/spinel/level_3/spinel_lvl_3_missile.tscn"),
	SingleHitMissiles.SPINEL_LVL_4: load("res://towers/buildable_towers/spinel/level_4/spinel_lvl_4_missile.tscn"),
	SingleHitMissiles.SPINEL_LVL_5: load("res://towers/buildable_towers/spinel/level_5/spinel_lvl_5_missile.tscn"),
	SingleHitMissiles.SAM_SITE_LVL_3: load("res://towers/upgrade_towers/sam_site/level_3/sam_site_lvl_3_missile.tscn"),
}