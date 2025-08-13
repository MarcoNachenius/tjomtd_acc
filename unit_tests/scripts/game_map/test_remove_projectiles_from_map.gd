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

## This is a one-size-fits-all way of testing how the map removes all projectiles
## because all projectile spawners add projectiles as their children when they launch.
func test_remove_projectiles_from_map():
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
	
	# Create test creep
	# -----------------
	var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.BLUE_SPIDER].instantiate()
	add_child_autofree(test_creep)
	# Place creep outside tower range
	test_creep.global_position = Vector2(-1000, -1000)
	test_creep.stun(10)
	await get_tree().process_frame


	# Place tower on map 
	# -------------------
	const SAM_SITE_LVL_1_TOWER_ID: TowerConstants.TowerIDs = TowerConstants.TowerIDs.SAM_SITE_LVL_1
	const ARBITRARY_PLACEMENT_COORD: Vector2i = Vector2i(10, 10)
	test_map.place_built_tower(ARBITRARY_PLACEMENT_COORD, SAM_SITE_LVL_1_TOWER_ID)
	# Process frame to ensure tower's projectile spawner gets created when it 
	# has been added to scene.
	await get_tree().process_frame
	# Ensure tower has been added to map
	assert_eq(test_map.get_towers_on_map().size(), 1, "Map contains tower")

	# Extract and assign tower from map
	# ---------------------------------
	# Ensure tower on map is correctly typed
	assert_true(test_map.get_towers_on_map()[0] is Tower, "Tower on map is correctly typed")
	# Extract tower as var
	var sam_site_lvl_1_tower: Tower = test_map.get_towers_on_map()[0]
	# Ensure tower's projectile spawner has been created
	assert_not_null(sam_site_lvl_1_tower.PRIMARY_PROJECTILE_SPAWNER, "Tower's projectile spawner has been created")

	# Set up projectile tracking
	# --------------------------
	var found_projectiles: bool = false
	# Ensure method of searching for projectiles does not produce false positives.
	for child in sam_site_lvl_1_tower.PRIMARY_PROJECTILE_SPAWNER.get_children():
		if child is Projectile:
			found_projectiles = true
			break
	assert_false(found_projectiles, "No projectiles found before launch")

	# Add projectiles to scene
	# ------------------------
	# Assign target to projectile spawner
	sam_site_lvl_1_tower.PRIMARY_PROJECTILE_SPAWNER.__target = test_creep
	# Call function that adds projectiles to scene
	sam_site_lvl_1_tower.PRIMARY_PROJECTILE_SPAWNER._launch_projectiles()
	# Ensure projectile has been fully created
	await get_tree().process_frame
	# Verify that projectile has been added to scene
	for child in sam_site_lvl_1_tower.PRIMARY_PROJECTILE_SPAWNER.get_children():
		if child is Projectile:
			found_projectiles = true
			break
	assert_true(found_projectiles, "Projectile found after launch")

	# Remove projectiles from scene
	# -----------------------------
	# CALL TEST FUNCTION
	test_map.remove_remaining_projectiles()
	# Process frame to remove all projectiles from scene
	await get_tree().process_frame
	# Reset search value
	found_projectiles = false 
	# Ensure method of searching for projectiles does not produce false positives.
	for child in sam_site_lvl_1_tower.PRIMARY_PROJECTILE_SPAWNER.get_children():
		if child is Projectile:
			found_projectiles = true
			break
	assert_false(found_projectiles, "Projectiles successfully removed")

	# Clean up
	test_map.queue_free()
