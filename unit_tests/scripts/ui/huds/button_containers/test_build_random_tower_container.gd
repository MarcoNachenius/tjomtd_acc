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

func test_select_random_tower_button_pressed():
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
    # Process frame to create the map
    await get_tree().process_frame


    # ================================================================
    #              ** CREATE RANDOM BUILD TOWER HUD **
    # ================================================================
    # Instantiate random build tower hud
    var random_build_tower_hud: RandomTowerBuildHUD = GameConstants.HUD_LOADS[GameConstants.HudTypes.RANDOM_TOWER_BUILD].instantiate()
    random_build_tower_hud.GAME_MAP = test_map
    add_child_autofree(random_build_tower_hud)
    random_build_tower_hud.add_child(test_map)
    # Process frame to create the hud and the map
    await get_tree().process_frame

    # ================================================================
    #                 ** VERIFY INITIAL STATE **
    # ================================================================
    # Build random tower container
    assert_true(random_build_tower_hud.BUILD_RANDOM_TOWER_CONTAINER.visible, "Build random tower container is visible on creation")
    assert_true(random_build_tower_hud.BUILD_RANDOM_TOWER_CONTAINER.BUILD_RANDOM_TOWER_BUTTON.visible, "Build random tower button is visible on creation")
    assert_false(random_build_tower_hud.BUILD_RANDOM_TOWER_CONTAINER.EXIT_BUILD_MODE_BUTTON.visible, "Exit build mode button is not visible on creation")
    # Tower properties container
    assert_false(random_build_tower_hud.TOWER_PROPERTIES_CONTAINER.visible, "Tower properties container is not visible on creation")


    # ================================================================
    #                      ** CONDUCT TESTS **
    # ================================================================
    # Simulate select random tower button being pressed
    random_build_tower_hud._on_build_random_tower_button_pressed()


    # ================================================================
    #                      ** ASSES RESULTS **
    # ================================================================
    # Build random tower container
    assert_true(random_build_tower_hud.BUILD_RANDOM_TOWER_CONTAINER.visible, "Build random tower container is visible after button press")
    assert_true(random_build_tower_hud.BUILD_RANDOM_TOWER_CONTAINER.EXIT_BUILD_MODE_BUTTON.visible, "Exit build mode button is visible after button press")
    assert_false(random_build_tower_hud.BUILD_RANDOM_TOWER_CONTAINER.BUILD_RANDOM_TOWER_BUTTON.visible, "Build random tower button is not visible on creation")
    # Tower properties container
    assert_false(random_build_tower_hud.TOWER_PROPERTIES_CONTAINER.visible, "Tower properties container is not visible after button press")


    # ================================================================
    #                          ** CLEANUP **
    # ================================================================
    test_map.queue_free()
    # Process frame to remove the hud and the map
    await get_tree().process_frame

func test_exit_build_mode_button_pressed():
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
    # Process frame to create the map
    await get_tree().process_frame


    # ================================================================
    #              ** CREATE RANDOM BUILD TOWER HUD **
    # ================================================================
    # Instantiate random build tower hud
    var random_build_tower_hud: RandomTowerBuildHUD = GameConstants.HUD_LOADS[GameConstants.HudTypes.RANDOM_TOWER_BUILD].instantiate()
    random_build_tower_hud.GAME_MAP = test_map
    add_child_autofree(random_build_tower_hud)
    random_build_tower_hud.add_child(test_map)
    # Process frame to create the hud and the map
    await get_tree().process_frame

    # ================================================================
    #                 ** VERIFY INITIAL STATE **
    # ================================================================
    # Build random tower container
    assert_true(random_build_tower_hud.BUILD_RANDOM_TOWER_CONTAINER.visible, "Build random tower container is visible on creation")
    assert_true(random_build_tower_hud.BUILD_RANDOM_TOWER_CONTAINER.BUILD_RANDOM_TOWER_BUTTON.visible, "Build random tower button is visible on creation")
    assert_false(random_build_tower_hud.BUILD_RANDOM_TOWER_CONTAINER.EXIT_BUILD_MODE_BUTTON.visible, "Exit build mode button is not visible on creation")
    # Tower properties container
    assert_false(random_build_tower_hud.TOWER_PROPERTIES_CONTAINER.visible, "Tower properties container is not visible on creation")


    # ================================================================
    #                      ** CONDUCT TESTS **
    # ================================================================
    # Simulate select random tower button being pressed
    random_build_tower_hud._on_build_random_tower_button_pressed()
    # Simulate exit build mode button being pressed
    random_build_tower_hud._on_exit_build_mode_button_pressed()


    # ================================================================
    #                      ** ASSES RESULTS **
    # ================================================================
    # Build random tower container
    assert_true(random_build_tower_hud.BUILD_RANDOM_TOWER_CONTAINER.visible, "Build random tower container is visible after button press")
    assert_false(random_build_tower_hud.BUILD_RANDOM_TOWER_CONTAINER.EXIT_BUILD_MODE_BUTTON.visible, "Exit build mode button is not visible after button press")
    assert_true(random_build_tower_hud.BUILD_RANDOM_TOWER_CONTAINER.BUILD_RANDOM_TOWER_BUTTON.visible, "Build random tower button is visible on creation")
    # Tower properties container
    assert_false(random_build_tower_hud.TOWER_PROPERTIES_CONTAINER.visible, "Tower properties container is not visible after button press")


    # ================================================================
    #                          ** CLEANUP **
    # ================================================================
    test_map.queue_free()
    # Process frame to remove the hud and the map
    await get_tree().process_frame