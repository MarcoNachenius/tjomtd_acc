extends VBoxContainer
class_name SlateButtonVbox

signal slate_button_pressed(slate_id: SlateConstants.SlateIDs)

# DAMAGE SLATES
@export var DAMAGE_SLATE_LVL_1_BUTTON: Button
@export var DAMAGE_SLATE_LVL_2_BUTTON: Button
@export var DAMAGE_SLATE_LVL_3_BUTTON: Button
# SLOW SLATES
@export var SLOW_SLATE_LVL_1_BUTTON: Button
@export var SLOW_SLATE_LVL_2_BUTTON: Button
@export var SLOW_SLATE_LVL_3_BUTTON: Button
# RANGE SLATES
@export var RANGE_SLATE_LVL_1_BUTTON: Button
@export var RANGE_SLATE_LVL_2_BUTTON: Button
@export var RANGE_SLATE_LVL_3_BUTTON: Button
# SPEED SLATES
@export var SPEED_SLATE_LVL_1_BUTTON: Button
@export var SPEED_SLATE_LVL_2_BUTTON: Button
@export var SPEED_SLATE_LVL_3_BUTTON: Button
# BURN SLATES
@export var BURN_SLATE_LVL_1_BUTTON: Button
@export var BURN_SLATE_LVL_2_BUTTON: Button
@export var BURN_SLATE_LVL_3_BUTTON: Button
# HOLD SLATES
@export var HOLD_SLATE_LVL_1_BUTTON: Button
@export var HOLD_SLATE_LVL_2_BUTTON: Button
@export var HOLD_SLATE_LVL_3_BUTTON: Button


@onready var ALL_BUTTONS: Array[Button] = [
	# DAMAGE SLATES
	DAMAGE_SLATE_LVL_1_BUTTON,
	DAMAGE_SLATE_LVL_2_BUTTON,
	DAMAGE_SLATE_LVL_3_BUTTON,
	# SLOW SLATES
	SLOW_SLATE_LVL_1_BUTTON,
	SLOW_SLATE_LVL_2_BUTTON,
	SLOW_SLATE_LVL_3_BUTTON,
	# RANGE SLATES
	RANGE_SLATE_LVL_1_BUTTON,
	RANGE_SLATE_LVL_2_BUTTON,
	RANGE_SLATE_LVL_3_BUTTON,
	# SPEED SLATES
	SPEED_SLATE_LVL_1_BUTTON,
	SPEED_SLATE_LVL_2_BUTTON,
	SPEED_SLATE_LVL_3_BUTTON,
	# BURN SLATES
	BURN_SLATE_LVL_1_BUTTON,
	BURN_SLATE_LVL_2_BUTTON,
	BURN_SLATE_LVL_3_BUTTON,
	# HOLD SLATES
	HOLD_SLATE_LVL_1_BUTTON,
	HOLD_SLATE_LVL_2_BUTTON,
	HOLD_SLATE_LVL_3_BUTTON,
]


var SLATE_ID_TO_BUTTON_PRESSED_CALLABLES: Dictionary[SlateConstants.SlateIDs, Callable] = {
	# DAMAGE SLATES
	SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_1: on_damage_slate_lvl_1_button_pressed,
	SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_2: on_damage_slate_lvl_2_button_pressed,
	SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_3: on_damage_slate_lvl_3_button_pressed,
	# SLOW SLATES
	SlateConstants.SlateIDs.SLOW_SLATE_LVL_1: on_slow_slate_lvl_1_button_pressed,
	SlateConstants.SlateIDs.SLOW_SLATE_LVL_2: on_slow_slate_lvl_2_button_pressed,
	SlateConstants.SlateIDs.SLOW_SLATE_LVL_3: on_slow_slate_lvl_3_button_pressed,
	# RANGE SLATES
	SlateConstants.SlateIDs.RANGE_SLATE_LVL_1: on_range_slate_lvl_1_button_pressed,
	SlateConstants.SlateIDs.RANGE_SLATE_LVL_2: on_range_slate_lvl_2_button_pressed,
	SlateConstants.SlateIDs.RANGE_SLATE_LVL_3: on_range_slate_lvl_3_button_pressed,
	# SPEED SLATES
	SlateConstants.SlateIDs.SPEED_SLATE_LVL_1: on_speed_slate_lvl_1_button_pressed,
	SlateConstants.SlateIDs.SPEED_SLATE_LVL_2: on_speed_slate_lvl_2_button_pressed,
	SlateConstants.SlateIDs.SPEED_SLATE_LVL_3: on_speed_slate_lvl_3_button_pressed,
	# BURN SLATES
	SlateConstants.SlateIDs.BURN_SLATE_LVL_1: on_burn_slate_lvl_1_button_pressed,
	SlateConstants.SlateIDs.BURN_SLATE_LVL_2: on_burn_slate_lvl_2_button_pressed,
	SlateConstants.SlateIDs.BURN_SLATE_LVL_3: on_burn_slate_lvl_3_button_pressed,
	# HOLD SLATES
	SlateConstants.SlateIDs.HOLD_SLATE_LVL_1: on_hold_slate_lvl_1_button_pressed,
	SlateConstants.SlateIDs.HOLD_SLATE_LVL_2: on_hold_slate_lvl_2_button_pressed,
	SlateConstants.SlateIDs.HOLD_SLATE_LVL_3: on_hold_slate_lvl_3_button_pressed,
}


@onready var SLATE_ID_TO_BUTTON: Dictionary[SlateConstants.SlateIDs, Button] = {
	# DAMAGE SLATES
	SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_1: DAMAGE_SLATE_LVL_1_BUTTON,
	SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_2: DAMAGE_SLATE_LVL_2_BUTTON,
	SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_3: DAMAGE_SLATE_LVL_3_BUTTON,
	# SLOW SLATES
	SlateConstants.SlateIDs.SLOW_SLATE_LVL_1: SLOW_SLATE_LVL_1_BUTTON,
	SlateConstants.SlateIDs.SLOW_SLATE_LVL_2: SLOW_SLATE_LVL_2_BUTTON,
	SlateConstants.SlateIDs.SLOW_SLATE_LVL_3: SLOW_SLATE_LVL_3_BUTTON,
	# RANGE SLATES
	SlateConstants.SlateIDs.RANGE_SLATE_LVL_1: RANGE_SLATE_LVL_1_BUTTON,
	SlateConstants.SlateIDs.RANGE_SLATE_LVL_2: RANGE_SLATE_LVL_2_BUTTON,
	SlateConstants.SlateIDs.RANGE_SLATE_LVL_3: RANGE_SLATE_LVL_3_BUTTON,
	# SPEED SLATES
	SlateConstants.SlateIDs.SPEED_SLATE_LVL_1: SPEED_SLATE_LVL_1_BUTTON,
	SlateConstants.SlateIDs.SPEED_SLATE_LVL_2: SPEED_SLATE_LVL_2_BUTTON,
	SlateConstants.SlateIDs.SPEED_SLATE_LVL_3: SPEED_SLATE_LVL_3_BUTTON,
	# BURN SLATES
	SlateConstants.SlateIDs.BURN_SLATE_LVL_1: BURN_SLATE_LVL_1_BUTTON,
	SlateConstants.SlateIDs.BURN_SLATE_LVL_2: BURN_SLATE_LVL_2_BUTTON,
	SlateConstants.SlateIDs.BURN_SLATE_LVL_3: BURN_SLATE_LVL_3_BUTTON,
	# HOLD SLATES
	SlateConstants.SlateIDs.HOLD_SLATE_LVL_1: HOLD_SLATE_LVL_1_BUTTON,
	SlateConstants.SlateIDs.HOLD_SLATE_LVL_2: HOLD_SLATE_LVL_2_BUTTON,
	SlateConstants.SlateIDs.HOLD_SLATE_LVL_3: HOLD_SLATE_LVL_3_BUTTON,
}

func _ready() -> void:
	# Connect all button pressed signals to their respective callables
	for slate_id in SLATE_ID_TO_BUTTON_PRESSED_CALLABLES.keys():
		var button: Button = SLATE_ID_TO_BUTTON[slate_id]
		var callable: Callable = SLATE_ID_TO_BUTTON_PRESSED_CALLABLES[slate_id]
		button.pressed.connect(callable)


# ==============
# PUBLIC METHODS
# ==============
func hide_all_buttons() -> void:
	for button in ALL_BUTTONS:
		button.visible = false


func show_buttons(slateID) -> void:
	for slate_id in slateID:
		SLATE_ID_TO_BUTTON[slate_id].visible = true


# ==============================
# BUTTON PRESSED SIGNAL EMITTERS
# ==============================
# DAMAGE SLATES
func on_damage_slate_lvl_1_button_pressed() -> void:
	slate_button_pressed.emit(SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_1)

func on_damage_slate_lvl_2_button_pressed() -> void:
	slate_button_pressed.emit(SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_2)

func on_damage_slate_lvl_3_button_pressed() -> void:
	slate_button_pressed.emit(SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_3)

# SLOW SLATES
func on_slow_slate_lvl_1_button_pressed() -> void:
	slate_button_pressed.emit(SlateConstants.SlateIDs.SLOW_SLATE_LVL_1)

func on_slow_slate_lvl_2_button_pressed() -> void:
	slate_button_pressed.emit(SlateConstants.SlateIDs.SLOW_SLATE_LVL_2)

func on_slow_slate_lvl_3_button_pressed() -> void:
	slate_button_pressed.emit(SlateConstants.SlateIDs.SLOW_SLATE_LVL_3)

# RANGE SLATES
func on_range_slate_lvl_1_button_pressed() -> void:
	slate_button_pressed.emit(SlateConstants.SlateIDs.RANGE_SLATE_LVL_1)

func on_range_slate_lvl_2_button_pressed() -> void:
	slate_button_pressed.emit(SlateConstants.SlateIDs.RANGE_SLATE_LVL_2)

func on_range_slate_lvl_3_button_pressed() -> void:
	slate_button_pressed.emit(SlateConstants.SlateIDs.RANGE_SLATE_LVL_3)

# SPEED SLATES
func on_speed_slate_lvl_1_button_pressed() -> void:
	slate_button_pressed.emit(SlateConstants.SlateIDs.SPEED_SLATE_LVL_1)

func on_speed_slate_lvl_2_button_pressed() -> void:
	slate_button_pressed.emit(SlateConstants.SlateIDs.SPEED_SLATE_LVL_2)

func on_speed_slate_lvl_3_button_pressed() -> void:
	slate_button_pressed.emit(SlateConstants.SlateIDs.SPEED_SLATE_LVL_3)

# BURN SLATES
func on_burn_slate_lvl_1_button_pressed() -> void:
	slate_button_pressed.emit(SlateConstants.SlateIDs.BURN_SLATE_LVL_1)

func on_burn_slate_lvl_2_button_pressed() -> void:
	slate_button_pressed.emit(SlateConstants.SlateIDs.BURN_SLATE_LVL_2)

func on_burn_slate_lvl_3_button_pressed() -> void:
	slate_button_pressed.emit(SlateConstants.SlateIDs.BURN_SLATE_LVL_3)

# HOLD SLATES
func on_hold_slate_lvl_1_button_pressed() -> void:
	slate_button_pressed.emit(SlateConstants.SlateIDs.HOLD_SLATE_LVL_1)

func on_hold_slate_lvl_2_button_pressed() -> void:
	slate_button_pressed.emit(SlateConstants.SlateIDs.HOLD_SLATE_LVL_2)

func on_hold_slate_lvl_3_button_pressed() -> void:
	slate_button_pressed.emit(SlateConstants.SlateIDs.HOLD_SLATE_LVL_3)
