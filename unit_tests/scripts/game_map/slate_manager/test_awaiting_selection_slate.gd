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

func test_selected_tower_with_no_viable_options():
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

    # Generate test towers awaiting selection
    var black_marble_lvl_1: Tower = TowerConstants.ALL_TOWER_LOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()
    test_map.add_child(black_marble_lvl_1)
    await get_tree().process_frame
    var bismuth_lvl_4: Tower = TowerConstants.ALL_TOWER_LOADS[TowerConstants.TowerIDs.BISMUTH_LVL_4].instantiate()
    test_map.add_child(bismuth_lvl_4)
    await get_tree().process_frame

    # Simulate game map having towers awaiting selection
    var simulated_awaiting_selection_towers_list: Array[Tower] = [black_marble_lvl_1, bismuth_lvl_4]
    test_map.__towers_awaiting_selection = simulated_awaiting_selection_towers_list

    var selected_tower_id = black_marble_lvl_1.TOWER_ID
    var got_value: Array[SlateConstants.SlateIDs] = test_map.SLATE_MANAGER.selected_tower_awaiting_selection_slate_upgrades(selected_tower_id) 
    var expected_value: Array[SlateConstants.SlateIDs] = []

    assert_eq(got_value, expected_value)

    # Clean up
    test_map.queue_free()


func test_selected_tower_with_one_viable_option():
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

    # Generate test towers awaiting selection
    var larimar_lvl_1: Tower = TowerConstants.ALL_TOWER_LOADS[TowerConstants.TowerIDs.LARIMAR_LVL_1].instantiate()
    test_map.add_child(larimar_lvl_1)
    await get_tree().process_frame
    var larimar_lvl_2: Tower = TowerConstants.ALL_TOWER_LOADS[TowerConstants.TowerIDs.LARIMAR_LVL_2].instantiate()
    test_map.add_child(larimar_lvl_2)
    await get_tree().process_frame
    var sunstone_lvl_3: Tower = TowerConstants.ALL_TOWER_LOADS[TowerConstants.TowerIDs.SUNSTONE_LVL_3].instantiate()
    test_map.add_child(sunstone_lvl_3)
    await get_tree().process_frame

    # Simulate game map having towers awaiting selection
    var simulated_awaiting_selection_towers_list: Array[Tower] = [larimar_lvl_1, larimar_lvl_2, sunstone_lvl_3]
    test_map.__towers_awaiting_selection = simulated_awaiting_selection_towers_list

    var selected_tower_id = larimar_lvl_1.TOWER_ID
    var got_value = test_map.SLATE_MANAGER.selected_tower_awaiting_selection_slate_upgrades(selected_tower_id)
    var expected_value: Array[SlateConstants.SlateIDs] = [SlateConstants.SlateIDs.HOLD_SLATE_LVL_1]
 

    assert_eq(got_value, expected_value)

    # Clean up
    test_map.queue_free()

func test_selected_tower_with_two_viable_options():
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

    # Generate test towers awaiting selection
    var larimar_lvl_1: Tower = TowerConstants.ALL_TOWER_LOADS[TowerConstants.TowerIDs.LARIMAR_LVL_1].instantiate()
    test_map.add_child(larimar_lvl_1)
    await get_tree().process_frame
    var larimar_lvl_2: Tower = TowerConstants.ALL_TOWER_LOADS[TowerConstants.TowerIDs.LARIMAR_LVL_2].instantiate()
    test_map.add_child(larimar_lvl_2)
    await get_tree().process_frame
    var larimar_lvl_3: Tower = TowerConstants.ALL_TOWER_LOADS[TowerConstants.TowerIDs.LARIMAR_LVL_3].instantiate()
    test_map.add_child(larimar_lvl_3)
    await get_tree().process_frame
    var sunstone_lvl_3: Tower = TowerConstants.ALL_TOWER_LOADS[TowerConstants.TowerIDs.SUNSTONE_LVL_3].instantiate()
    test_map.add_child(sunstone_lvl_3)
    await get_tree().process_frame
    var sunstone_lvl_4: Tower = TowerConstants.ALL_TOWER_LOADS[TowerConstants.TowerIDs.SUNSTONE_LVL_4].instantiate()
    test_map.add_child(sunstone_lvl_4)
    await get_tree().process_frame

    # Simulate game map having towers awaiting selection
    var simulated_awaiting_selection_towers_list: Array[Tower] = [larimar_lvl_1, larimar_lvl_2, larimar_lvl_3, sunstone_lvl_3, sunstone_lvl_4]
    test_map.__towers_awaiting_selection = simulated_awaiting_selection_towers_list

    var selected_tower_id = larimar_lvl_2.TOWER_ID
    var got_value = test_map.SLATE_MANAGER.selected_tower_awaiting_selection_slate_upgrades(selected_tower_id)
    var expected_value: Array[SlateConstants.SlateIDs] = [SlateConstants.SlateIDs.HOLD_SLATE_LVL_1, SlateConstants.SlateIDs.HOLD_SLATE_LVL_2]
 

    assert_eq(got_value, expected_value)

    # Clean up
    test_map.queue_free()