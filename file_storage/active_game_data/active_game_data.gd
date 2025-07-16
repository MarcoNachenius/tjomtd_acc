class_name ActiveGameData
extends Resource

# =============
# GAME MAP VARS
# =============
# 0 value refers to unassigned map ID
@export var __map_id: int = 0 : set = set_map_id, get = get_map_id
# Key = Placement Grid Coordinate (Vector2i)
# Value = Tower ID enum value (GameConstants.TowerIDs)
@export var __placed_towers: Dictionary[Vector2i, int] = {} : set = set_placed_towers, get = get_placed_towers
# Array of grid coordinates where barricades are placed (Vector2i).
@export var __barricade_positions: Array[Vector2i] = [] : set = set_barricade_positions, get = get_barricade_positions
@export var __remaining_balance: int = 0 : set = set_remaining_balance, get = get_remaining_balance
@export var __remaining_lives: int = 0 : set = set_remaining_lives, get = get_remaining_lives
# ==================
# CREEP SPAWNER VARS
# ==================
@export var wave_number: int
@export var build_level: int


# ===================
# GETTERS AND SETTERS
# ===================

## Setter for __map_id.
## 
## Parameters:
##     value (int) – The ID of the map to select.
## 
## Behavior:
##     • Checks whether `value` exists in the allowed MapConstants.MapID values.
##     • If valid, assigns it to `__map_id`.
##     • If invalid, logs an error via `push_error` and leaves `__map_id` unchanged.
func set_map_id(value: int) -> void:
	if value in MapConstants.MapID.values():
		__map_id = value
	else:
		push_error("Invalid MAP_ID: %s" % str(value))

## Getter for __map_id.
## 
## Returns:
##     int – The currently stored map ID.
func get_map_id() -> int:
	return __map_id

## Setter for __placed_towers.
## 
## Parameters:
##     value (Dictionary[Vector2i, int]) – A mapping from grid coordinates to tower IDs.
## 
## Behavior:
##     • Clears the existing dictionary.
##     • For each entry in `value`, checks that the key is a Vector2i and the value is a valid TowerID.
##     • Logs an error for any invalid entries and skips them.
##     • Stores the rest in `__placed_towers`.
func set_placed_towers(placedTowersDict: Dictionary[Vector2i, int]) -> void:
	__placed_towers.clear()
	__placed_towers = placedTowersDict

## Getter for __placed_towers.
## 
## Returns:
##     Dictionary[Vector2i, int] – A deep copy of the internal placed-towers map,
##     so callers can inspect it without mutating your internal state.
func get_placed_towers() -> Dictionary[Vector2i, int]:
	return __placed_towers.duplicate(true)

## Setter for __barricade_positions.
##
## Parameters:
##     value (Array[Vector2i]) – An array of grid coordinates to place barricades.
##
## Behavior:
##     • Clears the existing positions.
##     • Iterates over `value`, checking each entry is a Vector2i.
##     • Logs an error via `push_error` and skips any invalid entries.
##     • Appends valid Vector2i entries to the internal array.
func set_barricade_positions(barricadeCoords: Array[Vector2i]) -> void:
	__barricade_positions.clear()
	__barricade_positions = barricadeCoords

## Getter for __barricade_positions.
##
## Returns:
##     Array[Vector2i] – A deep copy of the internal barricade positions array,
##     so callers cannot modify internal state directly.
func get_barricade_positions() -> Array:
	return __barricade_positions.duplicate(true)

## Setter for __remaining_balance.
##
## Parameters:
##     value (int) – The new remaining balance amount.
##
## Behavior:
##     • Checks that `value` is non-negative.
##     • If valid, assigns it to `__remaining_balance`.
##     • If invalid (negative), logs an error via `push_error` and leaves `__remaining_balance` unchanged.
func set_remaining_balance(value: int) -> void:
	if value >= 0:
		__remaining_balance = value
	else:
		push_error("Invalid remaining balance: %s" % str(value))

## Getter for __remaining_balance.
##
## Returns:
##     int – The currently stored remaining balance.
func get_remaining_balance() -> int:
	return __remaining_balance

## Setter for __remaining_lives.
##
## Parameters:
##     value (int) – The new remaining lives count.
##
## Behavior:
##     • Checks that `value` is non-negative.
##     • If valid, assigns it to `__remaining_lives`.
##     • If invalid (negative), logs an error via `push_error` and leaves `__remaining_lives` unchanged.
func set_remaining_lives(value: int) -> void:
	if value >= 0:
		__remaining_lives = value
	else:
		push_error("Invalid remaining lives: %s" % str(value))

## Getter for __remaining_lives.
##
## Returns:
##     int – The currently stored remaining lives.
func get_remaining_lives() -> int:
	return __remaining_lives
