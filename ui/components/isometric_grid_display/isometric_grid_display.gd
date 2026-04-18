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
	# Build the grid once. Map dimensions never change at runtime, so the
	# resulting Line2D nodes remain valid for the lifetime of this node and
	# do not need to be rebuilt (e.g. when the camera moves).
	self._build_isometric_grid()


# ---------------
# PRIVATE METHODS
# ---------------
func _build_isometric_grid() -> void:
	var grid_width: int = GAME_MAP.MAP_WIDTH * 2
	var grid_height: int = GAME_MAP.MAP_HEIGHT * 2

	var tile_size: Vector2 = Vector2(
		MapConstants.MAP_TILE_WIDTH / 2.0,
		MapConstants.MAP_TILE_HEIGHT / 2.0
	)
	var half_tile: Vector2 = tile_size / 2.0

	# Offsets from a placement tile's center to its four corners.
	var top_offset: Vector2    = Vector2(0.0, -half_tile.y)
	var right_offset: Vector2  = Vector2(half_tile.x, 0.0)
	var bottom_offset: Vector2 = Vector2(0.0, half_tile.y)
	var left_offset: Vector2   = Vector2(-half_tile.x, 0.0)

	var quarter_width: float  = MapConstants.MAP_TILE_WIDTH / 4.0
	var quarter_height: float = MapConstants.MAP_TILE_HEIGHT / 4.0

	# Draw horizontal lines (constant y).
	for y in range(grid_height):
		var start_center: Vector2 = Vector2(
			(0 - y) * quarter_width,
			(0 + y) * quarter_height
		)
		var end_center: Vector2 = Vector2(
			((grid_width - 1) - y) * quarter_width,
			((grid_width - 1) + y) * quarter_height
		)
		_add_grid_line_local(start_center + left_offset, end_center + right_offset)

	# Draw vertical lines (constant x).
	for x in range(grid_width):
		var start_center: Vector2 = Vector2(
			x * quarter_width,
			x * quarter_height
		)
		var end_center: Vector2 = Vector2(
			(x - (grid_height - 1)) * quarter_width,
			(x + (grid_height - 1)) * quarter_height
		)
		_add_grid_line_local(start_center + top_offset, end_center + bottom_offset)


func _add_grid_line_local(start_in_game_map: Vector2, end_in_game_map: Vector2) -> void:
	var start_local: Vector2 = self.to_local(GAME_MAP.to_global(start_in_game_map))
	var end_local: Vector2   = self.to_local(GAME_MAP.to_global(end_in_game_map))

	var line: Line2D = Line2D.new()
	line.points = PackedVector2Array([start_local, end_local])
	line.width = LINE_WIDTH
	line.default_color = LINE_COLOR
	self.add_child(line)
