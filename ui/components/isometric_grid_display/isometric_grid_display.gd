extends Node2D
class_name IsometricGridDisplay

# EXPORTS
## Reference to the GameMap whose placement grid should be delineated.
@export var GAME_MAP: GameMap
## Width of the grid lines in pixels.
@export var LINE_WIDTH: float = 1.0
## Color of the grid lines.
@export var LINE_COLOR: Color = Color(1.0, 1.0, 1.0, 1.0)

# -----------------
# INHERITED METHODS
# -----------------
func _ready() -> void:
	# Ensure a GameMap has been assigned.
	assert(GAME_MAP, "No game map (GAME_MAP) has been assigned.")
	# Ensure the GameMap has a tile set to derive dimensions from.
	assert(GAME_MAP.tile_set, "GAME_MAP has no tile_set assigned.")
	self._draw_isometric_grid()


# ---------------
# PRIVATE METHODS
# ---------------
func _draw_isometric_grid() -> void:
	# Draw vertical lines
	var line_offset: Vector2 = Vector2(GAME_MAP.tile_set.tile_size.x, -GAME_MAP.tile_set.tile_size.y)
	for from_x in range(GAME_MAP.MAP_WIDTH * 2 + 1):
		var line: Line2D = Line2D.new()
		var from_coord: Vector2 = GAME_MAP.map_to_local(Vector2i(from_x, 1)) + line_offset
		var to_coord: Vector2 = GAME_MAP.map_to_local(Vector2i(from_x, GAME_MAP.MAP_HEIGHT * 2 + 1)) + line_offset
		line.points = PackedVector2Array([from_coord/2, to_coord/2])
		line.width = LINE_WIDTH
		line.default_color = LINE_COLOR
		self.add_child(line)
	
	# Draw horizontal lines
	var h_line_offset: Vector2 = Vector2(-GAME_MAP.tile_set.tile_size.x, -GAME_MAP.tile_set.tile_size.y)
	for from_y in range(GAME_MAP.MAP_HEIGHT * 2 + 1):
		var line: Line2D = Line2D.new()
		var from_coord: Vector2 = GAME_MAP.map_to_local(Vector2i(2, from_y - 1)) + h_line_offset
		var to_coord: Vector2 = GAME_MAP.map_to_local(Vector2i(GAME_MAP.MAP_WIDTH * 2 + 2, from_y - 1)) + h_line_offset
		line.points = PackedVector2Array([from_coord/2, to_coord/2])
		line.width = LINE_WIDTH
		line.default_color = LINE_COLOR
		self.add_child(line)
