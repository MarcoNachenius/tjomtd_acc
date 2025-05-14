extends CanvasLayer
class_name RandomTowerBuildHUD

# EXPORTS
@export var BUILD_RANDOM_TOWER_CONTAINER: BuildRandomTowerContainer
@export var GAME_MAP: GameMap
@export var TOWER_PROPERTIES_CONTAINER: TowerPropertiesContainer
@export var TOWER_UPGRADES_CONTAINER: TowerUpgradesContainer
@export var AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER: AwaitingSelectionUpgradeTowersContainer
@export var PATH_LINE_VISIBILITY_CONTAINER: PathLineVisibilityContainer

# CONSTANTS - Onready variables
@onready var TOWER_UPGRADES_CONTAINER_BUTTON_CALLBACKS: Dictionary[Button, Callable] = {
	TOWER_UPGRADES_CONTAINER.TOMBSTONE_BUTTON: _on_tombstone_button_pressed,
}

@onready var AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER_BUTTON_CALLBACKS: Dictionary[Button, Callable] = {
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.BLACK_MARBLE_LEVEL_2_BUTTON: _on_black_marble_level_2_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.BLACK_MARBLE_LEVEL_3_BUTTON: _on_black_marble_level_3_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.SUNSTONE_LEVEL_2_BUTTON: _on_sunstone_level_2_button_pressed,
	AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.SUNSTONE_LEVEL_3_BUTTON: _on_sunstone_level_3_button_pressed,
	
}

@onready var PATH_LINE_VISIBILITY_CONTAINER_BUTTON_CALLBACKS: Dictionary[Button, Callable] = {
	PATH_LINE_VISIBILITY_CONTAINER.SHOW_PATH_BUTTON: _on_show_path_button_pressed,
	PATH_LINE_VISIBILITY_CONTAINER.HIDE_PATH_BUTTON: _on_hide_path_button_pressed
}

# CONSTANTS - Invariable components
var TOWER_UPGRADE_MANAGER: TowerUpgradeManager

# LOCALS
var __selected_tower: Tower
## Number of towers that can be placed per turn
var __max_towers_per_turn = GameConstants.MAX_PLACEABLE_TOWERS_PER_TURN
## Number of towers that have been placed this turn
var __current_turn_tower_count = 0

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

## Connects signals for game map
func _connect_game_map_signals():
	# Connect the game map signals to the appropriate methods
	GAME_MAP.gained_credits.connect(_on_credits_gained)
	GAME_MAP.lost_credits.connect(_on_credits_lost)
	GAME_MAP.gained_life.connect(_on_life_gained)
	GAME_MAP.lost_life.connect(_on_life_lost)
	GAME_MAP.completed_wave.connect(_on_wave_completed)
	GAME_MAP.tower_selected.connect(_on_tower_selected)
	GAME_MAP.tower_placed.connect(_on_tower_placed)

func _connect_tower_properties_hbox_signals():
	TOWER_PROPERTIES_CONTAINER.KEEP_TOWER_BUTTON.pressed.connect(_on_keep_tower_button_pressed)

func _connect_awaiting_selection_upgrade_towers_container_signals():
	for button in AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER.ALL_BUTTONS:
		# Retrieve the callback function from the dictionary using the button as the key.
		button.pressed.connect(AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER_BUTTON_CALLBACKS[button])

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

# ****************
# SIGNAL CALLBACKS
# ****************
#
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

#                                              | Game Map |
# =============================================================================================================
func _on_credits_gained(remaining_balance: int):
	pass

func _on_credits_lost(remaining_balance: int):
	pass

func _on_life_gained(remaining_lives: int):
	pass

func _on_life_lost(remaining_lives: int):
	pass

func _on_wave_completed(total_waves_completed: int):
	# Enable build mode for map
	GAME_MAP.set_state(GAME_MAP.States.BUILD_MODE)
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

func _on_tower_selected(tower: Tower):
	# Reset transparency of previously selected tower sprite and awaiting selection animation
	if __selected_tower and __selected_tower.get_state() == Tower.States.AWAITING_SELECTION:
		# Decrease transparency of tower sprite and awaiting selection animation
		__selected_tower.AWAITING_SELECTION_ANIMATION.modulate.a = 0.5
		__selected_tower.TOWER_SPRITE.modulate.a = 0.5
	
	# Hide range display shape for previously selected tower,
	# provided it is not a barricade
	if __selected_tower and __selected_tower.TOWER_ID != TowerConstants.TowerIDs.BARRICADE:
		__selected_tower.RANGE_DISPLAY_SHAPE. visible = false

	# Set new selected tower
	__selected_tower = tower

	# Show range display shape of newly selected tower if it is not a barricade
	if __selected_tower.TOWER_ID != TowerConstants.TowerIDs.BARRICADE:
		__selected_tower.RANGE_DISPLAY_SHAPE.visible = true

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

# SUNSTONE
# --------
func _on_sunstone_level_2_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.SUNSTONE_LVL_2)

func _on_sunstone_level_3_button_pressed():
	_handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.SUNSTONE_LVL_3)
