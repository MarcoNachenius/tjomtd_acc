extends CanvasLayer
class_name GameHud

@export var BALANCE_TEXT_LABEL: RichTextLabel
@export var BUILD_TOWERS_HBOX_CONTAINER: HBoxContainer
@export var TOWER_PROPERTIES_HBOX_CONTAINER: HBoxContainer
@export var REMAINING_LIVES_TEXT_LABEL: RichTextLabel
@export var START_NEW_WAVE_BUTTON: Button
@export var WAVES_COMPLETED_TEXT_LABEL: RichTextLabel
@export var EXIT_BUILD_MODE_BUTTON: Button
@export var REMOVE_BARRICADE_BUTTON: Button

@export var __game_map: GameMap

const REMAINING_LIVES_STR_PREFIX: String = "Remaining Lives: "
const BALANCE_STR_PREFIX: String = "Balance: "
const WAVES_COMPLETED_STR_PREFIX: String = "Waves Completed: "

var __selected_tower: Tower

# ===============
# BUILTIN METHODS
# ===============

func _ready():
	# Set initial score values
	BALANCE_TEXT_LABEL.text = BALANCE_STR_PREFIX + str(__game_map.__curr_balance)
	REMAINING_LIVES_TEXT_LABEL.text = REMAINING_LIVES_STR_PREFIX + str(__game_map.__remaining_lives)
	WAVES_COMPLETED_TEXT_LABEL.text = WAVES_COMPLETED_STR_PREFIX + str(__game_map.__total_waves_completed)
	# Connect signals
	__game_map.gained_credits.connect(_on_credits_gained)
	__game_map.lost_credits.connect(_on_credits_lost)
	__game_map.gained_life.connect(_on_life_gained)
	__game_map.lost_life.connect(_on_life_lost)
	__game_map.completed_wave.connect(_on_wave_completed)
	__game_map.tower_selected.connect(_on_tower_selected)

# ==============
# CUSTOM METHODS
# ==============

# SETTERS
func set_game_map(game_map: GameMap) -> void:
	__game_map = game_map


# ===========
# MAP SIGNALS
# ===========

func _on_credits_gained(remaining_balance: int):
	BALANCE_TEXT_LABEL.text = BALANCE_STR_PREFIX + str(remaining_balance)

func _on_credits_lost(remaining_balance: int):
	BALANCE_TEXT_LABEL.text = BALANCE_STR_PREFIX + str(remaining_balance)

func _on_life_gained(remaining_lives: int):
	REMAINING_LIVES_TEXT_LABEL.text = REMAINING_LIVES_STR_PREFIX + str(remaining_lives)

func _on_life_lost(remaining_lives: int):
	REMAINING_LIVES_TEXT_LABEL.text = REMAINING_LIVES_STR_PREFIX + str(remaining_lives)

func _on_wave_completed(total_waves_completed: int):
	WAVES_COMPLETED_TEXT_LABEL.text = WAVES_COMPLETED_STR_PREFIX + str(total_waves_completed)
	# Show start new wave button
	BUILD_TOWERS_HBOX_CONTAINER.visible = true
	START_NEW_WAVE_BUTTON.visible = true

func _on_tower_selected(tower: Tower):
	__selected_tower = tower
	BUILD_TOWERS_HBOX_CONTAINER.visible = false
	TOWER_PROPERTIES_HBOX_CONTAINER.visible = true
	if __selected_tower.TOWER_ID == TowerConstants.TowerIDs.BARRICADE:
		REMOVE_BARRICADE_BUTTON.visible = true
		return
	REMOVE_BARRICADE_BUTTON.visible = false

# ===================
# BUILD TOWER SIGNALS
# ===================
func _on_barricade_button_pressed():
	__game_map.set_build_tower_preload(TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BARRICADE])
	__game_map.set_build_tower_cost(TowerConstants.TowerPrices[TowerConstants.TowerIDs.BARRICADE])
	__game_map.set_state(__game_map.States.BUILD_MODE)
	EXIT_BUILD_MODE_BUTTON.visible = true

func _on_black_marble_lvl_1_button_pressed():
	__game_map.set_build_tower_preload(TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BLACK_MARBLE_LVL_1])
	__game_map.set_build_tower_cost(TowerConstants.TowerPrices[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1])
	__game_map.set_state(__game_map.States.BUILD_MODE)
	EXIT_BUILD_MODE_BUTTON.visible = true

func _on_black_marble_lvl_2_pressed():
	__game_map.set_build_tower_preload(TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BLACK_MARBLE_LVL_2])
	__game_map.set_build_tower_cost(TowerConstants.TowerPrices[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2])
	__game_map.set_state(__game_map.States.BUILD_MODE)
	EXIT_BUILD_MODE_BUTTON.visible = true

func _on_black_marble_lvl_3_pressed():
	__game_map.set_build_tower_preload(TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BLACK_MARBLE_LVL_3])
	__game_map.set_build_tower_cost(TowerConstants.TowerPrices[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_3])
	__game_map.set_state(__game_map.States.BUILD_MODE)
	EXIT_BUILD_MODE_BUTTON.visible = true

func _on_bismuth_lvl_1_button_pressed():
	__game_map.set_build_tower_preload(TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BISMUTH_LVL_1])
	__game_map.set_build_tower_cost(TowerConstants.TowerPrices[TowerConstants.TowerIDs.BISMUTH_LVL_1])
	__game_map.set_state(__game_map.States.BUILD_MODE)
	EXIT_BUILD_MODE_BUTTON.visible = true

func _on_test_tower_pressed():
	__game_map.set_build_tower_preload(TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.TEST_BUILD_TOWER])
	__game_map.set_build_tower_cost(TowerConstants.TowerPrices[TowerConstants.TowerIDs.TEST_BUILD_TOWER])
	__game_map.set_state(__game_map.States.BUILD_MODE)
	EXIT_BUILD_MODE_BUTTON.visible = true

# ==========================
# GAME NAVIGATION PROPERTIES
# ==========================

func _on_start_new_wave_button_pressed():
	# Reset build tower values
	__game_map.clear_build_tower_values()
	# Initiate new wave
	__game_map.creep_spawner.initiate_new_wave()
	# Hide build towers hbox container
	BUILD_TOWERS_HBOX_CONTAINER.visible = false
	# Hide start new wave button
	START_NEW_WAVE_BUTTON.visible = false
	# Change state
	__game_map.set_state(__game_map.States.NAVIGATION_MODE)
	EXIT_BUILD_MODE_BUTTON.visible = false

func _on_show_path_buttton_pressed():
	if __game_map.__path_line_visible:
		__game_map.hide_path_line()
	else:
		__game_map.show_path_line()

func _on_exit_build_mode_pressed():
	__game_map.switch_states(__game_map.States.NAVIGATION_MODE)
	EXIT_BUILD_MODE_BUTTON.visible = false

func _on_remove_barricade_pressed():
	__game_map.remove_tower(__selected_tower)
	TOWER_PROPERTIES_HBOX_CONTAINER.visible = false
	BUILD_TOWERS_HBOX_CONTAINER.visible = true
