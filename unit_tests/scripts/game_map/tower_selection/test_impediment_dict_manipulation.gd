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


func test_add_tower_to_placement_grid_coords_dict():
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

    # Create test tower
    var test_placement_grid_coord: Vector2i = Vector2i(20, 20)
    var test_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_1].instantiate()
    test_tower.set_placement_grid_coordinate(test_placement_grid_coord)
    add_child_autofree(test_tower)

    # Create expected values
    var expected_dict_size: int = 4
    var expected_coord_1: Vector2i = Vector2i(20, 20)
    var expected_coord_2: Vector2i = Vector2i(19, 20)
    var expected_coord_3: Vector2i = Vector2i(20, 21)
    var expected_coord_4: Vector2i = Vector2i(19, 21)

    # Generate the placement grid coords for the tower
    var tower_placement_grid_coords: Array[Vector2i] = test_map.get_tower_impediment_points(test_tower.get_placement_grid_coordinate())

    # Verify that the placement grid coords generated are the same as the expected values
    assert_true(tower_placement_grid_coords.has(expected_coord_1), "Placement grid coord dict should contain coord 1")
    assert_true(tower_placement_grid_coords.has(expected_coord_2), "Placement grid coord dict should contain coord 2")
    assert_true(tower_placement_grid_coords.has(expected_coord_3), "Placement grid coord dict should contain coord 3")
    assert_true(tower_placement_grid_coords.has(expected_coord_4), "Placement grid coord dict should contain coord 4")

    # Create a new dict to test adding to the impediment dict
    var test_placement_dict: Dictionary[Vector2i, Tower] = {}

    # Simulate adding the tower's impediment points to the dict
    test_map._add_tower_to_placement_grid_coords_dict(test_tower, test_placement_dict)

    # Verify size of impediment dict
    assert_eq(test_placement_dict.size(), expected_dict_size, "Placement grid coord dict should have size of 4")

    # Verify impediment dict contains expected coords
    assert_true(test_placement_dict.has(expected_coord_1), "Placement grid coord dict should contain coord 1")
    assert_true(test_placement_dict.has(expected_coord_2), "Placement grid coord dict should contain coord 2")
    assert_true(test_placement_dict.has(expected_coord_3), "Placement grid coord dict should contain coord 3")
    assert_true(test_placement_dict.has(expected_coord_4), "Placement grid coord dict should contain coord 4")

    # Verify impediment dict keys reference the tower placed
    assert_eq(test_placement_dict[expected_coord_1], test_tower, "Placement grid coord dict should contain coord 1")
    assert_eq(test_placement_dict[expected_coord_2], test_tower, "Placement grid coord dict should contain coord 2")
    assert_eq(test_placement_dict[expected_coord_3], test_tower, "Placement grid coord dict should contain coord 3")
    assert_eq(test_placement_dict[expected_coord_4], test_tower, "Placement grid coord dict should contain coord 4")

    # Clean up
    test_map.queue_free()
    test_tower.queue_free()

func test_add_to_tower_placement_coords_dict_via_place_tower():
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

    # Ensure impediment dicts are empty
    assert_eq(test_map.__placement_grid_coords_for_towers.size(), 0, "Placement grid coord dict should be empty")

    # Place non-barricade tower
    var test_placement_grid_coord: Vector2i = Vector2i(20, 20)
    test_map.set_build_tower_preload(TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_1])
    test_map.place_tower(test_placement_grid_coord)

    # Ensure tower exists
    assert_not_null(test_map.__towers_awaiting_selection[0], "Placed tower exists in game map's list of tower awaiting selection")

    # Fetch tower placed
    var selected_tower: Tower = test_map.__towers_awaiting_selection[0]

    # Create expected values
    var expected_dict_size: int = 4
    var expected_coord_1: Vector2i = Vector2i(20, 20)
    var expected_coord_2: Vector2i = Vector2i(19, 20)
    var expected_coord_3: Vector2i = Vector2i(20, 21)
    var expected_coord_4: Vector2i = Vector2i(19, 21)

    # Verify size of impediment dict
    assert_eq(test_map.__placement_grid_coords_for_towers.size(), expected_dict_size, "Placement grid coord dict should have size of 4")

    # Verify impediment dict contains expected coords
    assert_true(test_map.__placement_grid_coords_for_towers.has(expected_coord_1), "Placement grid coord dict should contain coord 1")
    assert_true(test_map.__placement_grid_coords_for_towers.has(expected_coord_2), "Placement grid coord dict should contain coord 2")
    assert_true(test_map.__placement_grid_coords_for_towers.has(expected_coord_3), "Placement grid coord dict should contain coord 3")
    assert_true(test_map.__placement_grid_coords_for_towers.has(expected_coord_4), "Placement grid coord dict should contain coord 4")

    # Verify impediment dict keys reference the tower placed
    assert_eq(test_map.__placement_grid_coords_for_towers[expected_coord_1], selected_tower, "Placement grid coord dict should contain coord 1")
    assert_eq(test_map.__placement_grid_coords_for_towers[expected_coord_2], selected_tower, "Placement grid coord dict should contain coord 2")
    assert_eq(test_map.__placement_grid_coords_for_towers[expected_coord_3], selected_tower, "Placement grid coord dict should contain coord 3")
    assert_eq(test_map.__placement_grid_coords_for_towers[expected_coord_4], selected_tower, "Placement grid coord dict should contain coord 4")

    # Clean up
    test_map.queue_free()


func test_remove_tower_from_placement_grid_coords_dict():
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

    # Create test tower
    var test_placement_grid_coord: Vector2i = Vector2i(20, 20)
    var test_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_1].instantiate()
    test_tower.set_placement_grid_coordinate(test_placement_grid_coord)
    add_child_autofree(test_tower)

    # Create expected values
    var expected_dict_size: int = 4
    var expected_coord_1: Vector2i = Vector2i(20, 20)
    var expected_coord_2: Vector2i = Vector2i(19, 20)
    var expected_coord_3: Vector2i = Vector2i(20, 21)
    var expected_coord_4: Vector2i = Vector2i(19, 21)

    # Generate the placement grid coords for the tower
    # Validity of coords already cerified in test_add_to_tower_placement_coords_dict_via_place_tower
    var tower_placement_grid_coords: Array[Vector2i] = test_map.get_tower_impediment_points(test_tower.get_placement_grid_coordinate())

    # Verify that the placement grid coords generated are the same as the expected values
    assert_true(tower_placement_grid_coords.has(expected_coord_1), "Placement grid coord dict should contain coord 1")
    assert_true(tower_placement_grid_coords.has(expected_coord_2), "Placement grid coord dict should contain coord 2")
    assert_true(tower_placement_grid_coords.has(expected_coord_3), "Placement grid coord dict should contain coord 3")
    assert_true(tower_placement_grid_coords.has(expected_coord_4), "Placement grid coord dict should contain coord 4")

    # Create a new dict to test adding to the impediment dict
    var test_placement_dict: Dictionary[Vector2i, Tower] = {}

    # Simulate adding the tower's impediment points to the dict
    test_map._add_tower_to_placement_grid_coords_dict(test_tower, test_placement_dict)

    # Verify size of impediment dict
    assert_eq(test_placement_dict.size(), expected_dict_size, "Placement grid coord dict should have size of 4")

    # Simulate removing the tower's impediment points to the dict
    test_map._remove_tower_from_placement_grid_coords_dict(test_tower, test_placement_dict)

    # Verify that the impediment dict is empty
    assert_eq(test_placement_dict.size(), 0, "Placement grid coord dict should be empty")

    # Clean up
    test_map.queue_free()
    test_tower.queue_free()


func test_remove_from_tower_placement_coords_dict_via_convert_to_barricade():
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

    # Ensure impediment dicts are empty
    assert_eq(test_map.__placement_grid_coords_for_towers.size(), 0, "Placement grid coord dict should be empty")

    # Place non-barricade tower
    var test_placement_grid_coord: Vector2i = Vector2i(20, 20)
    test_map.set_build_tower_preload(TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_1])
    test_map.place_tower(test_placement_grid_coord)

    # Ensure tower exists
    assert_not_null(test_map.__towers_awaiting_selection[0], "Placed tower exists in game map's list of tower awaiting selection")

    # Fetch tower placed
    var selected_tower: Tower = test_map.__towers_awaiting_selection[0]

    # Create expected values
    var expected_dict_size: int = 4

    # Ensure dict has been populated
    assert_eq(test_map.__placement_grid_coords_for_towers.size(), expected_dict_size, "Placement grid coord dict should have size of 4")

    # Simulate converting the tower to a barricade
    test_map.convert_tower_to_barricade(selected_tower)

    # Verify that the tower has been removed from the impediment dict
    assert_eq(test_map.__placement_grid_coords_for_towers.size(), 0, "Placement grid coord dict should be empty")

    # Clean up
    test_map.queue_free()


func test_add_to_barricade_placement_coords_dict_via_convert_to_barricade():
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

    # Ensure impediment dicts are empty
    assert_eq(test_map.__placement_grid_coords_for_towers.size(), 0, "Placement grid coord dict should be empty")

    # Place non-barricade tower
    var test_placement_grid_coord: Vector2i = Vector2i(20, 20)
    test_map.set_build_tower_preload(TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_1])
    test_map.place_tower(test_placement_grid_coord)

    # Ensure tower exists
    assert_not_null(test_map.__towers_awaiting_selection[0], "Placed tower exists in game map's list of tower awaiting selection")

    # Fetch tower placed
    var selected_tower: Tower = test_map.__towers_awaiting_selection[0]

    # Create expected values
    var expected_dict_size: int = 4

    # Ensure barricade dict is empty
    assert_eq(test_map.__placement_grid_coords_for_barricades.size(), 0, "Placement grid coord dict should be empty")

    # Ensure dict has been populated
    assert_eq(test_map.__placement_grid_coords_for_towers.size(), expected_dict_size, "Placement grid coord dict should have size of 4")

    # Simulate converting the tower to a barricade
    test_map.convert_tower_to_barricade(selected_tower)

    # Verify that the impediment points have been added to the barricade dict
    assert_eq(test_map.__placement_grid_coords_for_barricades.size(), expected_dict_size, "Placement grid coord dict should have size of 4")

    # Clean up
    test_map.queue_free()


func test_replace_tower_in_placement_grid_coords_dict():
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

    # Create test tower
    var test_placement_grid_coord: Vector2i = Vector2i(20, 20)
    var test_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_1].instantiate()
    test_tower.set_placement_grid_coordinate(test_placement_grid_coord)
    add_child_autofree(test_tower)
    var test_replacement_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_1].instantiate()
    test_replacement_tower.set_placement_grid_coordinate(test_placement_grid_coord)
    add_child_autofree(test_replacement_tower)

    # Create expected values
    var expected_coord_1: Vector2i = Vector2i(20, 20)
    var expected_coord_2: Vector2i = Vector2i(19, 20)
    var expected_coord_3: Vector2i = Vector2i(20, 21)
    var expected_coord_4: Vector2i = Vector2i(19, 21)

    # Create a new dict to test adding to the impediment dict
    var test_placement_dict: Dictionary[Vector2i, Tower] = {}

    # Simulate adding the tower's impediment points to the dict
    test_map._add_tower_to_placement_grid_coords_dict(test_tower, test_placement_dict)

    # Verify initial impediment dict contains expected coords
    assert_true(test_placement_dict.has(expected_coord_1), "Placement grid coord dict should contain coord 1")
    assert_true(test_placement_dict.has(expected_coord_2), "Placement grid coord dict should contain coord 2")
    assert_true(test_placement_dict.has(expected_coord_3), "Placement grid coord dict should contain coord 3")
    assert_true(test_placement_dict.has(expected_coord_4), "Placement grid coord dict should contain coord 4")

    # Simulate replacing the tower in the impediment dict
    test_map._replace_tower_in_placement_grid_coords_dict(test_tower, test_replacement_tower, test_placement_dict)

    # Verify impediment dict contains expected coords
    assert_true(test_placement_dict.has(expected_coord_1), "Placement grid coord dict should contain coord 1")
    assert_true(test_placement_dict.has(expected_coord_2), "Placement grid coord dict should contain coord 2")
    assert_true(test_placement_dict.has(expected_coord_3), "Placement grid coord dict should contain coord 3")
    assert_true(test_placement_dict.has(expected_coord_4), "Placement grid coord dict should contain coord 4")

    # Verify impediment dict keys reference the tower placed
    assert_eq(test_placement_dict[expected_coord_1], test_replacement_tower, "Placement grid coord dict should contain coord 1")
    assert_eq(test_placement_dict[expected_coord_2], test_replacement_tower, "Placement grid coord dict should contain coord 2")
    assert_eq(test_placement_dict[expected_coord_3], test_replacement_tower, "Placement grid coord dict should contain coord 3")
    assert_eq(test_placement_dict[expected_coord_4], test_replacement_tower, "Placement grid coord dict should contain coord 4")

func test_replace_tower_placement_coords_upgrade_from_towers_awaiting_selection():
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

    # Ensure impediment dicts are empty
    assert_eq(test_map.__placement_grid_coords_for_towers.size(), 0, "Placement grid coord dict should be empty")

    # Place non-barricade tower
    var test_placement_grid_coord: Vector2i = Vector2i(20, 20)
    test_map.set_build_tower_preload(TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_1])
    test_map.place_tower(test_placement_grid_coord)

    # Ensure tower exists
    assert_not_null(test_map.__towers_awaiting_selection[0], "Placed tower exists in game map's list of tower awaiting selection")

    # Fetch tower placed
    var selected_tower: Tower = test_map.__towers_awaiting_selection[0]

    # Create expected values
    var expected_dict_size: int = 4
    var expected_coord_1: Vector2i = Vector2i(20, 20)
    var expected_coord_2: Vector2i = Vector2i(19, 20)
    var expected_coord_3: Vector2i = Vector2i(20, 21)
    var expected_coord_4: Vector2i = Vector2i(19, 21)

    # Verify size of impediment dict
    assert_eq(test_map.__placement_grid_coords_for_towers.size(), expected_dict_size, "Placement grid coord dict should have size of 4")

    # Simulate upgrading the tower in the impediment dict
    test_map.keep_upgrade_tower_from_towers_awaiting_selection(selected_tower, TowerConstants.UpgradeTowerIDs.TOMBSTONE_LVL_1)

    # Verfy tower ID has been updated
    assert_not_null(test_map.__towers_on_map[0])
    assert_eq(test_map.__towers_on_map[0].TOWER_ID, TowerConstants.TowerIDs.TOMBSTONE_LVL_1, "Tower ID should be TOMBSTONE_LVL_1")

    # Fetch new upgrade tower
    var test_replacement_tower: Tower = test_map.__towers_on_map[0]

    # Verify impediment dict has not grown in size
    assert_eq(test_map.__placement_grid_coords_for_towers.size(), expected_dict_size, "Placement grid coord dict should have size of 4")

    # Verify impediment dict keys reference the the upgraded tower
    assert_eq(test_map.__placement_grid_coords_for_towers[expected_coord_1], test_replacement_tower, "Placement grid coord dict should contain coord 1")
    assert_eq(test_map.__placement_grid_coords_for_towers[expected_coord_2], test_replacement_tower, "Placement grid coord dict should contain coord 2")
    assert_eq(test_map.__placement_grid_coords_for_towers[expected_coord_3], test_replacement_tower, "Placement grid coord dict should contain coord 3")
    assert_eq(test_map.__placement_grid_coords_for_towers[expected_coord_4], test_replacement_tower, "Placement grid coord dict should contain coord 4")

    # Clean up
    test_map.queue_free()

func test_replace_tower_placement_coords_from_upgrade_from_towers_on_map():
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

    # Verify size of impediment dict
    assert_eq(test_map.__placement_grid_coords_for_towers.size(), 12, "Placement grid coord dict should have size of 12")

    # Simulate selecting larimar tower
    var test_selected_tower: Tower = larimar_lvl_1

    # Simulate keeping the tower
    test_map.upgrade_from_towers_on_map(test_selected_tower, TowerConstants.UpgradeTowerIDs.TOMBSTONE_LVL_1)

    # Verify that impediment dict contains only points of the selected tower
    assert_eq(test_map.__placement_grid_coords_for_towers.size(), 4, "Placement grid coord dict should have size of 4")

    # Clean up
    test_map.queue_free()