extends HBoxContainer
class_name ExtendedUpgradesContainer

@export var TOMBSTONE_LVL_2_BUTTON: Button
@export var SAM_SITE_LVL_2_BUTTON: Button

@onready var ALL_BUTTONS: Array[Button] = [
    TOMBSTONE_LVL_2_BUTTON,
    SAM_SITE_LVL_2_BUTTON,
]

@onready var TOWER_ID_TO_BUTTON_DICT: Dictionary[TowerConstants.TowerIDs, Button] = {
    TowerConstants.TowerIDs.TOMBSTONE_LVL_2: TOMBSTONE_LVL_2_BUTTON,
    TowerConstants.TowerIDs.SAM_SITE_LVL_2: SAM_SITE_LVL_2_BUTTON,
}

# PUBLIC METHODS
func hide_all_buttons():
    for button in ALL_BUTTONS:
        button.visible = false