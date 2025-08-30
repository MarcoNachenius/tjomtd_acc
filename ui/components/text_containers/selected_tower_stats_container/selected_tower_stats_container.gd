extends VBoxContainer
class_name SelectedTowerStatsContainer

@export var TOWER_NAME_TEXT: RichTextLabel
@export var TOWER_ATTR_CONTAINER: TowerAttributesContainer


func populate_tower_stats(tower: Tower) -> void:
	TOWER_ATTR_CONTAINER.visible = true
	_assign_tower_name(tower)
	# Handle Barricade selection
	if tower.TOWER_ID == TowerConstants.TowerIDs.BARRICADE:
		TOWER_ATTR_CONTAINER.visible = false
		return
	
	TOWER_ATTR_CONTAINER.visible = true
	_assign_description(tower)
	_assign_damage(tower)
	_assign_range(tower)
	_assign_cooldown(tower)
	_assign_upgrades_into(tower)

func _assign_description(tower: Tower) -> void:
	if TowerDescriptions.TOWER_ID_TO_DESCRPTION_TEXT.keys().has(tower.TOWER_ID):
		TOWER_ATTR_CONTAINER.DESCRIPTION_VALUE.text = TowerDescriptions.TOWER_ID_TO_DESCRPTION_TEXT[tower.TOWER_ID]
	else:
		TOWER_ATTR_CONTAINER.DESCRIPTION_VALUE.text = " TOWER DESCRIPTION NOT FOUND"

func _assign_tower_name(tower: Tower) -> void:
	if TowerConstants.TOWER_NAMES.keys().has(tower.TOWER_ID):
		TOWER_NAME_TEXT.text = TowerConstants.TOWER_NAMES[tower.TOWER_ID]
	else:
		TOWER_NAME_TEXT.text = "Tower name not found"

func _assign_damage(tower: Tower) -> void:
	# Don't bother finding potential damage buff amounts if there is no damage to increase
	if tower.PRIMARY_PROJECTILE_SPAWNER.get_damage() == 0:
		TOWER_ATTR_CONTAINER.DAMAGE_VALUE.text = str(0)
		return
	
	var display_text: String = ""
	
	# Add base damage to display text
	display_text += str(tower.PRIMARY_PROJECTILE_SPAWNER.INITIAL_DAMAGE)

	# Add damage buff amount
	var damage_buff_amount: int = tower.PRIMARY_PROJECTILE_SPAWNER.total_bonus_damage()
	if damage_buff_amount > 0:
		display_text += " (+%d)" % damage_buff_amount
	
	TOWER_ATTR_CONTAINER.DAMAGE_VALUE.text = display_text


func _assign_range(tower: Tower) -> void:
	var display_text: String = ""
	
	# Add base range to display text
	display_text += str(tower.PRIMARY_PROJECTILE_SPAWNER.INITIAL_RANGE)

	# Add range buff amount
	var range_buff_amount: int = tower.PRIMARY_PROJECTILE_SPAWNER.total_bonus_range()
	if range_buff_amount > 0:
		display_text += " (+%d)" % range_buff_amount
	
	TOWER_ATTR_CONTAINER.RANGE_VALUE.text = display_text

func _assign_cooldown(tower) -> void:
	TOWER_ATTR_CONTAINER.COOLDOWN_VALUE.text = str(tower.PRIMARY_PROJECTILE_SPAWNER.get_cooldown_duration()) + "s"

func _assign_upgrades_into(tower: Tower) -> void:
	var upgrades_into_text: String = ""
	var found_tower_id: bool = TowerConstants.UPGRADES_INTO.keys().has(tower.TOWER_ID)
	# Handle situation where tower id has not been found in TowerConstants.UPGRADES_INTO
	if !found_tower_id:
		TOWER_ATTR_CONTAINER.UPGRADES_INTO_VALUE.text = "Tower ID not found in TowerConstants.UPGRADES_INTO"
		return
	
	var upgrades_into_tower_list: Array[TowerConstants.TowerIDs] = TowerConstants.UPGRADES_INTO[tower.TOWER_ID]
	# Construct display text string value
	for upgrade_tower_id in upgrades_into_tower_list:
		# Remove "Level x" suffix from tower name
		var split_tower_name = TowerConstants.TOWER_NAMES[upgrade_tower_id].split(" ")
		split_tower_name.resize(split_tower_name.size() - 2)
		var altered_tower_name: String = ""
		for word in split_tower_name:
			altered_tower_name += word + " "
		
		# Add processed tower name line
		upgrades_into_text += "  - " + altered_tower_name
	 
	TOWER_ATTR_CONTAINER.UPGRADES_INTO_VALUE.text = upgrades_into_text

## Handles logic when tower is deselected
func clear_tower_stats() -> void:
	TOWER_ATTR_CONTAINER.visible = false
	TOWER_NAME_TEXT.text = "No Tower Selected"
