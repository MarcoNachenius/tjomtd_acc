extends Node2D
class_name Tower

enum States {
	AWAITING_SELECTION,
	BUILT
}

enum TowerOrigin {
	BUILT,
	UPGRADED,
	BARRICADED,
}

# ORDERING CONTSTANTS
const TOWER_Z_INDEX: int = 4
const TOWER_Z_AS_RELATIVE: bool = true
const TOWER_SPRITE_Z_INDEX: int = 1
const TOWER_SPRITE_Z_AS_RELATIVE: bool = true

# ANIMATION CONSTANTS
const AWAITING_SELECTION_ANIMATION_NAME: String = "awaiting_selection"

# PRIVATE VARS
var __build_cost: int
var __curr_state: States
var __curr_display_range: int
var __selection_area: TowerSelectionArea
var __placement_grid_coord: Vector2i
var __upgrades_into: Array[TowerConstants.TowerIDs]
var __requires_towers: Dictionary[TowerConstants.TowerIDs, int]

# EXPORT VARS
@export var TOWER_ID: TowerConstants.TowerIDs
@export var TOWER_SPRITE: Sprite2D
@export var USE_CUSTOM_TOWER_DISPLAY_RANGE: bool 
@export var CUSTOM_TOWER_DISPLAY_RANGE: int 
@export var PRIMARY_PROJECTILE_SPAWNER: ProjectileSpawner

# GENERATED CHILD SCENES
var SURFACE_SPRITE: Sprite2D
var AWAITING_SELECTION_ANIMATION: AnimatedSprite2D
var RANGE_DISPLAY_SHAPE: RangeDisplayShape

# BUILTINS
func _ready():
	assert(TowerConstants.TowerPrices.has(TOWER_ID), "No tower price provided in TowerConstants.TowerPrices")
	__build_cost = TowerConstants.TowerPrices[TOWER_ID]
	assert(TowerConstants.UPGRADES_INTO.has(TOWER_ID), "Missing upgrades into for tower. Assign value in TowerConstants.UPGRADES_INTO")
	__upgrades_into = TowerConstants.UPGRADES_INTO[TOWER_ID]
	assert(TowerConstants.REQUIRES_TOWERS.has(TOWER_ID), "Missing requires towers for tower. Assign value in TowerConstants.REQUIRES_TOWERS")
	__requires_towers = TowerConstants.REQUIRES_TOWERS[TOWER_ID]
	# Instantiate child scenes
	_create_surface_sprite()
	_create_awaiting_selection_animation()
	_create_range_display_shape()
	# Set up z index and z as relative values
	_handle_ordering()

# PUBLIC METHODS
# ==============
func disable_selection_area():
	assert(__selection_area, "No slection area has been created")
	__selection_area.monitoring = false

func enable_selection_area():
	assert(__selection_area, "No slection area has been created")
	__selection_area.monitoring = true

# PRIVATE METHODS
# ===============
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

## Creates circle indicating range whenever tower is selected.
## Does not create range shape if tower is a barricade
func _create_range_display_shape():
	# Barricades do not have any range
	if TOWER_ID == TowerConstants.TowerIDs.BARRICADE:
		return
	# Handle size creation based on the projectile spawner range
	if !USE_CUSTOM_TOWER_DISPLAY_RANGE:
		assert(PRIMARY_PROJECTILE_SPAWNER, "No projectile spawner has been assigned")
		assert(PRIMARY_PROJECTILE_SPAWNER.get_detection_range(), "No range has been assigned to projectile spawner")
		# Get the range from the projectile spawner
		__curr_display_range = PRIMARY_PROJECTILE_SPAWNER.get_detection_range()
	
	# Handle size creation based on custom range
	if USE_CUSTOM_TOWER_DISPLAY_RANGE:
		assert(CUSTOM_TOWER_DISPLAY_RANGE, "No custom range has been assigned")
		# Get the range from the custom range
		__curr_display_range = CUSTOM_TOWER_DISPLAY_RANGE
	
	# Create the range display shape
	var new_display_shape: RangeDisplayShape = RangeDisplayShape.new(__curr_display_range)
	add_child(new_display_shape)
	RANGE_DISPLAY_SHAPE = new_display_shape
	RANGE_DISPLAY_SHAPE.y_sort_enabled = true
	RANGE_DISPLAY_SHAPE.z_as_relative = false
	RANGE_DISPLAY_SHAPE.z_index = 1
	RANGE_DISPLAY_SHAPE.visible = false

## Avoid human error and ensure that tower and its sprite are always ordered correctly
func _handle_ordering():
	# Handle scene root ordering
	y_sort_enabled = true
	z_as_relative = TOWER_Z_AS_RELATIVE
	z_index = TOWER_Z_INDEX
	
	# Handle tower sprite ordering
	if TOWER_ID != TowerConstants.TowerIDs.BARRICADE: # Barricades do not have tower sprites
		TOWER_SPRITE.y_sort_enabled = true
		TOWER_SPRITE.z_as_relative = TOWER_SPRITE_Z_AS_RELATIVE
		TOWER_SPRITE.z_index = TOWER_SPRITE_Z_INDEX 


# GETTERS
# =======
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
	assert(state in States.values(), "Invalid state")
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
		if TOWER_ID == TowerConstants.TowerIDs.BARRICADE:
			return
		# Remove transparency of the tower sprite
		if TOWER_ID == TowerConstants.TowerIDs.BARRICADE:
			TOWER_SPRITE.modulate.a = 1.0
		TOWER_SPRITE.modulate.a = 1.0
		# Show tower surface
		SURFACE_SPRITE.visible = true
		# Hide awaiting selection
		AWAITING_SELECTION_ANIMATION.visible = false
		AWAITING_SELECTION_ANIMATION.stop()

func get_state() -> States:
	return __curr_state
