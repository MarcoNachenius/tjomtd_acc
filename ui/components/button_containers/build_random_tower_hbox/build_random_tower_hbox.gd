extends HBoxContainer
class_name BuildRandomTowerHBox

@export var BUILD_RANDOM_TOWER_BUTTON: Button
@export var EXIT_BUILD_MODE_BUTTON: Button
@export var KEEP_TOWER_BUTTON: Button

func _ready():
    # Show the build random tower button
    BUILD_RANDOM_TOWER_BUTTON.visible = true
    # Hide the exit build mode button
    EXIT_BUILD_MODE_BUTTON.visible = false
    # Hide the keep tower button
    KEEP_TOWER_BUTTON.visible = false