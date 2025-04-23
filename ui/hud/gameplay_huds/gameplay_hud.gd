extends CanvasLayer
class_name GameplayHUD

# =======
# EXPORTS
# =======
@export var __game_map: GameMap

# ======
# LOCALS
# ======
## Number of towers that can be placed per turn
var __max_towers_per_turn = 5
## Number of towers that have been placed this turn
var __current_turn_tower_count = 0
## Coordinates of the towers that have been placed this turn
var __turn_tower_placement_coords: Array[Tower] = []