extends CanvasLayer


@export var BUILD_RANDOM_TOWER_HBOX: BuildRandomTowerHBox
@export var GAME_MAP: GameMap
@export var TOWER_PROPERTIES_HBOX: TowerPropertiesHBox

var __selected_tower: Tower
## Number of towers that can be placed per turn
var __max_towers_per_turn = 5
## Number of towers that have been placed this turn
var __current_turn_tower_count = 0
## Coordinates of the towers that have been placed this turn
var __turn_towers: Array[Tower] = []

# *****************
# INHERITED METHODS
# *****************
func _ready():
	_connect_all_component_signals()
	# Hide tower properties hbox
	TOWER_PROPERTIES_HBOX.visible = false


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
	BUILD_RANDOM_TOWER_HBOX.BUILD_RANDOM_TOWER_BUTTON.pressed.connect(_on_build_random_tower_button_pressed)
	BUILD_RANDOM_TOWER_HBOX.EXIT_BUILD_MODE_BUTTON.pressed.connect(_on_exit_build_mode_button_pressed)

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
	TOWER_PROPERTIES_HBOX.KEEP_TOWER_BUTTON.pressed.connect(_on_keep_tower_button_pressed)


# ***************
# SIGNAL HANDLERS
# ***************
#
#                                        | Build Random Tower HBox |
# =============================================================================================================
## Handle build random tower button pressed signal
func _on_build_random_tower_button_pressed():
	# Hide build tower button
	BUILD_RANDOM_TOWER_HBOX.BUILD_RANDOM_TOWER_BUTTON.visible = false
	# Show exit build mode button
	BUILD_RANDOM_TOWER_HBOX.EXIT_BUILD_MODE_BUTTON.visible = true
	# Switch to build mode
	GAME_MAP.set_state(GAME_MAP.States.BUILD_MODE)
	# Assign random towrer preload to the game map
	GAME_MAP.set_build_tower_preload(GAME_MAP.RANDOM_TOWER_GENERATOR.generate_random_tower_preload())

## Handle the exit build mode button pressed signal
func _on_exit_build_mode_button_pressed():
	# Show build tower button
	BUILD_RANDOM_TOWER_HBOX.BUILD_RANDOM_TOWER_BUTTON.visible = true
	# Hide exit build mode button
	BUILD_RANDOM_TOWER_HBOX.EXIT_BUILD_MODE_BUTTON.visible = false
	# Switch to navigation mode
	GAME_MAP.set_state(GAME_MAP.States.NAVIGATION_MODE)

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
	#WAVES_COMPLETED_TEXT_LABEL.text = WAVES_COMPLETED_STR_PREFIX + str(total_waves_completed)
	## Show start new wave button
	#BUILD_TOWERS_HBOX_CONTAINER.visible = true
	#START_NEW_WAVE_BUTTON.visible = true

func _on_tower_selected(tower: Tower):
	__selected_tower = tower
	TOWER_PROPERTIES_HBOX.visible = true
	# Handle towers awaiting selection
	if __selected_tower.get_state() == Tower.States.AWAITING_SELECTION:
		TOWER_PROPERTIES_HBOX.KEEP_TOWER_BUTTON.visible = true
		return


func _on_tower_placed(tower: Tower):
	__current_turn_tower_count += 1
	__turn_towers.append(tower)
	# If the max number of towers has been placed, disable the build random tower button
	if __current_turn_tower_count == __max_towers_per_turn:
		BUILD_RANDOM_TOWER_HBOX.visible = false
		

#                                        | Tower Properties HBox |
# =============================================================================================================

func _on_keep_tower_button_pressed():
	pass
