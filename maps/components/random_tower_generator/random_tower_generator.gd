extends Node
class_name RandomTowerGenerator

# CONSTANTS
const MAX_LEVEL: int = 30

# LOCALS
var __curr_buildable_tower_preloads: Array[PackedScene] = []
var __curr_level: int = 0

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
	assert(__curr_level < MAX_LEVEL, "Cannot upgrade level beyond MAX_LEVEL")
	__curr_level += 1
	# Update current buildable tower preloads list
	match __curr_level: # Match is used because nested arrays are not supported.
		1:
			__curr_buildable_tower_preloads = LEVEL_1_BUILDABLE_TOWER_PRELOADS
		2:
			__curr_buildable_tower_preloads = LEVEL_2_BUILDABLE_TOWER_PRELOADS



# LEVEL 1 BUILDABLE TOWER PRELOADS
var LEVEL_1_BUILDABLE_TOWER_PRELOADS: Array[PackedScene] = [
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BLACK_MARBLE_LVL_1],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BISMUTH_LVL_1],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.LARIMAR_LVL_1],
]

# LEVEL 2 BUILDABLE TOWER PRELOADS
var LEVEL_2_BUILDABLE_TOWER_PRELOADS: Array[PackedScene] = [
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BLACK_MARBLE_LVL_1],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BISMUTH_LVL_1],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.LARIMAR_LVL_1],
	TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BLACK_MARBLE_LVL_2],
	
]
