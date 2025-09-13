extends CanvasLayer

@export var STARTING_MENU_CONTAINER: StartingMenuContainer
@export var RECIPE_MENU: RecipeMenu
@export var SELECT_MAP_CONTAINER: SelectMapContainer
@export var BACKGROUND_MUSIC_TRACK: AudioStreamPlayer

func _ready() -> void:
	_connect_all_button_container_signals()
	BACKGROUND_MUSIC_TRACK.play()
	# Hide load game button if no save file exists
	if GameDataStorage.save_file_exists():
		STARTING_MENU_CONTAINER.LOAD_GAME_BUTTON.visible = true
	else:
		STARTING_MENU_CONTAINER.LOAD_GAME_BUTTON.visible = false

func _connect_all_button_container_signals():
	_connect_starting_menu_container_button_signals()
	_connect_select_map_container_button_signals()
	_connect_recipe_menu_buttons()

func _connect_starting_menu_container_button_signals():
	STARTING_MENU_CONTAINER.NEW_GAME_BUTTON.pressed.connect(_on_new_game_button_pressed)
	STARTING_MENU_CONTAINER.LOAD_GAME_BUTTON.pressed.connect(_on_load_game_button_pressed)
	STARTING_MENU_CONTAINER.TOWER_AND_SLATE_INFO_BUTTON.pressed.connect(_on_tower_and_slate_info_button_pressed)
	STARTING_MENU_CONTAINER.EXIT_GAME_BUTTON.pressed.connect(_on_exit_game_button_pressed)

func _connect_select_map_container_button_signals():
	SELECT_MAP_CONTAINER.GEM_TD_BUTTON.pressed.connect(_on_gem_td_button_pressed)
	SELECT_MAP_CONTAINER.LINE_TD_BUTTON.pressed.connect(_on_line_td_button_pressed)
	SELECT_MAP_CONTAINER.BACK_TO_MAIN_MENU_BUTTON.pressed.connect(_on_return_to_main_menu_button_pressed)

func _connect_recipe_menu_buttons():
	RECIPE_MENU.RETURN_TO_MENU_BUTTON.pressed.connect(_display_starting_menu)

#									STARTING MENU CONTAINER
# ==============================================================================================
func _on_new_game_button_pressed():
	_display_select_map_container()

func _on_load_game_button_pressed():

	# Load game data from disk
	GameDataStorage.load_game_data()

	if !GameDataStorage.ACTIVE_GAME_DATA:
		push_error("Step 3: No active game data found after loading. Please check your save file.")
		return
	
	var map_id = GameDataStorage.ACTIVE_GAME_DATA.get_map_id()

	# Ensure map ID is valid
	if !GameConstants.MAP_ID_TO_COMPLETE_BUILD.has(map_id):
		push_error("Step 5: No complete build found for map ID: %d" % map_id)
		return
	
	var new_scene_root = GameConstants.MAP_ID_TO_COMPLETE_BUILD[map_id].instantiate()

	# Replace current scene
	var tree := get_tree()
	var old_scene := tree.current_scene
	old_scene.queue_free()
	tree.root.add_child(new_scene_root)
	tree.current_scene = new_scene_root

	# Find the GameMap node in the new scene
	var game_map: GameMap = null
	for child in new_scene_root.get_children():
		if child is GameMap:
			game_map = child
			break
	assert(game_map, "Game Map not found in loaded scene.")

	# Load the game map with the active game data
	game_map.load_game()

	# Find the RandomTowerBuildHUD node in the new scene
	var hud: RandomTowerBuildHUD = null
	for child in new_scene_root.get_children():
		if child is RandomTowerBuildHUD:
			hud = child
			break
	assert(hud, "HUD not found in loaded scene.")

	# Assign display values from load file
	# Balance
	hud.GAME_STATS_CONTAINER.CURR_BALANCE_AMOUNT_LABEL.text = str(GameDataStorage.ACTIVE_GAME_DATA.get_remaining_balance())
	# Remaining lives
	hud.GAME_STATS_CONTAINER.REMAINING_LIVES_AMOUNT_LABEL.text = str(GameDataStorage.ACTIVE_GAME_DATA.get_remaining_lives())
	# Waves completed
	hud.GAME_STATS_CONTAINER.WAVES_COMPLETED_AMOUNT_LABEL.text = str(GameDataStorage.ACTIVE_GAME_DATA.wave_number)
	# Build level
	hud.GAME_STATS_CONTAINER.CURR_BUILD_LEVEL_AMOUNT_LABEL.text = str(GameDataStorage.ACTIVE_GAME_DATA.build_level)
	# Update upgrade build tower button text
	hud.UPGRADE_BUILD_LEVEL_BUTTON.text = hud.UPGRADE_BUILD_LEVEL_BUTTON_STRING_PREFIX + str(game_map.RANDOM_TOWER_GENERATOR.get_curr_upgrade_cost()) + ")"
	
func _on_tower_and_slate_info_button_pressed() -> void:
	# Hide unwanted components
	STARTING_MENU_CONTAINER.visible = false
	SELECT_MAP_CONTAINER.visible = false
	# Show recipe menu
	RECIPE_MENU.visible = true

func _on_exit_game_button_pressed():
	get_tree().quit()

## Shows and hides components that are required for displaying the main menu
func _display_starting_menu():
	# Show starting menu container
	STARTING_MENU_CONTAINER.visible = true
	# Hide select map container
	SELECT_MAP_CONTAINER.visible = false
	# Hide recipe menu
	RECIPE_MENU.visible = false


#									 SELECT MAP CONTAINER
# ==============================================================================================
func _on_gem_td_button_pressed():
	# Create new game data
	GameDataStorage.create_new_game_data(MapConstants.MapID.GEM_TD)
	# Change scene to the Gem TD complete build
	get_tree().change_scene_to_packed(GameConstants.GEM_TD_COMPLETE_BUILD)

func _on_line_td_button_pressed():
	# Create new game data
	GameDataStorage.create_new_game_data(MapConstants.MapID.LINE_TD)
	# Change scene to the Line TD complete build
	get_tree().change_scene_to_packed(GameConstants.LINE_TD_COMPLETE_BUILD)

func _display_select_map_container():
	# Hide starting menu container
	STARTING_MENU_CONTAINER.visible = false
	# Show select map container
	SELECT_MAP_CONTAINER.visible = true

#									 SHARED BUTTON SIGNALS
# ===============================================================================================

func _on_return_to_main_menu_button_pressed():
	_display_starting_menu()
