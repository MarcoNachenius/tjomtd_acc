extends Node
class_name RandomTowerGenerator

# CONSTANTS
const MAX_LEVEL: int = 5

# LOCALS
var __curr_buildable_tower_preloads: Array[PackedScene] = []
var __curr_level: int = 0
var __curr_upgrade_cost: int = 0

func _ready():
	upgrade_level()

## Generates a random tower preload based on the current level.
func generate_random_tower_preload() -> PackedScene:
	# Select a random tower preload from the current level's buildable tower preloads
	var random_index: int = randi() % __curr_buildable_tower_preloads.size()
	var tower_scene: PackedScene = __curr_buildable_tower_preloads[random_index]
	return tower_scene



## Increases the current level and updates the current buildable tower preloads.
func upgrade_level() -> void:
	assert(__curr_level <= MAX_LEVEL, "Cannot upgrade level beyond MAX_LEVEL")
	__curr_level += 1
	# Update current buildable tower preloads list
	match __curr_level: # Match is used because nested arrays are not supported.
		1:
			__curr_buildable_tower_preloads.append_array(LEVEL_1_BUILDABLE_TOWER_PRELOADS)
			__curr_upgrade_cost = LEVEL_UPGRADE_PRICES[__curr_level]
		2:
			__curr_buildable_tower_preloads.append_array(LEVEL_2_BUILDABLE_TOWER_PRELOADS)
			__curr_upgrade_cost = LEVEL_UPGRADE_PRICES[__curr_level]
		3:
			__curr_buildable_tower_preloads.append_array(LEVEL_3_BUILDABLE_TOWER_PRELOADS)
			__curr_upgrade_cost = LEVEL_UPGRADE_PRICES[__curr_level]
		4:
			__curr_buildable_tower_preloads.append_array(LEVEL_4_BUILDABLE_TOWER_PRELOADS)
			__curr_upgrade_cost = LEVEL_UPGRADE_PRICES[__curr_level]
		5:
			__curr_buildable_tower_preloads.append_array(LEVEL_5_BUILDABLE_TOWER_PRELOADS)
			__curr_upgrade_cost = LEVEL_UPGRADE_PRICES[__curr_level]


var LEVEL_1_BUILDABLE_TOWER_PRELOADS: Array[PackedScene] = [
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BLACK_MARBLE_LVL_1],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BISMUTH_LVL_1],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.LARIMAR_LVL_1],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.SUNSTONE_LVL_1],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.SPINEL_LVL_1],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.KUNZITE_LVL_1],
]

var LEVEL_2_BUILDABLE_TOWER_PRELOADS: Array[PackedScene] = [
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BLACK_MARBLE_LVL_2],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BISMUTH_LVL_2],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.LARIMAR_LVL_2],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.SUNSTONE_LVL_2],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.SPINEL_LVL_2],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.KUNZITE_LVL_2],
]

var LEVEL_3_BUILDABLE_TOWER_PRELOADS: Array[PackedScene] = [
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BLACK_MARBLE_LVL_3],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BISMUTH_LVL_3],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.LARIMAR_LVL_3],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.SUNSTONE_LVL_3],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.SPINEL_LVL_3],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.KUNZITE_LVL_3],
]

var LEVEL_4_BUILDABLE_TOWER_PRELOADS: Array[PackedScene] = [
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BLACK_MARBLE_LVL_4],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BISMUTH_LVL_4],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.LARIMAR_LVL_4],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.SUNSTONE_LVL_4],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.SPINEL_LVL_4],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.KUNZITE_LVL_4],
]

var LEVEL_5_BUILDABLE_TOWER_PRELOADS: Array[PackedScene] = [
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BLACK_MARBLE_LVL_5],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BISMUTH_LVL_5],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.LARIMAR_LVL_5],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.SUNSTONE_LVL_5],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.SPINEL_LVL_5],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.KUNZITE_LVL_5],
]

const LEVEL_UPGRADE_PRICES: Array[int] = [
	0,
	20, # Level 1
	200, # Level 2
	700, # Level 3
	2000, # Level 4
	5000, # Level 5
]

# GETTERS
# =======

func get_curr_upgrade_cost() -> int:
	return __curr_upgrade_cost

func get_curr_level() -> int:
	return __curr_level

## Loads the current level's buildable tower preloads.
func load_level(level: int) -> void:
	assert(level >= 1 and level <= MAX_LEVEL, "Invalid level: %d" % level)
	for __ in range(level - 1):
		upgrade_level()