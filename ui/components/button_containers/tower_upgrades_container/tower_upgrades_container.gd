extends HBoxContainer
class_name TowerUpgradesContainer

# SINGLETON
@export var CONNECTED_MAIN_HUB: RandomTowerBuildHUD

# TOWER BUTTON EXPORTS
# ====================
@export var TOMBSTONE_BUTTON: Button
@export var SAM_SITE_BUTTON: Button
@export var LAVA_POOL_BUTTON: Button
@export var ICE_SHARD_BUTTON: Button
@export var EMP_STUNNER_BUTTON: Button
@export var GATLING_GUN_BUTTON: Button
@export var SHARP_SHOOTER_BUTTON: Button

@onready var ALL_TOWER_BUTTONS: Array[Button] = [
	TOMBSTONE_BUTTON,
	SAM_SITE_BUTTON,
	LAVA_POOL_BUTTON,
	ICE_SHARD_BUTTON,
	EMP_STUNNER_BUTTON,
	GATLING_GUN_BUTTON,
	SHARP_SHOOTER_BUTTON,
]

@onready var TOWER_ID_TO_BUTTON_DICT: Dictionary[TowerConstants.TowerIDs, Button] = {
	TowerConstants.TowerIDs.TOMBSTONE_LVL_1: TOMBSTONE_BUTTON,
	TowerConstants.TowerIDs.SAM_SITE_LVL_1: SAM_SITE_BUTTON,
	TowerConstants.TowerIDs.LAVA_POOL_LVL_1: LAVA_POOL_BUTTON,
	TowerConstants.TowerIDs.ICE_SHARD_LVL_1: ICE_SHARD_BUTTON,
	TowerConstants.TowerIDs.EMP_STUNNER_LVL_1: EMP_STUNNER_BUTTON,
	TowerConstants.TowerIDs.GATLING_GUN_LVL_1: GATLING_GUN_BUTTON,
	TowerConstants.TowerIDs.SHARP_SHOOTER_LVL_1: SHARP_SHOOTER_BUTTON,
}

@onready var TOWER_UPGRADES_CONTAINER_BUTTON_CALLBACKS: Dictionary[Button, Callable] = {
	TOMBSTONE_BUTTON: _on_tombstone_button_pressed,
	SAM_SITE_BUTTON: _on_sam_site_button_pressed,
	LAVA_POOL_BUTTON: _on_lava_pool_button_pressed,
	ICE_SHARD_BUTTON: _on_ice_shard_button_pressed,
	EMP_STUNNER_BUTTON: _on_emp_stunner_button_pressed,
	GATLING_GUN_BUTTON: _on_gatling_gun_button_pressed,
	SHARP_SHOOTER_BUTTON: _on_sharp_shooter_button_pressed,
}


func _ready():
	# Ensure all tower button exports have been assigned.
	_validate_tower_button_exports()
	# Tower upgrades container
	_connect_tower_upgrades_signals()

# PRIVATE METHODS
# ===============
func _connect_tower_upgrades_signals():
	# Connect the button signals to the appropriate methods
	for button in ALL_TOWER_BUTTONS:
		# Retrieve the callback function from the dictionary using the button as the key.
		button.pressed.connect(TOWER_UPGRADES_CONTAINER_BUTTON_CALLBACKS[button])


## Ensures that all tower button exports have been assigned.
func _validate_tower_button_exports():
	assert(TOMBSTONE_BUTTON, "TOMBSTONE_BUTTON is not assigned in the inspector.")
	assert(SAM_SITE_BUTTON, "SAM_SITE_BUTTON is not assigned in the inspector.")
	assert(LAVA_POOL_BUTTON, "LAVA_POOL_BUTTON is not assigned in the inspector.")
	assert(ICE_SHARD_BUTTON, "ICE_SHARD_BUTTON is not assigned in the inspector.")
	assert(EMP_STUNNER_BUTTON, "EMP_STUNNER_BUTTON is not assigned in the inspector.")
	assert(GATLING_GUN_BUTTON, "GATLING_GUN_BUTTON is not assigned in the inspector.")
	assert(SHARP_SHOOTER_BUTTON, "SHARP_SHOOTER_BUTTON is not assigned in the inspector.")

# PUBLIC METHODS
# ==============
## Disables the visibility of all tower buttons.
func hide_all_tower_buttons():
	for button in ALL_TOWER_BUTTONS:
		button.visible = false

func _on_tombstone_button_pressed():
	CONNECTED_MAIN_HUB.handle_built_tower_upgrade(TowerConstants.UpgradeTowerIDs.TOMBSTONE_LVL_1)

func _on_sam_site_button_pressed():
	CONNECTED_MAIN_HUB.handle_built_tower_upgrade(TowerConstants.UpgradeTowerIDs.SAM_SITE_LVL_1)

func _on_lava_pool_button_pressed():
	CONNECTED_MAIN_HUB.handle_built_tower_upgrade(TowerConstants.UpgradeTowerIDs.LAVA_POOL_LVL_1)

func _on_ice_shard_button_pressed():
	CONNECTED_MAIN_HUB.handle_built_tower_upgrade(TowerConstants.UpgradeTowerIDs.ICE_SHARD_LVL_1)

func _on_emp_stunner_button_pressed():
	CONNECTED_MAIN_HUB.handle_built_tower_upgrade(TowerConstants.UpgradeTowerIDs.EMP_STUNNER_LVL_1)

func _on_gatling_gun_button_pressed():
	CONNECTED_MAIN_HUB.handle_built_tower_upgrade(TowerConstants.UpgradeTowerIDs.GATLING_GUN_LVL_1)

func _on_sharp_shooter_button_pressed():
	CONNECTED_MAIN_HUB.handle_built_tower_upgrade(TowerConstants.UpgradeTowerIDs.SHARP_SHOOTER_LVL_1)