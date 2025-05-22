extends HBoxContainer
class_name TowerRangeVisibilityContainer

@export var SHOW_TOWER_RANGE_BUTTON: Button
@export var HIDE_TOWER_RANGE_BUTTON: Button

@onready var ALL_BUTTONS: Array[Button] = [SHOW_TOWER_RANGE_BUTTON, HIDE_TOWER_RANGE_BUTTON]

func _ready() -> void:
    # Show range button
    assert(SHOW_TOWER_RANGE_BUTTON, "Show tower range button not assigned in container as export var")
    SHOW_TOWER_RANGE_BUTTON.visible = true

    # Hide range button
    assert(HIDE_TOWER_RANGE_BUTTON, "Hide tower range button not assigned in container as export var")
    HIDE_TOWER_RANGE_BUTTON.visible = true
