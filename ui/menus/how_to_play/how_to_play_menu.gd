extends Control
class_name HowToPlayMenu

# MENU CHANGE BUTTONS
@export var RETURN_TO_MAIN_MENU_BUTTON: Button
@export var TOWER_AND_SLATE_INFO_BUTTON: Button


func _ready() -> void:
	assert(RETURN_TO_MAIN_MENU_BUTTON, "Main menu button not assigned")
	assert(TOWER_AND_SLATE_INFO_BUTTON, "Tower and Slate Info button not assigned")
	_connect_all_button_signals()


#####################
# SIGNAL CONNECTORS #
#####################
func _connect_all_button_signals() -> void:
	_connect_menu_change_buttons_signals()


# Menu Change Buttons
# -------------------
func _connect_menu_change_buttons_signals() -> void:
	RETURN_TO_MAIN_MENU_BUTTON.pressed.connect(_on_main_menu_button_pressed)
	TOWER_AND_SLATE_INFO_BUTTON.pressed.connect(_on_tower_slate_stats_button_pressed)

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_packed(UIConstants.START_GAME_MENU_LOAD)

func _on_tower_slate_stats_button_pressed() -> void:
	get_tree().change_scene_to_packed(UIConstants.RECIPE_MENU_LOAD)
