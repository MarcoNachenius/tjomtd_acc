extends GutTest 

func before_each():
    # Ensure previous nodes are fully freed.
    await get_tree().process_frame

## Creating a blank map and processing the frame should create the map is important for 
## creating a test object to run the rest of the tests in this file.
func test_create_blank_map():
    # ================================================================
    #                ** CREATE BLANK MAP **
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


func test_hide_button_after_built_tower_upgrade():
    # SCENARIO:
        # Player upgrades buit towers to lava pool
        # Player has no towers awaiting selection at the time of upgrade
        # Wave is not in progress at the time of upgrade
    # ================================================================
    #                ** CREATE BLANK MAP **
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
    #           ** CREATE RANDOM BUILD TOWER HUD **
    # ================================================================
    # Instantiate random build tower hud
    var random_build_tower_hud: RandomTowerBuildHUD = GameConstants.HUD_LOADS[GameConstants.HudTypes.RANDOM_TOWER_BUILD].instantiate()
    random_build_tower_hud.GAME_MAP = test_map
    add_child_autofree(random_build_tower_hud)
    random_build_tower_hud.add_child(test_map)
    # Process frame to create the hud and the map
    await get_tree().process_frame

    # ================================================================
    #               ** PLACE BUILT TOWERS **
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

    # Simulate black marble lvl 2 being selected
    random_build_tower_hud._on_tower_selected(black_marble_lvl_2)
    await get_tree().process_frame

    # ================================================================
    #             ** VERIFY INITIAL STATE **
    # ================================================================
    # Ensure lava pool button is visible
    assert_true(random_build_tower_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container is visible when black marble level 2 is selected")
    assert_true(random_build_tower_hud.TOWER_UPGRADES_CONTAINER.LAVA_POOL_BUTTON.visible, "Lava pool upgrade button is visible when black marble level 2 is selected")

    # ================================================================
    #                 ** CONDUCT TESTS **
    # ================================================================
    # Simulate built towers being upgraded to lava pool
    random_build_tower_hud.TOWER_UPGRADES_CONTAINER._on_lava_pool_button_pressed()
    await get_tree().process_frame    

    # ================================================================
    #                 ** ASSES RESULTS **
    # ================================================================
    # Ensure lava pool selection has been triggered
    assert_eq(random_build_tower_hud.__selected_tower.TOWER_ID, TowerConstants.TowerIDs.LAVA_POOL_LVL_1, "Selected tower has been upgraded to lava pool level 1")
    # Ensure lava pool button is no longer visible
    assert_false(random_build_tower_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container is not visible after upgrading black marble level 2 to lava pool")
    assert_false(random_build_tower_hud.TOWER_UPGRADES_CONTAINER.LAVA_POOL_BUTTON.visible, "Lava pool upgrade button is not visible after upgrading black marble level 2 to lava pool")

    # ================================================================
    #                    ** CLEANUP **
    # ================================================================
    test_map.queue_free()
    # Process frame to remove the hud and the map
    await get_tree().process_frame


func test_hide_button_after_awaiting_selection_tower_upgrade():
    # SCENARIO:
        # Player upgrades buit towers to lava pool
        # Player has no towers awaiting selection at the time of upgrade
        # Wave is not in progress at the time of upgrade
    # ================================================================
    #                ** CREATE BLANK MAP **
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
    #           ** CREATE RANDOM BUILD TOWER HUD **
    # ================================================================
    # Instantiate random build tower hud
    var random_build_tower_hud: RandomTowerBuildHUD = GameConstants.HUD_LOADS[GameConstants.HudTypes.RANDOM_TOWER_BUILD].instantiate()
    random_build_tower_hud.GAME_MAP = test_map
    add_child_autofree(random_build_tower_hud)
    random_build_tower_hud.add_child(test_map)
    # Process frame to create the hud and the map
    await get_tree().process_frame

    # ================================================================
    #               ** PLACE BUILT TOWERS **
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

    # Simulate black marble lvl 2 being selected
    random_build_tower_hud._on_tower_selected(black_marble_lvl_2)
    await get_tree().process_frame

    # ================================================================
    #             ** VERIFY INITIAL STATE **
    # ================================================================
    # Ensure lava pool button is visible
    assert_true(random_build_tower_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container is visible when black marble level 2 is selected")
    assert_true(random_build_tower_hud.TOWER_UPGRADES_CONTAINER.LAVA_POOL_BUTTON.visible, "Lava pool upgrade button is visible when black marble level 2 is selected")

    # ================================================================
    #                 ** CONDUCT TESTS **
    # ================================================================
    # Simulate built towers being upgraded to lava pool
    random_build_tower_hud.TOWER_UPGRADES_CONTAINER._on_lava_pool_button_pressed()
    await get_tree().process_frame    

    # ================================================================
    #                 ** ASSES RESULTS **
    # ================================================================
    # Ensure lava pool selection has been triggered
    assert_eq(random_build_tower_hud.__selected_tower.TOWER_ID, TowerConstants.TowerIDs.LAVA_POOL_LVL_1, "Selected tower has been upgraded to lava pool level 1")
    # Ensure lava pool button is no longer visible
    assert_false(random_build_tower_hud.TOWER_UPGRADES_CONTAINER.visible, "Tower upgrades container is not visible after upgrading black marble level 2 to lava pool")
    assert_false(random_build_tower_hud.TOWER_UPGRADES_CONTAINER.LAVA_POOL_BUTTON.visible, "Lava pool upgrade button is not visible after upgrading black marble level 2 to lava pool")

    # ================================================================
    #                    ** CLEANUP **
    # ================================================================
    test_map.queue_free()
    # Process frame to remove the hud and the map
    await get_tree().process_frame

