extends HBoxContainer
class_name TowerUpgradesContainer

# TOWER BUTTON EXPORTS
# ====================
@export var TOMBSTONE_BUTTON: Button

var ALL_TOWER_BUTTONS: Array[Button] = [
	TOMBSTONE_BUTTON,
]

var TOWER_BUTTON_CALLBACKS: Dictionary[Button, Callable] = {
	TOMBSTONE_BUTTON: _on_tombstone_button_pressed,
}

var TOWER_ID_TO_BUTTON_DICT: Dictionary[TowerConstants.TowerIDs, Button] = {
	TowerConstants.TowerIDs.TOMBSTONE_LVL_1: TOMBSTONE_BUTTON,
}

func _ready():
	# Ensure all tower button exports have been assigned.
	_validate_tower_button_exports()

## Ensures that all tower button exports have been assigned.
func _validate_tower_button_exports():
	assert(TOMBSTONE_BUTTON, "TOMBSTONE_BUTTON is not assigned in the inspector.")

## Connect all tower button signals to their respective callbacks.

func _connect_tower_button_signals():
	for button in ALL_TOWER_BUTTONS:
		# Retrieve the callback function from the dictionary using the button as the key.
		button.pressed.connect(TOWER_BUTTON_CALLBACKS[button])


#                                 | TOWER BUTTONS |
# ====================================================================================================

## WIP
func _on_tombstone_button_pressed():
	pass
