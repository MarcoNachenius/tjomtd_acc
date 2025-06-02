extends CanvasLayer

@export var BACK_TO_MAIN_MENU_BUTTON: Button
@export var EXIT_GAME_BUTTON: Button

func _ready() -> void:
    BACK_TO_MAIN_MENU_BUTTON.pressed.connect(_on_back_to_main_menu_button_pressed)
    EXIT_GAME_BUTTON.pressed.connect(_on_exit_game_button_pressed)

func _on_exit_game_button_pressed():
    get_tree().quit()

func _on_back_to_main_menu_button_pressed():
    get_tree().change_scene_to_packed(UIConstants.START_GAME_MENU_LOAD)