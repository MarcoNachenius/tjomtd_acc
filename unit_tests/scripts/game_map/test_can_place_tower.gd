extends GutTest 

## Reset before each test case
func before_each():
	await get_tree().process_frame  # Ensure previous nodes are fully freed.


## Creating a blank map and processing the frame should create the map is important for 
## creating a test object to run the rest of the tests in this file.
func test_create_blank_map():
	# ================================================================
	#					 ** CREATE BLANK MAP **
	# ================================================================
	var test_map = GameMap.new()
	# LINE_TD is used because it has no mandatory path stops
	test_map.MAP_ID = MapConstants.MapID.LINE_TD
	# Set the map's size to 10x10
	test_map.MAP_HEIGHT = 10
	test_map.MAP_WIDTH = 10
    # Ensure start and end points don't interfere with placement validity
	test_map.__path_start_point = Vector2i(0, 0)
	test_map.__path_end_point = Vector2i(0, 19)
	# Create test tileset
	var test_tileset = TileSet.new()
	test_tileset.tile_shape = TileSet.TILE_SHAPE_ISOMETRIC
	test_tileset.tile_layout = TileSet.TILE_LAYOUT_DIAMOND_DOWN
	test_tileset.tile_offset_axis = TileSet.TILE_OFFSET_AXIS_VERTICAL
	test_tileset.tile_size = Vector2i(256, 128)
	# Asssign the test tileset to the map
	test_map.tile_set = test_tileset
	# Add the test map to the scene
	add_child_autofree(test_map)
	# Process frame to create the map
	await get_tree().process_frame
	# ================================================================


	# Verify the map was created successfully
	assert_not_null(test_map, "Test map created successfully")
	assert_true(test_map is GameMap, "Test map is of type GameMap")
	# Ensure no other waypoints are present besides the start and end points
	assert_eq(test_map.__mandatory_waypoints, [test_map.__path_start_point, test_map.__path_end_point], "Test map has no mandatory waypoints")

	# Clean up
	test_map.queue_free()

func test_can_place_tower_top_left_corner():
	# ================================================================
	#					 ** CREATE BLANK MAP **
	# ================================================================
	var test_map: GameMap = GameMap.new()
	# LINE_TD is used because it has no mandatory path stops
	test_map.MAP_ID = MapConstants.MapID.LINE_TD
	# Set the map's size to 10x10
	test_map.MAP_HEIGHT = 10
	test_map.MAP_WIDTH = 10
    # Ensure start and end points don't interfere with placement validity
	test_map.__path_start_point = Vector2i(10, 9)
	test_map.__path_end_point = Vector2i(10, 12)
	# Create test tileset
	var test_tileset = TileSet.new()
	test_tileset.tile_shape = TileSet.TILE_SHAPE_ISOMETRIC
	test_tileset.tile_layout = TileSet.TILE_LAYOUT_DIAMOND_DOWN
	test_tileset.tile_offset_axis = TileSet.TILE_OFFSET_AXIS_VERTICAL
	test_tileset.tile_size = Vector2i(256, 128)
	# Asssign the test tileset to the map
	test_map.tile_set = test_tileset
	# Add the test map to the scene
	add_child_autofree(test_map)
	# Process frame to create the map
	await get_tree().process_frame
	# ================================================================

	# Assert value of (0, 0) placement grid point
	# (0, 0) should be invalid because impediment points fall outside left border of the map
	assert_false(test_map.can_place_tower(Vector2i(0, 0)), "Tile placement at (0, 0) should be false")
	# Assert value of (0, 1) placement grid point (invalid point)
	# (0, 1) should be invalid because impediment points fall outside left border of the map
	assert_false(test_map.can_place_tower(Vector2i(0, 1)), "Tile placement at (0, 1) should be false")
	# Assert value of (1, -1) placement grid point (invalid point)
	# (1, -1) should be invalid because impediment points fall outside left border of the map
	assert_false(test_map.can_place_tower(Vector2i(1, -1)), "Tile placement at (1, -1) should be false")
	# Assert value of (1, 0) placement grid point (valid point)
	assert_true(test_map.can_place_tower(Vector2i(1, 0)), "Tile placement at (1, 0) should be true")

	# Clean up
	test_map.queue_free()

func test_can_place_tower_top_right_corner():
	# ================================================================
	#					 ** CREATE BLANK MAP **
	# ================================================================
	var test_map: GameMap = GameMap.new()
	# LINE_TD is used because it has no mandatory path stops
	test_map.MAP_ID = MapConstants.MapID.LINE_TD
	# Set the map's size to 10x10
	test_map.MAP_HEIGHT = 10
	test_map.MAP_WIDTH = 10
    # Ensure start and end points don't interfere with placement validity
	test_map.__path_start_point = Vector2i(10, 9)
	test_map.__path_end_point = Vector2i(10, 12)
	# Create test tileset
	var test_tileset = TileSet.new()
	test_tileset.tile_shape = TileSet.TILE_SHAPE_ISOMETRIC
	test_tileset.tile_layout = TileSet.TILE_LAYOUT_DIAMOND_DOWN
	test_tileset.tile_offset_axis = TileSet.TILE_OFFSET_AXIS_VERTICAL
	test_tileset.tile_size = Vector2i(256, 128)
	# Asssign the test tileset to the map
	test_map.tile_set = test_tileset
	# Add the test map to the scene
	add_child_autofree(test_map)
	# Process frame to create the map
	await get_tree().process_frame
	# ================================================================


	# Assert value of (20, 0) placement grid point (invalid point)
	# (20, 0) should be invalid because impediment points fall outside right border of the map
	assert_false(test_map.can_place_tower(Vector2i(20, 0)), "Tile placement at (20, 0) should be false")
	# Assert value of (19, -1) placement grid point (invalid point)
	# (19, -1) should be invalid because impediment points fall outside top border of the map
	assert_false(test_map.can_place_tower(Vector2i(19, -1)), "Tile placement at (19, -1) should be false")
	# Assert value of (19, 0) placement grid point (valid point)
	assert_true(test_map.can_place_tower(Vector2i(19, 0)), "Tile placement at (19, 0) should be true")

	# Clean up
	test_map.queue_free()

func test_can_place_tower_bottom_left_corner():
	# ================================================================
	#					 ** CREATE BLANK MAP **
	# ================================================================
	var test_map: GameMap = GameMap.new()
	# LINE_TD is used because it has no mandatory path stops
	test_map.MAP_ID = MapConstants.MapID.LINE_TD
	# Set the map's size to 10x10
	test_map.MAP_HEIGHT = 10
	test_map.MAP_WIDTH = 10
    # Ensure start and end points don't interfere with placement validity
	test_map.__path_start_point = Vector2i(10, 9)
	test_map.__path_end_point = Vector2i(10, 12)
	# Create test tileset
	var test_tileset = TileSet.new()
	test_tileset.tile_shape = TileSet.TILE_SHAPE_ISOMETRIC
	test_tileset.tile_layout = TileSet.TILE_LAYOUT_DIAMOND_DOWN
	test_tileset.tile_offset_axis = TileSet.TILE_OFFSET_AXIS_VERTICAL
	test_tileset.tile_size = Vector2i(256, 128)
	# Asssign the test tileset to the map
	test_map.tile_set = test_tileset
	# Add the test map to the scene
	add_child_autofree(test_map)
	# Process frame to create the map
	await get_tree().process_frame
	# ================================================================


	# Assert value of (0, 18) placement grid point (invalid point)
	# (0, 18) should be invalid because impediment points fall outside left border of the map
	assert_false(test_map.can_place_tower(Vector2i(0, 18)), "Tile placement at (0, 18) should be false")
	# Assert value of (1, 19) placement grid point (invalid point)
	# (1, 19) should be invalid because impediment points fall outside bottom border of the map
	assert_false(test_map.can_place_tower(Vector2i(1, 19)), "Tile placement at (1, 19) should be false")
	# Assert value of (1, 18) placement grid point (valid point)
	assert_true(test_map.can_place_tower(Vector2i(1, 18)), "Tile placement at (1, 18) should be true")

	# Clean up
	test_map.queue_free()

func test_can_place_tower_bottom_right_corner():
	# ================================================================
	#					 ** CREATE BLANK MAP **
	# ================================================================
	var test_map: GameMap = GameMap.new()
	# LINE_TD is used because it has no mandatory path stops
	test_map.MAP_ID = MapConstants.MapID.LINE_TD
	# Set the map's size to 10x10
	test_map.MAP_HEIGHT = 10
	test_map.MAP_WIDTH = 10
    # Ensure start and end points don't interfere with placement validity
	test_map.__path_start_point = Vector2i(10, 9)
	test_map.__path_end_point = Vector2i(10, 12)
	# Create test tileset
	var test_tileset = TileSet.new()
	test_tileset.tile_shape = TileSet.TILE_SHAPE_ISOMETRIC
	test_tileset.tile_layout = TileSet.TILE_LAYOUT_DIAMOND_DOWN
	test_tileset.tile_offset_axis = TileSet.TILE_OFFSET_AXIS_VERTICAL
	test_tileset.tile_size = Vector2i(256, 128)
	# Asssign the test tileset to the map
	test_map.tile_set = test_tileset
	# Add the test map to the scene
	add_child_autofree(test_map)
	# Process frame to create the map
	await get_tree().process_frame
	# ================================================================


	# Assert value of (20, 18) placement grid point (invalid point)
	# (20, 18) should be invalid because impediment points fall outside right border of the map
	assert_false(test_map.can_place_tower(Vector2i(20, 18)), "Tile placement at (20, 18) should be false")
	# Assert value of (19, 19) placement grid point (invalid point)
	# (19, 19) should be invalid because impediment points fall outside bottom border of the map
	assert_false(test_map.can_place_tower(Vector2i(19, 19)), "Tile placement at (19, 19) should be false")
	# Assert value of (19, 18) placement grid point (valid point)
	assert_true(test_map.can_place_tower(Vector2i(19, 18)), "Tile placement at (19, 18) should be true")

	# Clean up
	test_map.queue_free()