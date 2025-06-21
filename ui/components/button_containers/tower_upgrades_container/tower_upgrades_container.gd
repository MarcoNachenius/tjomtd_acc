extends HBoxContainer
class_name TowerUpgradesContainer

# TOWER BUTTON EXPORTS
# ====================
@export var TOMBSTONE_BUTTON: Button
@export var SAM_SITE_BUTTON: Button
@export var LAVA_POOL_BUTTON: Button
@export var ICE_SHARD_BUTTON: Button
@export var EMP_STUNNER_BUTTON: Button
@export var GATLING_GUN_BUTTON: Button

@onready var ALL_TOWER_BUTTONS: Array[Button] = [
	TOMBSTONE_BUTTON,
	SAM_SITE_BUTTON,
	LAVA_POOL_BUTTON,
	ICE_SHARD_BUTTON,
	EMP_STUNNER_BUTTON,
	GATLING_GUN_BUTTON,
]

@onready var TOWER_ID_TO_BUTTON_DICT: Dictionary[TowerConstants.TowerIDs, Button] = {
	TowerConstants.TowerIDs.TOMBSTONE_LVL_1: TOMBSTONE_BUTTON,
	TowerConstants.TowerIDs.SAM_SITE_LVL_1: SAM_SITE_BUTTON,
	TowerConstants.TowerIDs.LAVA_POOL_LVL_1: LAVA_POOL_BUTTON,
	TowerConstants.TowerIDs.ICE_SHARD_LVL_1: ICE_SHARD_BUTTON,
	TowerConstants.TowerIDs.EMP_STUNNER_LVL_1: EMP_STUNNER_BUTTON,
	TowerConstants.TowerIDs.GATLING_GUN_LVL_1: GATLING_GUN_BUTTON,
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
	assert(ICE_SHARD_BUTTON, "ICE_SHARD_BUTTON is not assigned in the inspector.")
	assert(EMP_STUNNER_BUTTON, "EMP_STUNNER_BUTTON is not assigned in the inspector.")
	assert(GATLING_GUN_BUTTON, "GATLING_GUN_BUTTON is not assigned in the inspector.")

# PUBLIC METHODS
# ==============
## Disables the visibility of all tower buttons.
func hide_all_tower_buttons():
	for button in ALL_TOWER_BUTTONS:
		button.visible = false

