extends HBoxContainer
class_name AwaitingSelectionUpgradeTowersContainer

# EXPORTS
@export var BLACK_MARBLE_LEVEL_2_BUTTON: Button
@export var BLACK_MARBLE_LEVEL_3_BUTTON: Button

# CONSTANTS
@onready var ALL_BUTTONS: Array = [
    BLACK_MARBLE_LEVEL_2_BUTTON,
    BLACK_MARBLE_LEVEL_3_BUTTON,
]

# PUBLIC METHODS
func hide_all_buttons():
    for button in ALL_BUTTONS:
        button.visible = false