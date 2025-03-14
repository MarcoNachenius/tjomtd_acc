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
    # Set the map's main grid size to 20x20 where towers can be placed
    test_map.MAP_HEIGHT = 10
    test_map.MAP_WIDTH = 10
    # Set path start and end points
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

func test_path_generation_right_from_start_point_right():
    # ================================================================
    #                     ** CREATE BLANK MAP **
    # ================================================================
    var test_map = GameMap.new()
    # LINE_TD is used because it has no mandatory path stops
    test_map.MAP_ID = MapConstants.MapID.LINE_TD
    # Set the map's main grid size to 20x20 where towers can be placed
    test_map.MAP_HEIGHT = 10
    test_map.MAP_WIDTH = 10
    # Set path start and end points
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

    # PERFORM TEST
    # ------------
    # Ensure first two points of generated path can only be (0, 0) and (2, 0)
    test_map.place_tower_impediment_points(Vector2i(1, 1))
    test_map.place_tower_impediment_points(Vector2i(4, 0))

    # ASSESS RESULTS
    # --------------
    # Ensure retention of path start point
    assert_eq(test_map.__curr_path[0], test_map.__path_start_point, "Path start point retained")
    # Ensure retention of path end point
    assert_eq(test_map.__curr_path[-1], test_map.__path_end_point, "Path end point retained")
    # Ensure first alteration of path occurs at (2, 0)
    assert_eq(test_map.__curr_path[1], Vector2i(2, 0))

    # Clean up
    test_map.queue_free()

func test_path_generation_right_from_start_point_down():
    # ================================================================
    #                     ** CREATE BLANK MAP **
    # ================================================================
    var test_map = GameMap.new()
    # LINE_TD is used because it has no mandatory path stops
    test_map.MAP_ID = MapConstants.MapID.LINE_TD
    # Set the map's main grid size to 20x20 where towers can be placed
    test_map.MAP_HEIGHT = 10
    test_map.MAP_WIDTH = 10
    # Set path start and end points
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

    # PERFORM TEST
    # ------------
    # Ensure first two points of generated path can only be (0, 0) and (0, 2)
    test_map.place_tower_impediment_points(Vector2i(2, 0))
    test_map.place_tower_impediment_points(Vector2i(1, 3))

    # ASSESS RESULTS
    # --------------
    # Ensure retention of path start point
    assert_eq(test_map.__curr_path[0], test_map.__path_start_point, "Path start point retained")
    # Ensure retention of path end point
    assert_eq(test_map.__curr_path[-1], test_map.__path_end_point, "Path end point retained")
    # Ensure first alteration of path occurs at (0, 2)
    assert_eq(test_map.__curr_path[1], Vector2i(0, 2))

    # Clean up
    test_map.queue_free()

func test_path_generation_from_start_point_left():
    # ================================================================
    #                     ** CREATE BLANK MAP **
    # ================================================================
    var test_map = GameMap.new()
    # LINE_TD is used because it has no mandatory path stops
    test_map.MAP_ID = MapConstants.MapID.LINE_TD
    # Set the map's main grid size to 20x20 where towers can be placed
    test_map.MAP_HEIGHT = 10
    test_map.MAP_WIDTH = 10
    # Set path start and end points
    test_map.__path_start_point = Vector2i(19, 0)
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

    # PERFORM TEST
    # ------------
    # Ensure first two points of generated path can only be (19, 0) and (17, 0)
    test_map.place_tower_impediment_points(Vector2i(19, 1))
    test_map.place_tower_impediment_points(Vector2i(16, 0))

    # ASSESS RESULTS
    # --------------
    # Ensure retention of path start point
    assert_eq(test_map.__curr_path[0], test_map.__path_start_point, "Path start point retained")
    # Ensure retention of path end point
    assert_eq(test_map.__curr_path[-1], test_map.__path_end_point, "Path end point retained")
    # Ensure first alteration of path occurs at (17, 0)
    assert_eq(test_map.__curr_path[1], Vector2i(17, 0))

    # Clean up
    test_map.queue_free()


func test_path_generation_right_from_start_point_up():
    # ================================================================
    #                     ** CREATE BLANK MAP **
    # ================================================================
    var test_map = GameMap.new()
    # LINE_TD is used because it has no mandatory path stops
    test_map.MAP_ID = MapConstants.MapID.LINE_TD
    # Set the map's main grid size to 20x20 where towers can be placed
    test_map.MAP_HEIGHT = 10
    test_map.MAP_WIDTH = 10
    # Set path start and end points
    test_map.__path_start_point = Vector2i(0, 19)
    test_map.__path_end_point = Vector2i(0, 0)
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

    # PERFORM TEST
    # ------------
    # Ensure first two points of generated path can only be (0, 19) and (0, 17)
    test_map.place_tower_impediment_points(Vector2i(2, 18))
    test_map.place_tower_impediment_points(Vector2i(1, 15))

    # ASSESS RESULTS
    # --------------
    # Ensure retention of path start point
    assert_eq(test_map.__curr_path[0], test_map.__path_start_point, "Path start point retained")
    # Ensure retention of path end point
    assert_eq(test_map.__curr_path[-1], test_map.__path_end_point, "Path end point retained")
    # Ensure first alteration of path occurs at (0, 17)
    assert_eq(test_map.__curr_path[1], Vector2i(0, 17))

    # Clean up
    test_map.queue_free()