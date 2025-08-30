extends HBoxContainer
class_name AwaitingSelectionUpgradeSlatesContainer

# =======
# EXPORTS
# =======
@export var __connected_main_hud: RandomTowerBuildHUD
# ===== Hold slates =====
@export var HOLD_SLATE_LVL_1_BUTTON: Button
@export var HOLD_SLATE_LVL_2_BUTTON: Button
@export var HOLD_SLATE_LVL_3_BUTTON: Button
# ===== Slow slates =====
@export var SLOW_SLATE_LVL_1_BUTTON: Button
@export var SLOW_SLATE_LVL_2_BUTTON: Button
@export var SLOW_SLATE_LVL_3_BUTTON: Button
# ===== Burn slates =====
@export var BURN_SLATE_LVL_1_BUTTON: Button
@export var BURN_SLATE_LVL_2_BUTTON: Button
@export var BURN_SLATE_LVL_3_BUTTON: Button
# ===== Damage slates =====
@export var DAMAGE_SLATE_LVL_1_BUTTON: Button
@export var DAMAGE_SLATE_LVL_2_BUTTON: Button
@export var DAMAGE_SLATE_LVL_3_BUTTON: Button
# ===== Range slates =====
@export var RANGE_SLATE_LVL_1_BUTTON: Button
@export var RANGE_SLATE_LVL_2_BUTTON: Button
@export var RANGE_SLATE_LVL_3_BUTTON: Button
# ===== Speed slates =====
@export var SPEED_SLATE_LVL_1_BUTTON: Button
@export var SPEED_SLATE_LVL_2_BUTTON: Button
@export var SPEED_SLATE_LVL_3_BUTTON: Button

# ==========
# SINGLETONS
# ==========
@onready var ALL_BUTTONS: Array[Button] = [
    ## ===== Hold slates =====
    HOLD_SLATE_LVL_1_BUTTON,
    HOLD_SLATE_LVL_2_BUTTON,
    HOLD_SLATE_LVL_3_BUTTON,
    ## ===== Slow slates =====
    SLOW_SLATE_LVL_1_BUTTON,
    SLOW_SLATE_LVL_2_BUTTON,
    SLOW_SLATE_LVL_3_BUTTON,
    ## ===== Burn slates =====
    #BURN_SLATE_LVL_1_BUTTON,
    #BURN_SLATE_LVL_2_BUTTON,
    #BURN_SLATE_LVL_3_BUTTON,
    ## ===== Damage slates =====
    DAMAGE_SLATE_LVL_1_BUTTON,
    DAMAGE_SLATE_LVL_2_BUTTON,
    DAMAGE_SLATE_LVL_3_BUTTON,
    ## ===== Range slates =====
    RANGE_SLATE_LVL_1_BUTTON,
    RANGE_SLATE_LVL_2_BUTTON,
    RANGE_SLATE_LVL_3_BUTTON,
    ## ===== Speed slates =====
    #SPEED_SLATE_LVL_1_BUTTON,
    #SPEED_SLATE_LVL_2_BUTTON,
    #SPEED_SLATE_LVL_3_BUTTON,
]


@onready var SLATE_ID_TO_BUTTON: Dictionary[SlateConstants.SlateIDs, Button] = {
    # ===== Hold slates =====
    SlateConstants.SlateIDs.HOLD_SLATE_LVL_1: HOLD_SLATE_LVL_1_BUTTON,
    SlateConstants.SlateIDs.HOLD_SLATE_LVL_2: HOLD_SLATE_LVL_2_BUTTON,
    SlateConstants.SlateIDs.HOLD_SLATE_LVL_3: HOLD_SLATE_LVL_3_BUTTON,
    # ===== Slow slates =====
    SlateConstants.SlateIDs.SLOW_SLATE_LVL_1: SLOW_SLATE_LVL_1_BUTTON,
    SlateConstants.SlateIDs.SLOW_SLATE_LVL_2: SLOW_SLATE_LVL_2_BUTTON,
    SlateConstants.SlateIDs.SLOW_SLATE_LVL_3: SLOW_SLATE_LVL_3_BUTTON,
    # ===== Burn slates =====
    SlateConstants.SlateIDs.BURN_SLATE_LVL_1: BURN_SLATE_LVL_1_BUTTON,
    SlateConstants.SlateIDs.BURN_SLATE_LVL_2: BURN_SLATE_LVL_2_BUTTON,
    SlateConstants.SlateIDs.BURN_SLATE_LVL_3: BURN_SLATE_LVL_3_BUTTON,
    # ===== Damage slates =====
    SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_1: DAMAGE_SLATE_LVL_1_BUTTON,
    SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_2: DAMAGE_SLATE_LVL_2_BUTTON,
    SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_3: DAMAGE_SLATE_LVL_3_BUTTON,
    # ===== Range slates =====
    SlateConstants.SlateIDs.RANGE_SLATE_LVL_1: RANGE_SLATE_LVL_1_BUTTON,
    SlateConstants.SlateIDs.RANGE_SLATE_LVL_2: RANGE_SLATE_LVL_2_BUTTON,
    SlateConstants.SlateIDs.RANGE_SLATE_LVL_3: RANGE_SLATE_LVL_3_BUTTON,
    # ===== Speed slates =====
    SlateConstants.SlateIDs.SPEED_SLATE_LVL_1: SPEED_SLATE_LVL_1_BUTTON,
    SlateConstants.SlateIDs.SPEED_SLATE_LVL_2: SPEED_SLATE_LVL_2_BUTTON,
    SlateConstants.SlateIDs.SPEED_SLATE_LVL_3: SPEED_SLATE_LVL_3_BUTTON,
}


@onready var BUTTON_TO_PRESSED_CALLABLES: Dictionary[Button, Callable] = {
    # ===== Damage slates =====
    DAMAGE_SLATE_LVL_1_BUTTON: _on_damage_slate_lvl_1_button_pressed,
    DAMAGE_SLATE_LVL_2_BUTTON: _on_damage_slate_lvl_2_button_pressed,
    DAMAGE_SLATE_LVL_3_BUTTON: _on_damage_slate_lvl_3_button_pressed,
    # ===== Hold slates =====
    HOLD_SLATE_LVL_1_BUTTON: _on_hold_slate_lvl_1_button_pressed,
    HOLD_SLATE_LVL_2_BUTTON: _on_hold_slate_lvl_2_button_pressed,
    HOLD_SLATE_LVL_3_BUTTON: _on_hold_slate_lvl_3_button_pressed,
    # ===== Slow slates =====
    SLOW_SLATE_LVL_1_BUTTON: _on_slow_slate_lvl_1_button_pressed,
    SLOW_SLATE_LVL_2_BUTTON: _on_slow_slate_lvl_2_button_pressed,
    SLOW_SLATE_LVL_3_BUTTON: _on_slow_slate_lvl_3_button_pressed,
    # ===== Burn slates =====
    BURN_SLATE_LVL_1_BUTTON: _on_burn_slate_lvl_1_button_pressed,
    BURN_SLATE_LVL_2_BUTTON: _on_burn_slate_lvl_2_button_pressed,
    BURN_SLATE_LVL_3_BUTTON: _on_burn_slate_lvl_3_button_pressed,
    # ===== Range slates =====
    RANGE_SLATE_LVL_1_BUTTON: _on_range_slate_lvl_1_button_pressed,
    RANGE_SLATE_LVL_2_BUTTON: _on_range_slate_lvl_2_button_pressed,
    RANGE_SLATE_LVL_3_BUTTON: _on_range_slate_lvl_3_button_pressed,
    # ===== Speed slates =====
    SPEED_SLATE_LVL_1_BUTTON: _on_speed_slate_lvl_1_button_pressed,
    SPEED_SLATE_LVL_2_BUTTON: _on_speed_slate_lvl_2_button_pressed,
    SPEED_SLATE_LVL_3_BUTTON: _on_speed_slate_lvl_3_button_pressed,
}
# ============
# PRIVATE VARS
# ============
var __connected_game_map: GameMap

func _ready() -> void:
    _connect_game_map()
    _connect_button_pressed_signals()
    # Ensure no buttons are visible on ready
    hide_all_buttons()

# ===============
# PRIVATE METHODS
# ===============
func _connect_game_map() -> void:
    assert(__connected_main_hud, "Main HUD export not assigned to AwaitingSelectionUpgradeSlatesContainer")
    __connected_game_map = __connected_main_hud.GAME_MAP

func _connect_button_pressed_signals() -> void:
    for button in ALL_BUTTONS:
        # Verify that button has been assigned in inspector
        assert(button, "A button in ALL_BUTTONS was not assigned in the Inspector")
        # Verify that callable has been created for button
        assert(BUTTON_TO_PRESSED_CALLABLES.keys().has(button), "Callable has not been assigned to button")
        # Connect pressed signal to assigned callable
        button.pressed.connect(BUTTON_TO_PRESSED_CALLABLES[button])

# ==============
# PUBLIC METHODS
# ==============
## Shows buttons that correspond to the provided slate IDs
func show_buttons(slateIDs: Array[SlateConstants.SlateIDs]) -> void:
    # Ensure base container is visible
    self.visible = true
    # Ensure all previously visible buttons are no longer visible
    hide_all_buttons()
    for slate_id in slateIDs:
        assert(SLATE_ID_TO_BUTTON.keys().has(slate_id), "No button mapped to: %s" % [SlateDescriptions.SLATE_NAMES[slate_id]])
        SLATE_ID_TO_BUTTON[slate_id].visible = true

func hide_all_buttons() -> void:
    for button in ALL_BUTTONS:
        button.visible = false

# ========================
# BUTTON PRESSED CALLABLES
# ========================
# ===== Damage slates =====
func _on_damage_slate_lvl_1_button_pressed() -> void:
    __connected_game_map.keep_slate_from_towers_awaiting_selection(__connected_main_hud.get_selected_tower(), SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_1)

func _on_damage_slate_lvl_2_button_pressed() -> void:
    __connected_game_map.keep_slate_from_towers_awaiting_selection(__connected_main_hud.get_selected_tower(), SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_2)

func _on_damage_slate_lvl_3_button_pressed() -> void:
    __connected_game_map.keep_slate_from_towers_awaiting_selection(__connected_main_hud.get_selected_tower(), SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_3)

# ===== Hold slates =====
func _on_hold_slate_lvl_1_button_pressed() -> void:
    __connected_game_map.keep_slate_from_towers_awaiting_selection(__connected_main_hud.get_selected_tower(), SlateConstants.SlateIDs.HOLD_SLATE_LVL_1)

func _on_hold_slate_lvl_2_button_pressed() -> void:
    __connected_game_map.keep_slate_from_towers_awaiting_selection(__connected_main_hud.get_selected_tower(), SlateConstants.SlateIDs.HOLD_SLATE_LVL_2)

func _on_hold_slate_lvl_3_button_pressed() -> void:
    __connected_game_map.keep_slate_from_towers_awaiting_selection(__connected_main_hud.get_selected_tower(), SlateConstants.SlateIDs.HOLD_SLATE_LVL_3)

# ===== Slow slates =====
func _on_slow_slate_lvl_1_button_pressed() -> void:
    __connected_game_map.keep_slate_from_towers_awaiting_selection(__connected_main_hud.get_selected_tower(), SlateConstants.SlateIDs.SLOW_SLATE_LVL_1)

func _on_slow_slate_lvl_2_button_pressed() -> void:
    __connected_game_map.keep_slate_from_towers_awaiting_selection(__connected_main_hud.get_selected_tower(), SlateConstants.SlateIDs.SLOW_SLATE_LVL_2)

func _on_slow_slate_lvl_3_button_pressed() -> void:
    __connected_game_map.keep_slate_from_towers_awaiting_selection(__connected_main_hud.get_selected_tower(), SlateConstants.SlateIDs.SLOW_SLATE_LVL_3)

# ===== Burn slates =====
func _on_burn_slate_lvl_1_button_pressed() -> void:
    print("Burn Slate Lvl 1 pressed. WIP")

func _on_burn_slate_lvl_2_button_pressed() -> void:
    print("Burn Slate Lvl 2 pressed. WIP")

func _on_burn_slate_lvl_3_button_pressed() -> void:
    print("Burn Slate Lvl 3 pressed. WIP")

# ===== Range slates =====
func _on_range_slate_lvl_1_button_pressed() -> void:
    __connected_game_map.keep_slate_from_towers_awaiting_selection(__connected_main_hud.get_selected_tower(), SlateConstants.SlateIDs.RANGE_SLATE_LVL_1)

func _on_range_slate_lvl_2_button_pressed() -> void:
    __connected_game_map.keep_slate_from_towers_awaiting_selection(__connected_main_hud.get_selected_tower(), SlateConstants.SlateIDs.RANGE_SLATE_LVL_2)

func _on_range_slate_lvl_3_button_pressed() -> void:
    __connected_game_map.keep_slate_from_towers_awaiting_selection(__connected_main_hud.get_selected_tower(), SlateConstants.SlateIDs.RANGE_SLATE_LVL_3)

# ===== Speed slates =====
func _on_speed_slate_lvl_1_button_pressed() -> void:
    print("Speed Slate Lvl 1 pressed. WIP")

func _on_speed_slate_lvl_2_button_pressed() -> void:
    print("Speed Slate Lvl 2 pressed. WIP")

func _on_speed_slate_lvl_3_button_pressed() -> void:
    print("Speed Slate Lvl 3 pressed. WIP")
