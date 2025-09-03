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


func test_speed_display_with_tower_speed_aura():
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

    # Test values
    const TEST_STARTING_SPEED: float = 0.5
    const TEST_STARTING_SPEED_DISPLAY_TEXT: String = "0.5s"
    const TEST_SPEED_INCREASE_FACTOR: float = 0.5
    const TEST_BUFFED_SPEED: float = 0.25
    const TEST_BUFFED_SPEED_DISPLAY_TEXT: String = "0.5s (-0.25s)"

    # Process frame to ensure the game map is ready
    await get_tree().process_frame

    # Create test instance of random tower build hud
    var test_random_tower_build_hud: RandomTowerBuildHUD = GameConstants.HUD_LOADS[GameConstants.HudTypes.RANDOM_TOWER_BUILD].instantiate()
    # Set the game map for the random tower build hud
    test_random_tower_build_hud.GAME_MAP = test_game_map
    add_child_autofree(test_random_tower_build_hud)
    # Process frame to ensure the random tower build hud is ready
    await get_tree().process_frame

    # Place tower on map
    test_game_map.place_built_tower(Vector2i(10 ,10), TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1)
    await get_tree().process_frame

    # Ensure tower has been added to map
    assert_eq(test_game_map.__towers_on_map.size(), 1, "Tower has been detected on map")

    # Assign tower to var
    var black_marble_lvl_1: Tower = test_game_map.__towers_on_map[0]

    # Ensure tower has primary projectile spawner
    assert_not_null(black_marble_lvl_1.PRIMARY_PROJECTILE_SPAWNER, "Tower has primary projectile spawner assigned.")

    # Artificially assign tower's starting speed
    black_marble_lvl_1.PRIMARY_PROJECTILE_SPAWNER.INITIAL_SPEED = TEST_STARTING_SPEED
    black_marble_lvl_1.PRIMARY_PROJECTILE_SPAWNER.__cooldown_duration = TEST_STARTING_SPEED

    # Simulate tower being selected
    test_game_map.tower_selected.emit(black_marble_lvl_1)

    # Process frame to ensure the tower selected signal is processed
    await get_tree().process_frame

    # Ensure starting speed has also been assigned to primary projectile spawner's cooldown timer
    assert_eq(black_marble_lvl_1.PRIMARY_PROJECTILE_SPAWNER.__cooldown_timer.wait_time, TEST_STARTING_SPEED, "Projectile spawner's initial timer wait time is correct.")

    # Ensure display speed without buff is correct
    var got_initial_display_text: String = test_random_tower_build_hud.SELECTED_TOWER_STATS_CONTAINER.TOWER_ATTR_CONTAINER.COOLDOWN_VALUE.text
    assert_eq(got_initial_display_text, TEST_STARTING_SPEED_DISPLAY_TEXT, "Display speed without buff amount is correct")

    # ADD SPEED AURA
    # ---------------
    # Instantiate speed aura scene
    var test_speed_aura: TowerSpeedAura = TowerAuraConstants.TOWER_SPEED_AURA_PRELOAD.instantiate()
    # Set aura increase factor
    test_speed_aura.SPEED_INCREASE_FACTOR = TEST_SPEED_INCREASE_FACTOR
    # Add speed aura to map (where it would appear when implemented)
    test_game_map.add_child(test_speed_aura)
    # Place speed aura in same position as tower
    test_speed_aura.global_position = black_marble_lvl_1.global_position
    # Process frame which adds speed aura
    await get_tree().process_frame
    # Process frame which triggers overlapping areas
    await get_tree().physics_frame
    # Process frame which handles signal emissions
    await get_tree().physics_frame

    # Ensure speed buff has reached tower
    assert_eq(black_marble_lvl_1.PRIMARY_PROJECTILE_SPAWNER.get_cooldown_duration(), TEST_BUFFED_SPEED, "Initial tower speed timer wait time is correct.")

    # Simulate tower being selected again after speed buff has been applied
    test_game_map.tower_selected.emit(black_marble_lvl_1)
    # Process frame which handles signal emission
    await get_tree().process_frame

    # Ensure display speed has been updated after speed buff
    var got_buffed_speed_display_text: String = test_random_tower_build_hud.SELECTED_TOWER_STATS_CONTAINER.TOWER_ATTR_CONTAINER.COOLDOWN_VALUE.text
    assert_eq(got_buffed_speed_display_text, TEST_BUFFED_SPEED_DISPLAY_TEXT, "Display speed with buff amount is correct")

    # Ensure buffed speed has also been assigned to primary projectile spawner's cooldown timer
    assert_eq(black_marble_lvl_1.PRIMARY_PROJECTILE_SPAWNER.__cooldown_timer.wait_time, TEST_BUFFED_SPEED, "Tower buffed wait time is correct.")

    # Remove speed aura from map
    test_speed_aura.queue_free()
    # Process frame to emit queue free request
    await get_tree().process_frame
    # Process frame to emit area exited signals
    await get_tree().physics_frame
    # Process frame to handle area exited signal methods
    await get_tree().physics_frame

    # Ensure tower's speed has been restored to initial value
    assert_eq(black_marble_lvl_1.PRIMARY_PROJECTILE_SPAWNER.get_cooldown_duration(), TEST_STARTING_SPEED, "Tower speed has been restored to initial value.")

    # Simulate tower being selected again after speed buff has been removed
    test_game_map.tower_selected.emit(black_marble_lvl_1)
    # Process frame which handles signal emission
    await get_tree().process_frame

    # Ensure starting speed has also been reset to primary projectile spawner's cooldown timer
    assert_eq(black_marble_lvl_1.PRIMARY_PROJECTILE_SPAWNER.__cooldown_timer.wait_time, TEST_STARTING_SPEED, "Projectile spawner's initial timer wait time has been correctly reset.")

    # Ensure display speed has been restored to original value
    got_initial_display_text = test_random_tower_build_hud.SELECTED_TOWER_STATS_CONTAINER.TOWER_ATTR_CONTAINER.COOLDOWN_VALUE.text
    assert_eq(got_initial_display_text, TEST_STARTING_SPEED_DISPLAY_TEXT, "Display speed without buff amount is correct")

    # Clean up
    test_game_map.queue_free()
    test_random_tower_build_hud.queue_free()
    black_marble_lvl_1.queue_free()
    # Process frame to ensure all objects are cleaned up
    await get_tree().process_frame