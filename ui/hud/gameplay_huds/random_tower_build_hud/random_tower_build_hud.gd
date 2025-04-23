extends CanvasLayer


@export var BUILD_RANDOM_TOWER_HBOX: BuildRandomTowerHBox
@export var GAME_MAP: GameMap

var __selected_tower: Tower

# *****************
# INHERITED METHODS
# *****************
func _ready():
	_connect_all_component_signals()


# ****************
# INTERNAL METHODS
# ****************
## Connect signals from all components to relevant handler methods on ready.
func _connect_all_component_signals():
	# Build random tower hbox
	_connect_build_random_tower_hbox()
	# Game map
	_connect_game_map_signals()

## Connects signals for buttons in the BuildRandomTowerHBox
func _connect_build_random_tower_hbox():
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

## Handle the exit build mode button pressed signal
func _on_exit_build_mode_button_pressed():
	# Show build tower button
	BUILD_RANDOM_TOWER_HBOX.BUILD_RANDOM_TOWER_BUTTON.visible = true
	# Hide exit build mode button
	BUILD_RANDOM_TOWER_HBOX.EXIT_BUILD_MODE_BUTTON.visible = false

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
	#BUILD_TOWERS_HBOX_CONTAINER.visible = false
	#TOWER_PROPERTIES_HBOX_CONTAINER.visible = true
	#if __selected_tower.TOWER_ID == TowerConstants.TowerIDs.BARRICADE:
	#    REMOVE_BARRICADE_BUTTON.visible = true
	#    return
	#REMOVE_BARRICADE_BUTTON.visible = false
