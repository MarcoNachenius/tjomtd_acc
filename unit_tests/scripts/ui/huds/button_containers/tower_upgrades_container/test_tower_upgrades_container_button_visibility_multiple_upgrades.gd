extends GutTest

func before_each():
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

func test_sharp_shooter_and_gatling_gun_button_appearance_awaiting_selection():
    # ================================================================
    #                     ** CREATE BLANK MAP **
    # ================================================================
    var test_game_map = GameMap.new()
    # LINE_TD is used because it has no mandatory path stops
    test_game_map.MAP_ID = MapConstants.MapID.LINE_TD
    # Set the map's size to 10x10
    test_game_map.MAP_HEIGHT = 10
    test_game_map.MAP_WIDTH = 10
    # Ensure start and end points don't interfere with placement validity
    test_game_map.__path_start_point = Vector2i(0, 0)
    test_game_map.__path_end_point = Vector2i(0, 19)
    # Create test tileset
    var test_tileset = TileSet.new()
    test_tileset.tile_shape = TileSet.TILE_SHAPE_ISOMETRIC
    test_tileset.tile_layout = TileSet.TILE_LAYOUT_DIAMOND_DOWN
    test_tileset.tile_offset_axis = TileSet.TILE_OFFSET_AXIS_VERTICAL
    test_tileset.tile_size = Vector2i(256, 128)
    # Asssign the test tileset to the map
    test_game_map.tile_set = test_tileset
    # Add the test map to the scene
    add_child_autofree(test_game_map)
    # Process frame to create the map
    await get_tree().process_frame
    # ================================================================

    # Create test instance of game map
    # Process frame to ensure the game map is ready
    await get_tree().process_frame

    # Create test instance of random tower build hud
    var test_random_tower_build_hud: RandomTowerBuildHUD = GameConstants.HUD_LOADS[GameConstants.HudTypes.RANDOM_TOWER_BUILD].instantiate()
    # Set the game map for the random tower build hud
    test_random_tower_build_hud.GAME_MAP = test_game_map
    add_child_autofree(test_random_tower_build_hud)
    # Process frame to ensure the random tower build hud is ready
    await get_tree().process_frame

    # Create towers required for upgrade to Sharp Shooter
    var black_marble_lvl_3: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_3].instantiate()
    test_game_map.add_child(black_marble_lvl_3)
    var black_marble_lvl_4: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_4].instantiate()
    test_game_map.add_child(black_marble_lvl_4)

    # Create towers required for upgrade to Gatling Gun
    var sunstone_lvl_2: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.SUNSTONE_LVL_2].instantiate()
    test_game_map.add_child(sunstone_lvl_2)
    var kunzite_lvl_2: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.KUNZITE_LVL_2].instantiate()
    test_game_map.add_child(kunzite_lvl_2)

    # Create simulated list of towers and assign to game map
    var test_towers_awaiting_selection: Array[Tower] = [black_marble_lvl_3, black_marble_lvl_4, sunstone_lvl_2, kunzite_lvl_2]
    test_game_map.__towers_awaiting_selection = test_towers_awaiting_selection

    # Ensure upgrade container is not visible before selecting a tower
    assert_false(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container should not be visible")

    # Simulate tower being selected
    test_game_map.tower_selected.emit(black_marble_lvl_3)

    # Process frame to ensure the tower selected signal is processed
    await get_tree().process_frame

    # Ensure selected tower has been correctly set
    assert_eq(test_random_tower_build_hud.__selected_tower, black_marble_lvl_3, "Selected tower should be black marble level 1")

    # Ensure the game map is in navigation mode
    assert_eq(test_game_map.get_state(), GameMap.States.NAVIGATION_MODE, "Game map should be in navigation mode")

    # Ensure upgrade manager thinks that upgrade to Gatling Gun is possible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADE_MANAGER.can_upgrade_to_tower(TowerConstants.TowerIDs.SHARP_SHOOTER_LVL_1, test_towers_awaiting_selection), "Upgrade to Gatling Gun should be possible")

    # Upgrade towers container should now be visible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container should be visible")

    # Gatling Gun level 1 button should be visible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.TOWER_ID_TO_BUTTON_DICT[TowerConstants.TowerIDs.SHARP_SHOOTER_LVL_1].visible, "Gatling Gun level 1 button should be visible")

    # Sharp Shooter level 1 button should be visible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.TOWER_ID_TO_BUTTON_DICT[TowerConstants.TowerIDs.GATLING_GUN_LVL_1].visible, "Sharp Shooter level 1 button should be visible")

    # Upgrades into value of tower stats container should contain ' - Sharp Shooter' string value
    assert_true(test_random_tower_build_hud.SELECTED_TOWER_STATS_CONTAINER.TOWER_ATTR_CONTAINER.UPGRADES_INTO_VALUE.text.contains(" - Sharp Shooter"), "Upgrades into value of tower stats container contains ' - Sharp Shooter' string value")

    # Upgrades into value of tower stats container should contain ' - Gatling Gun' string value
    assert_true(test_random_tower_build_hud.SELECTED_TOWER_STATS_CONTAINER.TOWER_ATTR_CONTAINER.UPGRADES_INTO_VALUE.text.contains(" - Gatling Gun"), "Upgrades into value of tower stats container contains ' - Gatling Gun' string value")

    # Clean up
    test_game_map.queue_free()
    test_random_tower_build_hud.queue_free()
    black_marble_lvl_3.queue_free()
    black_marble_lvl_4.queue_free()
    # Process frame to ensure all objects are cleaned up
    await get_tree().process_frame