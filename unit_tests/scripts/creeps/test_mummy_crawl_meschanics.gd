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


# Mummies are able to crawl over obstacles. Their paths should only consist of 
# start point, mandatory stop points and end point.
func test_path_generation():
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


func test_enter_crawl_trigger_area():
	# ===========
	# TEST VALUES
	# ===========
	const TST_CREEP_WAVE_PROPERTIES: Dictionary = {
		WaveConstants.WaveProperties.CREEP_ID: CreepConstants.CreepIDs.MUMMY,
		WaveConstants.WaveProperties.CREEP_SPEED: 2,
		WaveConstants.WaveProperties.CREEP_HEALTH: 10,
		WaveConstants.WaveProperties.WAVE_SIZE: 2,
		WaveConstants.WaveProperties.SPAWN_COOLDOWN_TIME: 100.0,
		WaveConstants.WaveProperties.POINTS_FOR_DEATH: 4
	}

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
	assert_eq(test_map.creep_mapped_to_local_path_positions(CreepConstants.CreepIDs.MUMMY), initial_creep_path_pixel_map)	

	# Simulate Mummy spawn
	test_map.CREEP_SPAWNER.__wave_creep_properties = TST_CREEP_WAVE_PROPERTIES
	test_map.CREEP_SPAWNER.set_creep_preload(CreepConstants.CreepPreloads[TST_CREEP_WAVE_PROPERTIES[WaveConstants.WaveProperties.CREEP_ID]])
	test_map.CREEP_SPAWNER.__wave_size = TST_CREEP_WAVE_PROPERTIES[WaveConstants.WaveProperties.WAVE_SIZE]
	test_map.CREEP_SPAWNER._spawn_wave_creep()
	await get_tree().process_frame

	# Find spawned creep
	assert_eq(test_map.ENTITY_LAYER.get_children().size(), 2, "Two nodes have been found under ENTITY_LAYER")
	var detected_mummy: Mummy = test_map.ENTITY_LAYER.get_children()[1]
	assert_false(detected_mummy.CRAWL_ANIMATIONS.visible, "Assigned creep is Mummy")

	# Verify initial state of mummy
	assert_eq(detected_mummy.get_curr_state(), detected_mummy.States.MOVING, "Mummy was in moving state before entering crawl trigger area")

	# Simulate mummy entering crawl trigger
	detected_mummy.global_position = test_map.__placement_grid.map_to_local(TST_BARRICADE_POSITION)
	
	# Emit signal
	await  get_tree().process_frame
	# Change state
	await  get_tree().process_frame

	# Test state change to crawling when entering crawl trigger area
	assert_true(detected_mummy.get_curr_state() == detected_mummy.States.CRAWLING, "Mummy state transitioned to States.CRAWLING when entering crawl trigger area")

	# Clean up
	test_map.queue_free()
	await  get_tree().process_frame


func test_exit_crawl_trigger_area():
	# ===========
	# TEST VALUES
	# ===========
	const TST_CREEP_WAVE_PROPERTIES: Dictionary = {
		WaveConstants.WaveProperties.CREEP_ID: CreepConstants.CreepIDs.MUMMY,
		WaveConstants.WaveProperties.CREEP_SPEED: 2,
		WaveConstants.WaveProperties.CREEP_HEALTH: 10,
		WaveConstants.WaveProperties.WAVE_SIZE: 2,
		WaveConstants.WaveProperties.SPAWN_COOLDOWN_TIME: 100.0,
		WaveConstants.WaveProperties.POINTS_FOR_DEATH: 4
	}

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
	assert_eq(test_map.creep_mapped_to_local_path_positions(CreepConstants.CreepIDs.MUMMY), initial_creep_path_pixel_map)	

	# Simulate Mummy spawn
	test_map.CREEP_SPAWNER.__wave_creep_properties = TST_CREEP_WAVE_PROPERTIES
	test_map.CREEP_SPAWNER.set_creep_preload(CreepConstants.CreepPreloads[TST_CREEP_WAVE_PROPERTIES[WaveConstants.WaveProperties.CREEP_ID]])
	test_map.CREEP_SPAWNER.__wave_size = TST_CREEP_WAVE_PROPERTIES[WaveConstants.WaveProperties.WAVE_SIZE]
	test_map.CREEP_SPAWNER._spawn_wave_creep()
	await get_tree().process_frame

	# Find spawned creep
	assert_eq(test_map.ENTITY_LAYER.get_children().size(), 2, "Two nodes have been found under ENTITY_LAYER")
	var detected_mummy: Mummy = test_map.ENTITY_LAYER.get_children()[1]
	assert_false(detected_mummy.CRAWL_ANIMATIONS.visible, "Assigned creep is Mummy")

	# Verify initial state of mummy
	assert_true(detected_mummy.get_curr_state() == detected_mummy.States.MOVING, "Mummy was in moving state before entering crawl trigger area")

	# Simulate mummy entering crawl trigger
	detected_mummy.global_position = test_map.__placement_grid.map_to_local(TST_BARRICADE_POSITION)
	
	# Emit signal
	await  get_tree().process_frame
	# Change state
	await  get_tree().process_frame


	# Test state change to crawling when entering crawl trigger area
	assert_eq(detected_mummy.get_curr_state(), detected_mummy.States.CRAWLING, "Mummy state transitioned to States.CRAWLING when entering crawl trigger area")

	# Move mummy outside of crawl trigger area
	detected_mummy.global_position = test_map.__placement_grid.map_to_local(Vector2i(16, 16))

	# Emit signal
	await  get_tree().process_frame
	# Change state
	await  get_tree().process_frame

	# Test state change to crawling when entering crawl trigger area
	assert_eq(detected_mummy.get_curr_state(), detected_mummy.States.MOVING, "Mummy state transitioned to States.MOVING when exiting crawl trigger area")

	# Clean up
	test_map.queue_free()
	await  get_tree().process_frame


func test_crawl_speed_change():
	# ===========
	# TEST VALUES
	# ===========
	const TST_CREEP_WAVE_PROPERTIES: Dictionary = {
		WaveConstants.WaveProperties.CREEP_ID: CreepConstants.CreepIDs.MUMMY,
		WaveConstants.WaveProperties.CREEP_SPEED: 24,
		WaveConstants.WaveProperties.CREEP_HEALTH: 10,
		WaveConstants.WaveProperties.WAVE_SIZE: 2,
		WaveConstants.WaveProperties.SPAWN_COOLDOWN_TIME: 100.0,
		WaveConstants.WaveProperties.POINTS_FOR_DEATH: 4,
		WaveConstants.WaveProperties.CRAWL_SPEED_FACTOR: 0.75
	}

	const TST_START_POINT := Vector2i(0, 0)
	const TST_END_POINT := Vector2i(19, 19)

	# ===============
	# EXPECTED VALUES
	# ===============
	const EXPECTED_MOVING_POSITION_CHANGE: Vector2 = Vector2i(0, 12)
	const EXPECTED_CRAWLING_POSITION_CHANGE: Vector2 = Vector2i(0, 9)

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

	# Simulate Mummy spawn
	test_map.CREEP_SPAWNER.__wave_creep_properties = TST_CREEP_WAVE_PROPERTIES
	test_map.CREEP_SPAWNER.set_creep_preload(CreepConstants.CreepPreloads[TST_CREEP_WAVE_PROPERTIES[WaveConstants.WaveProperties.CREEP_ID]])
	test_map.CREEP_SPAWNER.__wave_size = TST_CREEP_WAVE_PROPERTIES[WaveConstants.WaveProperties.WAVE_SIZE]
	test_map.CREEP_SPAWNER._spawn_wave_creep()
	await get_tree().process_frame

	# Find spawned creep
	var detected_mummy: Mummy = test_map.ENTITY_LAYER.get_children()[0]
	assert_false(detected_mummy.CRAWL_ANIMATIONS.visible, "Assigned creep is Mummy")

	# Verify initial state of mummy
	assert_true(detected_mummy.get_curr_state() == detected_mummy.States.MOVING, "Mummy was in moving state before entering crawl trigger area")

	# Capture moving position change
	var starting_moving_position: Vector2 = detected_mummy.global_position
	await get_tree().process_frame
	var captured_moving_position_change: Vector2 = detected_mummy.global_position - starting_moving_position
	assert_eq(captured_moving_position_change, EXPECTED_MOVING_POSITION_CHANGE, "Mummy global position change is (0, 12) when moving")

	# Simulate mummy entering crawl trigger
	detected_mummy._switch_state(Creep.States.CRAWLING)	
	await  get_tree().process_frame

	# Capture crawling position change
	var starting_crawling_position: Vector2 = detected_mummy.global_position
	await get_tree().process_frame
	var captured_crawling_position_change: Vector2 = detected_mummy.global_position - starting_crawling_position
	assert_eq(captured_crawling_position_change, EXPECTED_CRAWLING_POSITION_CHANGE, "Mummy global position change is (0, 9) when crawling")

	# Clean up
	test_map.queue_free()
	await  get_tree().process_frame


