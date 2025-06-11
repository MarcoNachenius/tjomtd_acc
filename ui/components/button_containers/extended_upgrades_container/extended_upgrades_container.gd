extends HBoxContainer
class_name ExtendedUpgradesContainer

@export var TOMBSTONE_LVL_2_BUTTON: Button
@export var SAM_SITE_LVL_2_BUTTON: Button
@export var LAVA_POOL_LVL_2_BUTTON: Button
@export var LAVA_POOL_LVL_3_BUTTON: Button
@export var ICE_SHARD_LVL_2_BUTTON: Button
@export var ICE_SHARD_LVL_3_BUTTON: Button

@onready var ALL_BUTTONS: Array[Button] = [
    TOMBSTONE_LVL_2_BUTTON,
    SAM_SITE_LVL_2_BUTTON,
    LAVA_POOL_LVL_2_BUTTON,
    LAVA_POOL_LVL_3_BUTTON,
    ICE_SHARD_LVL_2_BUTTON,
    ICE_SHARD_LVL_3_BUTTON,
]

@onready var TOWER_ID_TO_BUTTON_DICT: Dictionary[TowerConstants.TowerIDs, Button] = {
    TowerConstants.TowerIDs.TOMBSTONE_LVL_2: TOMBSTONE_LVL_2_BUTTON,
    TowerConstants.TowerIDs.SAM_SITE_LVL_2: SAM_SITE_LVL_2_BUTTON,
    TowerConstants.TowerIDs.LAVA_POOL_LVL_2: LAVA_POOL_LVL_2_BUTTON,
    TowerConstants.TowerIDs.LAVA_POOL_LVL_3: LAVA_POOL_LVL_3_BUTTON,
    TowerConstants.TowerIDs.ICE_SHARD_LVL_2: ICE_SHARD_LVL_2_BUTTON,
    TowerConstants.TowerIDs.ICE_SHARD_LVL_3: ICE_SHARD_LVL_3_BUTTON,
}

# PUBLIC METHODS
func hide_all_buttons():
    for button in ALL_BUTTONS:
        button.visible = false