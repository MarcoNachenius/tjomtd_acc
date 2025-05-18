extends HBoxContainer
class_name AwaitingSelectionUpgradeTowersContainer

# EXPORTS
@export var BLACK_MARBLE_LEVEL_2_BUTTON: Button
@export var BLACK_MARBLE_LEVEL_3_BUTTON: Button
@export var SUNSTONE_LEVEL_2_BUTTON: Button
@export var SUNSTONE_LEVEL_3_BUTTON: Button


# CONSTANTS
@onready var ALL_BUTTONS: Array[Button] = [
    BLACK_MARBLE_LEVEL_2_BUTTON,
    BLACK_MARBLE_LEVEL_3_BUTTON,
    SUNSTONE_LEVEL_2_BUTTON,
    SUNSTONE_LEVEL_3_BUTTON,
]

@onready var TOWER_ID_TO_BUTTON_DICT: Dictionary[TowerConstants.TowerIDs, Button] = {
    TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2: BLACK_MARBLE_LEVEL_2_BUTTON,
    TowerConstants.TowerIDs.BLACK_MARBLE_LVL_3: BLACK_MARBLE_LEVEL_3_BUTTON,
    TowerConstants.TowerIDs.SUNSTONE_LVL_2: SUNSTONE_LEVEL_2_BUTTON,
    TowerConstants.TowerIDs.SUNSTONE_LVL_3: SUNSTONE_LEVEL_3_BUTTON,
}

# PUBLIC METHODS
func hide_all_buttons():
    for button in ALL_BUTTONS:
        button.visible = false