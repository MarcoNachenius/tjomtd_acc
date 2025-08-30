extends GutTest

func before_each():
    await get_tree().process_frame


func test_damage_slate_lvl_1_button_use():
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
    #                ** CREATE RANDOM BUILD HUD **
    # ================================================================    
    # Create test instance of random tower build hud
    var test_random_tower_build_hud: RandomTowerBuildHUD = GameConstants.HUD_LOADS[GameConstants.HudTypes.RANDOM_TOWER_BUILD].instantiate()
    # Set the game map for the random tower build hud
    test_random_tower_build_hud.GAME_MAP = test_game_map
    add_child_autofree(test_random_tower_build_hud)
    # Process frame to ensure the random tower build hud is ready
    await get_tree().process_frame
    await get_tree().process_frame

    # ================================================================
    #                  ** PLACE REQUIRED TOWERS **
    # ================================================================
    # BLACK_MARBLE_LVL_1
    # Simulate autoload being assigned to required tower
    test_game_map.__build_tower_preload = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BLACK_MARBLE_LVL_1]
    # Simulate tower being placed on map (placement grid coord is arbitrary)
    test_game_map.place_tower(Vector2i(5, 5))
    await get_tree().process_frame
    # BLACK_MARBLE_LVL_2
    # Simulate autoload being assigned to required tower
    test_game_map.__build_tower_preload = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BLACK_MARBLE_LVL_2]
    # Simulate tower being placed on map (placement grid coord is arbitrary)
    test_game_map.place_tower(Vector2i(5, 7))
    await get_tree().process_frame
    # SPINEL_LVL_3
    # Simulate autoload being assigned to required tower
    test_game_map.__build_tower_preload = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.SPINEL_LVL_3]
    # Simulate tower being placed on map (placement grid coord is arbitrary)
    test_game_map.place_tower(Vector2i(5, 9))
    await get_tree().process_frame

    # ================================================================
    #                ** EVALUATE BUTTON DISPLAY RESULTS **
    # ================================================================
    # Ensure towers have been added to map
    assert_true(test_game_map.__towers_awaiting_selection.size() > 0, "Towers awaiting selection have been added to map")
    # Simulate tower being selected (which specific tower is being selected is arbitrary)
    test_random_tower_build_hud._on_tower_selected(test_game_map.__towers_awaiting_selection[0])

    # Ensure intended upgrade slate buttons are visible
    var expected_visible_tower_buttons: Array[Button] = [
        test_random_tower_build_hud.AWAITING_SELECTION_SLATE_UPGRADES_CONTAINER.DAMAGE_SLATE_LVL_1_BUTTON
    ]
    for button in expected_visible_tower_buttons:
        assert_true(button.visible, "Intended button is visible")

    # Ensure only the buttons that are expected are visible
    var found_unexpected_visible_button: bool = false
    for button in test_random_tower_build_hud.AWAITING_SELECTION_SLATE_UPGRADES_CONTAINER.ALL_BUTTONS:
        # Ignore buttons that are expected to be visible
        if expected_visible_tower_buttons.has(button):
            continue
        # Check for unwanted visibility of button
        if button.visible:
            found_unexpected_visible_button = true
            break
    assert_false(found_unexpected_visible_button, "No unwanted visible buttons detected")

    # ================================================================
    #               ** EVALUATE BUTTON PRESSED RESULTS **
    # ================================================================

    # Simulate tower slate being kept
    test_random_tower_build_hud.AWAITING_SELECTION_SLATE_UPGRADES_CONTAINER._on_damage_slate_lvl_1_button_pressed()
    # Process frame to convert selected tower to slate
    await get_tree().process_frame

    # Ensure slate with the desired ID has been added to map
    assert_eq(test_game_map.SLATE_MANAGER.__slates_on_map[0].SLATE_ID, SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_1, "DAMAGE_SLATE_LVL_1 slate successfully created")

    # Clean up
    test_random_tower_build_hud.queue_free()


func test_damage_slate_lvl_2_button_use():
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
    #                ** CREATE RANDOM BUILD HUD **
    # ================================================================    
    # Create test instance of random tower build hud
    var test_random_tower_build_hud: RandomTowerBuildHUD = GameConstants.HUD_LOADS[GameConstants.HudTypes.RANDOM_TOWER_BUILD].instantiate()
    # Set the game map for the random tower build hud
    test_random_tower_build_hud.GAME_MAP = test_game_map
    add_child_autofree(test_random_tower_build_hud)
    # Process frame to ensure the random tower build hud is ready
    await get_tree().process_frame
    await get_tree().process_frame

    # ================================================================
    #                  ** PLACE REQUIRED TOWERS **
    # ================================================================
    # BLACK_MARBLE_LVL_3
    # Simulate autoload being assigned to required tower
    test_game_map.__build_tower_preload = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BLACK_MARBLE_LVL_3]
    # Simulate tower being placed on map (placement grid coord is arbitrary)
    test_game_map.place_tower(Vector2i(5, 7))
    await get_tree().process_frame
    # SPINEL_LVL_4
    # Simulate autoload being assigned to required tower
    test_game_map.__build_tower_preload = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.SPINEL_LVL_4]
    # Simulate tower being placed on map (placement grid coord is arbitrary)
    test_game_map.place_tower(Vector2i(5, 9))
    await get_tree().process_frame

    # ================================================================
    #                ** EVALUATE BUTTON DISPLAY RESULTS **
    # ================================================================
    # Ensure towers have been added to map
    assert_true(test_game_map.__towers_awaiting_selection.size() > 0, "Towers awaiting selection have been added to map")
    # Simulate tower being selected (which specific tower is being selected is arbitrary)
    test_random_tower_build_hud._on_tower_selected(test_game_map.__towers_awaiting_selection[0])

    # Ensure intended upgrade slate buttons are visible
    var expected_visible_tower_buttons: Array[Button] = [
        test_random_tower_build_hud.AWAITING_SELECTION_SLATE_UPGRADES_CONTAINER.DAMAGE_SLATE_LVL_2_BUTTON
    ]
    for button in expected_visible_tower_buttons:
        assert_true(button.visible, "Intended button is visible")

    # Ensure only the buttons that are expected are visible
    var found_unexpected_visible_button: bool = false
    for button in test_random_tower_build_hud.AWAITING_SELECTION_SLATE_UPGRADES_CONTAINER.ALL_BUTTONS:
        # Ignore buttons that are expected to be visible
        if expected_visible_tower_buttons.has(button):
            continue
        # Check for unwanted visibility of button
        if button.visible:
            found_unexpected_visible_button = true
            break
    assert_false(found_unexpected_visible_button, "No unwanted visible buttons detected")

    # ================================================================
    #               ** EVALUATE BUTTON PRESSED RESULTS **
    # ================================================================

    # Simulate tower slate being kept
    test_random_tower_build_hud.AWAITING_SELECTION_SLATE_UPGRADES_CONTAINER._on_damage_slate_lvl_2_button_pressed()
    # Process frame to convert selected tower to slate
    await get_tree().process_frame

    # Ensure slate with the desired ID has been added to map
    assert_eq(test_game_map.SLATE_MANAGER.__slates_on_map[0].SLATE_ID, SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_2, "DAMAGE_SLATE_LVL_2 slate successfully created")

    # Clean up
    test_random_tower_build_hud.queue_free()


func test_damage_slate_lvl_3_button_use():
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
    #                ** CREATE RANDOM BUILD HUD **
    # ================================================================    
    # Create test instance of random tower build hud
    var test_random_tower_build_hud: RandomTowerBuildHUD = GameConstants.HUD_LOADS[GameConstants.HudTypes.RANDOM_TOWER_BUILD].instantiate()
    # Set the game map for the random tower build hud
    test_random_tower_build_hud.GAME_MAP = test_game_map
    add_child_autofree(test_random_tower_build_hud)
    # Process frame to ensure the random tower build hud is ready
    await get_tree().process_frame
    await get_tree().process_frame

    # ================================================================
    #                  ** PLACE REQUIRED TOWERS **
    # ================================================================
    # BLACK_MARBLE_LVL_3
    # Simulate autoload being assigned to required tower
    test_game_map.__build_tower_preload = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BLACK_MARBLE_LVL_3]
    # Simulate tower being placed on map (placement grid coord is arbitrary)
    test_game_map.place_tower(Vector2i(5, 5))
    await get_tree().process_frame
    # BLACK_MARBLE_LVL_4
    # Simulate autoload being assigned to required tower
    test_game_map.__build_tower_preload = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.BLACK_MARBLE_LVL_4]
    # Simulate tower being placed on map (placement grid coord is arbitrary)
    test_game_map.place_tower(Vector2i(5, 7))
    await get_tree().process_frame
    # SPINEL_LVL_5
    # Simulate autoload being assigned to required tower
    test_game_map.__build_tower_preload = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.SPINEL_LVL_5]
    # Simulate tower being placed on map (placement grid coord is arbitrary)
    test_game_map.place_tower(Vector2i(5, 9))
    await get_tree().process_frame

    # ================================================================
    #                ** EVALUATE BUTTON DISPLAY RESULTS **
    # ================================================================
    # Ensure towers have been added to map
    assert_true(test_game_map.__towers_awaiting_selection.size() > 0, "Towers awaiting selection have been added to map")
    # Simulate tower being selected (which specific tower is being selected is arbitrary)
    test_random_tower_build_hud._on_tower_selected(test_game_map.__towers_awaiting_selection[0])

    # Ensure intended upgrade slate buttons are visible
    var expected_visible_tower_buttons: Array[Button] = [
        test_random_tower_build_hud.AWAITING_SELECTION_SLATE_UPGRADES_CONTAINER.DAMAGE_SLATE_LVL_3_BUTTON
    ]
    for button in expected_visible_tower_buttons:
        assert_true(button.visible, "Intended button is visible")

    # Ensure only the buttons that are expected are visible
    var found_unexpected_visible_button: bool = false
    for button in test_random_tower_build_hud.AWAITING_SELECTION_SLATE_UPGRADES_CONTAINER.ALL_BUTTONS:
        # Ignore buttons that are expected to be visible
        if expected_visible_tower_buttons.has(button):
            continue
        # Check for unwanted visibility of button
        if button.visible:
            found_unexpected_visible_button = true
            break
    assert_false(found_unexpected_visible_button, "No unwanted visible buttons detected")

    # ================================================================
    #               ** EVALUATE BUTTON PRESSED RESULTS **
    # ================================================================

    # Simulate tower slate being kept
    test_random_tower_build_hud.AWAITING_SELECTION_SLATE_UPGRADES_CONTAINER._on_damage_slate_lvl_3_button_pressed()
    # Process frame to convert selected tower to slate
    await get_tree().process_frame

    # Ensure slate with the desired ID has been added to map
    assert_eq(test_game_map.SLATE_MANAGER.__slates_on_map[0].SLATE_ID, SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_3, "DAMAGE_SLATE_LVL_3 slate successfully created")

    # Clean up
    test_random_tower_build_hud.queue_free()