extends CanvasLayer
class_name RandomTowerBuildHUD

@export var BUILD_RANDOM_TOWER_CONTAINER: BuildRandomTowerContainer
@export var GAME_MAP: GameMap
@export var TOWER_PROPERTIES_CONTAINER: TowerPropertiesContainer
@export var TOWER_UPGRADES_CONTAINER: TowerUpgradesContainer

var __selected_tower: Tower
## Number of towers that can be placed per turn
var __max_towers_per_turn = 5
## Number of towers that have been placed this turn
var __current_turn_tower_count = 0

var TOWER_UPGRADE_MANAGER: TowerUpgradeManager

# *****************
# INHERITED METHODS
# *****************
func _ready():
	_connect_all_component_signals()
	_create_tower_upgrade_manager()
	# Hide tower properties hbox
	TOWER_PROPERTIES_CONTAINER.visible = false
	# Hide tower upgrades container
	TOWER_UPGRADES_CONTAINER.visible = false


# ****************
# INTERNAL METHODS
# ****************
## Connect signals from all components to relevant handler methods on ready.
func _connect_all_component_signals():
	# Build random tower hbox
	_connect_build_random_tower_hbox_signals()
	# Game map
	_connect_game_map_signals()
	# Tower properties hbox
	_connect_tower_properties_hbox_signals()

## Connects signals for buttons in the BuildRandomTowerHBox
func _connect_build_random_tower_hbox_signals():
	# Connect the button signals to the appropriate methods
	BUILD_RANDOM_TOWER_CONTAINER.BUILD_RANDOM_TOWER_BUTTON.pressed.connect(_on_build_random_tower_button_pressed)
	BUILD_RANDOM_TOWER_CONTAINER.EXIT_BUILD_MODE_BUTTON.pressed.connect(_on_exit_build_mode_button_pressed)

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



# ***************
# SIGNAL HANDLERS
# ***************
#
#                                        | Build Random Tower HBox |
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
	GAME_MAP.switch_states(GAME_MAP.States.NAVIGATION_MODE)

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
	pass

func _on_tower_selected(tower: Tower):
	# Reset transparency of previously selected tower sprite and awaiting selection animation
	if __selected_tower and __selected_tower.get_state() == Tower.States.AWAITING_SELECTION:
		# Decrease transparency of tower sprite and awaiting selection animation
		__selected_tower.AWAITING_SELECTION_ANIMATION.modulate.a = 0.5
		__selected_tower.TOWER_SPRITE.modulate.a = 0.5
	
	# Set new selected tower
	__selected_tower = tower
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
		return
	
	# Handle built tower selection
	if __selected_tower.get_state() == Tower.States.BUILT:
		# Handle tower upgrade container visibility
		_show_upgrade_tower_buttons(__selected_tower, GAME_MAP.get_towers_on_map())


func _on_tower_placed(tower: Tower):
	__current_turn_tower_count += 1
	# If the max number of towers has been placed, exit build mode.
	if __current_turn_tower_count == __max_towers_per_turn:
		BUILD_RANDOM_TOWER_CONTAINER.visible = false
		GAME_MAP.clear_build_tower_values()
		GAME_MAP.switch_states(GAME_MAP.States.NAVIGATION_MODE)
	
	# Avoid tower preload staying the same when a tower is placed, the max nummber of turn towers has
	# not been reached and the game map is still in build mode.
	GAME_MAP.set_build_tower_preload(GAME_MAP.RANDOM_TOWER_GENERATOR.generate_random_tower_preload())


#                                        | Tower Properties HBox |
# =============================================================================================================

func _on_keep_tower_button_pressed():

	# Hide keep tower button
	TOWER_PROPERTIES_CONTAINER.KEEP_TOWER_BUTTON.visible = false

	# Hide build random tower hbox
	BUILD_RANDOM_TOWER_CONTAINER.visible = false

	# Move the selected tower to the towers on map list
	# and convert the rest of the towers to barricades.
	GAME_MAP.keep_built_tower_awaiting_selection(__selected_tower)
	
	# Switch the game map state to navigation mode
	GAME_MAP.switch_states(GAME_MAP.States.NAVIGATION_MODE)

	__current_turn_tower_count = 0
