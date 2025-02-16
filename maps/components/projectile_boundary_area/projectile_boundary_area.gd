extends Area2D
class_name ProjectileBoundaryArea

var __game_map: GameMap

func _ready():
	# Ensure that the parent is of type GameMap
	assert(get_parent(), "ProjectileBoundaryArea has not been added as a child node of map")
	assert(get_parent() is GameMap, "ProjectileBoundaryArea's parent is not of type GameMap")
	__game_map = get_parent()
	_create_collision_shape()

func _create_collision_shape():
	var new_coll_shape = CollisionShape2D.new()
	var new_shape = ConvexPolygonShape2D.new()
	add_child(new_coll_shape)
	new_coll_shape.shape = new_shape

	var corner_offset: Vector2 = Vector2(0, MapConstants.MAP_TILE_HEIGHT/2)

	# Generate coordiantes of corners of the area
	var top_left_corner: Vector2 = __game_map.map_to_local(Vector2i(0, 0)) - corner_offset
	var top_right_corner: Vector2 = __game_map.map_to_local(Vector2i(__game_map.MAP_WIDTH, 0)) - corner_offset
	var bottom_left_corner: Vector2 = __game_map.map_to_local(Vector2i(0, __game_map.MAP_HEIGHT)) - corner_offset
	var bottom_right_corner: Vector2 = __game_map.map_to_local(Vector2i(__game_map.MAP_WIDTH, __game_map.MAP_HEIGHT)) - corner_offset

	# Set the shape points
	new_shape.points = [top_left_corner, top_right_corner, bottom_right_corner, bottom_left_corner]


func _on_area_exited(area:Area2D):
	if !area.get_parent() is Projectile:
		return
	if is_instance_valid(area):
		area.get_parent().queue_free()
