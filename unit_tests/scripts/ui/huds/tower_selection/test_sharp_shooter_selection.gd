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


func test_sam_site_lvl_1_selection():
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
	var sam_site_lvl_1: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.UpgradeTowerIDs.SHARP_SHOOTER_LVL_1].instantiate()
	test_game_map.add_child(sam_site_lvl_1)
	sam_site_lvl_1.switch_state(Tower.States.BUILT)

	# Create simulated list of towers and assign to game map
	var test_towers_awaiting_selection: Array[Tower] = [sam_site_lvl_1]
	test_game_map.__towers_on_map = test_towers_awaiting_selection

	assert_not_null(sam_site_lvl_1.PRIMARY_PROJECTILE_SPAWNER, "Tower has primary projectile spawner assigned.")

	# Simulate tower being selected
	test_game_map.tower_selected.emit(sam_site_lvl_1)

	# Process frame to ensure the tower selected signal is processed
	await get_tree().process_frame

	# Clean up
	test_game_map.queue_free()
	test_random_tower_build_hud.queue_free()
	sam_site_lvl_1.queue_free()
	# Process frame to ensure all objects are cleaned up
	await get_tree().process_frame

func test_sam_site_lvl_2_selection():
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
	var sam_site_lvl_2: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.UpgradeTowerIDs.SHARP_SHOOTER_LVL_2].instantiate()
	test_game_map.add_child(sam_site_lvl_2)
	sam_site_lvl_2.switch_state(Tower.States.BUILT)

	# Create simulated list of towers and assign to game map
	var test_towers_awaiting_selection: Array[Tower] = [sam_site_lvl_2]
	test_game_map.__towers_on_map = test_towers_awaiting_selection

	assert_not_null(sam_site_lvl_2.PRIMARY_PROJECTILE_SPAWNER, "Tower has primary projectile spawner assigned.")

	# Simulate tower being selected
	test_game_map.tower_selected.emit(sam_site_lvl_2)

	# Process frame to ensure the tower selected signal is processed
	await get_tree().process_frame

	# Clean up
	test_game_map.queue_free()
	test_random_tower_build_hud.queue_free()
	sam_site_lvl_2.queue_free()
	# Process frame to ensure all objects are cleaned up
	await get_tree().process_frame