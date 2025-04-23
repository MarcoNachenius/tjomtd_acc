extends Node
class_name RandomTowerGenerator

# LOCALS
var __curr_level: int = 1

## Generates a random tower preload based on the current level.
func generate_random_tower_preload() -> PackedScene:
    var tower_scene: PackedScene = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BLACK_MARBLE_LVL_1]
    return tower_scene



## Increases the current level of the tower generator.
func upgrade_level() -> void:
    __curr_level += 1