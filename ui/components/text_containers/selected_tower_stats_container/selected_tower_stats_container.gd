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
	TOWER_ATTR_CONTAINER.DAMAGE_VALUE.text = str(tower.PRIMARY_PROJECTILE_SPAWNER.get_damage())

func _assign_range(tower: Tower) -> void:
	TOWER_ATTR_CONTAINER.RANGE_VALUE.text = str(tower.PRIMARY_PROJECTILE_SPAWNER.get_detection_range())

func _assign_cooldown(tower) -> void:
	TOWER_ATTR_CONTAINER.COOLDOWN_VALUE.text = str(tower.PRIMARY_PROJECTILE_SPAWNER.get_cooldown_duration()) + "s"

## Handles logic when tower is deselected
func clear_tower_stats() -> void:
	TOWER_ATTR_CONTAINER.visible = false
	TOWER_NAME_TEXT.text = "No Tower Selected"
