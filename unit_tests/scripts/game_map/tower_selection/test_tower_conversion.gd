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
	assert_eq(test_map.__towers_awaiting_selection, [])
	assert_eq(test_map.__barricades_on_map, [])

	# Place non-barricade tower
	var test_placement_grid_coord: Vector2i = Vector2i(20, 20)
	test_map.set_build_tower_preload(TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_1])
	test_map.place_tower(test_placement_grid_coord)

	# Ensure tower was properly placed.
	assert_eq(len(test_map.__towers_awaiting_selection), 1)
	assert_true(test_map.__towers_awaiting_selection[0] is Tower)
	var test_built_tower: Tower = test_map.__towers_awaiting_selection[0]
	assert_eq(test_built_tower.TOWER_ID, TowerConstants.TowerIDs.BISMUTH_LVL_1)
	assert_eq(test_map.__barricades_on_map, [])
	assert_eq(test_map.__towers_on_map, [])

	# Convert tower to barricade
	test_map.convert_tower_to_barricade(test_built_tower)

	# Ensure barricade is in list
	assert_eq(test_map.__towers_on_map, [])
	assert_eq(len(test_map.__barricades_on_map), 1)
	assert_true(test_map.__barricades_on_map[0] is Tower)
	var test_converted_barricade: Tower = test_map.__barricades_on_map[0]
	assert_eq(test_map.__towers_awaiting_selection, [])
	assert_eq(test_converted_barricade.TOWER_ID, TowerConstants.TowerIDs.BARRICADE)

	# Clean up
	test_map.queue_free()


func test_keep_built_tower_from_towers_awaiting_selection():
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

	# Create tower loads
	var black_marble_lvl_1_preload: PackedScene = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1]
	var black_marble_lvl_2_preload: PackedScene = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2]
	var black_marble_lvl_3_preload: PackedScene = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_3]
	
	# Create test tower placement grid coordinates
	var tower_1_placement_grid_coord: Vector2i = Vector2i(10, 0)
	var tower_2_placement_grid_coord: Vector2i = Vector2i(10, 2)
	var tower_3_placement_grid_coord: Vector2i = Vector2i(10, 4)

	# Place 3 towers
	test_map.set_build_tower_preload(black_marble_lvl_1_preload)
	test_map.place_tower(tower_1_placement_grid_coord)
	test_map.set_build_tower_preload(black_marble_lvl_2_preload)
	test_map.place_tower(tower_2_placement_grid_coord)
	test_map.set_build_tower_preload(black_marble_lvl_3_preload)
	test_map.place_tower(tower_3_placement_grid_coord)


	# Ensure towers were properly added the correct list
	assert_eq(len(test_map.__towers_awaiting_selection), 3)

	# Simulate pressing the keep tower button
	var tower_to_keep: Tower = test_map.__towers_awaiting_selection[1]

	# Simulate keeping the tower
	test_map.keep_built_tower_awaiting_selection(tower_to_keep)

	# Ensure the tower is in the towers on map list
	assert_eq(len(test_map.__towers_on_map), 1)
	assert_eq(test_map.__towers_on_map[0].TOWER_ID, TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2)
	# Ensure the selected tower's placement grid coordinates are the same as the original
	assert_eq(tower_to_keep.get_placement_grid_coordinate(), tower_2_placement_grid_coord)


	# Ensure the rest of the towers have been converted to barricades
	assert_eq(len(test_map.__barricades_on_map), 2)
	# Test barricade 1 placement grid coordinates
	assert_eq(test_map.__barricades_on_map[0].get_placement_grid_coordinate(), tower_1_placement_grid_coord)
	# Test barricade 2 placement grid coordinates
	assert_eq(test_map.__barricades_on_map[1].get_placement_grid_coordinate(), tower_3_placement_grid_coord)

	# Clean up
	test_map.queue_free()

func test_keep_upgrade_tower_from_towers_awaiting_selection():
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

	# Create tower loads
	var black_marble_lvl_1_preload: PackedScene = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1]
	var black_marble_lvl_2_preload: PackedScene = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2]
	var black_marble_lvl_3_preload: PackedScene = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_3]
	
	# Create test tower placement grid coordinates
	var tower_1_placement_grid_coord: Vector2i = Vector2i(10, 0)
	var tower_2_placement_grid_coord: Vector2i = Vector2i(10, 2)
	var tower_3_placement_grid_coord: Vector2i = Vector2i(10, 4)

	# Place 3 towers
	test_map.set_build_tower_preload(black_marble_lvl_1_preload)
	test_map.place_tower(tower_1_placement_grid_coord)
	test_map.set_build_tower_preload(black_marble_lvl_2_preload)
	test_map.place_tower(tower_2_placement_grid_coord)
	test_map.set_build_tower_preload(black_marble_lvl_3_preload)
	test_map.place_tower(tower_3_placement_grid_coord)


	# Ensure towers were properly added the correct list
	assert_eq(len(test_map.__towers_awaiting_selection), 3)

	# Simulate pressing the keep tower button
	var tower_to_keep: Tower = test_map.__towers_awaiting_selection[1]

	# Simulate keeping the tower
	test_map.keep_upgrade_tower_from_towers_awaiting_selection(tower_to_keep, TowerConstants.UpgradeTowerIDs.TOMBSTONE_LVL_1)

	# Ensure the tower is in the towers on map list
	assert_eq(len(test_map.__towers_on_map), 1)
	assert_eq(test_map.__towers_on_map[0].TOWER_ID, TowerConstants.TowerIDs.TOMBSTONE_LVL_1)
	# Ensure the selected tower's placement grid coordinates are the same as the original
	assert_eq(tower_to_keep.get_placement_grid_coordinate(), tower_2_placement_grid_coord)


	# Ensure the rest of the towers have been converted to barricades
	assert_eq(len(test_map.__barricades_on_map), 2)
	# Test barricade 1 placement grid coordinates
	assert_eq(test_map.__barricades_on_map[0].get_placement_grid_coordinate(), tower_1_placement_grid_coord)
	# Test barricade 2 placement grid coordinates
	assert_eq(test_map.__barricades_on_map[1].get_placement_grid_coordinate(), tower_3_placement_grid_coord)

	# Clean up
	test_map.queue_free()


func test_upgrade_from_towers_on_map():
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

	# Create tower loads
	var black_marble_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()
	var bismuth_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_1].instantiate()
	var larimar_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.LARIMAR_LVL_1].instantiate()
	
	# Create test tower placement grid coordinates
	var tower_1_placement_grid_coord: Vector2i = Vector2i(10, 0)
	var tower_2_placement_grid_coord: Vector2i = Vector2i(10, 2)
	var tower_3_placement_grid_coord: Vector2i = Vector2i(10, 4)

	# Place towers that are required for upgrade tower on map
	# Black Marble level 1
	test_map.add_child(black_marble_lvl_1)
	black_marble_lvl_1.set_placement_grid_coordinate(tower_1_placement_grid_coord)
	black_marble_lvl_1.switch_state(Tower.States.BUILT)
	# Bismuth level 1
	test_map.add_child(bismuth_lvl_1)
	bismuth_lvl_1.set_placement_grid_coordinate(tower_2_placement_grid_coord)
	bismuth_lvl_1.switch_state(Tower.States.BUILT)
	# Larimar level 1
	test_map.add_child(larimar_lvl_1)
	larimar_lvl_1.set_placement_grid_coordinate(tower_3_placement_grid_coord)
	larimar_lvl_1.switch_state(Tower.States.BUILT)

	# Simulate game map having 3 tower on map
	test_map.__towers_on_map.append(black_marble_lvl_1)
	test_map.__towers_on_map.append(bismuth_lvl_1)
	test_map.__towers_on_map.append(larimar_lvl_1)

	# Add mock tower impediments to the map dict
	test_map._add_tower_to_placement_grid_coords_dict(black_marble_lvl_1, test_map.__placement_grid_coords_for_towers)
	test_map._add_tower_to_placement_grid_coords_dict(bismuth_lvl_1, test_map.__placement_grid_coords_for_towers)
	test_map._add_tower_to_placement_grid_coords_dict(larimar_lvl_1, test_map.__placement_grid_coords_for_towers)

	# Simulate selecting larimar tower
	var test_selected_tower: Tower = larimar_lvl_1

	# Simulate keeping the tower
	test_map.upgrade_from_towers_on_map(test_selected_tower, TowerConstants.UpgradeTowerIDs.TOMBSTONE_LVL_1)

	# Ensure the tower is in the towers on map list
	assert_eq(len(test_map.__towers_on_map), 1)
	assert_eq(test_map.__towers_on_map[0].TOWER_ID, TowerConstants.TowerIDs.TOMBSTONE_LVL_1)
	# Ensure the selected tower's placement grid coordinates are the same as the original
	assert_eq(test_selected_tower.get_placement_grid_coordinate(), tower_3_placement_grid_coord)


	# Ensure the rest of the towers have been converted to barricades
	assert_eq(len(test_map.__barricades_on_map), 2)
	# Test barricade 1 placement grid coordinates
	assert_eq(test_map.__barricades_on_map[0].get_placement_grid_coordinate(), tower_1_placement_grid_coord)
	# Test barricade 2 placement grid coordinates
	assert_eq(test_map.__barricades_on_map[1].get_placement_grid_coordinate(), tower_2_placement_grid_coord)

	# Clean up
	test_map.queue_free()


func test_extended_upgrade_map():
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

	# Create tower loads
	var black_marble_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()
	var bismuth_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_1].instantiate()
	var larimar_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.LARIMAR_LVL_1].instantiate()
	
	# Create test tower placement grid coordinates
	var tower_1_placement_grid_coord: Vector2i = Vector2i(10, 0)
	var tower_2_placement_grid_coord: Vector2i = Vector2i(10, 2)
	var tower_3_placement_grid_coord: Vector2i = Vector2i(10, 4)

	# Place towers that are required for upgrade tower on map
	# Black Marble level 1
	test_map.add_child(black_marble_lvl_1)
	black_marble_lvl_1.set_placement_grid_coordinate(tower_1_placement_grid_coord)
	black_marble_lvl_1.switch_state(Tower.States.BUILT)
	# Bismuth level 1
	test_map.add_child(bismuth_lvl_1)
	bismuth_lvl_1.set_placement_grid_coordinate(tower_2_placement_grid_coord)
	bismuth_lvl_1.switch_state(Tower.States.BUILT)
	# Larimar level 1
	test_map.add_child(larimar_lvl_1)
	larimar_lvl_1.set_placement_grid_coordinate(tower_3_placement_grid_coord)
	larimar_lvl_1.switch_state(Tower.States.BUILT)

	# Simulate game map having 3 tower on map
	test_map.__towers_on_map.append(black_marble_lvl_1)
	test_map.__towers_on_map.append(bismuth_lvl_1)
	test_map.__towers_on_map.append(larimar_lvl_1)

	# Add mock tower impediments to the map dict
	test_map._add_tower_to_placement_grid_coords_dict(black_marble_lvl_1, test_map.__placement_grid_coords_for_towers)
	test_map._add_tower_to_placement_grid_coords_dict(bismuth_lvl_1, test_map.__placement_grid_coords_for_towers)
	test_map._add_tower_to_placement_grid_coords_dict(larimar_lvl_1, test_map.__placement_grid_coords_for_towers)

	# Simulate selecting larimar tower
	var test_selected_tower: Tower = larimar_lvl_1

	# Simulate keeping the tower
	test_map.upgrade_from_towers_on_map(test_selected_tower, TowerConstants.UpgradeTowerIDs.TOMBSTONE_LVL_1)

	test_map.upgrade_tower(test_map.__towers_on_map[0], TowerConstants.UpgradeTowerIDs.TOMBSTONE_LVL_2)

	# Ensure the tower is in the towers on map list
	assert_eq(len(test_map.__towers_on_map), 1)
	assert_eq(test_map.__towers_on_map[0].TOWER_ID, TowerConstants.TowerIDs.TOMBSTONE_LVL_2)
	# Ensure the selected tower's placement grid coordinates are the same as the original
	assert_eq(test_selected_tower.get_placement_grid_coordinate(), tower_3_placement_grid_coord)

	# Clean up
	test_map.queue_free()
