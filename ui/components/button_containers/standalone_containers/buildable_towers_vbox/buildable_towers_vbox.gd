extends VBoxContainer
class_name BuildableTowerButtonsVBox

signal buildable_tower_button_pressed(tower_id: TowerConstants.TowerIDs)

# BLACK MARBLE
@export var BLACK_MARBLE_LVL_1_BUTTON: Button
@export var BLACK_MARBLE_LVL_2_BUTTON: Button
@export var BLACK_MARBLE_LVL_3_BUTTON: Button
@export var BLACK_MARBLE_LVL_4_BUTTON: Button
@export var BLACK_MARBLE_LVL_5_BUTTON: Button
# BISMUTH
@export var BISMUTH_LVL_1_BUTTON: Button
@export var BISMUTH_LVL_2_BUTTON: Button
@export var BISMUTH_LVL_3_BUTTON: Button
@export var BISMUTH_LVL_4_BUTTON: Button
@export var BISMUTH_LVL_5_BUTTON: Button
# SUNSTONE
@export var SUNSTONE_LVL_1_BUTTON: Button
@export var SUNSTONE_LVL_2_BUTTON: Button
@export var SUNSTONE_LVL_3_BUTTON: Button
@export var SUNSTONE_LVL_4_BUTTON: Button
@export var SUNSTONE_LVL_5_BUTTON: Button
# SPINEL
@export var SPINEL_LVL_1_BUTTON: Button
@export var SPINEL_LVL_2_BUTTON: Button
@export var SPINEL_LVL_3_BUTTON: Button
@export var SPINEL_LVL_4_BUTTON: Button
@export var SPINEL_LVL_5_BUTTON: Button
# KUNZITE
@export var KUNZITE_LVL_1_BUTTON: Button
@export var KUNZITE_LVL_2_BUTTON: Button
@export var KUNZITE_LVL_3_BUTTON: Button
@export var KUNZITE_LVL_4_BUTTON: Button
@export var KUNZITE_LVL_5_BUTTON: Button
# LARIMAR
@export var LARIMAR_LVL_1_BUTTON: Button
@export var LARIMAR_LVL_2_BUTTON: Button
@export var LARIMAR_LVL_3_BUTTON: Button
@export var LARIMAR_LVL_4_BUTTON: Button
@export var LARIMAR_LVL_5_BUTTON: Button


var ALL_BUTTONS: Array[Button] = [
	# BLACK MARBLE
	BLACK_MARBLE_LVL_1_BUTTON,
	BLACK_MARBLE_LVL_2_BUTTON,
	BLACK_MARBLE_LVL_3_BUTTON,
	BLACK_MARBLE_LVL_4_BUTTON,
	BLACK_MARBLE_LVL_5_BUTTON,
	# BISMUTH
	BISMUTH_LVL_1_BUTTON,
	BISMUTH_LVL_2_BUTTON,
	BISMUTH_LVL_3_BUTTON,
	BISMUTH_LVL_4_BUTTON,
	BISMUTH_LVL_5_BUTTON,
	# SUNSTONE
	SUNSTONE_LVL_1_BUTTON,
	SUNSTONE_LVL_2_BUTTON,
	SUNSTONE_LVL_3_BUTTON,
	SUNSTONE_LVL_4_BUTTON,
	SUNSTONE_LVL_5_BUTTON,
	# SPINEL
	SPINEL_LVL_1_BUTTON,
	SPINEL_LVL_2_BUTTON,
	SPINEL_LVL_3_BUTTON,
	SPINEL_LVL_4_BUTTON,
	SPINEL_LVL_5_BUTTON,
	# KUNZITE
	KUNZITE_LVL_1_BUTTON,
	KUNZITE_LVL_2_BUTTON,
	KUNZITE_LVL_3_BUTTON,
	KUNZITE_LVL_4_BUTTON,
	KUNZITE_LVL_5_BUTTON,
	# LARIMAR
	LARIMAR_LVL_1_BUTTON,
	LARIMAR_LVL_2_BUTTON,
	LARIMAR_LVL_3_BUTTON,
	LARIMAR_LVL_4_BUTTON,
	LARIMAR_LVL_5_BUTTON,
]


@onready var TOWER_ID_TO_BUTTON: Dictionary[TowerConstants.TowerIDs, Button] = {
	# BLACK MARBLE
	TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1: BLACK_MARBLE_LVL_1_BUTTON,
	TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2: BLACK_MARBLE_LVL_2_BUTTON,
	TowerConstants.TowerIDs.BLACK_MARBLE_LVL_3: BLACK_MARBLE_LVL_3_BUTTON,
	TowerConstants.TowerIDs.BLACK_MARBLE_LVL_4: BLACK_MARBLE_LVL_4_BUTTON,
	TowerConstants.TowerIDs.BLACK_MARBLE_LVL_5: BLACK_MARBLE_LVL_5_BUTTON,
	# BISMUTH
	TowerConstants.TowerIDs.BISMUTH_LVL_1: BISMUTH_LVL_1_BUTTON,
	TowerConstants.TowerIDs.BISMUTH_LVL_2: BISMUTH_LVL_2_BUTTON,
	TowerConstants.TowerIDs.BISMUTH_LVL_3: BISMUTH_LVL_3_BUTTON,
	TowerConstants.TowerIDs.BISMUTH_LVL_4: BISMUTH_LVL_4_BUTTON,
	TowerConstants.TowerIDs.BISMUTH_LVL_5: BISMUTH_LVL_5_BUTTON,
	# SUNSTONE
	TowerConstants.TowerIDs.SUNSTONE_LVL_1: SUNSTONE_LVL_1_BUTTON,
	TowerConstants.TowerIDs.SUNSTONE_LVL_2: SUNSTONE_LVL_2_BUTTON,
	TowerConstants.TowerIDs.SUNSTONE_LVL_3: SUNSTONE_LVL_3_BUTTON,
	TowerConstants.TowerIDs.SUNSTONE_LVL_4: SUNSTONE_LVL_4_BUTTON,
	TowerConstants.TowerIDs.SUNSTONE_LVL_5: SUNSTONE_LVL_5_BUTTON,
	# SPINEL
	TowerConstants.TowerIDs.SPINEL_LVL_1: SPINEL_LVL_1_BUTTON,
	TowerConstants.TowerIDs.SPINEL_LVL_2: SPINEL_LVL_2_BUTTON,
	TowerConstants.TowerIDs.SPINEL_LVL_3: SPINEL_LVL_3_BUTTON,
	TowerConstants.TowerIDs.SPINEL_LVL_4: SPINEL_LVL_4_BUTTON,
	TowerConstants.TowerIDs.SPINEL_LVL_5: SPINEL_LVL_5_BUTTON,
	# KUNZITE
	TowerConstants.TowerIDs.KUNZITE_LVL_1: KUNZITE_LVL_1_BUTTON,
	TowerConstants.TowerIDs.KUNZITE_LVL_2: KUNZITE_LVL_2_BUTTON,
	TowerConstants.TowerIDs.KUNZITE_LVL_3: KUNZITE_LVL_3_BUTTON,
	TowerConstants.TowerIDs.KUNZITE_LVL_4: KUNZITE_LVL_4_BUTTON,
	TowerConstants.TowerIDs.KUNZITE_LVL_5: KUNZITE_LVL_5_BUTTON,
	# LARIMAR
	TowerConstants.TowerIDs.LARIMAR_LVL_1: LARIMAR_LVL_1_BUTTON,
	TowerConstants.TowerIDs.LARIMAR_LVL_2: LARIMAR_LVL_2_BUTTON,
	TowerConstants.TowerIDs.LARIMAR_LVL_3: LARIMAR_LVL_3_BUTTON,
	TowerConstants.TowerIDs.LARIMAR_LVL_4: LARIMAR_LVL_4_BUTTON,
	TowerConstants.TowerIDs.LARIMAR_LVL_5: LARIMAR_LVL_5_BUTTON,
}


var TOWER_ID_TO_BUTTON_PRESSED_CALLABLES: Dictionary[TowerConstants.TowerIDs, Callable] = {
	# BLACK MARBLE
	TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1: _on_black_marble_lvl_1_button_pressed,
	TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2: _on_black_marble_lvl_2_button_pressed,
	TowerConstants.TowerIDs.BLACK_MARBLE_LVL_3: _on_black_marble_lvl_3_button_pressed,
	TowerConstants.TowerIDs.BLACK_MARBLE_LVL_4: _on_black_marble_lvl_4_button_pressed,
	TowerConstants.TowerIDs.BLACK_MARBLE_LVL_5: _on_black_marble_lvl_5_button_pressed,
	# BISMUTH
	TowerConstants.TowerIDs.BISMUTH_LVL_1: _on_bismuth_lvl_1_button_pressed,
	TowerConstants.TowerIDs.BISMUTH_LVL_2: _on_bismuth_lvl_2_button_pressed,
	TowerConstants.TowerIDs.BISMUTH_LVL_3: _on_bismuth_lvl_3_button_pressed,
	TowerConstants.TowerIDs.BISMUTH_LVL_4: _on_bismuth_lvl_4_button_pressed,
	TowerConstants.TowerIDs.BISMUTH_LVL_5: _on_bismuth_lvl_5_button_pressed,
	# SUNSTONE
	TowerConstants.TowerIDs.SUNSTONE_LVL_1: _on_sunstone_lvl_1_button_pressed,
	TowerConstants.TowerIDs.SUNSTONE_LVL_2: _on_sunstone_lvl_2_button_pressed,
	TowerConstants.TowerIDs.SUNSTONE_LVL_3: _on_sunstone_lvl_3_button_pressed,
	TowerConstants.TowerIDs.SUNSTONE_LVL_4: _on_sunstone_lvl_4_button_pressed,
	TowerConstants.TowerIDs.SUNSTONE_LVL_5: _on_sunstone_lvl_5_button_pressed,
	# SPINEL
	TowerConstants.TowerIDs.SPINEL_LVL_1: _on_spinel_lvl_1_button_pressed,
	TowerConstants.TowerIDs.SPINEL_LVL_2: _on_spinel_lvl_2_button_pressed,
	TowerConstants.TowerIDs.SPINEL_LVL_3: _on_spinel_lvl_3_button_pressed,
	TowerConstants.TowerIDs.SPINEL_LVL_4: _on_spinel_lvl_4_button_pressed,
	TowerConstants.TowerIDs.SPINEL_LVL_5: _on_spinel_lvl_5_button_pressed,
	# KUNZITE
	TowerConstants.TowerIDs.KUNZITE_LVL_1: _on_kunzite_lvl_1_button_pressed,
	TowerConstants.TowerIDs.KUNZITE_LVL_2: _on_kunzite_lvl_2_button_pressed,
	TowerConstants.TowerIDs.KUNZITE_LVL_3: _on_kunzite_lvl_3_button_pressed,
	TowerConstants.TowerIDs.KUNZITE_LVL_4: _on_kunzite_lvl_4_button_pressed,
	TowerConstants.TowerIDs.KUNZITE_LVL_5: _on_kunzite_lvl_5_button_pressed,
	# LARIMAR
	TowerConstants.TowerIDs.LARIMAR_LVL_1: _on_larimar_lvl_1_button_pressed,
	TowerConstants.TowerIDs.LARIMAR_LVL_2: _on_larimar_lvl_2_button_pressed,
	TowerConstants.TowerIDs.LARIMAR_LVL_3: _on_larimar_lvl_3_button_pressed,
	TowerConstants.TowerIDs.LARIMAR_LVL_4: _on_larimar_lvl_4_button_pressed,
	TowerConstants.TowerIDs.LARIMAR_LVL_5: _on_larimar_lvl_5_button_pressed,
}


func _ready() -> void:
	# Connect all button pressed signals to their respective callables
	for tower_id in TOWER_ID_TO_BUTTON_PRESSED_CALLABLES.keys():
		var button: Button = TOWER_ID_TO_BUTTON[tower_id]
		var callable: Callable = TOWER_ID_TO_BUTTON_PRESSED_CALLABLES[tower_id]
		button.pressed.connect(callable)


# ==============
# PUBLIC METHODS
# ==============
func hide_all_buttons() -> void:
	for button in ALL_BUTTONS:
		button.visible = false

func show_buttons(towerIDs: Array[TowerConstants.TowerIDs]) -> void:
	for tower_id in towerIDs:
		TOWER_ID_TO_BUTTON[tower_id].visible = true


# ==============================
# BUTTON PRESSED SIGNAL EMITTERS
# ==============================
# BLACK MARBLE
func _on_black_marble_lvl_1_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1)

func _on_black_marble_lvl_2_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2)

func _on_black_marble_lvl_3_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.BLACK_MARBLE_LVL_3)

func _on_black_marble_lvl_4_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.BLACK_MARBLE_LVL_4)

func _on_black_marble_lvl_5_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.BLACK_MARBLE_LVL_5)

# BISMUTH
func _on_bismuth_lvl_1_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.BISMUTH_LVL_1)

func _on_bismuth_lvl_2_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.BISMUTH_LVL_2)

func _on_bismuth_lvl_3_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.BISMUTH_LVL_3)

func _on_bismuth_lvl_4_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.BISMUTH_LVL_4)

func _on_bismuth_lvl_5_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.BISMUTH_LVL_5)

# SUNSTONE
func _on_sunstone_lvl_1_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.SUNSTONE_LVL_1)

func _on_sunstone_lvl_2_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.SUNSTONE_LVL_2)

func _on_sunstone_lvl_3_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.SUNSTONE_LVL_3)

func _on_sunstone_lvl_4_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.SUNSTONE_LVL_4)

func _on_sunstone_lvl_5_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.SUNSTONE_LVL_5)

# SPINEL
func _on_spinel_lvl_1_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.SPINEL_LVL_1)

func _on_spinel_lvl_2_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.SPINEL_LVL_2)

func _on_spinel_lvl_3_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.SPINEL_LVL_3)

func _on_spinel_lvl_4_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.SPINEL_LVL_4)

func _on_spinel_lvl_5_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.SPINEL_LVL_5)

# KUNZITE
func _on_kunzite_lvl_1_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.KUNZITE_LVL_1)

func _on_kunzite_lvl_2_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.KUNZITE_LVL_2)

func _on_kunzite_lvl_3_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.KUNZITE_LVL_3)

func _on_kunzite_lvl_4_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.KUNZITE_LVL_4)

func _on_kunzite_lvl_5_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.KUNZITE_LVL_5)

# LARIMAR
func _on_larimar_lvl_1_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.LARIMAR_LVL_1)

func _on_larimar_lvl_2_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.LARIMAR_LVL_2)

func _on_larimar_lvl_3_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.LARIMAR_LVL_3)

func _on_larimar_lvl_4_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.LARIMAR_LVL_4)

func _on_larimar_lvl_5_button_pressed() -> void:
	buildable_tower_button_pressed.emit(TowerConstants.TowerIDs.LARIMAR_LVL_5)
