extends Node
class_name SlateManager

# CONSTANTS


# PRIVATE VARS
@onready var __slates_on_map: Array[Slate] = []
var __connected_game_map: GameMap

func _init(gameMapParent: GameMap) -> void:
	__connected_game_map = gameMapParent

func _ready() -> void:
	assert(__connected_game_map, "Game map parent has not been connnected to slate manager")

# PRIVATE METHODS
# ===============

# PUBLIC METHODS
# ==============
## Returns a list of all slate IDs into which the selected tower can be upgraded.
## Rules:
##  - Only consider slates that the given tower type can contribute to.
##  - A slate is viable iff ALL its required tower counts are satisfied by the
##	current "awaiting selection" towers on the map.
##  - Uses safe .get() lookups to avoid KeyErrors when a tower type isn't present.
func selected_tower_awaiting_selection_slate_upgrades(towerID: TowerConstants.TowerIDs) -> Array[SlateConstants.SlateIDs]:
	# Return value
	var viable_slates: Array[SlateConstants.SlateIDs] = []

	# If this tower type can't upgrade into any slate, nothing to do.
	if !SlateConstants.TOWER_UPGRADES_INTO_SLATES.has(towerID):
		return viable_slates

	# Fetch current counts of towers awaiting selection on the map.
	var towers_awaiting_selection: Dictionary[TowerConstants.TowerIDs, int] = __connected_game_map.awaiting_selection_tower_count_dict()

	# Iterate only the slates that this tower type can form/participate in.
	var candidate_slates: Array = SlateConstants.TOWER_UPGRADES_INTO_SLATES[towerID]
	for slate_id in candidate_slates:
		# Each slate must have a requirements entry: { TowerID: required_count, ... }
		assert(SlateConstants.REQUIRES_TOWERS.has(slate_id), "Missing REQUIRES_TOWERS entry for slate_id: %s" % [str(slate_id)])
		var required_towers = SlateConstants.REQUIRES_TOWERS[slate_id]

		# Fast skip if the selected tower type isn't even part of this slate's recipe.
		if !required_towers.has(towerID):
			continue

		# Check that ALL required tower counts are satisfied by what's awaiting selection.
		var all_requirements_met: bool = true
		for req_tower_id in required_towers.keys():
			var needed: int = int(required_towers[req_tower_id])
			var have: int = int(towers_awaiting_selection.get(req_tower_id, 0))
			if have < needed:
				all_requirements_met = false
				break

		if all_requirements_met:
			viable_slates.append(slate_id)

	return viable_slates


## Adds a Slate instance to the map's Slate list.
## Ensures that no duplicates are added.
func add_slate_to_map(slate: Slate) -> void:
	# Ensure the Slate does not already exist in the array.
	assert(not __slates_on_map.has(slate), "Attempted to add a duplicate slate to __slates_on_map")
	
	# Append the Slate to the array.
	__slates_on_map.append(slate)


## Removes a Slate instance from the map's Slate list.
func remove_slate_from_map(slate: Slate) -> void:
	# Does nothing if slate is not in array by design
	__slates_on_map.erase(slate)


## Returns a dictionary mapping each placement grid coordinate (Vector2i)
## to an array of SlateID ints that are placed there.
##
## Format:
##   {
##	   Vector2i(x, y): [SlateID, SlateID, ...],
##	   ...
##   }
##
## This matches the format required by ActiveGameData.__slates_by_grid_coordinate for saving.
func slate_save_data() -> Dictionary[Vector2i, Array]:
	var slate_dict: Dictionary[Vector2i, Array] = {}

	for slate in __slates_on_map:
		var coord: Vector2i = Vector2i(slate.get_placement_grid_coordinate())
		var slate_id: int = int(slate.SLATE_ID)

		# Get the existing array at this coord or a new one
		var slate_ids_at_coord: Array = slate_dict.get(coord, [])
		slate_ids_at_coord.append(slate_id)

		# Reassign to ensure the updated array is stored in the dict
		slate_dict[coord] = slate_ids_at_coord

	return slate_dict


# GETTERS
# =======
## Returns a read-only copy of the array of Slates currently on the map.
## This prevents external code from directly modifying the internal array.
func get_slates_on_map() -> Array[Slate]:
	# Return a duplicate so that outside code can't alter the original array directly.
	return __slates_on_map


# SETTERS
# =======
