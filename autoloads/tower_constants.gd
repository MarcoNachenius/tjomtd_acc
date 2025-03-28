extends Node


enum TowerIDs {
    BARRICADE,
    BLACK_MARBLE_LVL_1,
    BLACK_MARBLE_LVL_2,
    BLACK_MARBLE_LVL_3,
    BISMUTH_LVL_1,
    TEST_BUILD_TOWER
}

enum BuildTowerIDs {
    BARRICADE = TowerIDs.BARRICADE,
    BLACK_MARBLE_LVL_1 = TowerIDs.BLACK_MARBLE_LVL_1,
    BLACK_MARBLE_LVL_2 = TowerIDs.BLACK_MARBLE_LVL_2,
    BLACK_MARBLE_LVL_3 = TowerIDs.BLACK_MARBLE_LVL_3,
    BISMUTH_LVL_1 = TowerIDs.BISMUTH_LVL_1,
    TEST_BUILD_TOWER = TowerIDs.TEST_BUILD_TOWER
}

enum UpgradeTowerIDs {
    TEST_UPGRADE_TOWER,
}

var BUILD_TOWER_PRELOADS: Dictionary = {
    BuildTowerIDs.BARRICADE: load("res://towers/barricade/tower_barricade.tscn"),
    BuildTowerIDs.BLACK_MARBLE_LVL_1: load("res://towers/buildable_towers/black_marble/level_1/black_marble_lvl_1.tscn"),
    BuildTowerIDs.BLACK_MARBLE_LVL_2: load("res://towers/buildable_towers/black_marble/level_2/black_marble_lvl_2.tscn"),
    BuildTowerIDs.BLACK_MARBLE_LVL_3: load("res://towers/buildable_towers/black_marble/level_3/black_marble_lvl_3_tower.tscn"),
    BuildTowerIDs.BISMUTH_LVL_1: load("res://towers/buildable_towers/bismuth/level_1/bismuth_lvl_1_tower.tscn"),
    BuildTowerIDs.TEST_BUILD_TOWER: load("res://towers/test_tower/test_tower.tscn")
}

const TowerPrices: Dictionary = {
    TowerIDs.BARRICADE: 10,
    TowerIDs.BLACK_MARBLE_LVL_1: 20,
    TowerIDs.BLACK_MARBLE_LVL_2: 25,
    TowerIDs.BLACK_MARBLE_LVL_3: 30,
    TowerIDs.BISMUTH_LVL_1: 30,
    TowerIDs.TEST_BUILD_TOWER: 10,
}


var UPGRADES_INTO: Dictionary = {
    TowerIDs.BARRICADE: BARRICADE_UPGRADES_INTO,
    TowerIDs.BLACK_MARBLE_LVL_1: BLACK_MARBLE_LVL_1_UPGRADES_INTO,
    TowerIDs.BLACK_MARBLE_LVL_2: BLACK_MARBLE_LVL_2_UPGRADES_INTO,
    TowerIDs.BLACK_MARBLE_LVL_3: BLACK_MARBLE_LVL_3_UPGRADES_INTO,
    TowerIDs.BISMUTH_LVL_1: BISMUTH_LVL_1_UPGRADES_INTO,
    TowerIDs.TEST_BUILD_TOWER: TEST_BUILD_TOWER_UPGRADES_INTO,
}

var REQUIRES_TOWERS: Dictionary = {
    TowerIDs.BARRICADE: BARRICADE_REQUIRES_TOWERS,
    TowerIDs.BLACK_MARBLE_LVL_1: BLACK_MARBLE_LVL_1_REQUIRES_TOWERS,
    TowerIDs.BLACK_MARBLE_LVL_2: BLACK_MARBLE_LVL_2_REQUIRES_TOWERS,
    TowerIDs.BLACK_MARBLE_LVL_3: BLACK_MARBLE_LVL_3_REQUIRES_TOWERS,
    TowerIDs.BISMUTH_LVL_1: BISMUTH_LVL_1_REQUIRES_TOWERS,
    TowerIDs.TEST_BUILD_TOWER: TEST_BUILD_TOWER_REQUIRES_TOWERS,
}

var TOWER_SELECTION_AREA_PRELOAD: PackedScene = load("res://ui/components/tower_selection_area/tower_selection_area.tscn")


# UPGRADES INTO
var BARRICADE_UPGRADES_INTO: Array[TowerIDs] = []
var BLACK_MARBLE_LVL_1_UPGRADES_INTO: Array[TowerIDs] = []
var BLACK_MARBLE_LVL_2_UPGRADES_INTO: Array[TowerIDs] = []
var BLACK_MARBLE_LVL_3_UPGRADES_INTO: Array[TowerIDs] = []
var BISMUTH_LVL_1_UPGRADES_INTO: Array[TowerIDs] = []
var TEST_BUILD_TOWER_UPGRADES_INTO: Array[TowerIDs] = []

# REQUIRE TOWERS
var BARRICADE_REQUIRES_TOWERS: Array[TowerIDs] = []
var BLACK_MARBLE_LVL_1_REQUIRES_TOWERS: Array[TowerIDs] = []
var BLACK_MARBLE_LVL_2_REQUIRES_TOWERS: Array[TowerIDs] = []
var BLACK_MARBLE_LVL_3_REQUIRES_TOWERS: Array[TowerIDs] = []
var BISMUTH_LVL_1_REQUIRES_TOWERS: Array[TowerIDs] = []
var TEST_BUILD_TOWER_REQUIRES_TOWERS: Array[TowerIDs] = []