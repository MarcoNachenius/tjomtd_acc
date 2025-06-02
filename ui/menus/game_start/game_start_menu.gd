extends CanvasLayer

@export var STARTING_MENU_CONTAINER: StartingMenuContainer
@export var SELECT_MAP_CONTAINER: SelectMapContainer

func _ready() -> void:
	_connect_all_button_container_signals()

func _connect_all_button_container_signals():
	_connect_starting_menu_container_button_signals()
	_connect_select_map_container_button_signals()

func _connect_starting_menu_container_button_signals():
	STARTING_MENU_CONTAINER.NEW_GAME_BUTTON.pressed.connect(_on_new_game_button_pressed)
	STARTING_MENU_CONTAINER.EXIT_GAME_BUTTON.pressed.connect(_on_exit_game_button_pressed)

func _connect_select_map_container_button_signals():
	SELECT_MAP_CONTAINER.GEM_TD_BUTTON.pressed.connect(_on_gem_td_button_pressed)
	SELECT_MAP_CONTAINER.LINE_TD_BUTTON.pressed.connect(_on_line_td_button_pressed)
	SELECT_MAP_CONTAINER.BACK_TO_MAIN_MENU_BUTTON.pressed.connect(_on_return_to_main_menu_button_pressed)

#                                    STARTING MENU CONTAINER
# ==============================================================================================
func _on_new_game_button_pressed():
	_display_select_map_container()

func _on_exit_game_button_pressed():
	get_tree().quit()

## Shows and hides components that are required for displaying the main menu
func _display_starting_menu():
	# Show starting menu container
	STARTING_MENU_CONTAINER.visible = true
	# Hide select map container
	SELECT_MAP_CONTAINER.visible = false


#                                     SELECT MAP CONTAINER
# ==============================================================================================
func _on_gem_td_button_pressed():
	get_tree().change_scene_to_packed(GameConstants.GEM_TD_COMPLETE_BUILD)

func _on_line_td_button_pressed():
	get_tree().change_scene_to_packed(GameConstants.LINE_TD_COMPLETE_BUILD)

func _display_select_map_container():
	# Hide starting menu container
	STARTING_MENU_CONTAINER.visible = false
	# Show select map container
	SELECT_MAP_CONTAINER.visible = true

#                                     SHARED BUTTON SIGNALS
# ==============================================================================================

func _on_return_to_main_menu_button_pressed():
	_display_starting_menu()
