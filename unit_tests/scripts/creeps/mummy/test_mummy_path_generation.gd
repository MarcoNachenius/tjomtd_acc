extends GutTest 

func before_each():
	# Ensure previous nodes are fully freed.
	await get_tree().process_frame

## Creating a blank map and processing the frame should create the map is important for 
## creating a test object to run the rest of the tests in this file.
func test_create_blank_map():
	# ================================================================
	#                     ** CREATE BLANK MAP **
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
	await  get_tree().process_frame


# Mummies are able to crawl over barricades when normal creeps are not.
func test_path_generation_with_barricade():
	# ===========
	# TEST VALUES
	# ===========
	const TST_START_POINT := Vector2i(0, 0)
	const TST_END_POINT := Vector2i(19, 19)
	const TST_EXPECTED_MUMMY_PATH: Array[Vector2i] = [TST_START_POINT, TST_END_POINT]
	const TST_BARRICADE_POSITION := Vector2i(10, 9)

	# ================================================================
	#                     ** CREATE BLANK MAP **
	# ================================================================
	var test_map = GameMap.new()
	# LINE_TD is used because it has no mandatory path stops
	test_map.MAP_ID = MapConstants.MapID.LINE_TD
	test_map.MAP_HEIGHT = 10
	test_map.MAP_WIDTH = 10
	# Ensure start and end points don't interfere with placement validity
	test_map.__path_start_point = TST_START_POINT
	test_map.__path_end_point = TST_END_POINT
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

	# Verify inintial path
	assert_eq(test_map.__curr_path, TST_EXPECTED_MUMMY_PATH)
	var initial_creep_path_pixel_map: Array[Vector2i] = test_map.creep_mapped_to_local_path_positions(CreepConstants.CreepIDs.DEMON)
	test_map.place_barricade(TST_BARRICADE_POSITION, true)
	
	# Essure that path changes for normal creeps, but not for Mummy creeps
	assert_ne(test_map.creep_mapped_to_local_path_positions(CreepConstants.CreepIDs.DEMON), initial_creep_path_pixel_map)
	assert_eq(test_map.creep_mapped_to_local_path_positions(CreepConstants.CreepIDs.MUMMY), initial_creep_path_pixel_map)

	# Clean up
	test_map.queue_free()
	await  get_tree().process_frame


func test_path_generation_with_built_tower():
	# ===========
	# TEST VALUES
	# ===========
	const TST_START_POINT := Vector2i(0, 0)
	const TST_END_POINT := Vector2i(19, 19)
	const TST_EXPECTED_MUMMY_PATH: Array[Vector2i] = [TST_START_POINT, TST_END_POINT]
	const TST_TOWER_POSITION := Vector2i(10, 9)
	const TST_TOWER_ID: TowerConstants.TowerIDs = TowerConstants.TowerIDs.BISMUTH_LVL_2

	# ================================================================
	#                     ** CREATE BLANK MAP **
	# ================================================================
	var test_map = GameMap.new()
	# LINE_TD is used because it has no mandatory path stops
	test_map.MAP_ID = MapConstants.MapID.LINE_TD
	test_map.MAP_HEIGHT = 10
	test_map.MAP_WIDTH = 10
	# Ensure start and end points don't interfere with placement validity
	test_map.__path_start_point = TST_START_POINT
	test_map.__path_end_point = TST_END_POINT
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

	# Verify inintial path
	assert_eq(test_map.__curr_path, TST_EXPECTED_MUMMY_PATH)
	var initial_creep_path_pixel_map: Array[Vector2i] = test_map.creep_mapped_to_local_path_positions(CreepConstants.CreepIDs.DEMON)
	test_map.place_built_tower(TST_TOWER_POSITION, TST_TOWER_ID)
	
	# Essure that path changes for Mummy creeps
	assert_ne(test_map.creep_mapped_to_local_path_positions(CreepConstants.CreepIDs.MUMMY), initial_creep_path_pixel_map)

	# Clean up
	test_map.queue_free()
	await  get_tree().process_frame


func test_path_generation_with_tower_awaiting_selection():
	# ===========
	# TEST VALUES
	# ===========
	const TST_START_POINT := Vector2i(0, 0)
	const TST_END_POINT := Vector2i(19, 19)
	const TST_EXPECTED_MUMMY_PATH: Array[Vector2i] = [TST_START_POINT, TST_END_POINT]
	const TST_TOWER_POSITION := Vector2i(10, 9)
	const TST_TOWER_ID: TowerConstants.TowerIDs = TowerConstants.TowerIDs.BISMUTH_LVL_2

	# ================================================================
	#                     ** CREATE BLANK MAP **
	# ================================================================
	var test_map = GameMap.new()
	# LINE_TD is used because it has no mandatory path stops
	test_map.MAP_ID = MapConstants.MapID.LINE_TD
	test_map.MAP_HEIGHT = 10
	test_map.MAP_WIDTH = 10
	# Ensure start and end points don't interfere with placement validity
	test_map.__path_start_point = TST_START_POINT
	test_map.__path_end_point = TST_END_POINT
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

	# Verify inintial path
	assert_eq(test_map.__curr_path, TST_EXPECTED_MUMMY_PATH)
	var initial_creep_path_pixel_map: Array[Vector2i] = test_map.creep_mapped_to_local_path_positions(CreepConstants.CreepIDs.DEMON)
	test_map.__build_tower_preload = TowerConstants.ALL_TOWER_LOADS[TST_TOWER_ID]
	test_map.place_tower(TST_TOWER_POSITION)
	
	# Essure that path changes for Mummy creeps
	assert_ne(test_map.creep_mapped_to_local_path_positions(CreepConstants.CreepIDs.MUMMY), initial_creep_path_pixel_map)

	# Clean up
	test_map.queue_free()
	await  get_tree().process_frame