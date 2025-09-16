extends VBoxContainer
class_name UpgradeTowerInfoContainer

@export var TOWER_NAME_TEXT: RichTextLabel
@export var TOWER_STATS_TEXT: RichTextLabel
@export var TOWER_DESCRIPTION_TEXT: RichTextLabel
@export var UPGRADES_INTO_TOWER_BUTTONS: UpgradeTowerButtonsVBox
@export var REQUIRES_BUILDABLE_TOWERS_BUTTONS: BuildableTowerButtonsVBox
@export var REQUIRES_UPGRADE_TOWERS_BUTTONS: UpgradeTowerButtonsVBox

## VBox containing text header and requires towers button list
@export var REQUIRES_TOWERS_COLUMN: VBoxContainer
## VBox containing text header and upgrades into towers button list
@export var UPGRADES_INTO_TOWERS_COLUMN: VBoxContainer
## VBox containing text header and tower stats text
@export var TOWER_STATS_COLUMN: VBoxContainer
## VBox containing text header and tower description text
@export var TOWER_DESCRIPTION_COLUMN: VBoxContainer

func _ready() -> void:
	hide_all_button_list_columns()


# ==============
# PUBLIC METHODS
# ==============
## Hides 'Requires Towers' and 'Upgrades Into Tower' VBoxes 
## which contain a text header and a button list.
## This function ensures that when a column is made visible again,
## all previously visible buttons have been hidden.
func hide_all_button_list_columns() -> void:
	# Ensure previously visible buttons are hidden
	REQUIRES_BUILDABLE_TOWERS_BUTTONS.hide_all_buttons()
	REQUIRES_UPGRADE_TOWERS_BUTTONS.hide_all_buttons()
	UPGRADES_INTO_TOWER_BUTTONS.hide_all_buttons()
	# Hide all columns
	REQUIRES_TOWERS_COLUMN.visible = false
	UPGRADES_INTO_TOWERS_COLUMN.visible = false

## Hides tower description and tower stats VBoxes 
## which each contain separated header and content text labels.
## This function ensures that when a column is made visible again,
## all previously visible content text has been cleared.
func hide_stats_and_description_columns() -> void:
	# Ensure previously filled content is cleared
	TOWER_DESCRIPTION_TEXT.text = ""
	TOWER_STATS_TEXT.text = ""
	# Hide all columns
	TOWER_DESCRIPTION_COLUMN.visible = false
	TOWER_STATS_COLUMN.visible = false

## WIP
func display_tower_information(towerID: TowerConstants.TowerIDs) -> void:
	# Header text
	TOWER_NAME_TEXT.text = TowerDescriptions.TOWER_NAMES[towerID]

	# Stats and description columns
	# Clear previous values
	hide_stats_and_description_columns()
	_display_tower_description(towerID)
	# Stats text
	_display_tower_stats(towerID)
	
	# Upgrades into button containers
	# Clear previous values
	hide_all_button_list_columns()
	# Handle upgrades into towers buttons visibility
	_display_upgrades_into_tower_buttons(towerID)
	# Handle requires towers buttons visibility
	_display_requires_towers_buttons(towerID)


# ===============
# PRIVATE METHODS
# ===============
func _display_tower_description(towerID: TowerConstants.TowerIDs) -> void:
	# Hide entire column if tower description cannot be found
	if !TowerDescriptions.TOWER_ID_TO_DESCRPTION_TEXT.get(towerID):
		return

	# Ensure description column is visible
	TOWER_DESCRIPTION_COLUMN.visible = true

	# Load description text into container
	TOWER_DESCRIPTION_TEXT.text = TowerDescriptions.TOWER_ID_TO_DESCRPTION_TEXT[towerID]


func _display_tower_stats(towerID: TowerConstants.TowerIDs) -> void:
	# Display no stats if none can be found
	if !TowerDescriptions.TOWER_ID_TO_STATS.get(towerID):
		return
	
	# Ensure stats column is visible
	TOWER_STATS_COLUMN.visible = true
	
	# Create placeholder for stats text
	var combined_output_text: String = ""
	# Fetch relevant tower stats dict
	var tower_stats_dict = TowerDescriptions.TOWER_ID_TO_STATS[towerID]

	# Assign Damage (int)
	if tower_stats_dict.get(TowerDescriptions.TowerStats.DAMAGE, 0) > 0:
		combined_output_text += "Damage: %d\n" % tower_stats_dict[TowerDescriptions.TowerStats.DAMAGE]
	# Assign Speed (float)
	if tower_stats_dict.get(TowerDescriptions.TowerStats.ATTACK_COOLDOWN, 0) > 0:
		combined_output_text += "Speed (Attack Cooldown): %.2fs\n" % tower_stats_dict[TowerDescriptions.TowerStats.ATTACK_COOLDOWN]
	# Assign Range (int)
	if tower_stats_dict.get(TowerDescriptions.TowerStats.RANGE, 0) > 0:
		combined_output_text += "Range: %d\n" % tower_stats_dict[TowerDescriptions.TowerStats.RANGE]
	
	# Populate description text content 
	TOWER_STATS_TEXT.text = combined_output_text


func _display_upgrades_into_tower_buttons(towerID: TowerConstants.TowerIDs) -> void:
	# Fetch list of possible upgrade towers
	var upgrades_into_towers: Array[TowerConstants.TowerIDs] = TowerConstants.UPGRADES_INTO[towerID]

	# Hide entire column if there are no possible upgrade towers
	if upgrades_into_towers.is_empty():
		return

	# Ensure upgrades into towers column is visible
	UPGRADES_INTO_TOWERS_COLUMN.visible = true

	# Show buttons corresponding to tower ids into which tower can upgrade
	UPGRADES_INTO_TOWER_BUTTONS.show_buttons(upgrades_into_towers)


func _display_requires_towers_buttons(towerID: TowerConstants.TowerIDs) -> void:
	# Fetch list of possible required towers
	var requires_towers_dict = TowerConstants.REQUIRES_TOWERS[towerID]
	var requires_towers: Array[TowerConstants.TowerIDs] = []
	requires_towers = requires_towers_dict.keys()

	# Hide entire column if there are no possible required towers
	if requires_towers.is_empty():
		return

	# Ensure upgrades into towers column is visible
	REQUIRES_TOWERS_COLUMN.visible = true

	# Precompute value-sets once
	var buildable_values: Array = TowerConstants.BuildTowerIDs.values()
	var upgrade_values: Array = TowerConstants.UpgradeTowerIDs.values()

	var buildable_towers: Array[TowerConstants.TowerIDs] = []
	var upgradeable_towers: Array[TowerConstants.TowerIDs] = []

	for required_tower_id in requires_towers:
		if buildable_values.has(required_tower_id):
			buildable_towers.append(required_tower_id)
			continue
		if upgrade_values.has(required_tower_id):
			upgradeable_towers.append(required_tower_id)

	if buildable_towers.is_empty():
		REQUIRES_BUILDABLE_TOWERS_BUTTONS.visible = false
	else:
		REQUIRES_BUILDABLE_TOWERS_BUTTONS.visible = true
		REQUIRES_BUILDABLE_TOWERS_BUTTONS.show_buttons(buildable_towers)
	
	if upgradeable_towers.is_empty():
		REQUIRES_UPGRADE_TOWERS_BUTTONS.visible = false
	else:
		REQUIRES_UPGRADE_TOWERS_BUTTONS.visible = true
		REQUIRES_UPGRADE_TOWERS_BUTTONS.show_buttons(upgradeable_towers)
