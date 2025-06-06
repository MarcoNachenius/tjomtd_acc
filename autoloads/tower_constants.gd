extends Node


# NB: Add new towers to the END of the enum list to avoid breaking current tower IDs assignment.
enum TowerIDs {
    BARRICADE,
    BLACK_MARBLE_LVL_1,
    BLACK_MARBLE_LVL_2,
    BLACK_MARBLE_LVL_3,
    BLACK_MARBLE_LVL_4,
    BLACK_MARBLE_LVL_5,
    BISMUTH_LVL_1,
    BISMUTH_LVL_2,
    BISMUTH_LVL_3,
    BISMUTH_LVL_4,
    BISMUTH_LVL_5,
    LARIMAR_LVL_1,
    LARIMAR_LVL_2,
    LARIMAR_LVL_3,
    LARIMAR_LVL_4,
    LARIMAR_LVL_5,
    SUNSTONE_LVL_1,
    SUNSTONE_LVL_2,
    SUNSTONE_LVL_3,
    SUNSTONE_LVL_4,
    SUNSTONE_LVL_5,
    TOMBSTONE_LVL_1,
    TOMBSTONE_LVL_2,
    SPINEL_LVL_1,
    SPINEL_LVL_2,
    SPINEL_LVL_3,
    SPINEL_LVL_4,
    SPINEL_LVL_5,
    KUNZITE_LVL_1,
    KUNZITE_LVL_2,
    KUNZITE_LVL_3,
    KUNZITE_LVL_4,
    KUNZITE_LVL_5,
    SAM_SITE_LVL_1,
    SAM_SITE_LVL_2,    
}

enum BuildTowerIDs {
    BARRICADE = TowerIDs.BARRICADE,
    BLACK_MARBLE_LVL_1 = TowerIDs.BLACK_MARBLE_LVL_1,
    BLACK_MARBLE_LVL_2 = TowerIDs.BLACK_MARBLE_LVL_2,
    BLACK_MARBLE_LVL_3 = TowerIDs.BLACK_MARBLE_LVL_3,
    BLACK_MARBLE_LVL_4 = TowerIDs.BLACK_MARBLE_LVL_4,
    BLACK_MARBLE_LVL_5 = TowerIDs.BLACK_MARBLE_LVL_5,
    BISMUTH_LVL_1 = TowerIDs.BISMUTH_LVL_1,
    BISMUTH_LVL_2 = TowerIDs.BISMUTH_LVL_2,
    BISMUTH_LVL_3 = TowerIDs.BISMUTH_LVL_3,
    BISMUTH_LVL_4 = TowerIDs.BISMUTH_LVL_4,
    BISMUTH_LVL_5 = TowerIDs.BISMUTH_LVL_5,
    LARIMAR_LVL_1 = TowerIDs.LARIMAR_LVL_1,
    LARIMAR_LVL_2 = TowerIDs.LARIMAR_LVL_2,
    LARIMAR_LVL_3 = TowerIDs.LARIMAR_LVL_3,
    LARIMAR_LVL_4 = TowerIDs.LARIMAR_LVL_4,
    LARIMAR_LVL_5 = TowerIDs.LARIMAR_LVL_5,
    SUNSTONE_LVL_1  = TowerIDs.SUNSTONE_LVL_1,
    SUNSTONE_LVL_2  = TowerIDs.SUNSTONE_LVL_2,
    SUNSTONE_LVL_3  = TowerIDs.SUNSTONE_LVL_3,
    SUNSTONE_LVL_4  = TowerIDs.SUNSTONE_LVL_4,
    SUNSTONE_LVL_5  = TowerIDs.SUNSTONE_LVL_5,
    SPINEL_LVL_1  = TowerIDs.SPINEL_LVL_1,
    SPINEL_LVL_2  = TowerIDs.SPINEL_LVL_2,
    SPINEL_LVL_3  = TowerIDs.SPINEL_LVL_3,
    SPINEL_LVL_4  = TowerIDs.SPINEL_LVL_4,
    SPINEL_LVL_5  = TowerIDs.SPINEL_LVL_5,
    KUNZITE_LVL_1  = TowerIDs.KUNZITE_LVL_1,
    KUNZITE_LVL_2  = TowerIDs.KUNZITE_LVL_2,
    KUNZITE_LVL_3  = TowerIDs.KUNZITE_LVL_3,
    KUNZITE_LVL_4  = TowerIDs.KUNZITE_LVL_4,
    KUNZITE_LVL_5  = TowerIDs.KUNZITE_LVL_5,
}

enum UpgradeTowerIDs {
    TOMBSTONE_LVL_1 = TowerIDs.TOMBSTONE_LVL_1,
    TOMBSTONE_LVL_2 = TowerIDs.TOMBSTONE_LVL_2,
    SAM_SITE_LVL_1 = TowerIDs.SAM_SITE_LVL_1,
    SAM_SITE_LVL_2 = TowerIDs.SAM_SITE_LVL_2,
}

var UPGRADE_TOWER_PRELOADS: Dictionary[UpgradeTowerIDs, PackedScene] = {
    UpgradeTowerIDs.TOMBSTONE_LVL_1: load("res://towers/upgrade_towers/tombstone/level_1/tombstone_level_1.tscn"),
    UpgradeTowerIDs.TOMBSTONE_LVL_2: load("res://towers/upgrade_towers/tombstone/level_2/tombstone_lvl_2_tower.tscn"),
    UpgradeTowerIDs.SAM_SITE_LVL_1: load("res://towers/upgrade_towers/sam_site/level_1/sam_site_lvl_1_tower.tscn"),
    UpgradeTowerIDs.SAM_SITE_LVL_2: load("res://towers/upgrade_towers/sam_site/level_2/sam_site_lvl_2_tower.tscn"),
}


var BUILD_TOWER_PRELOADS: Dictionary[BuildTowerIDs, PackedScene] = {
    BuildTowerIDs.BARRICADE: load("res://towers/barricade/tower_barricade.tscn"),
    BuildTowerIDs.BLACK_MARBLE_LVL_1: load("res://towers/buildable_towers/black_marble/level_1/black_marble_lvl_1.tscn"),
    BuildTowerIDs.BLACK_MARBLE_LVL_2: load("res://towers/buildable_towers/black_marble/level_2/black_marble_lvl_2.tscn"),
    BuildTowerIDs.BLACK_MARBLE_LVL_3: load("res://towers/buildable_towers/black_marble/level_3/black_marble_lvl_3_tower.tscn"),
    BuildTowerIDs.BLACK_MARBLE_LVL_4: load("res://towers/buildable_towers/black_marble/level_4/black_marble_lvl_4_tower.tscn"),
    BuildTowerIDs.BLACK_MARBLE_LVL_5: load("res://towers/buildable_towers/black_marble/level_5/black_marble_lvl_5_tower.tscn"),
    BuildTowerIDs.BISMUTH_LVL_1: load("res://towers/buildable_towers/bismuth/level_1/bismuth_lvl_1_tower.tscn"),
    BuildTowerIDs.BISMUTH_LVL_2: load("res://towers/buildable_towers/bismuth/level_2/bismuth_lvl_2_tower.tscn"),
    BuildTowerIDs.BISMUTH_LVL_3: load("res://towers/buildable_towers/bismuth/level_3/bismuth_lvl_3_tower.tscn"),
    BuildTowerIDs.BISMUTH_LVL_4: load("res://towers/buildable_towers/bismuth/level_4/bismuth_lvl_4_tower.tscn"),
    BuildTowerIDs.BISMUTH_LVL_5: load("res://towers/buildable_towers/bismuth/level_5/bismuth_lvl_5_tower.tscn"),
    BuildTowerIDs.LARIMAR_LVL_1: load("res://towers/buildable_towers/laminar/level_1/larimar_lvl_1.tscn"),
    BuildTowerIDs.LARIMAR_LVL_2: load("res://towers/buildable_towers/laminar/level_2/larimar_lvl_2.tscn"),
    BuildTowerIDs.LARIMAR_LVL_3: load("res://towers/buildable_towers/laminar/level_3/larimar_lvl_3_tower.tscn"),
    BuildTowerIDs.LARIMAR_LVL_4: load("res://towers/buildable_towers/laminar/level_4/larimar_lvl_4_tower.tscn"),
    BuildTowerIDs.LARIMAR_LVL_5: load("res://towers/buildable_towers/laminar/level_5/larimar_lvl_5_tower.tscn"),
    BuildTowerIDs.SUNSTONE_LVL_1: load("res://towers/buildable_towers/sunstone/level_1/sunstone_level_1_tower.tscn"),
    BuildTowerIDs.SUNSTONE_LVL_2: load("res://towers/buildable_towers/sunstone/level_2/sunstone_lvl_2_tower.tscn"),
    BuildTowerIDs.SUNSTONE_LVL_3: load("res://towers/buildable_towers/sunstone/level_3/sunstone_lvl_3_tower.tscn"),
    BuildTowerIDs.SUNSTONE_LVL_4: load("res://towers/buildable_towers/sunstone/level_4/sunstone_lvl_4_tower.tscn"),
    BuildTowerIDs.SUNSTONE_LVL_5: load("res://towers/buildable_towers/sunstone/level_5/sunstone_lvl_5_tower.tscn"),
    BuildTowerIDs.SPINEL_LVL_1: load("res://towers/buildable_towers/spinel/level_1/spinel_lvl_1_tower.tscn"),
    BuildTowerIDs.SPINEL_LVL_2: load("res://towers/buildable_towers/spinel/level_2/spinel_lvl_2_tower.tscn"),
    BuildTowerIDs.SPINEL_LVL_3: load("res://towers/buildable_towers/spinel/level_3/spinel_lvl_3_tower.tscn"),
    BuildTowerIDs.SPINEL_LVL_4: load("res://towers/buildable_towers/spinel/level_4/spinel_lvl_4_tower.tscn"),
    BuildTowerIDs.SPINEL_LVL_5: load("res://towers/buildable_towers/spinel/level_5/spinel_lvl_5_tower.tscn"),
    BuildTowerIDs.KUNZITE_LVL_1: load("res://towers/buildable_towers/kunzite/level_1/kunzite_lvl_1_tower.tscn"),
    BuildTowerIDs.KUNZITE_LVL_2: load("res://towers/buildable_towers/kunzite/level_2/kunzite_lvl_2_tower.tscn"),
    BuildTowerIDs.KUNZITE_LVL_3: load("res://towers/buildable_towers/kunzite/level_3/kunzite_lvl_3_tower.tscn"),
    BuildTowerIDs.KUNZITE_LVL_4: load("res://towers/buildable_towers/kunzite/level_4/kunzite_lvl_4_tower.tscn"),
    BuildTowerIDs.KUNZITE_LVL_5: load("res://towers/buildable_towers/kunzite/level_5/kunzite_lvl_5_tower.tscn"),
}

var ALL_TOWER_LOADS: Dictionary[TowerIDs, PackedScene] = {
    TowerIDs.BARRICADE: load("res://towers/barricade/tower_barricade.tscn"),
    TowerIDs.BLACK_MARBLE_LVL_1: load("res://towers/buildable_towers/black_marble/level_1/black_marble_lvl_1.tscn"),
    TowerIDs.BLACK_MARBLE_LVL_2: load("res://towers/buildable_towers/black_marble/level_2/black_marble_lvl_2.tscn"),
    TowerIDs.BLACK_MARBLE_LVL_3: load("res://towers/buildable_towers/black_marble/level_3/black_marble_lvl_3_tower.tscn"),
    TowerIDs.BLACK_MARBLE_LVL_4: load("res://towers/buildable_towers/black_marble/level_4/black_marble_lvl_4_tower.tscn"),
    TowerIDs.BLACK_MARBLE_LVL_5: load("res://towers/buildable_towers/black_marble/level_5/black_marble_lvl_5_tower.tscn"),
    TowerIDs.BISMUTH_LVL_1: load("res://towers/buildable_towers/bismuth/level_1/bismuth_lvl_1_tower.tscn"),
    TowerIDs.BISMUTH_LVL_2: load("res://towers/buildable_towers/bismuth/level_2/bismuth_lvl_2_tower.tscn"),
    TowerIDs.BISMUTH_LVL_3: load("res://towers/buildable_towers/bismuth/level_3/bismuth_lvl_3_tower.tscn"),
    TowerIDs.BISMUTH_LVL_4: load("res://towers/buildable_towers/bismuth/level_4/bismuth_lvl_4_tower.tscn"),
    TowerIDs.BISMUTH_LVL_5: load("res://towers/buildable_towers/bismuth/level_5/bismuth_lvl_5_tower.tscn"),
    TowerIDs.LARIMAR_LVL_1: load("res://towers/buildable_towers/laminar/level_1/larimar_lvl_1.tscn"),
    TowerIDs.LARIMAR_LVL_2: load("res://towers/buildable_towers/laminar/level_2/larimar_lvl_2.tscn"),
    TowerIDs.LARIMAR_LVL_3: load("res://towers/buildable_towers/laminar/level_3/larimar_lvl_3_tower.tscn"),
    TowerIDs.LARIMAR_LVL_4: load("res://towers/buildable_towers/laminar/level_4/larimar_lvl_4_tower.tscn"),
    TowerIDs.LARIMAR_LVL_5: load("res://towers/buildable_towers/laminar/level_5/larimar_lvl_5_tower.tscn"),
    TowerIDs.SUNSTONE_LVL_1: load("res://towers/buildable_towers/sunstone/level_1/sunstone_level_1_tower.tscn"),
    TowerIDs.SUNSTONE_LVL_2: load("res://towers/buildable_towers/sunstone/level_2/sunstone_lvl_2_tower.tscn"),
    TowerIDs.SUNSTONE_LVL_3: load("res://towers/buildable_towers/sunstone/level_3/sunstone_lvl_3_tower.tscn"),
    TowerIDs.SUNSTONE_LVL_4: load("res://towers/buildable_towers/sunstone/level_4/sunstone_lvl_4_tower.tscn"),
    TowerIDs.SUNSTONE_LVL_5: load("res://towers/buildable_towers/sunstone/level_5/sunstone_lvl_5_tower.tscn"),
    TowerIDs.TOMBSTONE_LVL_1: load("res://towers/upgrade_towers/tombstone/level_1/tombstone_level_1.tscn"),
    TowerIDs.TOMBSTONE_LVL_2: load("res://towers/upgrade_towers/tombstone/level_2/tombstone_lvl_2_tower.tscn"),
    TowerIDs.SPINEL_LVL_1: load("res://towers/buildable_towers/spinel/level_1/spinel_lvl_1_tower.tscn"),
    TowerIDs.SPINEL_LVL_2: load("res://towers/buildable_towers/spinel/level_2/spinel_lvl_2_tower.tscn"),
    TowerIDs.SPINEL_LVL_3: load("res://towers/buildable_towers/spinel/level_3/spinel_lvl_3_tower.tscn"),
    TowerIDs.SPINEL_LVL_4: load("res://towers/buildable_towers/spinel/level_4/spinel_lvl_4_tower.tscn"),
    TowerIDs.SPINEL_LVL_5: load("res://towers/buildable_towers/spinel/level_5/spinel_lvl_5_tower.tscn"),
    TowerIDs.KUNZITE_LVL_1: load("res://towers/buildable_towers/kunzite/level_1/kunzite_lvl_1_tower.tscn"),
    TowerIDs.KUNZITE_LVL_2: load("res://towers/buildable_towers/kunzite/level_2/kunzite_lvl_2_tower.tscn"),
    TowerIDs.KUNZITE_LVL_3: load("res://towers/buildable_towers/kunzite/level_3/kunzite_lvl_3_tower.tscn"),
    TowerIDs.KUNZITE_LVL_4: load("res://towers/buildable_towers/kunzite/level_4/kunzite_lvl_4_tower.tscn"),
    TowerIDs.KUNZITE_LVL_5: load("res://towers/buildable_towers/kunzite/level_5/kunzite_lvl_5_tower.tscn"),
    TowerIDs.SAM_SITE_LVL_1: load("res://towers/upgrade_towers/sam_site/level_1/sam_site_lvl_1_tower.tscn"),
    TowerIDs.SAM_SITE_LVL_2: load("res://towers/upgrade_towers/sam_site/level_2/sam_site_lvl_2_tower.tscn"),

}

const TowerPrices: Dictionary[TowerIDs, int] = {
    TowerIDs.BARRICADE: 0,
    TowerIDs.BLACK_MARBLE_LVL_1: 0,
    TowerIDs.BLACK_MARBLE_LVL_2: 0,
    TowerIDs.BLACK_MARBLE_LVL_3: 0,
    TowerIDs.BLACK_MARBLE_LVL_4: 0,
    TowerIDs.BLACK_MARBLE_LVL_5: 0,
    TowerIDs.BISMUTH_LVL_1: 0,
    TowerIDs.BISMUTH_LVL_2: 0,
    TowerIDs.BISMUTH_LVL_3: 0,
    TowerIDs.BISMUTH_LVL_4: 0,
    TowerIDs.BISMUTH_LVL_5: 0,
    TowerIDs.LARIMAR_LVL_1: 0,
    TowerIDs.LARIMAR_LVL_2: 0,
    TowerIDs.LARIMAR_LVL_3: 0,
    TowerIDs.LARIMAR_LVL_4: 0,
    TowerIDs.LARIMAR_LVL_5: 0,
    TowerIDs.SUNSTONE_LVL_1: 0,
    TowerIDs.SUNSTONE_LVL_2: 0,
    TowerIDs.SUNSTONE_LVL_3: 0,
    TowerIDs.SUNSTONE_LVL_4: 0,
    TowerIDs.SUNSTONE_LVL_5: 0,
    TowerIDs.KUNZITE_LVL_1: 0,
    TowerIDs.KUNZITE_LVL_2: 0,
    TowerIDs.KUNZITE_LVL_3: 0,
    TowerIDs.KUNZITE_LVL_4: 0,
    TowerIDs.KUNZITE_LVL_5: 0,
    TowerIDs.SPINEL_LVL_1: 0,
    TowerIDs.SPINEL_LVL_2: 0,
    TowerIDs.SPINEL_LVL_3: 0,
    TowerIDs.SPINEL_LVL_4: 0,
    TowerIDs.SPINEL_LVL_5: 0,
    TowerIDs.TOMBSTONE_LVL_1: 0,
    TowerIDs.TOMBSTONE_LVL_2: 500,
    TowerIDs.SAM_SITE_LVL_1: 0,
    TowerIDs.SAM_SITE_LVL_2: 50
}


const UPGRADES_INTO: Dictionary = {
    TowerIDs.BARRICADE: BARRICADE_UPGRADES_INTO,
    TowerIDs.BLACK_MARBLE_LVL_1: BLACK_MARBLE_LVL_1_UPGRADES_INTO,
    TowerIDs.BLACK_MARBLE_LVL_2: BLACK_MARBLE_LVL_2_UPGRADES_INTO,
    TowerIDs.BLACK_MARBLE_LVL_3: BLACK_MARBLE_LVL_3_UPGRADES_INTO,
    TowerIDs.BLACK_MARBLE_LVL_4: BLACK_MARBLE_LVL_4_UPGRADES_INTO,
    TowerIDs.BLACK_MARBLE_LVL_5: BLACK_MARBLE_LVL_5_UPGRADES_INTO,
    TowerIDs.BISMUTH_LVL_1: BISMUTH_LVL_1_UPGRADES_INTO,
    TowerIDs.BISMUTH_LVL_2: BISMUTH_LVL_2_UPGRADES_INTO,
    TowerIDs.BISMUTH_LVL_3: BISMUTH_LVL_3_UPGRADES_INTO,
    TowerIDs.BISMUTH_LVL_4: BISMUTH_LVL_4_UPGRADES_INTO,
    TowerIDs.BISMUTH_LVL_5: BISMUTH_LVL_5_UPGRADES_INTO,
    TowerIDs.LARIMAR_LVL_1: LARIMAR_LVL_1_UPGRADES_INTO,
    TowerIDs.LARIMAR_LVL_2: LARIMAR_LVL_2_UPGRADES_INTO,
    TowerIDs.LARIMAR_LVL_3: LARIMAR_LVL_3_UPGRADES_INTO,
    TowerIDs.LARIMAR_LVL_4: LARIMAR_LVL_4_UPGRADES_INTO,
    TowerIDs.LARIMAR_LVL_5: LARIMAR_LVL_5_UPGRADES_INTO,
    TowerIDs.SUNSTONE_LVL_1: SUNSTONE_LVL_1_UPGRADES_INTO,
    TowerIDs.SUNSTONE_LVL_2: SUNSTONE_LVL_2_UPGRADES_INTO,
    TowerIDs.SUNSTONE_LVL_3: SUNSTONE_LVL_3_UPGRADES_INTO,
    TowerIDs.SUNSTONE_LVL_4: SUNSTONE_LVL_4_UPGRADES_INTO,
    TowerIDs.SUNSTONE_LVL_5: SUNSTONE_LVL_5_UPGRADES_INTO,
    TowerIDs.SPINEL_LVL_1: SPINEL_LVL_1_UPGRADES_INTO,
    TowerIDs.SPINEL_LVL_2: SPINEL_LVL_2_UPGRADES_INTO,
    TowerIDs.SPINEL_LVL_3: SPINEL_LVL_3_UPGRADES_INTO,
    TowerIDs.SPINEL_LVL_4: SPINEL_LVL_4_UPGRADES_INTO,
    TowerIDs.SPINEL_LVL_5: SPINEL_LVL_5_UPGRADES_INTO,
    TowerIDs.TOMBSTONE_LVL_1: TOMBSTONE_LVL_1_UPGRADES_INTO,
    TowerIDs.TOMBSTONE_LVL_2: TOMBSTONE_LVL_2_UPGRADES_INTO,
    TowerIDs.KUNZITE_LVL_1: KUNZITE_LVL_1_UPGRADES_INTO,
    TowerIDs.KUNZITE_LVL_2: KUNZITE_LVL_2_UPGRADES_INTO,
    TowerIDs.KUNZITE_LVL_3: KUNZITE_LVL_3_UPGRADES_INTO,
    TowerIDs.KUNZITE_LVL_4: KUNZITE_LVL_4_UPGRADES_INTO,
    TowerIDs.KUNZITE_LVL_5: KUNZITE_LVL_5_UPGRADES_INTO,
    TowerIDs.SAM_SITE_LVL_1: SAM_SITE_LVL_1_UPGRADES_INTO,
    TowerIDs.SAM_SITE_LVL_2: SAM_SITE_LVL_2_UPGRADES_INTO,

}

const REQUIRES_TOWERS: Dictionary = {
    TowerIDs.BARRICADE: BARRICADE_REQUIRES_TOWERS,
    TowerIDs.BLACK_MARBLE_LVL_1: BLACK_MARBLE_LVL_1_REQUIRES_TOWERS,
    TowerIDs.BLACK_MARBLE_LVL_2: BLACK_MARBLE_LVL_2_REQUIRES_TOWERS,
    TowerIDs.BLACK_MARBLE_LVL_3: BLACK_MARBLE_LVL_3_REQUIRES_TOWERS,
    TowerIDs.BLACK_MARBLE_LVL_4: BLACK_MARBLE_LVL_4_REQUIRES_TOWERS,
    TowerIDs.BLACK_MARBLE_LVL_5: BLACK_MARBLE_LVL_5_REQUIRES_TOWERS,
    TowerIDs.BISMUTH_LVL_1: BISMUTH_LVL_1_REQUIRES_TOWERS,
    TowerIDs.BISMUTH_LVL_2: BISMUTH_LVL_2_REQUIRES_TOWERS,
    TowerIDs.BISMUTH_LVL_3: BISMUTH_LVL_3_REQUIRES_TOWERS,
    TowerIDs.BISMUTH_LVL_4: BISMUTH_LVL_4_REQUIRES_TOWERS,
    TowerIDs.BISMUTH_LVL_5: BISMUTH_LVL_5_REQUIRES_TOWERS,
    TowerIDs.LARIMAR_LVL_1: LARIMAR_LVL_1_REQUIRES_TOWERS,
    TowerIDs.LARIMAR_LVL_2: LARIMAR_LVL_2_REQUIRES_TOWERS,
    TowerIDs.LARIMAR_LVL_3: LARIMAR_LVL_3_REQUIRES_TOWERS,
    TowerIDs.LARIMAR_LVL_4: LARIMAR_LVL_4_REQUIRES_TOWERS,
    TowerIDs.LARIMAR_LVL_5: LARIMAR_LVL_5_REQUIRES_TOWERS,
    TowerIDs.SUNSTONE_LVL_1: SUNSTONE_LVL_1_REQUIRES_TOWERS,
    TowerIDs.SUNSTONE_LVL_2: SUNSTONE_LVL_2_REQUIRES_TOWERS,
    TowerIDs.SUNSTONE_LVL_3: SUNSTONE_LVL_3_REQUIRES_TOWERS,
    TowerIDs.SUNSTONE_LVL_4: SUNSTONE_LVL_4_REQUIRES_TOWERS,
    TowerIDs.SUNSTONE_LVL_5: SUNSTONE_LVL_5_REQUIRES_TOWERS,
    TowerIDs.SPINEL_LVL_1: SPINEL_LVL_1_REQUIRES_TOWERS,
    TowerIDs.SPINEL_LVL_2: SPINEL_LVL_2_REQUIRES_TOWERS,
    TowerIDs.SPINEL_LVL_3: SPINEL_LVL_3_REQUIRES_TOWERS,
    TowerIDs.SPINEL_LVL_4: SPINEL_LVL_4_REQUIRES_TOWERS,
    TowerIDs.SPINEL_LVL_5: SPINEL_LVL_5_REQUIRES_TOWERS,
    TowerIDs.TOMBSTONE_LVL_1: TOMBSTONE_LVL_1_REQUIRES_TOWERS,
    TowerIDs.TOMBSTONE_LVL_2: TOMBSTONE_LVL_2_REQUIRES_TOWERS,
    TowerIDs.KUNZITE_LVL_1: KUNZITE_LVL_1_REQUIRES_TOWERS,
    TowerIDs.KUNZITE_LVL_2: KUNZITE_LVL_2_REQUIRES_TOWERS,
    TowerIDs.KUNZITE_LVL_3: KUNZITE_LVL_3_REQUIRES_TOWERS,
    TowerIDs.KUNZITE_LVL_4: KUNZITE_LVL_4_REQUIRES_TOWERS,
    TowerIDs.KUNZITE_LVL_5: KUNZITE_LVL_5_REQUIRES_TOWERS,
    TowerIDs.SAM_SITE_LVL_1: SAM_SITE_LVL_1_REQUIRES_TOWERS,
    TowerIDs.SAM_SITE_LVL_2: SAM_SITE_LVL_2_REQUIRES_TOWERS,
}

# COMPONENT LOADS
var TOWER_SELECTION_AREA_PRELOAD: PackedScene = load("res://ui/components/tower_selection_area/tower_selection_area.tscn")
var AWAITING_SELECTION_ANIMATION_LOAD: PackedScene = load("res://towers/animated_sprites/awaiting_selection_animation.tscn")
var TOWER_SURFACE_SPRITE_LOAD: PackedScene = load("res://towers/sprites/tower_surface_sprite.tscn")


# UPGRADES INTO
const BARRICADE_UPGRADES_INTO: Array[TowerIDs] = []
const BLACK_MARBLE_LVL_1_UPGRADES_INTO: Array[TowerIDs] = [TowerIDs.TOMBSTONE_LVL_1]
const BLACK_MARBLE_LVL_2_UPGRADES_INTO: Array[TowerIDs] = []
const BLACK_MARBLE_LVL_3_UPGRADES_INTO: Array[TowerIDs] = []
const BLACK_MARBLE_LVL_4_UPGRADES_INTO: Array[TowerIDs] = []
const BLACK_MARBLE_LVL_5_UPGRADES_INTO: Array[TowerIDs] = []
const BISMUTH_LVL_1_UPGRADES_INTO: Array[TowerIDs] = [TowerIDs.TOMBSTONE_LVL_1]
const BISMUTH_LVL_2_UPGRADES_INTO: Array[TowerIDs] = []
const BISMUTH_LVL_3_UPGRADES_INTO: Array[TowerIDs] = []
const BISMUTH_LVL_4_UPGRADES_INTO: Array[TowerIDs] = []
const BISMUTH_LVL_5_UPGRADES_INTO: Array[TowerIDs] = []
const LARIMAR_LVL_1_UPGRADES_INTO: Array[TowerIDs] = [TowerIDs.TOMBSTONE_LVL_1]
const LARIMAR_LVL_2_UPGRADES_INTO: Array[TowerIDs] = []
const LARIMAR_LVL_3_UPGRADES_INTO: Array[TowerIDs] = []
const LARIMAR_LVL_4_UPGRADES_INTO: Array[TowerIDs] = []
const LARIMAR_LVL_5_UPGRADES_INTO: Array[TowerIDs] = []
const SUNSTONE_LVL_1_UPGRADES_INTO: Array[TowerIDs] = [TowerIDs.SAM_SITE_LVL_1]
const SUNSTONE_LVL_2_UPGRADES_INTO: Array[TowerIDs] = []
const SUNSTONE_LVL_3_UPGRADES_INTO: Array[TowerIDs] = []
const SUNSTONE_LVL_4_UPGRADES_INTO: Array[TowerIDs] = []
const SUNSTONE_LVL_5_UPGRADES_INTO: Array[TowerIDs] = []
const KUNZITE_LVL_1_UPGRADES_INTO: Array[TowerIDs] = [TowerIDs.SAM_SITE_LVL_1]
const KUNZITE_LVL_2_UPGRADES_INTO: Array[TowerIDs] = []
const KUNZITE_LVL_3_UPGRADES_INTO: Array[TowerIDs] = []
const KUNZITE_LVL_4_UPGRADES_INTO: Array[TowerIDs] = []
const KUNZITE_LVL_5_UPGRADES_INTO: Array[TowerIDs] = []
const SPINEL_LVL_1_UPGRADES_INTO: Array[TowerIDs] = [TowerIDs.SAM_SITE_LVL_1]
const SPINEL_LVL_2_UPGRADES_INTO: Array[TowerIDs] = []
const SPINEL_LVL_3_UPGRADES_INTO: Array[TowerIDs] = []
const SPINEL_LVL_4_UPGRADES_INTO: Array[TowerIDs] = []
const SPINEL_LVL_5_UPGRADES_INTO: Array[TowerIDs] = []
const TOMBSTONE_LVL_1_UPGRADES_INTO: Array[TowerIDs] = [TowerIDs.TOMBSTONE_LVL_2]
const TOMBSTONE_LVL_2_UPGRADES_INTO: Array[TowerIDs] = []
const SAM_SITE_LVL_1_UPGRADES_INTO: Array[TowerIDs] = [TowerIDs.SAM_SITE_LVL_2]
const SAM_SITE_LVL_2_UPGRADES_INTO: Array[TowerIDs] = []

# REQUIRE TOWERS
const BARRICADE_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const BLACK_MARBLE_LVL_1_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const BLACK_MARBLE_LVL_2_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const BLACK_MARBLE_LVL_3_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const BLACK_MARBLE_LVL_4_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const BLACK_MARBLE_LVL_5_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const BISMUTH_LVL_1_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const BISMUTH_LVL_2_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const BISMUTH_LVL_3_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const BISMUTH_LVL_4_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const BISMUTH_LVL_5_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const LARIMAR_LVL_1_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const LARIMAR_LVL_2_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const LARIMAR_LVL_3_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const LARIMAR_LVL_4_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const LARIMAR_LVL_5_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const SUNSTONE_LVL_1_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const SUNSTONE_LVL_2_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const SUNSTONE_LVL_3_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const SUNSTONE_LVL_4_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const SUNSTONE_LVL_5_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const KUNZITE_LVL_1_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const KUNZITE_LVL_2_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const KUNZITE_LVL_3_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const KUNZITE_LVL_4_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const KUNZITE_LVL_5_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const SPINEL_LVL_1_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const SPINEL_LVL_2_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const SPINEL_LVL_3_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const SPINEL_LVL_4_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const SPINEL_LVL_5_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const TOMBSTONE_LVL_1_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {
    TowerIDs.BLACK_MARBLE_LVL_1: 1,
    TowerIDs.BISMUTH_LVL_1: 1,
    TowerIDs.LARIMAR_LVL_1: 1
}
const TOMBSTONE_LVL_2_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {
    TowerIDs.TOMBSTONE_LVL_1: 1,
}
const SAM_SITE_LVL_1_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {
    TowerIDs.KUNZITE_LVL_1: 1,
    TowerIDs.SUNSTONE_LVL_1: 1,
    TowerIDs.SPINEL_LVL_1: 1
}

const SAM_SITE_LVL_2_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {
    TowerIDs.SAM_SITE_LVL_1: 1,
}

#                             | AWAITING SELECTION UPGRADE |
# ==========================================================================================
## Find dict referrencing the amount of towers needed to place a compound upgrade tower
const AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, Dictionary] = {
    TowerIDs.BLACK_MARBLE_LVL_2: BLACK_MARBLE_LVL_2_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.BLACK_MARBLE_LVL_3: BLACK_MARBLE_LVL_3_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.BLACK_MARBLE_LVL_4: BLACK_MARBLE_LVL_4_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.BLACK_MARBLE_LVL_5: BLACK_MARBLE_LVL_5_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.BISMUTH_LVL_2: BISMUTH_LVL_2_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.BISMUTH_LVL_3: BISMUTH_LVL_3_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.BISMUTH_LVL_4: BISMUTH_LVL_4_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.BISMUTH_LVL_5: BISMUTH_LVL_5_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.SUNSTONE_LVL_2: SUNSTONE_LVL_2_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.SUNSTONE_LVL_3: SUNSTONE_LVL_3_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.SUNSTONE_LVL_4: SUNSTONE_LVL_4_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.SUNSTONE_LVL_5: SUNSTONE_LVL_5_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.LARIMAR_LVL_2: LARIMAR_LVL_2_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.LARIMAR_LVL_3: LARIMAR_LVL_3_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.LARIMAR_LVL_4: LARIMAR_LVL_4_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.LARIMAR_LVL_5: LARIMAR_LVL_5_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.SPINEL_LVL_2: SPINEL_LVL_2_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.SPINEL_LVL_3: SPINEL_LVL_3_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.SPINEL_LVL_4: SPINEL_LVL_4_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.SPINEL_LVL_5: SPINEL_LVL_5_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.KUNZITE_LVL_2: KUNZITE_LVL_2_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.KUNZITE_LVL_3: KUNZITE_LVL_3_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.KUNZITE_LVL_4: KUNZITE_LVL_4_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
    TowerIDs.KUNZITE_LVL_5: KUNZITE_LVL_5_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS,
}

## Find array referrencing compound upgrade towers to which a tower awaiting selection can upgrade.  
const AWAITING_SELECTION_COMPOUND_UPGRADES_INTO: Dictionary[TowerIDs, Array] = {
    TowerIDs.BLACK_MARBLE_LVL_1: [TowerIDs.BLACK_MARBLE_LVL_2, TowerIDs.BLACK_MARBLE_LVL_3, TowerIDs.BLACK_MARBLE_LVL_4, TowerIDs.BLACK_MARBLE_LVL_5],
    TowerIDs.BLACK_MARBLE_LVL_2: [TowerIDs.BLACK_MARBLE_LVL_3, TowerIDs.BLACK_MARBLE_LVL_4, TowerIDs.BLACK_MARBLE_LVL_5],
    TowerIDs.BLACK_MARBLE_LVL_3: [TowerIDs.BLACK_MARBLE_LVL_4, TowerIDs.BLACK_MARBLE_LVL_5],
    TowerIDs.BLACK_MARBLE_LVL_4: [TowerIDs.BLACK_MARBLE_LVL_4],
    TowerIDs.BLACK_MARBLE_LVL_5: [],
    TowerIDs.BISMUTH_LVL_1: [TowerIDs.BISMUTH_LVL_2, TowerIDs.BISMUTH_LVL_3, TowerIDs.BISMUTH_LVL_4, TowerIDs.BISMUTH_LVL_5],
    TowerIDs.BISMUTH_LVL_2: [TowerIDs.BISMUTH_LVL_3, TowerIDs.BISMUTH_LVL_4, TowerIDs.BISMUTH_LVL_5],
    TowerIDs.BISMUTH_LVL_3: [TowerIDs.BISMUTH_LVL_4, TowerIDs.BISMUTH_LVL_5],
    TowerIDs.BISMUTH_LVL_4: [TowerIDs.BISMUTH_LVL_5],
    TowerIDs.BISMUTH_LVL_5: [],
    TowerIDs.LARIMAR_LVL_1: [TowerIDs.LARIMAR_LVL_2, TowerIDs.LARIMAR_LVL_3, TowerIDs.LARIMAR_LVL_4, TowerIDs.LARIMAR_LVL_5],
    TowerIDs.LARIMAR_LVL_2: [TowerIDs.LARIMAR_LVL_3, TowerIDs.LARIMAR_LVL_4, TowerIDs.LARIMAR_LVL_5],
    TowerIDs.LARIMAR_LVL_3: [TowerIDs.LARIMAR_LVL_4, TowerIDs.LARIMAR_LVL_5],
    TowerIDs.LARIMAR_LVL_5: [TowerIDs.LARIMAR_LVL_5],
    TowerIDs.SUNSTONE_LVL_1: [TowerIDs.SUNSTONE_LVL_2, TowerIDs.SUNSTONE_LVL_3, TowerIDs.SUNSTONE_LVL_4, TowerIDs.SUNSTONE_LVL_5],
    TowerIDs.SUNSTONE_LVL_2: [TowerIDs.SUNSTONE_LVL_3, TowerIDs.SUNSTONE_LVL_4, TowerIDs.SUNSTONE_LVL_5],
    TowerIDs.SUNSTONE_LVL_3: [TowerIDs.SUNSTONE_LVL_4, TowerIDs.SUNSTONE_LVL_5],
    TowerIDs.SUNSTONE_LVL_4: [TowerIDs.SUNSTONE_LVL_5],
    TowerIDs.SUNSTONE_LVL_5: [],
    TowerIDs.SPINEL_LVL_1: [TowerIDs.SPINEL_LVL_2, TowerIDs.SPINEL_LVL_3, TowerIDs.SPINEL_LVL_4, TowerIDs.SPINEL_LVL_5],
    TowerIDs.SPINEL_LVL_2: [TowerIDs.SPINEL_LVL_3, TowerIDs.SPINEL_LVL_4, TowerIDs.SPINEL_LVL_5],
    TowerIDs.SPINEL_LVL_3: [TowerIDs.SPINEL_LVL_4, TowerIDs.SPINEL_LVL_5],
    TowerIDs.SPINEL_LVL_4: [TowerIDs.SPINEL_LVL_5],
    TowerIDs.SPINEL_LVL_5: [],
    TowerIDs.KUNZITE_LVL_1: [TowerIDs.KUNZITE_LVL_2, TowerIDs.KUNZITE_LVL_3, TowerIDs.KUNZITE_LVL_4, TowerIDs.KUNZITE_LVL_5],
    TowerIDs.KUNZITE_LVL_2: [TowerIDs.KUNZITE_LVL_3, TowerIDs.KUNZITE_LVL_4, TowerIDs.KUNZITE_LVL_5],
    TowerIDs.KUNZITE_LVL_3: [TowerIDs.KUNZITE_LVL_4, TowerIDs.KUNZITE_LVL_5],
    TowerIDs.KUNZITE_LVL_4: [TowerIDs.KUNZITE_LVL_5],
    TowerIDs.KUNZITE_LVL_5: [],
}

# ************
# BLACK MARBLE
# ************
const BLACK_MARBLE_LVL_2_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.BLACK_MARBLE_LVL_1: 2
}
const BLACK_MARBLE_LVL_3_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.BLACK_MARBLE_LVL_1: 3,
    TowerIDs.BLACK_MARBLE_LVL_2: 2,
}
const BLACK_MARBLE_LVL_4_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.BLACK_MARBLE_LVL_1: 4,
    TowerIDs.BLACK_MARBLE_LVL_2: 3,
    TowerIDs.BLACK_MARBLE_LVL_3: 2,
}
const BLACK_MARBLE_LVL_5_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.BLACK_MARBLE_LVL_1: 5,
    TowerIDs.BLACK_MARBLE_LVL_2: 4,
    TowerIDs.BLACK_MARBLE_LVL_3: 3,
    TowerIDs.BLACK_MARBLE_LVL_4: 2,
}


# *******
# BISMUTH
# *******
const BISMUTH_LVL_2_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.BISMUTH_LVL_1: 2
}

const BISMUTH_LVL_3_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.BISMUTH_LVL_1: 3,
    TowerIDs.BISMUTH_LVL_2: 2
}

const BISMUTH_LVL_4_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.BISMUTH_LVL_1: 4,
    TowerIDs.BISMUTH_LVL_2: 3,
    TowerIDs.BISMUTH_LVL_3: 2,
}

const BISMUTH_LVL_5_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.BISMUTH_LVL_1: 5,
    TowerIDs.BISMUTH_LVL_2: 4,
    TowerIDs.BISMUTH_LVL_3: 3,
    TowerIDs.BISMUTH_LVL_4: 2,
}

# ********
# SUNSTONE
# ********
const SUNSTONE_LVL_2_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.SUNSTONE_LVL_1: 2,
}

const SUNSTONE_LVL_3_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.SUNSTONE_LVL_1: 3,
    TowerIDs.SUNSTONE_LVL_2: 2
}

const SUNSTONE_LVL_4_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.SUNSTONE_LVL_1: 4,
    TowerIDs.SUNSTONE_LVL_2: 3,
    TowerIDs.SUNSTONE_LVL_3: 2,
}

const SUNSTONE_LVL_5_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.SUNSTONE_LVL_1: 5,
    TowerIDs.SUNSTONE_LVL_2: 4,
    TowerIDs.SUNSTONE_LVL_3: 3,
    TowerIDs.SUNSTONE_LVL_4: 2,
}

# *******
# LARIMAR
# *******
const LARIMAR_LVL_2_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.LARIMAR_LVL_1: 2,
}
const LARIMAR_LVL_3_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.LARIMAR_LVL_1: 3,
    TowerIDs.LARIMAR_LVL_2: 2,
}
const LARIMAR_LVL_4_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.LARIMAR_LVL_1: 4,
    TowerIDs.LARIMAR_LVL_2: 3,
    TowerIDs.LARIMAR_LVL_3: 2,
}
const LARIMAR_LVL_5_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.LARIMAR_LVL_1: 5,
    TowerIDs.LARIMAR_LVL_2: 4,
    TowerIDs.LARIMAR_LVL_3: 3,
    TowerIDs.LARIMAR_LVL_4: 2,
}

# ******
# SPINEL
# ******
const SPINEL_LVL_2_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.SPINEL_LVL_1: 2,
}

const SPINEL_LVL_3_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.SPINEL_LVL_1: 3,
    TowerIDs.SPINEL_LVL_2: 2,
}

const SPINEL_LVL_4_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.SPINEL_LVL_1: 4,
    TowerIDs.SPINEL_LVL_2: 3,
    TowerIDs.SPINEL_LVL_3: 2,
}

const SPINEL_LVL_5_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.SPINEL_LVL_1: 5,
    TowerIDs.SPINEL_LVL_2: 4,
    TowerIDs.SPINEL_LVL_3: 3,
    TowerIDs.SPINEL_LVL_4: 2,
}

# *******
# KUNZITE
# *******
const KUNZITE_LVL_2_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.KUNZITE_LVL_1: 2,
}

const KUNZITE_LVL_3_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.KUNZITE_LVL_1: 3,
    TowerIDs.KUNZITE_LVL_2: 2,
}

const KUNZITE_LVL_4_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.KUNZITE_LVL_1: 4,
    TowerIDs.KUNZITE_LVL_2: 3,
    TowerIDs.KUNZITE_LVL_3: 2,
}

const KUNZITE_LVL_5_AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS: Dictionary[TowerIDs, int]  = {
    TowerIDs.KUNZITE_LVL_1: 5,
    TowerIDs.KUNZITE_LVL_2: 4,
    TowerIDs.KUNZITE_LVL_3: 3,
    TowerIDs.KUNZITE_LVL_4: 2,
}