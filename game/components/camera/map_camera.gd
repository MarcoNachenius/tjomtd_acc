extends Camera2D
class_name MapCamera

@export var __game_map: GameMap

func _ready():
	assert(__game_map, "GameMap not set in MapCamera")
	__game_map.camera_moved.connect(_on_camera_moved)
	position_smoothing_enabled = true

# Only zoom inputs are handled here, therefore stopping the method after
# a single input has been handled is perfectly acceptable.
func _unhandled_input(event: InputEvent) -> void:
	# Ignore zoom requests when game map is in build mode.
	if __game_map.get_state() == GameMap.States.BUILD_MODE:
		return

	# Handle PC zoom requests
	if Input.is_action_just_pressed("zoom_in"):
		_zoom_in()
		return
	if Input.is_action_just_pressed("zoom_out"):
		_zoom_out()
		return

	# Handle Android zoom requests
	if event is InputEventMagnifyGesture:
		if event.factor > 1.0:
			_zoom_in()
			return
		if event.factor < 1.0:
			_zoom_out()
			return


func _zoom_in():
	if zoom.x < GameConstants.MAX_ZOOM and zoom.y < GameConstants.MAX_ZOOM:
		zoom += Vector2(GameConstants.ZOOM_SPEED, GameConstants.ZOOM_SPEED)

func _zoom_out():
	if zoom.x > GameConstants.MIN_ZOOM and zoom.y > GameConstants.MIN_ZOOM:
		zoom -= Vector2(GameConstants.ZOOM_SPEED, GameConstants.ZOOM_SPEED)


func _on_camera_moved(distance: Vector2):
	position -= distance
