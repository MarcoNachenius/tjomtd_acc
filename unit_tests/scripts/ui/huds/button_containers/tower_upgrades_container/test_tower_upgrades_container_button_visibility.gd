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



func test_upgrade_tower_button_appearance_from_towers_on_map_list():
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

    # Create towers required for upgrade to tombstone
    var black_marble_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()
    test_game_map.add_child(black_marble_lvl_1)
    var bismuth_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_1].instantiate()
    test_game_map.add_child(bismuth_lvl_1)
    var larimar_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.LARIMAR_LVL_1].instantiate()
    test_game_map.add_child(larimar_lvl_1)

    # Create simulated list of towers and assign to game map
    var test_towers_on_map_array: Array[Tower] = [black_marble_lvl_1, bismuth_lvl_1, larimar_lvl_1]
    test_game_map.__towers_on_map = test_towers_on_map_array
    # Switch state of all towers to BUILT
    for tower in test_towers_on_map_array:
        tower.switch_state(Tower.States.BUILT)

    # Ensure upgrade container is not visible before selecting a tower
    assert_false(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container should not be visible")

    # Simulate tower being selected
    test_game_map.tower_selected.emit(black_marble_lvl_1)

    # Process frame to ensure the tower selected signal is processed
    await get_tree().process_frame

    # Ensure selected tower has been correctly set
    assert_eq(test_random_tower_build_hud.__selected_tower, black_marble_lvl_1, "Selected tower should be black marble level 1")

    # Ensure the game map is in navigation mode
    assert_eq(test_game_map.get_state(), GameMap.States.NAVIGATION_MODE, "Game map should be in navigation mode")

    # Ensure upgrade manager thinks that upgrade to tombstone is possible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADE_MANAGER.can_upgrade_to_tower(TowerConstants.TowerIDs.TOMBSTONE_LVL_1, test_towers_on_map_array), "Upgrade to tombstone should be possible")

    # Upgrade towers container should now be visible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container should be visible")

    # Tombstone level 1 button should be visible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.TOWER_ID_TO_BUTTON_DICT[TowerConstants.TowerIDs.TOMBSTONE_LVL_1].visible, "Tombstone level 1 button should be visible")

    # Clean up
    test_game_map.queue_free()
    test_random_tower_build_hud.queue_free()
    black_marble_lvl_1.queue_free()
    bismuth_lvl_1.queue_free()
    larimar_lvl_1.queue_free()
    # Process frame to ensure all objects are cleaned up
    await get_tree().process_frame



func test_tombstone_lvl_1_button_appearance_awaiting_selection():
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

    # Create towers required for upgrade to tombstone
    var black_marble_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()
    test_game_map.add_child(black_marble_lvl_1)
    var bismuth_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_1].instantiate()
    test_game_map.add_child(bismuth_lvl_1)
    var larimar_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.LARIMAR_LVL_1].instantiate()
    test_game_map.add_child(larimar_lvl_1)

    # Create simulated list of towers and assign to game map
    var test_towers_awaiting_selection: Array[Tower] = [black_marble_lvl_1, bismuth_lvl_1, larimar_lvl_1]
    test_game_map.__towers_awaiting_selection = test_towers_awaiting_selection

    # Ensure upgrade container is not visible before selecting a tower
    assert_false(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container should not be visible")

    # Simulate tower being selected
    test_game_map.tower_selected.emit(black_marble_lvl_1)

    # Process frame to ensure the tower selected signal is processed
    await get_tree().process_frame

    # Ensure selected tower has been correctly set
    assert_eq(test_random_tower_build_hud.__selected_tower, black_marble_lvl_1, "Selected tower should be black marble level 1")

    # Ensure the game map is in navigation mode
    assert_eq(test_game_map.get_state(), GameMap.States.NAVIGATION_MODE, "Game map should be in navigation mode")

    # Ensure upgrade manager thinks that upgrade to tombstone is possible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADE_MANAGER.can_upgrade_to_tower(TowerConstants.TowerIDs.TOMBSTONE_LVL_1, test_towers_awaiting_selection), "Upgrade to tombstone should be possible")

    # Upgrade towers container should now be visible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container should be visible")

    # Tombstone level 1 button should be visible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.TOWER_ID_TO_BUTTON_DICT[TowerConstants.TowerIDs.TOMBSTONE_LVL_1].visible, "Tombstone level 1 button should be visible")

    # Clean up
    test_game_map.queue_free()
    test_random_tower_build_hud.queue_free()
    black_marble_lvl_1.queue_free()
    bismuth_lvl_1.queue_free()
    larimar_lvl_1.queue_free()
    # Process frame to ensure all objects are cleaned up
    await get_tree().process_frame

func test_sam_site_lvl_1_button_appearance_awaiting_selection():
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

    # Create towers required for upgrade to tombstone
    var spinel_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.SPINEL_LVL_1].instantiate()
    test_game_map.add_child(spinel_lvl_1)
    var kunzite_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.KUNZITE_LVL_1].instantiate()
    test_game_map.add_child(kunzite_lvl_1)
    var sunstone_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.SUNSTONE_LVL_1].instantiate()
    test_game_map.add_child(sunstone_lvl_1)

    # Create simulated list of towers and assign to game map
    var test_towers_awaiting_selection: Array[Tower] = [spinel_lvl_1, kunzite_lvl_1, sunstone_lvl_1]
    test_game_map.__towers_awaiting_selection = test_towers_awaiting_selection

    # Ensure upgrade container is not visible before selecting a tower
    assert_false(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container should not be visible")

    # Simulate tower being selected
    test_game_map.tower_selected.emit(spinel_lvl_1)

    # Process frame to ensure the tower selected signal is processed
    await get_tree().process_frame

    # Ensure selected tower has been correctly set
    assert_eq(test_random_tower_build_hud.__selected_tower, spinel_lvl_1, "Selected tower should be black marble level 1")

    # Ensure the game map is in navigation mode
    assert_eq(test_game_map.get_state(), GameMap.States.NAVIGATION_MODE, "Game map should be in navigation mode")

    # Ensure upgrade manager thinks that upgrade to Sam Site is possible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADE_MANAGER.can_upgrade_to_tower(TowerConstants.TowerIDs.SAM_SITE_LVL_1, test_towers_awaiting_selection), "Upgrade to Sam Site should be possible")

    # Upgrade towers container should now be visible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container should be visible")

    # Sam Site level 1 button should be visible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.TOWER_ID_TO_BUTTON_DICT[TowerConstants.TowerIDs.SAM_SITE_LVL_1].visible, "Sam Site level 1 button should be visible")

    # Clean up
    test_game_map.queue_free()
    test_random_tower_build_hud.queue_free()
    spinel_lvl_1.queue_free()
    kunzite_lvl_1.queue_free()
    sunstone_lvl_1.queue_free()
    # Process frame to ensure all objects are cleaned up
    await get_tree().process_frame


func test_lava_pool_lvl_1_button_appearance_awaiting_selection():
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

    # Create towers required for upgrade to tombstone
    var black_marble_lvl_2: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2].instantiate()
    test_game_map.add_child(black_marble_lvl_2)
    var spinel_lvl_2: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.SPINEL_LVL_2].instantiate()
    test_game_map.add_child(spinel_lvl_2)
    var spinel_lvl_3: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.SPINEL_LVL_3].instantiate()
    test_game_map.add_child(spinel_lvl_3)

    # Create simulated list of towers and assign to game map
    var test_towers_awaiting_selection: Array[Tower] = [black_marble_lvl_2, spinel_lvl_2, spinel_lvl_3]
    test_game_map.__towers_awaiting_selection = test_towers_awaiting_selection

    # Ensure upgrade container is not visible before selecting a tower
    assert_false(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container should not be visible")

    # Simulate tower being selected
    test_game_map.tower_selected.emit(black_marble_lvl_2)

    # Process frame to ensure the tower selected signal is processed
    await get_tree().process_frame

    # Ensure selected tower has been correctly set
    assert_eq(test_random_tower_build_hud.__selected_tower, black_marble_lvl_2, "Selected tower should be black marble level 1")

    # Ensure the game map is in navigation mode
    assert_eq(test_game_map.get_state(), GameMap.States.NAVIGATION_MODE, "Game map should be in navigation mode")

    # Ensure upgrade manager thinks that upgrade to Lava Pool is possible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADE_MANAGER.can_upgrade_to_tower(TowerConstants.TowerIDs.LAVA_POOL_LVL_1, test_towers_awaiting_selection), "Upgrade to Lava Pool should be possible")

    # Upgrade towers container should now be visible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container should be visible")

    # Lava Pool level 1 button should be visible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.TOWER_ID_TO_BUTTON_DICT[TowerConstants.TowerIDs.LAVA_POOL_LVL_1].visible, "Lava Pool level 1 button should be visible")

    # Clean up
    test_game_map.queue_free()
    test_random_tower_build_hud.queue_free()
    black_marble_lvl_2.queue_free()
    spinel_lvl_2.queue_free()
    spinel_lvl_3.queue_free()
    # Process frame to ensure all objects are cleaned up
    await get_tree().process_frame

func test_ice_shard_lvl_1_button_appearance_awaiting_selection():
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

    # Create towers required for upgrade to tombstone
    var bismuth_lvl_3: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_3].instantiate()
    test_game_map.add_child(bismuth_lvl_3)
    var larimar_lvl_2: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.LARIMAR_LVL_2].instantiate()
    test_game_map.add_child(larimar_lvl_2)
    var spinel_lvl_4: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.SPINEL_LVL_4].instantiate()
    test_game_map.add_child(spinel_lvl_4)

    # Create simulated list of towers and assign to game map
    var test_towers_awaiting_selection: Array[Tower] = [bismuth_lvl_3, larimar_lvl_2, spinel_lvl_4]
    test_game_map.__towers_awaiting_selection = test_towers_awaiting_selection

    # Ensure upgrade container is not visible before selecting a tower
    assert_false(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container should not be visible")

    # Simulate tower being selected
    test_game_map.tower_selected.emit(bismuth_lvl_3)

    # Process frame to ensure the tower selected signal is processed
    await get_tree().process_frame

    # Ensure selected tower has been correctly set
    assert_eq(test_random_tower_build_hud.__selected_tower, bismuth_lvl_3, "Selected tower should be black marble level 1")

    # Ensure the game map is in navigation mode
    assert_eq(test_game_map.get_state(), GameMap.States.NAVIGATION_MODE, "Game map should be in navigation mode")

    # Ensure upgrade manager thinks that upgrade to Ice Shard is possible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADE_MANAGER.can_upgrade_to_tower(TowerConstants.TowerIDs.ICE_SHARD_LVL_1, test_towers_awaiting_selection), "Upgrade to Ice Shard should be possible")

    # Upgrade towers container should now be visible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container should be visible")

    # Ice Shard level 1 button should be visible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.TOWER_ID_TO_BUTTON_DICT[TowerConstants.TowerIDs.ICE_SHARD_LVL_1].visible, "Ice Shard level 1 button should be visible")

    # Clean up
    test_game_map.queue_free()
    test_random_tower_build_hud.queue_free()
    bismuth_lvl_3.queue_free()
    larimar_lvl_2.queue_free()
    spinel_lvl_4.queue_free()
    # Process frame to ensure all objects are cleaned up
    await get_tree().process_frame

func test_emp_stunner_lvl_1_button_appearance_awaiting_selection():
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

    # Create towers required for upgrade to tombstone
    var bismuth_lvl_2: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_2].instantiate()
    test_game_map.add_child(bismuth_lvl_2)
    var larimar_lvl_3: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.LARIMAR_LVL_3].instantiate()
    test_game_map.add_child(larimar_lvl_3)
    var sunstone_lvl_3: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.SUNSTONE_LVL_3].instantiate()
    test_game_map.add_child(sunstone_lvl_3)

    # Create simulated list of towers and assign to game map
    var test_towers_awaiting_selection: Array[Tower] = [bismuth_lvl_2, larimar_lvl_3, sunstone_lvl_3]
    test_game_map.__towers_awaiting_selection = test_towers_awaiting_selection

    # Ensure upgrade container is not visible before selecting a tower
    assert_false(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container should not be visible")

    # Simulate tower being selected
    test_game_map.tower_selected.emit(bismuth_lvl_2)

    # Process frame to ensure the tower selected signal is processed
    await get_tree().process_frame

    # Ensure selected tower has been correctly set
    assert_eq(test_random_tower_build_hud.__selected_tower, bismuth_lvl_2, "Selected tower should be black marble level 1")

    # Ensure the game map is in navigation mode
    assert_eq(test_game_map.get_state(), GameMap.States.NAVIGATION_MODE, "Game map should be in navigation mode")

    # Ensure upgrade manager thinks that upgrade to EMP Stunner is possible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADE_MANAGER.can_upgrade_to_tower(TowerConstants.TowerIDs.EMP_STUNNER_LVL_1, test_towers_awaiting_selection), "Upgrade to EMP Stunner should be possible")

    # Upgrade towers container should now be visible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container should be visible")

    # EMP Stunner level 1 button should be visible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.TOWER_ID_TO_BUTTON_DICT[TowerConstants.TowerIDs.EMP_STUNNER_LVL_1].visible, "Ice Shard level 1 button should be visible")

    # Clean up
    test_game_map.queue_free()
    test_random_tower_build_hud.queue_free()
    bismuth_lvl_2.queue_free()
    larimar_lvl_3.queue_free()
    sunstone_lvl_3.queue_free()
    # Process frame to ensure all objects are cleaned up
    await get_tree().process_frame

func test_gatling_gun_lvl_1_button_appearance_awaiting_selection():
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

    # Create towers required for upgrade to tombstone
    var black_marble_lvl_3: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_3].instantiate()
    test_game_map.add_child(black_marble_lvl_3)
    var kunzite_lvl_2: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.KUNZITE_LVL_2].instantiate()
    test_game_map.add_child(kunzite_lvl_2)
    var sunstone_lvl_2: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.SUNSTONE_LVL_2].instantiate()
    test_game_map.add_child(sunstone_lvl_2)

    # Create simulated list of towers and assign to game map
    var test_towers_awaiting_selection: Array[Tower] = [black_marble_lvl_3, kunzite_lvl_2, sunstone_lvl_2]
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
    assert_true(test_random_tower_build_hud.TOWER_UPGRADE_MANAGER.can_upgrade_to_tower(TowerConstants.TowerIDs.GATLING_GUN_LVL_1, test_towers_awaiting_selection), "Upgrade to Gatling Gun should be possible")

    # Upgrade towers container should now be visible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container should be visible")

    # Gatling Gun level 1 button should be visible
    assert_true(test_random_tower_build_hud.TOWER_UPGRADES_CONTAINER.TOWER_ID_TO_BUTTON_DICT[TowerConstants.TowerIDs.GATLING_GUN_LVL_1].visible, "Gatling Gun level 1 button should be visible")

    # Clean up
    test_game_map.queue_free()
    test_random_tower_build_hud.queue_free()
    black_marble_lvl_3.queue_free()
    kunzite_lvl_2.queue_free()
    sunstone_lvl_2.queue_free()
    # Process frame to ensure all objects are cleaned up
    await get_tree().process_frame


func test_sharp_shooter_lvl_1_button_appearance_awaiting_selection():
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

    # Create towers required for upgrade to tombstone
    var black_marble_lvl_3: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_3].instantiate()
    test_game_map.add_child(black_marble_lvl_3)
    var black_marble_lvl_4: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_4].instantiate()
    test_game_map.add_child(black_marble_lvl_4)

    # Create simulated list of towers and assign to game map
    var test_towers_awaiting_selection: Array[Tower] = [black_marble_lvl_3, black_marble_lvl_4]
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

    # Clean up
    test_game_map.queue_free()
    test_random_tower_build_hud.queue_free()
    black_marble_lvl_3.queue_free()
    black_marble_lvl_4.queue_free()
    # Process frame to ensure all objects are cleaned up
    await get_tree().process_frame