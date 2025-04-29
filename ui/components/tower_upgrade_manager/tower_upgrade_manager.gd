extends Node
class_name TowerUpgradeManager

var GAME_MAP: GameMap

var __built_tower_count_dict: Dictionary[TowerConstants.TowerIDs, int]


## Returns a dictionary with the count of EVERY tower of the provided array, regardless of tower state.
## The key is the id of the tower, the value is the count.
func _tower_count_dict(Towers: Array[Tower]) -> Dictionary[TowerConstants.TowerIDs, int]:
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
	__built_tower_count_dict = _tower_count_dict(GAME_MAP.get_towers_on_map())

# PUBLIC METHODS

## Returns true if the nessesary towers are available to upgrade the tower in
## the provided array of towers. Does not consider the state of the towers.
func can_upgrade_to_tower(towerID: TowerConstants.TowerIDs, towerArray: Array[Tower]) -> bool:
	# Create a dictionary of the count of each tower in the array
	var tower_count_dict: Dictionary[TowerConstants.TowerIDs, int] = _tower_count_dict(towerArray)
	# Get dictionary of the required towers to upgrade
	var requires_towers_dict: Dictionary[TowerConstants.TowerIDs, int] = TowerConstants.REQUIRES_TOWERS[towerID]

	# Iterate through requires towers dictionary
	for required_tower_id in requires_towers_dict.keys():
		# Return false if the required tower is not in the tower count dictionary
		if !tower_count_dict.has(required_tower_id):
			return false
		# Return false if the required tower count is less than the required amount in the requires towers dictionary
		if tower_count_dict[required_tower_id] < requires_towers_dict[required_tower_id]:
			return false

	# If we made it here, all requirements have been met
	return true


func tower_count_dict_to_tower_id_array(tower_count_dict: Dictionary[TowerConstants.TowerIDs, int]) -> Array[TowerConstants.TowerIDs]:
	var tower_id_array: Array[TowerConstants.TowerIDs] = []
	# Iterate through the tower count dictionary
	for tower_id in tower_count_dict.keys():
		# Add the tower id to the array the number of times specified in the count
		for i in range(tower_count_dict[tower_id]):
			tower_id_array.append(tower_id)
	return tower_id_array