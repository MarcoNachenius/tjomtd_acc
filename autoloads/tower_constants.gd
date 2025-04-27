extends Node

enum TowerIDs {
    BARRICADE,
    BLACK_MARBLE_LVL_1,
    BLACK_MARBLE_LVL_2,
    BLACK_MARBLE_LVL_3,
    BISMUTH_LVL_1,
    LARIMAR_LVL_1,
    TOMBSTONE_LVL_1,
    TEST_BUILD_TOWER
}

enum BuildTowerIDs {
    BARRICADE = TowerIDs.BARRICADE,
    BLACK_MARBLE_LVL_1 = TowerIDs.BLACK_MARBLE_LVL_1,
    BLACK_MARBLE_LVL_2 = TowerIDs.BLACK_MARBLE_LVL_2,
    BLACK_MARBLE_LVL_3 = TowerIDs.BLACK_MARBLE_LVL_3,
    BISMUTH_LVL_1 = TowerIDs.BISMUTH_LVL_1,
    LARIMAR_LVL_1 = TowerIDs.LARIMAR_LVL_1,
    TEST_BUILD_TOWER = TowerIDs.TEST_BUILD_TOWER
}

enum UpgradeTowerIDs {
    TOMBSTONE_LVL_1 = TowerIDs.TOMBSTONE_LVL_1,
}

var BUILD_TOWER_PRELOADS: Dictionary = {
    BuildTowerIDs.BARRICADE: load("res://towers/barricade/tower_barricade.tscn"),
    BuildTowerIDs.BLACK_MARBLE_LVL_1: load("res://towers/buildable_towers/black_marble/level_1/black_marble_lvl_1.tscn"),
    BuildTowerIDs.BLACK_MARBLE_LVL_2: load("res://towers/buildable_towers/black_marble/level_2/black_marble_lvl_2.tscn"),
    BuildTowerIDs.BLACK_MARBLE_LVL_3: load("res://towers/buildable_towers/black_marble/level_3/black_marble_lvl_3_tower.tscn"),
    BuildTowerIDs.BISMUTH_LVL_1: load("res://towers/buildable_towers/bismuth/level_1/bismuth_lvl_1_tower.tscn"),
    BuildTowerIDs.LARIMAR_LVL_1: load("res://towers/buildable_towers/laminar/level_1/larimar_lvl_1.tscn"),
    BuildTowerIDs.TEST_BUILD_TOWER: load("res://towers/test_tower/test_tower.tscn")
}

const TowerPrices: Dictionary = {
    TowerIDs.BARRICADE: 0,
    TowerIDs.BLACK_MARBLE_LVL_1: 0,
    TowerIDs.BLACK_MARBLE_LVL_2: 0,
    TowerIDs.BLACK_MARBLE_LVL_3: 0,
    TowerIDs.BISMUTH_LVL_1: 0,
    TowerIDs.LARIMAR_LVL_1: 0,
    TowerIDs.TEST_BUILD_TOWER: 0,
    TowerIDs.TOMBSTONE_LVL_1: 50
}


const UPGRADES_INTO: Dictionary = {
    TowerIDs.BARRICADE: BARRICADE_UPGRADES_INTO,
    TowerIDs.BLACK_MARBLE_LVL_1: BLACK_MARBLE_LVL_1_UPGRADES_INTO,
    TowerIDs.BLACK_MARBLE_LVL_2: BLACK_MARBLE_LVL_2_UPGRADES_INTO,
    TowerIDs.BLACK_MARBLE_LVL_3: BLACK_MARBLE_LVL_3_UPGRADES_INTO,
    TowerIDs.BISMUTH_LVL_1: BISMUTH_LVL_1_UPGRADES_INTO,
    TowerIDs.LARIMAR_LVL_1: LARIMAR_LVL_1_UPGRADES_INTO,
    TowerIDs.TEST_BUILD_TOWER: TEST_BUILD_TOWER_UPGRADES_INTO,
}

const REQUIRES_TOWERS: Dictionary = {
    TowerIDs.BARRICADE: BARRICADE_REQUIRES_TOWERS,
    TowerIDs.BLACK_MARBLE_LVL_1: BLACK_MARBLE_LVL_1_REQUIRES_TOWERS,
    TowerIDs.BLACK_MARBLE_LVL_2: BLACK_MARBLE_LVL_2_REQUIRES_TOWERS,
    TowerIDs.BLACK_MARBLE_LVL_3: BLACK_MARBLE_LVL_3_REQUIRES_TOWERS,
    TowerIDs.BISMUTH_LVL_1: BISMUTH_LVL_1_REQUIRES_TOWERS,
    TowerIDs.LARIMAR_LVL_1: LARIMAR_LVL_1_REQUIRES_TOWERS,
    TowerIDs.TEST_BUILD_TOWER: TEST_BUILD_TOWER_REQUIRES_TOWERS,
}

# LOADS
var TOWER_SELECTION_AREA_PRELOAD: PackedScene = load("res://ui/components/tower_selection_area/tower_selection_area.tscn")
var AWAITING_SELECTION_ANIMATION_LOAD: PackedScene = load("res://towers/animated_sprites/awaiting_selection_animation.tscn")
var TOWER_SURFACE_SPRITE_LOAD: PackedScene = load("res://towers/sprites/tower_surface_sprite.tscn")


# UPGRADES INTO
const BARRICADE_UPGRADES_INTO: Array[TowerIDs] = []
const BLACK_MARBLE_LVL_1_UPGRADES_INTO: Array[TowerIDs] = []
const BLACK_MARBLE_LVL_2_UPGRADES_INTO: Array[TowerIDs] = []
const BLACK_MARBLE_LVL_3_UPGRADES_INTO: Array[TowerIDs] = []
const BISMUTH_LVL_1_UPGRADES_INTO: Array[TowerIDs] = []
const LARIMAR_LVL_1_UPGRADES_INTO: Array[TowerIDs] = []
const TEST_BUILD_TOWER_UPGRADES_INTO: Array[TowerIDs] = []

# REQUIRE TOWERS
const BARRICADE_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const BLACK_MARBLE_LVL_1_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const BLACK_MARBLE_LVL_2_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const BLACK_MARBLE_LVL_3_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const BISMUTH_LVL_1_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const LARIMAR_LVL_1_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}
const TOMBSTONE_LVL_1_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {
    TowerIDs.BLACK_MARBLE_LVL_1: 1,
    TowerIDs.BISMUTH_LVL_1: 1,
    TowerIDs.LARIMAR_LVL_1: 1
}
const TEST_BUILD_TOWER_REQUIRES_TOWERS: Dictionary[TowerIDs, int] = {}