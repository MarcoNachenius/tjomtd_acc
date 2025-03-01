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
	# Set the map's path start and end points
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

func test_get_tower_impediment_points_top_left_corner():
	# ================================================================
	#					 ** CREATE BLANK MAP **
	# ================================================================
	var test_map: GameMap = GameMap.new()
	# LINE_TD is used because it has no mandatory path stops
	test_map.MAP_ID = MapConstants.MapID.LINE_TD
	# Set the map's size to 10x10
	test_map.MAP_HEIGHT = 10
	test_map.MAP_WIDTH = 10
	# Set the map's path start and end points
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

	# Assert value of (0, 0) placement grid point (invalid point: impediment points fall outside left border of the map)
	var test_placement_grid_point = Vector2i(0, 0)
	var top_left_main_tileset_point = Vector2i(-1, 0)
	var top_right_main_tileset_point = Vector2i(0, 0)
	var bottom_right_main_tileset_point = Vector2i(0, 1)
	var bottom_left_main_tileset_point = Vector2i(-1, 1)
	# Get impediment points
	var impediment_points = test_map.get_tower_impediment_points(test_placement_grid_point)
	
	# Perform tests
	assert_eq(test_map.get_tower_impediment_points(test_placement_grid_point).size(), 4, "There should be 4 points in the array")
	assert_true(impediment_points.has(top_left_main_tileset_point), "Top left main tileset point should be in the array")
	assert_true(impediment_points.has(top_right_main_tileset_point), "Top right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_right_main_tileset_point), "Bottom right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_left_main_tileset_point), "Bottom left main tileset point should be in the array")

	# Assert value of (0, 1) placement grid point (invalid point: impediment points fall outside left border of the map)
	test_placement_grid_point = Vector2i(0, 1)
	top_left_main_tileset_point = Vector2i(-1, 1)
	top_right_main_tileset_point = Vector2i(0, 1)
	bottom_right_main_tileset_point = Vector2i(0, 2)
	bottom_left_main_tileset_point = Vector2i(-1, 2)
	# Get impediment points
	impediment_points = test_map.get_tower_impediment_points(test_placement_grid_point)
	
	# Perform tests
	assert_eq(test_map.get_tower_impediment_points(test_placement_grid_point).size(), 4, "There should be 4 points in the array")
	assert_true(impediment_points.has(top_left_main_tileset_point), "Top left main tileset point should be in the array")
	assert_true(impediment_points.has(top_right_main_tileset_point), "Top right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_right_main_tileset_point), "Bottom right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_left_main_tileset_point), "Bottom left main tileset point should be in the array")

	# Assert value of (1, -1) placement grid point (invalid point: impediment points fall outside top border of the map)
	test_placement_grid_point = Vector2i(1, -1)
	top_left_main_tileset_point = Vector2i(0, -1)
	top_right_main_tileset_point = Vector2i(1, -1)
	bottom_right_main_tileset_point = Vector2i(1, 0)
	bottom_left_main_tileset_point = Vector2i(0, 0)
	# Get impediment points
	impediment_points = test_map.get_tower_impediment_points(test_placement_grid_point)
	
	# Perform tests
	assert_eq(test_map.get_tower_impediment_points(test_placement_grid_point).size(), 4, "There should be 4 points in the array")
	assert_true(impediment_points.has(top_left_main_tileset_point), "Top left main tileset point should be in the array")
	assert_true(impediment_points.has(top_right_main_tileset_point), "Top right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_right_main_tileset_point), "Bottom right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_left_main_tileset_point), "Bottom left main tileset point should be in the array")
	
	# Assert value of (1, 0) placement grid point (valid point)
	test_placement_grid_point = Vector2i(1, 0)
	top_left_main_tileset_point = Vector2i(0, 0)
	top_right_main_tileset_point = Vector2i(1, 0)
	bottom_right_main_tileset_point = Vector2i(1, 1)
	bottom_left_main_tileset_point = Vector2i(0, 1)
	# Get impediment points
	impediment_points = test_map.get_tower_impediment_points(test_placement_grid_point)
	
	# Perform tests
	assert_eq(test_map.get_tower_impediment_points(test_placement_grid_point).size(), 4, "There should be 4 points in the array")
	assert_true(impediment_points.has(top_left_main_tileset_point), "Top left main tileset point should be in the array")
	assert_true(impediment_points.has(top_right_main_tileset_point), "Top right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_right_main_tileset_point), "Bottom right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_left_main_tileset_point), "Bottom left main tileset point should be in the array")

	# Clean up
	test_map.queue_free()

func test_get_tower_impediment_points_top_right_corner():
	# ================================================================
	#					 ** CREATE BLANK MAP **
	# ================================================================
	var test_map: GameMap = GameMap.new()
	# LINE_TD is used because it has no mandatory path stops
	test_map.MAP_ID = MapConstants.MapID.LINE_TD
	# Set the map's size to 10x10
	test_map.MAP_HEIGHT = 10
	test_map.MAP_WIDTH = 10
	# Set the map's path start and end points
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

	# Assert value of (19, 0) placement grid point (valid point)
	var test_placement_grid_point = Vector2i(19, 0)
	var top_left_main_tileset_point = Vector2i(18, 0)
	var top_right_main_tileset_point = Vector2i(19, 0)
	var bottom_right_main_tileset_point = Vector2i(19, 1)
	var bottom_left_main_tileset_point = Vector2i(18, 1)
	# Get impediment points
	var impediment_points = test_map.get_tower_impediment_points(test_placement_grid_point)
	
	# Perform tests
	assert_eq(test_map.get_tower_impediment_points(test_placement_grid_point).size(), 4, "There should be 4 points in the array")
	assert_true(impediment_points.has(top_left_main_tileset_point), "Top left main tileset point should be in the array")
	assert_true(impediment_points.has(top_right_main_tileset_point), "Top right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_right_main_tileset_point), "Bottom right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_left_main_tileset_point), "Bottom left main tileset point should be in the array")

	# Assert value of (20, 0) placement grid point (invalid point: impediment points fall outside right border of the map)
	test_placement_grid_point = Vector2i(20, 1)
	top_left_main_tileset_point = Vector2i(19, 1)
	top_right_main_tileset_point = Vector2i(20, 1)
	bottom_right_main_tileset_point = Vector2i(20, 2)
	bottom_left_main_tileset_point = Vector2i(19, 2)
	# Get impediment points
	impediment_points = test_map.get_tower_impediment_points(test_placement_grid_point)
	
	# Perform tests
	assert_eq(test_map.get_tower_impediment_points(test_placement_grid_point).size(), 4, "There should be 4 points in the array")
	assert_true(impediment_points.has(top_left_main_tileset_point), "Top left main tileset point should be in the array")
	assert_true(impediment_points.has(top_right_main_tileset_point), "Top right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_right_main_tileset_point), "Bottom right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_left_main_tileset_point), "Bottom left main tileset point should be in the array")

	# Assert value of (19, -1) placement grid point (invalid point: impediment points fall outside top border of the map)
	test_placement_grid_point = Vector2i(19, -1)
	top_left_main_tileset_point = Vector2i(18, -1)
	top_right_main_tileset_point = Vector2i(19, -1)
	bottom_right_main_tileset_point = Vector2i(19, 0)
	bottom_left_main_tileset_point = Vector2i(18, 0)
	# Get impediment points
	impediment_points = test_map.get_tower_impediment_points(test_placement_grid_point)
	
	# Perform tests
	assert_eq(test_map.get_tower_impediment_points(test_placement_grid_point).size(), 4, "There should be 4 points in the array")
	assert_true(impediment_points.has(top_left_main_tileset_point), "Top left main tileset point should be in the array")
	assert_true(impediment_points.has(top_right_main_tileset_point), "Top right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_right_main_tileset_point), "Bottom right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_left_main_tileset_point), "Bottom left main tileset point should be in the array")

	# Clean up
	test_map.queue_free()

func test_get_tower_impediment_points_bottom_left_corner():
	# ================================================================
	#					 ** CREATE BLANK MAP **
	# ================================================================
	var test_map: GameMap = GameMap.new()
	# LINE_TD is used because it has no mandatory path stops
	test_map.MAP_ID = MapConstants.MapID.LINE_TD
	# Set the map's size to 10x10
	test_map.MAP_HEIGHT = 10
	test_map.MAP_WIDTH = 10
	# Set the map's path start and end points
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

	# Assert value of (1, 18) placement grid point (valid point)
	var test_placement_grid_point = Vector2i(1, 18)
	var top_left_main_tileset_point = Vector2i(0, 18)
	var top_right_main_tileset_point = Vector2i(1, 18)
	var bottom_right_main_tileset_point = Vector2i(1, 19)
	var bottom_left_main_tileset_point = Vector2i(0, 19)
	# Get impediment points
	var impediment_points = test_map.get_tower_impediment_points(test_placement_grid_point)
	
	# Perform tests
	assert_eq(test_map.get_tower_impediment_points(test_placement_grid_point).size(), 4, "There should be 4 points in the array")
	assert_true(impediment_points.has(top_left_main_tileset_point), "Top left main tileset point should be in the array")
	assert_true(impediment_points.has(top_right_main_tileset_point), "Top right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_right_main_tileset_point), "Bottom right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_left_main_tileset_point), "Bottom left main tileset point should be in the array")

	# Assert value of (0, 18) placement grid point (invalid point: impediment points fall outside left border of the map)
	test_placement_grid_point = Vector2i(0, 18)
	top_left_main_tileset_point = Vector2i(-1, 18)
	top_right_main_tileset_point = Vector2i(0, 18)
	bottom_right_main_tileset_point = Vector2i(0, 19)
	bottom_left_main_tileset_point = Vector2i(-1, 19)
	# Get impediment points
	impediment_points = test_map.get_tower_impediment_points(test_placement_grid_point)
	
	# Perform tests
	assert_eq(test_map.get_tower_impediment_points(test_placement_grid_point).size(), 4, "There should be 4 points in the array")
	assert_true(impediment_points.has(top_left_main_tileset_point), "Top left main tileset point should be in the array")
	assert_true(impediment_points.has(top_right_main_tileset_point), "Top right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_right_main_tileset_point), "Bottom right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_left_main_tileset_point), "Bottom left main tileset point should be in the array")

	# Assert value of (1, 19) placement grid point (invalid point: impediment points fall outside bottom border of the map)
	test_placement_grid_point = Vector2i(1, 19)
	top_left_main_tileset_point = Vector2i(0, 19)
	top_right_main_tileset_point = Vector2i(1, 19)
	bottom_right_main_tileset_point = Vector2i(1, 20)
	bottom_left_main_tileset_point = Vector2i(0, 20)
	# Get impediment points
	impediment_points = test_map.get_tower_impediment_points(test_placement_grid_point)
	
	# Perform tests
	assert_eq(test_map.get_tower_impediment_points(test_placement_grid_point).size(), 4, "There should be 4 points in the array")
	assert_true(impediment_points.has(top_left_main_tileset_point), "Top left main tileset point should be in the array")
	assert_true(impediment_points.has(top_right_main_tileset_point), "Top right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_right_main_tileset_point), "Bottom right main tileset point should be in the array")
	assert_true(impediment_points.has(bottom_left_main_tileset_point), "Bottom left main tileset point should be in the array")

	# Clean up
	test_map.queue_free()

