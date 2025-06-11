extends HBoxContainer
class_name TowerUpgradesContainer

# TOWER BUTTON EXPORTS
# ====================
@export var TOMBSTONE_BUTTON: Button
@export var SAM_SITE_BUTTON: Button
@export var LAVA_POOL_BUTTON: Button

@onready var ALL_TOWER_BUTTONS: Array[Button] = [
	TOMBSTONE_BUTTON,
	SAM_SITE_BUTTON,
	LAVA_POOL_BUTTON,
]

@onready var TOWER_ID_TO_BUTTON_DICT: Dictionary[TowerConstants.TowerIDs, Button] = {
	TowerConstants.TowerIDs.TOMBSTONE_LVL_1: TOMBSTONE_BUTTON,
	TowerConstants.TowerIDs.SAM_SITE_LVL_1: SAM_SITE_BUTTON,
	TowerConstants.TowerIDs.LAVA_POOL_LVL_1: LAVA_POOL_BUTTON
}

func _ready():
	# Ensure all tower button exports have been assigned.
	_validate_tower_button_exports()

# PRIVATE METHODS
# ===============
## Ensures that all tower button exports have been assigned.
func _validate_tower_button_exports():
	assert(TOMBSTONE_BUTTON, "TOMBSTONE_BUTTON is not assigned in the inspector.")
	assert(SAM_SITE_BUTTON, "SAM_SITE_BUTTON is not assigned in the inspector.")
	assert(LAVA_POOL_BUTTON, "LAVA_POOL_BUTTON is not assigned in the inspector.")

# PUBLIC METHODS
# ==============
## Disables the visibility of all tower buttons.
func hide_all_tower_buttons():
	for button in ALL_TOWER_BUTTONS:
		button.visible = false

