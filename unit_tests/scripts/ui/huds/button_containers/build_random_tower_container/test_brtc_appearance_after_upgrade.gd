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

func test_display_continer_after_built_tower_upgrade():
    
    # SCENARIO:
        # Player upgrades buit towers to lava pool
        # Player has no towers awaiting selection at the time of upgrade
        # Wave is not in progress at the time of upgrade
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
    #                   ** PLACE BUILT TOWERS **
    # ================================================================
    # Create towers required for upgrade to LAVA POOL
    random_build_tower_hud.GAME_MAP.place_built_tower(Vector2i(4, 5), TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2)
    random_build_tower_hud.GAME_MAP.place_built_tower(Vector2i(4, 7), TowerConstants.TowerIDs.SPINEL_LVL_2)
    random_build_tower_hud.GAME_MAP.place_built_tower(Vector2i(4, 9), TowerConstants.TowerIDs.SPINEL_LVL_3)

    var black_marble_lvl_2: Tower = random_build_tower_hud.GAME_MAP.__towers_on_map[0]
    var spinel_lvl_2: Tower = random_build_tower_hud.GAME_MAP.__towers_on_map[1]
    var spinel_lvl_3: Tower = random_build_tower_hud.GAME_MAP.__towers_on_map[2]

    assert_eq(black_marble_lvl_2.TOWER_ID, TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2, "First tower is black marble level 2")
    assert_eq(spinel_lvl_2.TOWER_ID, TowerConstants.TowerIDs.SPINEL_LVL_2, "Second tower is spinel level 2")
    assert_eq(spinel_lvl_3.TOWER_ID, TowerConstants.TowerIDs.SPINEL_LVL_3, "Third tower is spinel level 3")


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
    # Simulate black marble lvl 2 being selected
    random_build_tower_hud._on_tower_selected(black_marble_lvl_2)
    await get_tree().process_frame
    
    # Ensure lava pool button is visible
    assert_true(random_build_tower_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container is visible when black marble level 2 is selected")
    assert_true(random_build_tower_hud.TOWER_UPGRADES_CONTAINER.LAVA_POOL_BUTTON.visible, "Lava pool upgrade button is visible when black marble level 2 is selected")
    
    # Simulate built towers being upgraded to lava pool
    random_build_tower_hud.TOWER_UPGRADES_CONTAINER._on_lava_pool_button_pressed()
    await get_tree().process_frame

    

    # ================================================================
    #                      ** ASSES RESULTS **
    # ================================================================
    # Build random tower container should still be visible after upgrade
    assert_true(random_build_tower_hud.BUILD_RANDOM_TOWER_CONTAINER.visible, "Build random tower container is still visible after upgrading to lava pool")

    # ================================================================
    #                          ** CLEANUP **
    # ================================================================
    test_map.queue_free()
    # Process frame to remove the hud and the map
    await get_tree().process_frame


func test_stay_hidden_continer_after_built_tower_upgrade_wave_in_progress():
    
    # SCENARIO:
        # Player upgrades buit towers to lava pool
        # Player has no towers awaiting selection at the time of upgrade
        # Wave is in progress at the time of upgrade
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
    #                   ** PLACE BUILT TOWERS **
    # ================================================================
    # Create towers required for upgrade to LAVA POOL
    random_build_tower_hud.GAME_MAP.place_built_tower(Vector2i(4, 5), TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2)
    random_build_tower_hud.GAME_MAP.place_built_tower(Vector2i(4, 7), TowerConstants.TowerIDs.SPINEL_LVL_2)
    random_build_tower_hud.GAME_MAP.place_built_tower(Vector2i(4, 9), TowerConstants.TowerIDs.SPINEL_LVL_3)

    var black_marble_lvl_2: Tower = random_build_tower_hud.GAME_MAP.__towers_on_map[0]
    var spinel_lvl_2: Tower = random_build_tower_hud.GAME_MAP.__towers_on_map[1]
    var spinel_lvl_3: Tower = random_build_tower_hud.GAME_MAP.__towers_on_map[2]

    assert_eq(black_marble_lvl_2.TOWER_ID, TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2, "First tower is black marble level 2")
    assert_eq(spinel_lvl_2.TOWER_ID, TowerConstants.TowerIDs.SPINEL_LVL_2, "Second tower is spinel level 2")
    assert_eq(spinel_lvl_3.TOWER_ID, TowerConstants.TowerIDs.SPINEL_LVL_3, "Third tower is spinel level 3")


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
    # Simulate wave starting
    random_build_tower_hud._on_start_new_wave_button_pressed()
    # Simulate black marble lvl 2 being selected
    random_build_tower_hud._on_tower_selected(black_marble_lvl_2)
    await get_tree().process_frame
    
    # Ensure lava pool button is visible
    assert_true(random_build_tower_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container is visible when black marble level 2 is selected")
    assert_true(random_build_tower_hud.TOWER_UPGRADES_CONTAINER.LAVA_POOL_BUTTON.visible, "Lava pool upgrade button is visible when black marble level 2 is selected")
    
    # Simulate built towers being upgraded to lava pool
    random_build_tower_hud.TOWER_UPGRADES_CONTAINER._on_lava_pool_button_pressed()
    await get_tree().process_frame

    

    # ================================================================
    #                      ** ASSES RESULTS **
    # ================================================================
    # Build random tower container should not be visible after upgrade since wave is in progress at the time of upgrade
    assert_false(random_build_tower_hud.BUILD_RANDOM_TOWER_CONTAINER.visible, "Build random tower container is not visible after upgrading to lava pool with wave in progress")

    # ================================================================
    #                          ** CLEANUP **
    # ================================================================
    test_map.queue_free()
    # Process frame to remove the hud and the map
    await get_tree().process_frame


func test_display_continer_after_built_tower_upgrade_hybrid():
    
    # SCENARIO:
        # Player upgrades buit towers to lava pool
        # Player has placed tower awaiting selection, but not the max number of towers for the turn
        # Wave is not in progress at the time of upgrade
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
    #                   ** PLACE BUILT TOWERS **
    # ================================================================
    # Simulate player entering build mode
    random_build_tower_hud._on_build_random_tower_button_pressed()
    # Build three random towers to fill the awaiting selection container but not reach the max towers per turn
    random_build_tower_hud.GAME_MAP.place_tower(Vector2i(7, 5))
    random_build_tower_hud.GAME_MAP.place_tower(Vector2i(9, 5))
    random_build_tower_hud.GAME_MAP.place_tower(Vector2i(11, 5))
    # Simulate player exiting build mode
    random_build_tower_hud._on_exit_build_mode_button_pressed()

    # Create towers required for upgrade to LAVA POOL
    random_build_tower_hud.GAME_MAP.place_built_tower(Vector2i(4, 5), TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2)
    random_build_tower_hud.GAME_MAP.place_built_tower(Vector2i(4, 7), TowerConstants.TowerIDs.SPINEL_LVL_2)
    random_build_tower_hud.GAME_MAP.place_built_tower(Vector2i(4, 9), TowerConstants.TowerIDs.SPINEL_LVL_3)

    var black_marble_lvl_2: Tower = random_build_tower_hud.GAME_MAP.__towers_on_map[0]
    var spinel_lvl_2: Tower = random_build_tower_hud.GAME_MAP.__towers_on_map[1]
    var spinel_lvl_3: Tower = random_build_tower_hud.GAME_MAP.__towers_on_map[2]

    assert_eq(black_marble_lvl_2.TOWER_ID, TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2, "First tower is black marble level 2")
    assert_eq(spinel_lvl_2.TOWER_ID, TowerConstants.TowerIDs.SPINEL_LVL_2, "Second tower is spinel level 2")
    assert_eq(spinel_lvl_3.TOWER_ID, TowerConstants.TowerIDs.SPINEL_LVL_3, "Third tower is spinel level 3")


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
    # Simulate black marble lvl 2 being selected
    random_build_tower_hud._on_tower_selected(black_marble_lvl_2)
    await get_tree().process_frame
    
    # Ensure lava pool button is visible
    assert_true(random_build_tower_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container is visible when black marble level 2 is selected")
    assert_true(random_build_tower_hud.TOWER_UPGRADES_CONTAINER.LAVA_POOL_BUTTON.visible, "Lava pool upgrade button is visible when black marble level 2 is selected")
    
    # Simulate built towers being upgraded to lava pool
    random_build_tower_hud.TOWER_UPGRADES_CONTAINER._on_lava_pool_button_pressed()
    await get_tree().process_frame

    

    # ================================================================
    #                      ** ASSES RESULTS **
    # ================================================================
    # Build random tower container should still be visible after upgrade
    assert_true(random_build_tower_hud.BUILD_RANDOM_TOWER_CONTAINER.visible, "Build random tower container is still visible after upgrading to lava pool")

    # ================================================================
    #                          ** CLEANUP **
    # ================================================================
    test_map.queue_free()
    # Process frame to remove the hud and the map
    await get_tree().process_frame


func test_hide_continer_after_awaiting_tower_upgrade():
    # SCENARIO:
        # Player upgrades towers awaiting selection to lava pool
        # Player has not placed the max number of towers for the turn
        # Wave is not in progress at the time of upgrade
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
    #                   ** PLACE BUILT TOWERS **
    # ================================================================
    # Create towers required for upgrade to LAVA POOL
    random_build_tower_hud.GAME_MAP.__build_tower_preload = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2]
    random_build_tower_hud.GAME_MAP.place_tower(Vector2i(4, 5))
    random_build_tower_hud.GAME_MAP.__build_tower_preload = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.SPINEL_LVL_2]
    random_build_tower_hud.GAME_MAP.place_tower(Vector2i(4, 7))
    random_build_tower_hud.GAME_MAP.__build_tower_preload = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.SPINEL_LVL_3]
    random_build_tower_hud.GAME_MAP.place_tower(Vector2i(4, 9))


    var black_marble_lvl_2: Tower = random_build_tower_hud.GAME_MAP.__towers_awaiting_selection[0]
    var spinel_lvl_2: Tower = random_build_tower_hud.GAME_MAP.__towers_awaiting_selection[1]
    var spinel_lvl_3: Tower = random_build_tower_hud.GAME_MAP.__towers_awaiting_selection[2]

    assert_eq(black_marble_lvl_2.TOWER_ID, TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2, "First tower is black marble level 2")
    assert_eq(spinel_lvl_2.TOWER_ID, TowerConstants.TowerIDs.SPINEL_LVL_2, "Second tower is spinel level 2")
    assert_eq(spinel_lvl_3.TOWER_ID, TowerConstants.TowerIDs.SPINEL_LVL_3, "Third tower is spinel level 3")


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
    # Simulate black marble lvl 2 being selected
    random_build_tower_hud._on_tower_selected(black_marble_lvl_2)
    await get_tree().process_frame
    
    # Ensure lava pool button is visible
    assert_true(random_build_tower_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container is visible when black marble level 2 is selected")
    assert_true(random_build_tower_hud.TOWER_UPGRADES_CONTAINER.LAVA_POOL_BUTTON.visible, "Lava pool upgrade button is visible when black marble level 2 is selected")
    
    # Simulate built towers being upgraded to lava pool
    random_build_tower_hud.TOWER_UPGRADES_CONTAINER._on_lava_pool_button_pressed()
    await get_tree().process_frame

    

    # ================================================================
    #                      ** ASSES RESULTS **
    # ================================================================
    # Build random tower container should no longer be visible after upgrade since the towers were awaiting selection at the time of upgrade
    assert_false(random_build_tower_hud.BUILD_RANDOM_TOWER_CONTAINER.visible, "Build random tower container is not visible after upgrading to lava pool with towers awaiting selection")

    # ================================================================
    #                          ** CLEANUP **
    # ================================================================
    test_map.queue_free()
    # Process frame to remove the hud and the map
    await get_tree().process_frame