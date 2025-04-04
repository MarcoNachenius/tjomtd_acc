extends GutTest

## Simpulate situation where spawner global position is (0, 0), the creep global 
## position is always different and both of their positions are (0,0).

## Reset before each test case
func before_each():
	await get_tree().process_frame  # Ensure previous nodes are fully freed.


func test_angle_to_targeted_creep_north_east():
	# Create seperate points from which test objects will spawn
	var creep_place_point: Node2D = Node2D.new()
	var projectile_spawner_place_point: Node2D = Node2D.new()
	# Add object placers to scene for testing
	add_child_autofree(creep_place_point)
	add_child_autofree(projectile_spawner_place_point)
	# Set  placer positions
	projectile_spawner_place_point.global_position = Vector2.ZERO
	creep_place_point.global_position = Vector2(3.5, 0.0) # NORTH-EAST of spawner
	# Create test objects
	var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER].instantiate()
	var test_projectile_spawner = ProjectileSpawner.new()
	# Add test objects as child objects of placers
	creep_place_point.add_child(test_creep)
	projectile_spawner_place_point.add_child(test_projectile_spawner)
	# Verify starting positions
	assert_eq(test_projectile_spawner.global_position, Vector2.ZERO)
	assert_eq(test_projectile_spawner.position, Vector2.ZERO)
	assert_eq(test_creep.global_position, Vector2(3.5, 0.0))
	assert_eq(test_creep.position, Vector2.ZERO)
	
	# Conduct test
	test_projectile_spawner.__target = test_creep
	var retreived_angle: float = test_projectile_spawner._angle_to_targeted_creep()
	assert_almost_eq(retreived_angle, 0.0, 0.1)
	
	# Clean up
	test_creep.queue_free()
	test_projectile_spawner.queue_free()
	creep_place_point.queue_free()
	projectile_spawner_place_point.queue_free()

func test_angle_to_targeted_creep_east():
	# Create seperate points from which test objects will spawn
	var creep_place_point: Node2D = Node2D.new()
	var projectile_spawner_place_point: Node2D = Node2D.new()
	# Add object placers to scene for testing
	add_child_autofree(creep_place_point)
	add_child_autofree(projectile_spawner_place_point)
	# Set  placer positions
	projectile_spawner_place_point.global_position = Vector2.ZERO
	creep_place_point.global_position = Vector2(3.5, 3.5) # EAST of spawner
	# Create test objects
	var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER].instantiate()
	var test_projectile_spawner = ProjectileSpawner.new()
	# Add test objects as child objects of placers
	creep_place_point.add_child(test_creep)
	projectile_spawner_place_point.add_child(test_projectile_spawner)
	# Verify starting positions
	assert_eq(test_projectile_spawner.global_position, Vector2.ZERO)
	assert_eq(test_projectile_spawner.position, Vector2.ZERO)
	assert_eq(test_creep.global_position, Vector2(3.5, 3.5))
	assert_eq(test_creep.position, Vector2.ZERO)
	
	# Conduct test
	test_projectile_spawner.__target = test_creep
	var retreived_angle: float = test_projectile_spawner._angle_to_targeted_creep()
	assert_almost_eq(retreived_angle, PI/4, 0.1)
	
	# Clean up
	test_creep.queue_free()
	test_projectile_spawner.queue_free()
	creep_place_point.queue_free()
	projectile_spawner_place_point.queue_free()

func test_angle_to_targeted_creep_south_east():
	# Create seperate points from which test objects will spawn
	var creep_place_point: Node2D = Node2D.new()
	var projectile_spawner_place_point: Node2D = Node2D.new()
	# Add object placers to scene for testing
	add_child_autofree(creep_place_point)
	add_child_autofree(projectile_spawner_place_point)
	# Set  placer positions
	projectile_spawner_place_point.global_position = Vector2.ZERO
	creep_place_point.global_position = Vector2(0, 3.5) # SOUTH-EAST of spawner
	# Create test objects
	var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER].instantiate()
	var test_projectile_spawner = ProjectileSpawner.new()
	# Add test objects as child objects of placers
	creep_place_point.add_child(test_creep)
	projectile_spawner_place_point.add_child(test_projectile_spawner)
	# Verify starting positions
	assert_eq(test_projectile_spawner.global_position, Vector2.ZERO)
	assert_eq(test_projectile_spawner.position, Vector2.ZERO)
	assert_eq(test_creep.global_position, Vector2(0, 3.5))
	assert_eq(test_creep.position, Vector2.ZERO)
	
	# Conduct test
	test_projectile_spawner.__target = test_creep
	var retreived_angle: float = test_projectile_spawner._angle_to_targeted_creep()
	assert_almost_eq(retreived_angle, PI * 2/4, 0.1)
	
	# Clean up
	test_creep.queue_free()
	test_projectile_spawner.queue_free()
	creep_place_point.queue_free()
	projectile_spawner_place_point.queue_free()

func test_angle_to_targeted_creep_south():
	# Create seperate points from which test objects will spawn
	var creep_place_point: Node2D = Node2D.new()
	var projectile_spawner_place_point: Node2D = Node2D.new()
	# Add object placers to scene for testing
	add_child_autofree(creep_place_point)
	add_child_autofree(projectile_spawner_place_point)
	# Set  placer positions
	projectile_spawner_place_point.global_position = Vector2.ZERO
	creep_place_point.global_position = Vector2(-3.5, 3.5) # SOUTH of spawner
	# Create test objects
	var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER].instantiate()
	var test_projectile_spawner = ProjectileSpawner.new()
	# Add test objects as child objects of placers
	creep_place_point.add_child(test_creep)
	projectile_spawner_place_point.add_child(test_projectile_spawner)
	# Verify starting positions
	assert_eq(test_projectile_spawner.global_position, Vector2.ZERO)
	assert_eq(test_projectile_spawner.position, Vector2.ZERO)
	assert_eq(test_creep.global_position, Vector2(-3.5, 3.5))
	assert_eq(test_creep.position, Vector2.ZERO)
	
	# Conduct test
	test_projectile_spawner.__target = test_creep
	var retreived_angle: float = test_projectile_spawner._angle_to_targeted_creep()
	assert_almost_eq(retreived_angle, PI * 3/4, 0.1)
	
	# Clean up
	test_creep.queue_free()
	test_projectile_spawner.queue_free()
	creep_place_point.queue_free()
	projectile_spawner_place_point.queue_free()

func test_angle_to_targeted_creep_south_west():
	# Create seperate points from which test objects will spawn
	var creep_place_point: Node2D = Node2D.new()
	var projectile_spawner_place_point: Node2D = Node2D.new()
	# Add object placers to scene for testing
	add_child_autofree(creep_place_point)
	add_child_autofree(projectile_spawner_place_point)
	# Set  placer positions
	projectile_spawner_place_point.global_position = Vector2.ZERO
	creep_place_point.global_position = Vector2(-3.5, 0.0) # SOUTH-WEST of spawner
	# Create test objects
	var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER].instantiate()
	var test_projectile_spawner = ProjectileSpawner.new()
	# Add test objects as child objects of placers
	creep_place_point.add_child(test_creep)
	projectile_spawner_place_point.add_child(test_projectile_spawner)
	# Verify starting positions
	assert_eq(test_projectile_spawner.global_position, Vector2.ZERO)
	assert_eq(test_projectile_spawner.position, Vector2.ZERO)
	assert_eq(test_creep.global_position, Vector2(-3.5, 0.0))
	assert_eq(test_creep.position, Vector2.ZERO)
	
	# Conduct test
	test_projectile_spawner.__target = test_creep
	var retreived_angle: float = test_projectile_spawner._angle_to_targeted_creep()
	assert_almost_eq(retreived_angle, PI * 4/4, 0.1)
	
	# Clean up
	test_creep.queue_free()
	test_projectile_spawner.queue_free()
	creep_place_point.queue_free()
	projectile_spawner_place_point.queue_free()

func test_angle_to_targeted_creep_west():
	# Create seperate points from which test objects will spawn
	var creep_place_point: Node2D = Node2D.new()
	var projectile_spawner_place_point: Node2D = Node2D.new()
	# Add object placers to scene for testing
	add_child_autofree(creep_place_point)
	add_child_autofree(projectile_spawner_place_point)
	# Set  placer positions
	projectile_spawner_place_point.global_position = Vector2.ZERO
	creep_place_point.global_position = Vector2(-3.5, -3.5) # WEST of spawner
	# Create test objects
	var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER].instantiate()
	var test_projectile_spawner = ProjectileSpawner.new()
	# Add test objects as child objects of placers
	creep_place_point.add_child(test_creep)
	projectile_spawner_place_point.add_child(test_projectile_spawner)
	# Verify starting positions
	assert_eq(test_projectile_spawner.global_position, Vector2.ZERO)
	assert_eq(test_projectile_spawner.position, Vector2.ZERO)
	assert_eq(test_creep.global_position, Vector2(-3.5, -3.5))
	assert_eq(test_creep.position, Vector2.ZERO)
	
	# Conduct test
	test_projectile_spawner.__target = test_creep
	var retreived_angle: float = test_projectile_spawner._angle_to_targeted_creep()
	assert_almost_eq(retreived_angle, PI * 5/4, 0.1)
	
	# Clean up
	test_creep.queue_free()
	test_projectile_spawner.queue_free()
	creep_place_point.queue_free()
	projectile_spawner_place_point.queue_free()

func test_angle_to_targeted_creep_north_west():
	# Create seperate points from which test objects will spawn
	var creep_place_point: Node2D = Node2D.new()
	var projectile_spawner_place_point: Node2D = Node2D.new()
	# Add object placers to scene for testing
	add_child_autofree(creep_place_point)
	add_child_autofree(projectile_spawner_place_point)
	# Set  placer positions
	projectile_spawner_place_point.global_position = Vector2.ZERO
	creep_place_point.global_position = Vector2(0.0, -3.5) # NORTH-WEST of spawner
	# Create test objects
	var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER].instantiate()
	var test_projectile_spawner = ProjectileSpawner.new()
	# Add test objects as child objects of placers
	creep_place_point.add_child(test_creep)
	projectile_spawner_place_point.add_child(test_projectile_spawner)
	# Verify starting positions
	assert_eq(test_projectile_spawner.global_position, Vector2.ZERO)
	assert_eq(test_projectile_spawner.position, Vector2.ZERO)
	assert_eq(test_creep.global_position, Vector2(0.0, -3.5))
	assert_eq(test_creep.position, Vector2.ZERO)
	
	# Conduct test
	test_projectile_spawner.__target = test_creep
	var retreived_angle: float = test_projectile_spawner._angle_to_targeted_creep()
	assert_almost_eq(retreived_angle, PI * 6/4, 0.1)
	
	# Clean up
	test_creep.queue_free()
	test_projectile_spawner.queue_free()
	creep_place_point.queue_free()
	projectile_spawner_place_point.queue_free()

func test_angle_to_targeted_creep_north():
	# Create seperate points from which test objects will spawn
	var creep_place_point: Node2D = Node2D.new()
	var projectile_spawner_place_point: Node2D = Node2D.new()
	# Add object placers to scene for testing
	add_child_autofree(creep_place_point)
	add_child_autofree(projectile_spawner_place_point)
	# Set  placer positions
	projectile_spawner_place_point.global_position = Vector2.ZERO
	creep_place_point.global_position = Vector2(3.5, -3.5) # WEST of spawner
	# Create test objects
	var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER].instantiate()
	var test_projectile_spawner = ProjectileSpawner.new()
	# Add test objects as child objects of placers
	creep_place_point.add_child(test_creep)
	projectile_spawner_place_point.add_child(test_projectile_spawner)
	# Verify starting positions
	assert_eq(test_projectile_spawner.global_position, Vector2.ZERO)
	assert_eq(test_projectile_spawner.position, Vector2.ZERO)
	assert_eq(test_creep.global_position, Vector2(3.5, -3.5))
	assert_eq(test_creep.position, Vector2.ZERO)
	
	# Conduct test
	test_projectile_spawner.__target = test_creep
	var retreived_angle: float = test_projectile_spawner._angle_to_targeted_creep()
	assert_almost_eq(retreived_angle, PI * 7/4, 0.1)
	
	# Clean up
	test_creep.queue_free()
	test_projectile_spawner.queue_free()
	creep_place_point.queue_free()
	projectile_spawner_place_point.queue_free()
