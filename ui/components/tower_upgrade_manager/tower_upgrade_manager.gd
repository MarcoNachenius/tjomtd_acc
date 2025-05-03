extends Node
class_name TowerUpgradeManager

var GAME_MAP: GameMap

var __built_tower_count_dict: Dictionary[TowerConstants.TowerIDs, int]


## Returns a dictionary with the count of EVERY tower of the provided array, regardless of tower state.
## The key is the id of the tower, the value is the count.
func tower_count_dict(Towers: Array[Tower]) -> Dictionary[TowerConstants.TowerIDs, int]:
	var count_dict: Dictionary[TowerConstants.TowerIDs, int] = {}
	# Increment the count of a tower by 1 if it exists, or add new tower id and set it to 1 if it doesn't.
	for tower in Towers:
		count_dict[tower.TOWER_ID] = count_dict.get(tower.TOWER_ID, 0) + 1
	return count_dict

## Assign the game map to the upgrade manager.
## Connects to the game map's tower placed signal.
func set_game_map(game_map: GameMap) -> void:
	GAME_MAP = game_map
	# Connect to the tower placed signal
	GAME_MAP.tower_placed.connect(_on_game_map_tower_placed)

## Called when a tower is placed on the game map.
func _on_game_map_tower_placed(_tower: Tower) -> void:
	# Update built tower count dictionary
	__built_tower_count_dict = tower_count_dict(GAME_MAP.get_towers_on_map())

# PUBLIC METHODS

## Returns true if the nessesary towers are available to upgrade the tower in
## the provided array of towers. Does not consider the state of the towers.
func can_upgrade_to_tower(towerID: TowerConstants.TowerIDs, towerArray: Array[Tower]) -> bool:
	# Create a dictionary of the count of each tower in the array
	var tower_count: Dictionary[TowerConstants.TowerIDs, int] = tower_count_dict(towerArray)
	# Get dictionary of the required towers to upgrade
	var requires_towers_dict: Dictionary[TowerConstants.TowerIDs, int] = TowerConstants.REQUIRES_TOWERS[towerID]

	# Iterate through requires towers dictionary
	for required_tower_id in requires_towers_dict.keys():
		# Return false if the required tower is not in the tower count dictionary
		if !tower_count.has(required_tower_id):
			return false
		# Return false if the required tower count is less than the required amount in the requires towers dictionary
		if tower_count[required_tower_id] < requires_towers_dict[required_tower_id]:
			return false

	# If we made it here, all requirements have been met
	return true

## INCOMPLETE Returns an array of tower IDs that represent viable options for compound tower upgrades.
func viable_compound_upgrade_tower_ids(selectedTowerID: TowerConstants.TowerIDs, awaitingSelectionTowerCount: Dictionary[TowerConstants.TowerIDs, int]) -> Array[TowerConstants.TowerIDs]:
	# Ensure selected tower ID is valid
	assert(TowerConstants.AWAITING_SELECTION_COMPOUND_UPGRADES_INTO.keys().has(selectedTowerID))
	
	# Create return value holder
	var viable_tower_ids: Array[TowerConstants.TowerIDs] = []
	
	# Fetch candidates for compound tower upgrades
	var compound_upgrade_candidates: Array = TowerConstants.AWAITING_SELECTION_COMPOUND_UPGRADES_INTO[selectedTowerID]

	# Iterate through tower IDs into which the selection tower may upgrade 
	for upgrades_into_tower_id in compound_upgrade_candidates:
		# Fetch tower requirements for upgrade tower ID
		var upgrade_tower_requirements: Dictionary[TowerConstants.TowerIDs, int] = TowerConstants.AWAITING_SELECTION_COMPOUND_UPGRADE_REQUIREMENTS[upgrades_into_tower_id]
		
		# Iterate through every tower type of required towers for compound upgrade
		for required_tower_id in upgrade_tower_requirements.keys():
			# Skip when required tower id is not present in towers awaiting selection
			if !awaitingSelectionTowerCount.keys().has(required_tower_id):
				continue
			
			# Fetch number of placed towers IDs awaiting selection
			var num_of_placed_towers: int = awaitingSelectionTowerCount[required_tower_id]
			# Fetch required number of towers IDs for upgrade
			var required_num_of_towers: int = upgrade_tower_requirements[required_tower_id]

			# Skip when there are not enough towers placed to qualify for compound upgrade
			if num_of_placed_towers < required_num_of_towers:
				continue
			
			# Assumes all requirements have been met such that the upgrade tower is a valid candidate
			viable_tower_ids.append(upgrades_into_tower_id)
	
	return viable_tower_ids