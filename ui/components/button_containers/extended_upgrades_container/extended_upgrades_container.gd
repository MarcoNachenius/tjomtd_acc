extends HBoxContainer
class_name ExtendedUpgradesContainer

# SINGLETON
@export var CONNECTED_MAIN_HUB: RandomTowerBuildHUD

@export var TOMBSTONE_LVL_2_BUTTON: Button
@export var TOMBSTONE_LVL_3_BUTTON: Button
@export var SAM_SITE_LVL_2_BUTTON: Button
@export var SAM_SITE_LVL_3_BUTTON: Button
@export var LAVA_POOL_LVL_2_BUTTON: Button
@export var LAVA_POOL_LVL_3_BUTTON: Button
@export var ICE_SHARD_LVL_2_BUTTON: Button
@export var ICE_SHARD_LVL_3_BUTTON: Button
@export var EMP_STUNNER_LVL_2_BUTTON: Button
@export var EMP_STUNNER_LVL_3_BUTTON: Button
@export var GATLING_GUN_LVL_2_BUTTON: Button
@export var SHARP_SHOOTER_LVL_2_BUTTON: Button

@onready var ALL_BUTTONS: Array[Button] = [
    TOMBSTONE_LVL_3_BUTTON,
    TOMBSTONE_LVL_2_BUTTON,
    SAM_SITE_LVL_2_BUTTON,
    SAM_SITE_LVL_3_BUTTON,
    LAVA_POOL_LVL_2_BUTTON,
    LAVA_POOL_LVL_3_BUTTON,
    ICE_SHARD_LVL_2_BUTTON,
    ICE_SHARD_LVL_3_BUTTON,
    EMP_STUNNER_LVL_2_BUTTON,
    EMP_STUNNER_LVL_3_BUTTON,
    GATLING_GUN_LVL_2_BUTTON,
    SHARP_SHOOTER_LVL_2_BUTTON,
]

@onready var TOWER_ID_TO_BUTTON_DICT: Dictionary[TowerConstants.TowerIDs, Button] = {
    TowerConstants.TowerIDs.TOMBSTONE_LVL_2: TOMBSTONE_LVL_2_BUTTON,
    TowerConstants.TowerIDs.TOMBSTONE_LVL_3: TOMBSTONE_LVL_3_BUTTON,
    TowerConstants.TowerIDs.SAM_SITE_LVL_2: SAM_SITE_LVL_2_BUTTON,
    TowerConstants.TowerIDs.SAM_SITE_LVL_3: SAM_SITE_LVL_3_BUTTON,
    TowerConstants.TowerIDs.LAVA_POOL_LVL_2: LAVA_POOL_LVL_2_BUTTON,
    TowerConstants.TowerIDs.LAVA_POOL_LVL_3: LAVA_POOL_LVL_3_BUTTON,
    TowerConstants.TowerIDs.ICE_SHARD_LVL_2: ICE_SHARD_LVL_2_BUTTON,
    TowerConstants.TowerIDs.ICE_SHARD_LVL_3: ICE_SHARD_LVL_3_BUTTON,
    TowerConstants.TowerIDs.EMP_STUNNER_LVL_2: EMP_STUNNER_LVL_2_BUTTON,
    TowerConstants.TowerIDs.EMP_STUNNER_LVL_3: EMP_STUNNER_LVL_3_BUTTON,
    TowerConstants.TowerIDs.GATLING_GUN_LVL_2: GATLING_GUN_LVL_2_BUTTON,
    TowerConstants.TowerIDs.SHARP_SHOOTER_LVL_2: SHARP_SHOOTER_LVL_2_BUTTON,
}

func _ready() -> void:
    # Add tower prices to button text
    for tower_id in TOWER_ID_TO_BUTTON_DICT.keys():
        var button: Button = TOWER_ID_TO_BUTTON_DICT[tower_id]
        button.text += " (" + str(TowerConstants.TowerPrices[tower_id]) + ")"
    
    # Ensure all button exports have been assigned.
    assert(TOMBSTONE_LVL_2_BUTTON, "TOMBSTONE_LVL_2_BUTTON is not assigned in the inspector.")
    assert(TOMBSTONE_LVL_3_BUTTON, "TOMBSTONE_LVL_3_BUTTON is not assigned in the inspector.")
    assert(SAM_SITE_LVL_2_BUTTON, "SAM_SITE_LVL_2_BUTTON is not assigned in the inspector.")
    assert(SAM_SITE_LVL_3_BUTTON, "SAM_SITE_LVL_3_BUTTON is not assigned in the inspector.")
    assert(LAVA_POOL_LVL_2_BUTTON, "LAVA_POOL_LVL_2_BUTTON is not assigned in the inspector.")
    assert(LAVA_POOL_LVL_3_BUTTON, "LAVA_POOL_LVL_3_BUTTON is not assigned in the inspector.")
    assert(ICE_SHARD_LVL_2_BUTTON, "ICE_SHARD_LVL_2_BUTTON is not assigned in the inspector.")
    assert(ICE_SHARD_LVL_3_BUTTON, "ICE_SHARD_LVL_3_BUTTON is not assigned in the inspector.")
    assert(EMP_STUNNER_LVL_2_BUTTON, "EMP_STUNNER_LVL_2_BUTTON is not assigned in the inspector.")
    assert(EMP_STUNNER_LVL_3_BUTTON, "EMP_STUNNER_LVL_3_BUTTON is not assigned in the inspector.")
    assert(GATLING_GUN_LVL_2_BUTTON, "GATLING_GUN_LVL_2_BUTTON is not assigned in the inspector.")
    assert(SHARP_SHOOTER_LVL_2_BUTTON, "SHARP_SHOOTER_LVL_2_BUTTON is not assigned in the inspector.")

    # Connect signals
    _connect_extended_upgrades_signals()
    hide_all_buttons()


@onready var EXTENDED_UPGRADES_CONTAINER_BUTTON_CALLBACKS: Dictionary[Button, Callable] = {
    TOMBSTONE_LVL_2_BUTTON: _on_tombstone_lvl_2_button_pressed,
    TOMBSTONE_LVL_3_BUTTON: _on_tombstone_lvl_3_button_pressed,
    SAM_SITE_LVL_2_BUTTON: _on_sam_site_lvl_2_button_pressed,
    SAM_SITE_LVL_3_BUTTON: _on_sam_site_lvl_3_button_pressed,
    LAVA_POOL_LVL_2_BUTTON: _on_lava_pool_lvl_2_button_pressed,
    LAVA_POOL_LVL_3_BUTTON: _on_lava_pool_lvl_3_button_pressed,
    ICE_SHARD_LVL_2_BUTTON: _on_ice_shard_lvl_2_button_pressed,
    ICE_SHARD_LVL_3_BUTTON: _on_ice_shard_lvl_3_button_pressed,
    EMP_STUNNER_LVL_2_BUTTON: _on_emp_stunner_lvl_2_button_pressed,
    EMP_STUNNER_LVL_3_BUTTON: _on_emp_stunner_lvl_3_button_pressed,
    GATLING_GUN_LVL_2_BUTTON: _on_gatling_gun_lvl_2_button_pressed,
    SHARP_SHOOTER_LVL_2_BUTTON: _on_sharp_shooter_lvl_2_button_pressed,
}

# PUBLIC METHODS
func hide_all_buttons():
    for button in ALL_BUTTONS:
        button.visible = false


# PRIVATE METHODS
func _connect_extended_upgrades_signals():
    # Connect the button signals to the appropriate methods
    for button in ALL_BUTTONS:
        # Retrieve the callback function from the dictionary using the button as the key.
        button.pressed.connect(EXTENDED_UPGRADES_CONTAINER_BUTTON_CALLBACKS[button])

#                                           |EXTENDED UPGRADE CONTAINER|
# =============================================================================================================
func _on_sharp_shooter_lvl_2_button_pressed():
    CONNECTED_MAIN_HUB.GAME_MAP.handle_extended_upgrade(TowerConstants.UpgradeTowerIDs.SHARP_SHOOTER_LVL_2)

func _on_tombstone_lvl_2_button_pressed():
    CONNECTED_MAIN_HUB.GAME_MAP.handle_extended_upgrade(TowerConstants.UpgradeTowerIDs.TOMBSTONE_LVL_2)

func _on_tombstone_lvl_3_button_pressed():
    CONNECTED_MAIN_HUB.GAME_MAP.handle_extended_upgrade(TowerConstants.UpgradeTowerIDs.TOMBSTONE_LVL_3)

func _on_sam_site_lvl_2_button_pressed():
    CONNECTED_MAIN_HUB.GAME_MAP.handle_extended_upgrade(TowerConstants.UpgradeTowerIDs.SAM_SITE_LVL_2)

func _on_sam_site_lvl_3_button_pressed():
    CONNECTED_MAIN_HUB.GAME_MAP.handle_extended_upgrade(TowerConstants.UpgradeTowerIDs.SAM_SITE_LVL_3)

func _on_lava_pool_lvl_2_button_pressed():
    CONNECTED_MAIN_HUB.GAME_MAP.handle_extended_upgrade(TowerConstants.UpgradeTowerIDs.LAVA_POOL_LVL_2)

func _on_lava_pool_lvl_3_button_pressed():
    CONNECTED_MAIN_HUB.GAME_MAP.handle_extended_upgrade(TowerConstants.UpgradeTowerIDs.LAVA_POOL_LVL_3)

func _on_ice_shard_lvl_2_button_pressed():
    CONNECTED_MAIN_HUB.GAME_MAP.handle_extended_upgrade(TowerConstants.UpgradeTowerIDs.ICE_SHARD_LVL_2)

func _on_ice_shard_lvl_3_button_pressed():
    CONNECTED_MAIN_HUB.GAME_MAP.handle_extended_upgrade(TowerConstants.UpgradeTowerIDs.ICE_SHARD_LVL_3)

func _on_emp_stunner_lvl_2_button_pressed():
    CONNECTED_MAIN_HUB.GAME_MAP.handle_extended_upgrade(TowerConstants.UpgradeTowerIDs.EMP_STUNNER_LVL_2)

func _on_emp_stunner_lvl_3_button_pressed():
    CONNECTED_MAIN_HUB.GAME_MAP.handle_extended_upgrade(TowerConstants.UpgradeTowerIDs.EMP_STUNNER_LVL_3)

func _on_gatling_gun_lvl_2_button_pressed():
    CONNECTED_MAIN_HUB.GAME_MAP.handle_extended_upgrade(TowerConstants.UpgradeTowerIDs.GATLING_GUN_LVL_2)