extends Node2D
class_name Tower

enum States {
	AWAITING_SELECTION,
	BUILT
}

const AWAITING_SELECTION_ANIMATION_NAME: String = "awaiting_selection"

var __build_cost: int
var __curr_state: States
var __selection_area: TowerSelectionArea
var __placement_grid_coord: Vector2i
var __upgrades_into: Array[TowerConstants.TowerIDs]
var __requires_towers: Dictionary[TowerConstants.TowerIDs, int]

@export var TOWER_ID: TowerConstants.TowerIDs
@export var TOWER_SPRITE: Sprite2D
var SURFACE_SPRITE: Sprite2D
var AWAITING_SELECTION_ANIMATION: AnimatedSprite2D

# BUILTINS
func _ready():
	__build_cost = TowerConstants.TowerPrices[TOWER_ID]
	__upgrades_into = TowerConstants.UPGRADES_INTO[TOWER_ID]
	__requires_towers = TowerConstants.REQUIRES_TOWERS[TOWER_ID]
	# Instantiate child scenes
	_create_surface_sprite()
	_create_awaiting_selection_animation()

# CUSTOM
func disable_selection_area():
	assert(__selection_area, "No slection area has been created")
	__selection_area.monitoring = false

func enable_selection_area():
	assert(__selection_area, "No slection area has been created")
	__selection_area.monitoring = true

# LOCALS
func _create_surface_sprite():
	var new_surface_sprite: Sprite2D = TowerConstants.TOWER_SURFACE_SPRITE_LOAD.instantiate()
	SURFACE_SPRITE = new_surface_sprite
	add_child(SURFACE_SPRITE)

func _create_awaiting_selection_animation():
	# Do not add animation for barricades
	if TOWER_ID == TowerConstants.TowerIDs.BARRICADE:
		return
	var new_awaiting_selection_animation: AnimatedSprite2D = TowerConstants.AWAITING_SELECTION_ANIMATION_LOAD.instantiate()
	AWAITING_SELECTION_ANIMATION = new_awaiting_selection_animation
	add_child(AWAITING_SELECTION_ANIMATION)
	# Hide by default
	AWAITING_SELECTION_ANIMATION.visible = false

# GETTERS
func get_build_cost() -> int:
	return __build_cost

## Returns the tower's placement grid coordinate on the map.
func get_placement_grid_coordinate() -> Vector2i:
	return __placement_grid_coord

func get_upgrades_into_tower_ids() -> Array[TowerConstants.TowerIDs]:
	return __upgrades_into

func get_requires_towers() -> Dictionary[TowerConstants.TowerIDs, int]:
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

func set_requires_towers(requires_towers: Dictionary[TowerConstants.TowerIDs, int]):
	__requires_towers = requires_towers

func switch_state(state: States):
	#assert(state in States, "Invalid state")
	__curr_state = state

	if state == States.AWAITING_SELECTION:
		# Decrease transparency of the tower sprite
		TOWER_SPRITE.modulate.a = 0.5
		# Hide tower surface
		SURFACE_SPRITE.visible = false
		# Show and play awaiting selection
		AWAITING_SELECTION_ANIMATION.visible = true
		AWAITING_SELECTION_ANIMATION.play(AWAITING_SELECTION_ANIMATION_NAME)
		# Decrease transparency of the awaiting selection animation
		AWAITING_SELECTION_ANIMATION.modulate.a = 0.5
	
	if state == States.BUILT:
		# Remove transparency of the tower sprite
		TOWER_SPRITE.modulate.a = 1.0
		# Show tower surface
		SURFACE_SPRITE.visible = true
		# Hide awaiting selection
		AWAITING_SELECTION_ANIMATION.visible = false
		AWAITING_SELECTION_ANIMATION.stop()

func get_state() -> States:
	return __curr_state

