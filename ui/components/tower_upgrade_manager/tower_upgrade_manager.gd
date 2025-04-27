extends Node
class_name TowerUpgradeManager

## Returns a dictionary with the count of each tower in the game.
## The key is the id of the tower, the value is the count.
func _tower_count_dict(Towers: Array[Tower]) -> Dictionary[TowerConstants.TowerIDs, int]:
	var count_dict: Dictionary[TowerConstants.TowerIDs, int] = {}
	# Increment the count of a tower by 1 if it exists, or add new tower id and set it to 1 if it doesn't.
	for tower in Towers:
		count_dict[tower.TOWER_ID] = count_dict.get(tower.TOWER_ID, 0) + 1
	return count_dict
