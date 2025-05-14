extends HBoxContainer
class_name PathLineVisibilityContainer

@export var SHOW_PATH_BUTTON: Button
@export var HIDE_PATH_BUTTON: Button

@onready var ALL_BUTTONS: Array[Button] = [SHOW_PATH_BUTTON, HIDE_PATH_BUTTON]


# PUBLIC METHODS
func hide_all_buttons():
    for button in ALL_BUTTONS:
        button.visible = false