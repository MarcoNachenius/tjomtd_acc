extends Camera2D
class_name MapCamera

@export var __game_map: GameMap

func _ready():
	assert(__game_map, "GameMap not set in MapCamera")
	__game_map.camera_moved.connect(_on_camera_moved)


func _process(delta):
	if Input.is_action_just_pressed("zoom_in"):
		_zoom_in()
	if Input.is_action_just_pressed("zoom_out"):
		_zoom_out()

func _zoom_in():
	if zoom.x < GameConstants.MAX_ZOOM and zoom.y < GameConstants.MAX_ZOOM:
		zoom += Vector2(GameConstants.ZOOM_SPEED, GameConstants.ZOOM_SPEED)

func _zoom_out():
	if zoom.x > GameConstants.MIN_ZOOM and zoom.y > GameConstants.MIN_ZOOM:
		zoom -= Vector2(GameConstants.ZOOM_SPEED, GameConstants.ZOOM_SPEED)


func _on_camera_moved(distance: Vector2):
	position -= distance
