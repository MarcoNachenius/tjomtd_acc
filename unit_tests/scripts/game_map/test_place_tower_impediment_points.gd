extends GutTest 

func before_each():
	# Ensure previous nodes are fully freed.
	await get_tree().process_frame

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


func test_place_tower_in_valid_position():
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

	# Test objects
	var placement_grid_point = Vector2i(10, 10)
	var main_grid_impediment_points: Array[Vector2i] = [Vector2i(9, 10), Vector2i(10, 10), Vector2i(9, 11), Vector2i(10, 11)]

	# Ensure main grid impediment points are correct
	assert_eq(test_map.get_tower_impediment_points(placement_grid_point), main_grid_impediment_points, "Main grid impediment points are correct")
	# Ensure tower can be placed in valid position
	assert_true(test_map.can_place_tower(placement_grid_point), "Tower can be placed in valid position")

	# Place tower impediments
	test_map.place_tower_impediment_points(placement_grid_point)

	# Assert tower can no longer be placed in the placement grid point
	assert_false(test_map.can_place_tower(placement_grid_point), "Tower can no longer be placed in the placement grid point")
	# Assert tower may not be placed in the added main grid impediments as they have already in the map's impediments
	assert_false(test_map.can_place_tower(main_grid_impediment_points[0]), "Tower cannot be added to placement grid point (9, 10)")
	assert_false(test_map.can_place_tower(main_grid_impediment_points[1]), "Tower cannot be added to placement grid point (10, 10)")
	assert_false(test_map.can_place_tower(main_grid_impediment_points[2]), "Tower cannot be added to placement grid point (9, 11)")
	assert_false(test_map.can_place_tower(main_grid_impediment_points[3]), "Tower cannot be added to placement grid point (10, 11)")

	# Assert tower impediment points have been added to map impediment points
	assert_true(test_map.__path_impediments.has(main_grid_impediment_points[0]), "Impediment points contain placement grid point (9, 10)")
	assert_true(test_map.__path_impediments.has(main_grid_impediment_points[1]), "Impediment points contain placement grid point (10, 10)")
	assert_true(test_map.__path_impediments.has(main_grid_impediment_points[2]), "Impediment points contain placement grid point (9, 11)")
	assert_true(test_map.__path_impediments.has(main_grid_impediment_points[3]), "Impediment points contain placement grid point (10, 11)")


## Test a situation where the path start point is blocked by two tower impediment placements
func test_path_start_blockage():
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

	# Test objects
	# ----------------------------
	# pgp = 'placement grid point'
	# ----------------------------
	var pgp_1 = Vector2i(3, 0)
	var pgp_1_path_impediments: Array[Vector2i] = [Vector2i(2, 0), Vector2i(3, 0), Vector2i(2, 1), Vector2i(3, 1)]
	var pgp_2 = Vector2i(1, 2)
	var pgp_2_path_impediments: Array[Vector2i] = [Vector2i(0, 2), Vector2i(1, 2), Vector2i(0, 3), Vector2i(1, 3)]

	# PGP 1 PLACEMENT 
	# ---------------
	# Ensure pgp_1 main grid impediment points hev been correctly calculated
	assert_eq(test_map.get_tower_impediment_points(pgp_1), pgp_1_path_impediments, "Main grid impediment points are correct")
	# Ensure tower can be placed in pgp_1 (should be valid at this point because the path start point has not been blocked yet)
	assert_true(test_map.can_place_tower(pgp_1), "Tower can be placed in valid position")
	# Place tower impediments
	test_map.place_tower_impediment_points(pgp_1)
	# Assert tower can no longer be placed in the placement grid point
	assert_false(test_map.can_place_tower(pgp_1), "Tower can no longer be placed in the placement grid point")
	# Assert tower impediment points have been added to map impediment points
	assert_true(test_map.__path_impediments.has(pgp_1_path_impediments[0]), "Impediment points contain placement grid point (2, 0)")
	assert_true(test_map.__path_impediments.has(pgp_1_path_impediments[1]), "Impediment points contain placement grid point (3, 0)")
	assert_true(test_map.__path_impediments.has(pgp_1_path_impediments[2]), "Impediment points contain placement grid point (2, 1)")
	assert_true(test_map.__path_impediments.has(pgp_1_path_impediments[3]), "Impediment points contain placement grid point (3, 1)")
	# Assert tower may not be placed in the added main grid impediments as they have already in the map's impediments
	assert_false(test_map.can_place_tower(pgp_1_path_impediments[0]), "Tower cannot be added to placement grid point (2, 0)")
	assert_false(test_map.can_place_tower(pgp_1_path_impediments[1]), "Tower cannot be added to placement grid point (3, 0)")
	assert_false(test_map.can_place_tower(pgp_1_path_impediments[2]), "Tower cannot be added to placement grid point (2, 1)")
	assert_false(test_map.can_place_tower(pgp_1_path_impediments[3]), "Tower cannot be added to placement grid point (3, 1)")

	# PGP 2 PLACEMENT 
	# ---------------
	# Ensure pgp_2 main grid impediment points hev been correctly calculated
	assert_eq(test_map.get_tower_impediment_points(pgp_2), pgp_2_path_impediments, "Main grid impediment points are correct")
	# Ensure tower can be placed in pgp_2 (should be valid at this point because the path start point has not been blocked yet)
	assert_false(test_map.can_place_tower(pgp_2), "Tower should not be placeable in this position because it blocks the path start point")
	# Place tower impediments
	test_map.place_tower_impediment_points(pgp_2)
	# Assert tower can no longer be placed in the placement grid point
	assert_false(test_map.can_place_tower(pgp_2), "Tower can no longer be placed in the placement grid point")
	# Assert tower impediment points have been added to map impediment points
	assert_true(test_map.__path_impediments.has(pgp_2_path_impediments[0]), "Impediment points contain placement grid point (0, 2)")
	assert_true(test_map.__path_impediments.has(pgp_2_path_impediments[1]), "Impediment points contain placement grid point (1, 2)")
	assert_true(test_map.__path_impediments.has(pgp_2_path_impediments[2]), "Impediment points contain placement grid point (0, 3)")
	assert_true(test_map.__path_impediments.has(pgp_2_path_impediments[3]), "Impediment points contain placement grid point (1, 3)")
	# Assert tower may not be placed in the added main grid impediments as they have already in the map's impediments
	assert_false(test_map.can_place_tower(pgp_2_path_impediments[0]), "Tower cannot be added to placement grid point (0, 2)")
	assert_false(test_map.can_place_tower(pgp_2_path_impediments[1]), "Tower cannot be added to placement grid point (1, 2)")
	assert_false(test_map.can_place_tower(pgp_2_path_impediments[2]), "Tower cannot be added to placement grid point (0, 3)")
	assert_false(test_map.can_place_tower(pgp_2_path_impediments[3]), "Tower cannot be added to placement grid point (1, 3)")

	# TEST PATH START POINT BLOCKAGE
	# ------------------------------
	# Assert tower can no longer be placed in the path start point
	assert_eq(test_map.__curr_path, [], "Path start point is blocked")