extends CanvasLayer
class_name RandomTowerBuildHUD

# EXPORTS
# =======
# HBox/VBox Containers
@export var GAME_STATS_CONTAINER: GameStatsContainer
@export var BUILD_RANDOM_TOWER_CONTAINER: BuildRandomTowerContainer
@export var GAME_MAP: GameMap
@export var TOWER_PROPERTIES_CONTAINER: TowerPropertiesContainer
@export var TOWER_UPGRADES_CONTAINER: TowerUpgradesContainer
@export var AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER: AwaitingSelectionUpgradeTowersContainer
@export var PATH_LINE_VISIBILITY_CONTAINER: PathLineVisibilityContainer
@export var TOWER_RANGE_VISIBILITY_CONTAINER: TowerRangeVisibilityContainer
# Standalone Buttons
@export var START_NEW_WAVE_BUTTON: Button
@export var UPGRADE_BUILD_LEVEL_BUTTON: Button

# CONSTANTS - Onready variables
@onready var TOWER_UPGRADES_CONTAINER_BUTTON_CALLBACKS: Dictionary[Button, Callable] = {
	TOWER_UPGRADES_CONTAINER.TOMBSTONE_BUTTON: _on_tombstone_button_pressed,
}

@onready var AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER_BUTTON_CALLBACKS: Dictionary[Button, Callable] = {
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.BLACK_MARBLE_LEVEL_2_BUTTON: _on_black_marble_level_2_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.BLACK_MARBLE_LEVEL_3_BUTTON: _on_black_marble_level_3_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.BLACK_MARBLE_LEVEL_4_BUTTON: _on_black_marble_level_4_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.BLACK_MARBLE_LEVEL_5_BUTTON: _on_black_marble_level_5_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.SUNSTONE_LEVEL_2_BUTTON: _on_sunstone_level_2_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.SUNSTONE_LEVEL_3_BUTTON: _on_sunstone_level_3_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.SUNSTONE_LEVEL_4_BUTTON: _on_sunstone_level_4_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.SUNSTONE_LEVEL_5_BUTTON: _on_sunstone_level_5_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.SPINEL_LEVEL_2_BUTTON: _on_spinel_level_2_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.LARIMAR_LEVEL_2_BUTTON: _on_larimar_level_2_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.KUNZITE_LEVEL_2_BUTTON: _on_kunzite_level_2_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.KUNZITE_LEVEL_3_BUTTON: _on_kunzite_level_3_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.KUNZITE_LEVEL_4_BUTTON: _on_kunzite_level_4_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.KUNZITE_LEVEL_5_BUTTON: _on_kunzite_level_5_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.BISMUTH_LEVEL_2_BUTTON: _on_bismuth_level_2_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.BISMUTH_LEVEL_3_BUTTON: _on_bismuth_level_3_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.BISMUTH_LEVEL_4_BUTTON: _on_bismuth_level_4_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.BISMUTH_LEVEL_5_BUTTON: _on_bismuth_level_5_button_pressed,
	
}

@onready var PATH_LINE_VISIBILITY_CONTAINER_BUTTON_CALLBACKS: Dictionary[Button, Callable] = {
	PATH_LINE_VISIBILITY_CONTAINER.SHOW_PATH_BUTTON: _on_show_path_button_pressed,
	PATH_LINE_VISIBILITY_CONTAINER.HIDE_PATH_BUTTON: _on_hide_path_button_pressed
}

const UPGRADE_BUILD_LEVEL_BUTTON_STRING_PREFIX: String = "Upgrade Build Level ("

# CONSTANTS - Invariable components
var TOWER_UPGRADE_MANAGER: TowerUpgradeManager


# LOCALS
var __selected_tower: Tower
## Number of towers that can be placed per turn
var __max_towers_per_turn = GameConstants.MAX_PLACEABLE_TOWERS_PER_TURN
## Number of towers that have been placed this turn
var __current_turn_tower_count = 0
## Tracks if player wants tower range to be displayed when selected
@onready var __show_selected_tower_range: bool = true

# *****************
# INHERITED METHODS
# *****************
func _ready():
	# SIGNALS
	_connect_all_component_signals()
	# TOWER UPGRADE MANAGER
	_create_tower_upgrade_manager()
	# CONTAINER VISIBILITY
	_handle_initial_container_visibility()
	# Assign starting values to game stats container
	_initialise_all_game_stats()
	
	# Assign display amount of upgrade build level container
	UPGRADE_BUILD_LEVEL_BUTTON.text = UPGRADE_BUILD_LEVEL_BUTTON_STRING_PREFIX + str(GAME_MAP.RANDOM_TOWER_GENERATOR.LEVEL_UPGRADE_PRICES[1]) + ")"


# ****************
# INTERNAL METHODS
# ****************
## Connect signals from all components to relevant handler methods on ready.
func _connect_all_component_signals():
	# Build random tower hbox
	_connect_build_random_tower_container_signals()
	# Game map
	_connect_game_map_signals()
	# Tower properties hbox
	_connect_tower_properties_hbox_signals()
	# Tower upgrades container
	_connect_tower_upgrades_signals()
	# Awaiting selection upgrade towers container
	_connect_awaiting_selection_upgrade_towers_container_signals()
	# Path visibility container
	_connect_path_visibility_container_signals()
	# Tower range visibility container
	_connnect_tower_range_visibility_container_signals()
	# Standalone Hud buttons
	_connect_standalone_buttons_signals()

## Connects signals for buttons in the BuildRandomTowerHBox
func _connect_build_random_tower_container_signals():
	# Connect the button signals to the appropriate methods
	BUILD_RANDOM_TOWER_CONTAINER.BUILD_RANDOM_TOWER_BUTTON.pressed.connect(_on_build_random_tower_button_pressed)
	BUILD_RANDOM_TOWER_CONTAINER.EXIT_BUILD_MODE_BUTTON.pressed.connect(_on_exit_build_mode_button_pressed)

func _connect_path_visibility_container_signals():
	for button in PATH_LINE_VISIBILITY_CONTAINER.ALL_BUTTONS:
		button.pressed.connect(PATH_LINE_VISIBILITY_CONTAINER_BUTTON_CALLBACKS[button])

func _connect_tower_upgrades_signals():
	# Connect the button signals to the appropriate methods
	for button in TOWER_UPGRADES_CONTAINER.ALL_TOWER_BUTTONS:
		# Retrieve the callback function from the dictionary using the button as the key.
		button.pressed.connect(TOWER_UPGRADES_CONTAINER_BUTTON_CALLBACKS[button])

func _connnect_tower_range_visibility_container_signals():
	TOWER_RANGE_VISIBILITY_CONTAINER.SHOW_TOWER_RANGE_BUTTON.pressed.connect(_on_show_tower_range_button_pressed)
	TOWER_RANGE_VISIBILITY_CONTAINER.HIDE_TOWER_RANGE_BUTTON.pressed.connect(_on_hide_tower_range_button_pressed)
	TOWER_RANGE_VISIBILITY_CONTAINER.SHOW_TOWER_RANGE_BUTTON.visible = false


## Connects signals for game map
func _connect_game_map_signals():
	# Connect the game map signals to the appropriate methods
	GAME_MAP.balance_altered.connect(_on_balance_altered)
	GAME_MAP.lost_life.connect(_on_life_lost)
	GAME_MAP.completed_wave.connect(_on_wave_completed)
	GAME_MAP.tower_selected.connect(_on_tower_selected)
	GAME_MAP.tower_placed.connect(_on_tower_placed)

func _connect_tower_properties_hbox_signals():
	TOWER_PROPERTIES_CONTAINER.KEEP_TOWER_BUTTON.pressed.connect(_on_keep_tower_button_pressed)
	TOWER_PROPERTIES_CONTAINER.REMOVE_BARRICADE_BUTTON.pressed.connect(_on_remove_barricade_button_pressed)

func _connect_awaiting_selection_upgrade_towers_container_signals():
	for button in AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.ALL_BUTTONS:
		# Retrieve the callback function from the dictionary using the button as the key.
		button.pressed.connect(AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER_BUTTON_CALLBACKS[button])

## Connects pressed signals to callables for buttons on the hud that are not part of containers.
func _connect_standalone_buttons_signals():
	# Start New Wave Button
	assert(START_NEW_WAVE_BUTTON, "No start new wave button assigned")
	START_NEW_WAVE_BUTTON.pressed.connect(_on_start_new_wave_button_pressed)
	START_NEW_WAVE_BUTTON.visible = false

	# Upgrade Build Level Button
	assert(UPGRADE_BUILD_LEVEL_BUTTON, "No upgrade build level button assigned")
	UPGRADE_BUILD_LEVEL_BUTTON.pressed.connect(_on_upgrade_build_level_button_pressed)
	UPGRADE_BUILD_LEVEL_BUTTON.visible = true

func _create_tower_upgrade_manager():
	# Create a new instance of the tower upgrade manager
	TOWER_UPGRADE_MANAGER = TowerUpgradeManager.new()
	# Add the tower upgrade manager to the scene tree
	add_child(TOWER_UPGRADE_MANAGER)
	# Set the game map for the tower upgrade manager
	TOWER_UPGRADE_MANAGER.set_game_map(GAME_MAP)

## Enable visibility of multiple tower buttons.
func _show_upgrade_tower_buttons(selectedTower: Tower, towerArray: Array[Tower]):
	# Hide all tower buttons first
	TOWER_UPGRADES_CONTAINER.hide_all_tower_buttons()
	# Capture selected tower id
	var selected_tower_id: TowerConstants.TowerIDs = selectedTower.TOWER_ID
	# Enable visibility of the towers that can be upgraded
	for upgrade_tower_id in TowerConstants.UPGRADES_INTO[selected_tower_id]:
		# Set visibility of the possible upgrade towers of the selected tower
		var can_upgrade: bool = TOWER_UPGRADE_MANAGER.can_upgrade_to_tower(upgrade_tower_id, towerArray)
		# Only enable visibility of the tower upgrade container if at least one tower can be upgraded
		if can_upgrade:
			TOWER_UPGRADES_CONTAINER.visible = true
			TOWER_UPGRADES_CONTAINER.TOWER_ID_TO_BUTTON_DICT[upgrade_tower_id].visible = true

func _handle_built_tower_upgrade(upgradeTowerID: TowerConstants.UpgradeTowerIDs):
	_hide_containers_on_tower_kept()
	# Handle towers awaiting selection
	if __selected_tower.get_state() == Tower.States.AWAITING_SELECTION:
		GAME_MAP.keep_upgrade_tower_from_towers_awaiting_selection(__selected_tower, upgradeTowerID)
		# Switch the game map state to navigation mode
		GAME_MAP.switch_states(GameMap.States.NAVIGATION_MODE)
		return
	
	# Handle towers on map
	if __selected_tower.get_state() == Tower.States.BUILT:
		GAME_MAP.upgrade_from_towers_on_map(__selected_tower, upgradeTowerID)
		# Switch the game map state to navigation mode
		GAME_MAP.switch_states(GameMap.States.NAVIGATION_MODE)
		return

func _handle_built_tower_compound_upgrade(upgradeTowerID: TowerConstants.TowerIDs):
	_hide_containers_on_tower_kept()
	# Give player option to start new wave
	START_NEW_WAVE_BUTTON.visible = true
	GAME_MAP.keep_compound_upgrade_tower_from_towers_awaiting_selection(__selected_tower, upgradeTowerID)
	# Switch the game map state to navigation mode
	GAME_MAP.switch_states(GameMap.States.NAVIGATION_MODE)

## Handles visibility of viable upgrade buttons if the selected tower is awaiting selection.
## Automatically ignores towers that are not awaiting selection.
func _handle_compound_upgrade_for_towers_awaiting_selection():
	# Ignore towers that are not awaiting selection
	if __selected_tower.get_state() != Tower.States.AWAITING_SELECTION:
		AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.visible = false
		return
	
	# Create selected tower id
	var selected_tower_id: TowerConstants.TowerIDs = __selected_tower.TOWER_ID

	# Create count dict for towers awaiting selection
	var awaiting_selection_tower_count: Dictionary[TowerConstants.TowerIDs, int] = TOWER_UPGRADE_MANAGER.tower_count_dict(GAME_MAP.get_towers_awaiting_selection())

	# Create list viable compound upgrade tower IDs
	var viable_compound_upgrade_tower_ids: Array[TowerConstants.TowerIDs] = TOWER_UPGRADE_MANAGER.viable_compound_upgrade_tower_ids(selected_tower_id, awaiting_selection_tower_count)

	# Handle situation where ther are no vaible compound upgrade towers
	if viable_compound_upgrade_tower_ids.is_empty():
		# Hide compound tower upgrade container
		AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.visible = false
		return
	
	# Ensure blank compound upgrades container is visible before its button visibility is handled
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.visible = true
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.hide_all_buttons()

	# Show tower buttons corresponding to viable compound upgrade tower IDs
	for viable_tower_id in viable_compound_upgrade_tower_ids:
		AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.TOWER_ID_TO_BUTTON_DICT[viable_tower_id].visible = true

## Controls the visibility of containers when the HUD is initiated
func _handle_initial_container_visibility():
	# Hide tower properties hbox
	TOWER_PROPERTIES_CONTAINER.visible = false
	# Hide tower upgrades container
	TOWER_UPGRADES_CONTAINER.visible = false
	# Hide awaiting selection upgrade towers container
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.visible = false
	# Enable show path button visibility
	PATH_LINE_VISIBILITY_CONTAINER.visible = true
	PATH_LINE_VISIBILITY_CONTAINER.HIDE_PATH_BUTTON.visible = false
	PATH_LINE_VISIBILITY_CONTAINER.SHOW_PATH_BUTTON.visible = true

## Ensures that all containers before a wave starts are properly hidden
func _hide_containers_on_tower_kept():
	# Hide tower properties hbox
	TOWER_PROPERTIES_CONTAINER.visible = false
	# Hide tower upgrades container
	TOWER_UPGRADES_CONTAINER.visible = false
	# Hide awaiting selection upgrade towers container
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.visible = false
	# Hide build tower properties
	BUILD_RANDOM_TOWER_CONTAINER.visible = false

## Pulls all current values from map and reassigns them in game stats container.
func _initialise_all_game_stats():
	GAME_STATS_CONTAINER.CURR_BALANCE_AMOUNT_LABEL.text = str(GameConstants.STARTING_BALANCE)
	GAME_STATS_CONTAINER.REMAINING_LIVES_AMOUNT_LABEL.text = str(GameConstants.STARTING_LIVES)
	GAME_STATS_CONTAINER.CURR_BUILD_LEVEL_AMOUNT_LABEL.text = str(1)

# ****************
# SIGNAL CALLBACKS
# ****************
#
#                                            | Standalone Buttons |
# =============================================================================================================
func _on_start_new_wave_button_pressed():
	GAME_MAP.creep_spawner.initiate_new_wave()
	# Hide exit build mode button
	BUILD_RANDOM_TOWER_CONTAINER.EXIT_BUILD_MODE_BUTTON.visible = false
	# Switch to navigation mode
	GAME_MAP.switch_states(GameMap.States.NAVIGATION_MODE)

func _on_upgrade_build_level_button_pressed():
	# Do nothing if player cannot afford level upgrade
	if GAME_MAP.get_curr_balance() < GAME_MAP.RANDOM_TOWER_GENERATOR.get_curr_upgrade_cost():
		return
	
	# Subtract upgrade cost from current balance
	GAME_MAP.subtract_funds(GAME_MAP.RANDOM_TOWER_GENERATOR.get_curr_upgrade_cost())
	
	# Update tower generator
	GAME_MAP.RANDOM_TOWER_GENERATOR.upgrade_level()

	# Update upgrade build tower button text
	UPGRADE_BUILD_LEVEL_BUTTON.text = UPGRADE_BUILD_LEVEL_BUTTON_STRING_PREFIX + str(GAME_MAP.RANDOM_TOWER_GENERATOR.get_curr_upgrade_cost()) + ")"

	# Update display of current build level
	GAME_STATS_CONTAINER.CURR_BUILD_LEVEL_AMOUNT_LABEL.text = str(GAME_MAP.RANDOM_TOWER_GENERATOR.get_curr_level())

	

#                                       | Path Line Visibility Container |
# =============================================================================================================
func _on_show_path_button_pressed():
	GAME_MAP.show_path_line()
	PATH_LINE_VISIBILITY_CONTAINER.SHOW_PATH_BUTTON.visible = false
	PATH_LINE_VISIBILITY_CONTAINER.HIDE_PATH_BUTTON.visible = true

func _on_hide_path_button_pressed():
	GAME_MAP.hide_path_line()
	PATH_LINE_VISIBILITY_CONTAINER.SHOW_PATH_BUTTON.visible = true
	PATH_LINE_VISIBILITY_CONTAINER.HIDE_PATH_BUTTON.visible = false

#                                       | Tower Range Visibility Container |
# =============================================================================================================
func _on_show_tower_range_button_pressed():
	TOWER_RANGE_VISIBILITY_CONTAINER.SHOW_TOWER_RANGE_BUTTON.visible = false
	TOWER_RANGE_VISIBILITY_CONTAINER.HIDE_TOWER_RANGE_BUTTON.visible = true
	__show_selected_tower_range = true
	# Show range display of selected tower, provided it is not a barricade
	if __selected_tower and __selected_tower.TOWER_ID != TowerConstants.TowerIDs.BARRICADE:
		__selected_tower.RANGE_DISPLAY_SHAPE.visible = true

func _on_hide_tower_range_button_pressed():
	TOWER_RANGE_VISIBILITY_CONTAINER.SHOW_TOWER_RANGE_BUTTON.visible = true
	TOWER_RANGE_VISIBILITY_CONTAINER.HIDE_TOWER_RANGE_BUTTON.visible = false
	__show_selected_tower_range = false
	# Hide range display of selected tower, provided it is not a barricade
	if __selected_tower and __selected_tower.TOWER_ID != TowerConstants.TowerIDs.BARRICADE:
		__selected_tower.RANGE_DISPLAY_SHAPE.visible = false

#                                       | Build Random Tower Container |
# =============================================================================================================
## Handle build random tower button pressed signal
func _on_build_random_tower_button_pressed():
	# Hide tower properties hbox
	TOWER_PROPERTIES_CONTAINER.visible = false
	# Hide build tower button
	BUILD_RANDOM_TOWER_CONTAINER.BUILD_RANDOM_TOWER_BUTTON.visible = false
	# Show exit build mode button
	BUILD_RANDOM_TOWER_CONTAINER.EXIT_BUILD_MODE_BUTTON.visible = true
	# Switch to build mode
	GAME_MAP.set_state(GAME_MAP.States.BUILD_MODE)
	# Assign random towrer preload to the game map
	GAME_MAP.set_build_tower_preload(GAME_MAP.RANDOM_TOWER_GENERATOR.generate_random_tower_preload())

## Handle the exit build mode button pressed signal
func _on_exit_build_mode_button_pressed():
	# Show build tower button
	BUILD_RANDOM_TOWER_CONTAINER.BUILD_RANDOM_TOWER_BUTTON.visible = true
	# Hide exit build mode button
	BUILD_RANDOM_TOWER_CONTAINER.EXIT_BUILD_MODE_BUTTON.visible = false
	# Switch to navigation mode
	GAME_MAP.switch_states(GameMap.States.NAVIGATION_MODE)

## Handle remove barricade button pressed
func _on_remove_barricade_button_pressed():
	assert(__selected_tower, "No tower/barricade is currently selected")
	assert(__selected_tower.TOWER_ID == TowerConstants.TowerIDs.BARRICADE, "Selected tower is not a barricade")
	# Remove barricade from map
	GAME_MAP.remove_barricade(__selected_tower)
	# Deselect tower
	__selected_tower = null
	# Hide remove barricade button
	TOWER_PROPERTIES_CONTAINER.REMOVE_BARRICADE_BUTTON.visible = false


#                                              | Game Map |
# =============================================================================================================
func _on_balance_altered(curr_balance: int):
	GAME_STATS_CONTAINER.CURR_BALANCE_AMOUNT_LABEL.text = str(curr_balance)

func _on_credits_lost(remaining_balance: int):
	pass

func _on_life_gained(remaining_lives: int):
	pass

func _on_life_lost(remaining_lives: int):
	GAME_STATS_CONTAINER.REMAINING_LIVES_AMOUNT_LABEL.text = str(remaining_lives)

func _on_wave_completed(total_waves_completed: int):
	# Update tower count
	__current_turn_tower_count = 0
	# Hide tower properties hbox
	TOWER_PROPERTIES_CONTAINER.visible = false
	# Hide tower upgrades container
	TOWER_UPGRADES_CONTAINER.visible = false
	# Show build tower container
	BUILD_RANDOM_TOWER_CONTAINER.visible = true
	# Show build random tower button
	BUILD_RANDOM_TOWER_CONTAINER.BUILD_RANDOM_TOWER_BUTTON.visible = true
	# Hide exit build mode button
	BUILD_RANDOM_TOWER_CONTAINER.EXIT_BUILD_MODE_BUTTON.visible = false
	# Hide start new wave button
	START_NEW_WAVE_BUTTON.visible = false
	# Update game stats display
	GAME_STATS_CONTAINER.WAVES_COMPLETED_AMOUNT_LABEL.text = str(GAME_MAP.get_total_waves_completed())

func _on_tower_selected(tower: Tower):
	# Reset transparency of previously selected tower sprite and awaiting selection animation
	if __selected_tower and __selected_tower.get_state() == Tower.States.AWAITING_SELECTION:
		# Decrease transparency of tower sprite and awaiting selection animation
		__selected_tower.AWAITING_SELECTION_ANIMATION.modulate.a = 0.5
		__selected_tower.TOWER_SPRITE.modulate.a = 0.5
	
	# Hide range display shape for previously selected tower,
	# provided it is not a barricade
	if __selected_tower and __selected_tower.TOWER_ID != TowerConstants.TowerIDs.BARRICADE:
		__selected_tower.RANGE_DISPLAY_SHAPE.visible = false

	# Set newly selected tower
	__selected_tower = tower

	# Handle range display of newly selected tower
	if __selected_tower.TOWER_ID != TowerConstants.TowerIDs.BARRICADE and __show_selected_tower_range:
		__selected_tower.RANGE_DISPLAY_SHAPE.visible = true
	
	# Allow ability for player to remove barricade once wave has been completed
	TOWER_PROPERTIES_CONTAINER.REMOVE_BARRICADE_BUTTON.visible = false
	if __selected_tower.TOWER_ID == TowerConstants.TowerIDs.BARRICADE and !GAME_MAP.creep_spawner.wave_initiation_in_progress():
		TOWER_PROPERTIES_CONTAINER.REMOVE_BARRICADE_BUTTON.visible = true

	# Ensure properties container is visible 
	TOWER_PROPERTIES_CONTAINER.visible = true
	
	# Handle towers awaiting selection
	if __selected_tower.get_state() == Tower.States.AWAITING_SELECTION:
		# Show keep tower button
		TOWER_PROPERTIES_CONTAINER.KEEP_TOWER_BUTTON.visible = true
		# Increase transparency of tower sprite and awaiting selection animation
		tower.AWAITING_SELECTION_ANIMATION.modulate.a = 1.0
		tower.TOWER_SPRITE.modulate.a = 1.0
		# Show upgrade tower buttons based on towers awaiting selection
		_show_upgrade_tower_buttons(__selected_tower, GAME_MAP.get_towers_awaiting_selection())
		# Handle compound tower upgrades.
		_handle_compound_upgrade_for_towers_awaiting_selection()
		return
	
	# Handle built tower selection
	if __selected_tower.get_state() == Tower.States.BUILT:
		# Hide keep tower button
		TOWER_PROPERTIES_CONTAINER.KEEP_TOWER_BUTTON.visible = false
		# Handle tower upgrade container visibility
		_show_upgrade_tower_buttons(__selected_tower, GAME_MAP.get_towers_on_map())
	
	# Handle compound tower upgrades.
	_handle_compound_upgrade_for_towers_awaiting_selection()


func _on_tower_placed(_tower: Tower):
	__current_turn_tower_count += 1
	# If the max number of towers has been placed, exit build mode.
	if __current_turn_tower_count == __max_towers_per_turn:
		BUILD_RANDOM_TOWER_CONTAINER.visible = false
		GAME_MAP.clear_build_tower_values()
		GAME_MAP.switch_states(GameMap.States.NAVIGATION_MODE)
	
	# Avoid tower preload staying the same when a tower is placed, the max nummber of turn towers has
	# not been reached and the game map is still in build mode.
	GAME_MAP.set_build_tower_preload(GAME_MAP.RANDOM_TOWER_GENERATOR.generate_random_tower_preload())


#                                      | Tower Properties Container |
# =============================================================================================================

func _on_keep_tower_button_pressed():

	_hide_containers_on_tower_kept()

	# Move the selected tower to the towers on map list
	# and convert the rest of the towers to barricades.
	GAME_MAP.keep_built_tower_awaiting_selection(__selected_tower)
	
	# Switch the game map state to navigation mode
	GAME_MAP.switch_states(GameMap.States.NAVIGATION_MODE)

	# Allow player to start new wave
	START_NEW_WAVE_BUTTON.visible = true

	__current_turn_tower_count = 0


#                                        | Upgrade Tower Container |
# =============================================================================================================

func _on_tombstone_button_pressed():
	_handle_built_tower_upgrade(TowerConstants.UpgradeTowerIDs.TOMBSTONE_LVL_1)


#                                 | Awaiting Selection Upgrade Tower Container |
# =============================================================================================================
# BLACK MARBLE
# ------------
func _on_black_marble_level_2_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2)

func _on_black_marble_level_3_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.BLACK_MARBLE_LVL_3)

func _on_black_marble_level_4_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.BLACK_MARBLE_LVL_4)

func _on_black_marble_level_5_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.BLACK_MARBLE_LVL_5)

# SUNSTONE
# --------
func _on_sunstone_level_2_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.SUNSTONE_LVL_2)

func _on_sunstone_level_3_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.SUNSTONE_LVL_3)

func _on_sunstone_level_4_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.SUNSTONE_LVL_4)

func _on_sunstone_level_5_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.SUNSTONE_LVL_5)

# SPINEL
# ------
func _on_spinel_level_2_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.SPINEL_LVL_2)

# LARIMAR
# ------
func _on_larimar_level_2_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.LARIMAR_LVL_2)

# KUNZITE
# ------
func _on_kunzite_level_2_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.KUNZITE_LVL_2)

func _on_kunzite_level_3_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.KUNZITE_LVL_3)

func _on_kunzite_level_4_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.KUNZITE_LVL_4)

func _on_kunzite_level_5_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.KUNZITE_LVL_5)


# BISMUTH
# -------
func _on_bismuth_level_2_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.BISMUTH_LVL_2)

func _on_bismuth_level_3_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.BISMUTH_LVL_3)

func _on_bismuth_level_4_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.BISMUTH_LVL_4)

func _on_bismuth_level_5_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.BISMUTH_LVL_5)
