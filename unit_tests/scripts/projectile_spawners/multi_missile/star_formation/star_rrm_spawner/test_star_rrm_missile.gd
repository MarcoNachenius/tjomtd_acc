extends GutTest

## Reset before each test case
func before_each():
	await get_tree().process_frame  # Ensure previous nodes are fully freed.

func test_launch_angles():
	# ======================
	# CREATE MISSILE SPAWNER
	# ======================
	var missile_spawner = StarRandomRicochetMissileSpawner.new()
	missile_spawner.__missiles_per_launch = 4
	add_child_autofree(missile_spawner)

	# Process frame which adds spawner to the scene
	await get_tree().process_frame  

	# Verify initial values
	assert_eq(missile_spawner.__launch_angles.size(), 4, "Launch angles should be empty before execution")

	assert_almost_eq(missile_spawner.__launch_angles[0], 0.0, 0.1, "Expected angle 0.0")
	assert_almost_eq(missile_spawner.__launch_angles[1], PI / 2, 0.1, "Expected angle PI / 2")
	assert_almost_eq(missile_spawner.__launch_angles[2], PI, 0.1, "Expected angle PI")
	assert_almost_eq(missile_spawner.__launch_angles[3], (3*PI) / 2, 0.1, "Expected angle (3*PI) / 2")


func test_shb_launch_north_west_missile_velocities():
	# ==================
	# CREATE DUMMY CREEP
	# ==================
	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	# Place the target BELOW (positive Y).
	# Ensure the target is far enough away from the spawner to not be detected by the hurtbox.
	dummy_target.position = Vector2(1000, 0)
	add_child_autofree(dummy_target)
	# Ensure creep does not move or process path finding logic
	dummy_target.stun(10)

	# =====================
	# CREATE MISSILE SPAWNER
	# =====================
	var missile_spawner = StarRandomRicochetMissileSpawner.new()
	missile_spawner.__missile_damage = 10
	missile_spawner.__missile_speed = 10
	missile_spawner.__missiles_per_launch = 4
	missile_spawner.MISSILE_ID = ProjectileConstants.SingleHitMissiles.BISMUTH_LVL_1
	missile_spawner.__detection_range = 100
	add_child_autofree(missile_spawner)

	# Simulate properties which missile spawner must have to launch missile towards target
	missile_spawner.__target = dummy_target
	var simulated_targets_in_range: Array[Creep] = [dummy_target]
	# Add to hurtbox range to simulate the target having entered its range
	missile_spawner.__hurtbox.__creeps_in_range = simulated_targets_in_range

	# Process frame which adds missile and spawner to the scene
	await get_tree().process_frame  

	# Verify initial values
	assert_eq(missile_spawner.position, Vector2.ZERO, "missile spawner should be at origin")
	assert_eq(dummy_target.position, Vector2(1000, 0), "Dummy target should be at (0, 1000)")
	assert_eq(missile_spawner.__target, dummy_target, "missile spawner should have target set to dummy target")
	assert_eq(missile_spawner.__hurtbox.__creeps_in_range, simulated_targets_in_range, "Hurtbox should have target in range")

	# ============
	# CONDUCT TEST
	# ============
	missile_spawner._launch_projectiles()
	# Process frame to ensure missile is launched
	await get_tree().process_frame

	# ==============
	# VERIFY RESULTS
	# ==============
	#Verify that a missile was launched
	var found_missiles: Array[Projectile] = []
	for child in missile_spawner.get_children():
		if child is Projectile:
			found_missiles.append(child)

	var expected_velocities = [
	Vector2(1.0, 0.0), # Velocity towards target
	Vector2(0.0, 1.0),
	Vector2(-1.0, 0.0),
	Vector2(0.0, -1.0)
	]

	# Ensure four missiles were launched
	assert_eq(found_missiles.size(), 4, "Four missiles should have been launched")

	# Extract velocities and compare
	var actual_velocities = []
	for missile in found_missiles:
		actual_velocities.append(missile.get_velocity())  # Assuming a get_velocity() method

	# Extract the actual velocities
	var actual_0 = actual_velocities[0]
	var actual_1 = actual_velocities[1]
	var actual_2 = actual_velocities[2]
	var actual_3 = actual_velocities[3]
	
	# Expected velocities
	var expected_0 = expected_velocities[0]
	var expected_1 = expected_velocities[1]
	var expected_2 = expected_velocities[2]
	var expected_3 = expected_velocities[3]
	
	# Compare each missile's velocity with precision of 0.1
	assert_almost_eq(actual_0.x, expected_0.x, 0.1, "Missile 0 velocity X does not match expected")
	assert_almost_eq(actual_0.y, expected_0.y, 0.1, "Missile 0 velocity Y does not match expected")
	
	assert_almost_eq(actual_1.x, expected_1.x, 0.1, "Missile 1 velocity X does not match expected")
	assert_almost_eq(actual_1.y, expected_1.y, 0.1, "Missile 1 velocity Y does not match expected")
	
	assert_almost_eq(actual_2.x, expected_2.x, 0.1, "Missile 2 velocity X does not match expected")
	assert_almost_eq(actual_2.y, expected_2.y, 0.1, "Missile 2 velocity Y does not match expected")
	
	assert_almost_eq(actual_3.x, expected_3.x, 0.1, "Missile 3 velocity X does not match expected")
	assert_almost_eq(actual_3.y, expected_3.y, 0.1, "Missile 3 velocity Y does not match expected")

	# Clean up
	missile_spawner.queue_free()
	dummy_target.queue_free()
