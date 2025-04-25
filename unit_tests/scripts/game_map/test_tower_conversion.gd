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

	
func test_convert_tower_to_barricade():
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

	# Ensure tower and barricade lists are empty
	assert_eq(test_map.__towers_on_map, [])
	assert_eq(test_map.__barricades_on_map, [])

	# Place non-barricade tower
	var test_placement_grid_coord: Vector2i = Vector2i(20, 20)
	test_map.set_build_tower_preload(TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_1])
	test_map.place_tower(test_placement_grid_coord)

	# Ensure tower was properly placed.
	assert_eq(len(test_map.__towers_on_map), 1)
	assert_true(test_map.__towers_on_map[0] is Tower)
	var test_built_tower: Tower = test_map.__towers_on_map[0]
	assert_eq(test_built_tower.TOWER_ID, TowerConstants.TowerIDs.BISMUTH_LVL_1)
	assert_eq(test_map.__barricades_on_map, [])

	# Convert tower to barricade
	test_map.convert_tower_to_barricade(test_built_tower)

	# Ensure barricade is in list
	assert_eq(len(test_map.__barricades_on_map), 1)
	assert_true(test_map.__barricades_on_map[0] is Tower)
	var test_converted_barricade: Tower = test_map.__barricades_on_map[0]
	assert_eq(test_map.__towers_on_map, [])
	assert_eq(test_converted_barricade.TOWER_ID, TowerConstants.TowerIDs.BARRICADE)

	# Clean up
	test_map.queue_free()
