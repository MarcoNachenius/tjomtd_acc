extends VBoxContainer
class_name SlateInfoContainer

@export var SLATE_NAME_TEXT: RichTextLabel
@export var SLATE_STATS_TEXT: RichTextLabel
@export var SLATE_DESCRIPTION_TEXT: RichTextLabel
@export var REQUIRES_BUILDABLE_TOWERS_BUTTONS: BuildableTowerButtonsVBox
@export var REQUIRES_UPGRADE_TOWERS_BUTTONS: UpgradeTowerButtonsVBox

## VBox containing text header and requires towers button list
@export var REQUIRES_TOWERS_COLUMN: VBoxContainer
## VBox containing text header and slate stats text
@export var SLATE_STATS_COLUMN: VBoxContainer
## VBox containing text header and slate description text
@export var SLATE_DESCRIPTION_COLUMN: VBoxContainer

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
	# Hide all columns
	REQUIRES_TOWERS_COLUMN.visible = false

## Hides slate description and slate stats VBoxes 
## which each contain separated header and content text labels.
## This function ensures that when a column is made visible again,
## all previously visible content text has been cleared.
func hide_stats_and_description_columns() -> void:
	# Ensure previously filled content is cleared
	SLATE_DESCRIPTION_TEXT.text = ""
	SLATE_STATS_TEXT.text = ""
	# Hide all columns
	SLATE_DESCRIPTION_COLUMN.visible = false
	SLATE_STATS_COLUMN.visible = false

## Displays tower information based on provided slate id.
func display_slate_information(slateID: SlateConstants.SlateIDs) -> void:
	# Header text
	SLATE_NAME_TEXT.text = SlateDescriptions.SLATE_NAMES[slateID]

	# Stats and description columns
	# Clear previous values
	hide_stats_and_description_columns()
	_display_slate_description(slateID)
	# Stats text
	_display_slate_stats(slateID)
	
	# Upgrades into button containers
	# Clear previous values
	hide_all_button_list_columns()
	# Handle requires towers buttons visibility
	_display_requires_towers_buttons(slateID)


# ===============
# PRIVATE METHODS
# ===============
func _display_slate_description(slateID: SlateConstants.SlateIDs) -> void:
	# Hide entire column if slate description cannot be found
	if !SlateDescriptions.SLATE_ID_TO_DESCRIPTION_TEXT.get(slateID):
		return

	# Ensure description column is visible
	SLATE_DESCRIPTION_COLUMN.visible = true

	# Load description text into container
	SLATE_DESCRIPTION_TEXT.text = SlateDescriptions.SLATE_ID_TO_DESCRIPTION_TEXT[slateID]

func _display_slate_stats(slateID: SlateConstants.SlateIDs) -> void:
	# Display no stats if none can be found
	if !SlateDescriptions.SLATE_ID_TO_STATS.get(slateID):
		return
	
	# Ensure stats column is visible
	SLATE_STATS_COLUMN.visible = true
	
	# Build description text string value
	var combined_output_text: String = _generate_output_stats_text(slateID)
	# Assign description text to ui display element
	SLATE_STATS_TEXT.text = combined_output_text

func _generate_output_stats_text(slateID: SlateConstants.SlateIDs) -> String:
	# Create return value
	var combined_output_text: String = ""

	# Fetch relevant slate stats
	var slate_stats_dict = SlateDescriptions.SLATE_ID_TO_STATS[slateID]

	# BUILD DESCRIPTION TEXT
	# ===== Shared Values =====
	# Range (int)
	if slate_stats_dict.get(SlateDescriptions.SlateStats.RANGE):
		combined_output_text += "Range: %d\n" % slate_stats_dict[SlateDescriptions.SlateStats.RANGE]
	# Max Simul Targets (int)
	if slate_stats_dict.get(SlateDescriptions.SlateStats.MAX_SIMUL_TARGETS):
		combined_output_text += "Max Simultaneous Targets: %d\n" % slate_stats_dict[SlateDescriptions.SlateStats.MAX_SIMUL_TARGETS]
	
	# ===== Hold slates =====
	# Hold Duration (float)
	if slate_stats_dict.get(SlateDescriptions.SlateStats.HOLD_DURATION):
		combined_output_text += "Hold Duration: %.1f seconds\n" % slate_stats_dict[SlateDescriptions.SlateStats.HOLD_DURATION]
	
	# ===== Slow slates =====
	# Slow Percentage (float)
	if slate_stats_dict.get(SlateDescriptions.SlateStats.SLOW_PERCENTAGE):
		combined_output_text += "Slow Percentage: %.1f%%\n" % slate_stats_dict[SlateDescriptions.SlateStats.SLOW_PERCENTAGE]
	
	# ===== Burn slates =====
	# Damage Per Second (int)
	if slate_stats_dict.get(SlateDescriptions.SlateStats.DAMAGE_PER_SECOND):
		combined_output_text += "Damage Per Second: %d\n" % slate_stats_dict[SlateDescriptions.SlateStats.DAMAGE_PER_SECOND]
	
	# ===== Damage slates =====
	# Damage Increase Percentage (int)
	if slate_stats_dict.get(SlateDescriptions.SlateStats.DAMAGE_INCREASE_PERCENTAGE):
		combined_output_text += "Damage Increase Percentage: %d%%\n" % slate_stats_dict[SlateDescriptions.SlateStats.DAMAGE_INCREASE_PERCENTAGE]
	
	# ===== Range slates =====
	# Range Increase Percentage (int)
	if slate_stats_dict.get(SlateDescriptions.SlateStats.RANGE_INCREASE_PERCENTAGE):
		combined_output_text += "Range Increase Percentage: %d%%\n" % slate_stats_dict[SlateDescriptions.SlateStats.RANGE_INCREASE_PERCENTAGE]
	
	# ===== Speed slates =====
	# Speed Increase Percentage (int)
	if slate_stats_dict.get(SlateDescriptions.SlateStats.SPEED_INCREASE_PERCENTAGE):
		combined_output_text += "Speed Increase Percentage: %d%%\n" % slate_stats_dict[SlateDescriptions.SlateStats.SPEED_INCREASE_PERCENTAGE]

	return combined_output_text

func _display_requires_towers_buttons(slateID: SlateConstants.SlateIDs) -> void:
	# Fetch list of possible required towers
	var requires_towers_dict = SlateConstants.REQUIRES_TOWERS[slateID]
	var requires_towers = []
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
