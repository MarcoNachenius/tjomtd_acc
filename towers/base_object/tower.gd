extends Node2D
class_name Tower

enum States {
	AWAITING_SELECTION,
	BUILT
}

var __build_cost: int
var __curr_state: States
var __selection_area: TowerSelectionArea
var __placement_grid_coord: Vector2i
var __upgrades_into: Array[TowerConstants.TowerIDs]
var __requires_towers: Array[TowerConstants.TowerIDs]

@export var TOWER_ID: TowerConstants.TowerIDs
@export var TOWER_SPRITE: Sprite2D

# BUILTINS
func _ready():
	__build_cost = TowerConstants.TowerPrices[TOWER_ID]
	__upgrades_into = TowerConstants.UPGRADES_INTO[TOWER_ID]
	__requires_towers = TowerConstants.REQUIRES_TOWERS[TOWER_ID]

# CUSTOM
func disable_selection_area():
	assert(__selection_area, "No slection area has been created")
	__selection_area.monitoring = false

func enable_selection_area():
	assert(__selection_area, "No slection area has been created")
	__selection_area.monitoring = true


# GETTERS
func get_build_cost() -> int:
	return __build_cost

## Returns the tower's placement grid coordinate on the map.
func get_placement_grid_coordinate() -> Vector2i:
	return __placement_grid_coord

func get_upgrades_into_tower_ids() -> Array[TowerConstants.TowerIDs]:
	return __upgrades_into

func get_requires_towers() -> Array[TowerConstants.TowerIDs]:
	return __requires_towers

# SETTERS
func set_build_cost(build_cost: int) -> void:
	__build_cost = build_cost

func set_selection_area(new_selection_area: TowerSelectionArea):
	__selection_area = new_selection_area

## Sets the tower's placement grid coordinate on the map. 
## This is used to determine where the tower is placed on the map.
func set_placement_grid_coordinate(new_placement_grid_coord: Vector2i):
	__placement_grid_coord = new_placement_grid_coord

func set_upgrades_into_tower_ids(upgrades_into: Array[TowerConstants.TowerIDs]):
	__upgrades_into = upgrades_into

func set_requires_towers(requires_towers: Array[TowerConstants.TowerIDs]):
	__requires_towers = requires_towers

func switch_state(state: States):
	#assert(state in States, "Invalid state")
	__curr_state = state

	if state == States.AWAITING_SELECTION:
		# Increase transparency of the tower sprite
		TOWER_SPRITE.modulate.a = 0.5
	
	if state == States.BUILT:
		# Remove transparency of the tower sprite
		TOWER_SPRITE.modulate.a = 1.0

func get_state() -> States:
	return __curr_state
