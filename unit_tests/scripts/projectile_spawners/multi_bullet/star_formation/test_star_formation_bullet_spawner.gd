extends GutTest

## Reset before each test case
func before_each():
    await get_tree().process_frame  # Ensure previous nodes are fully freed.

func test_shb_launch_north_west():
    # ==================
    # CREATE DUMMY CREEP
    # ==================
    var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
    # Place the target BELOW (positive Y).
    # Ensure the target is far enough away from the spawner to not be detected by the hurtbox.
    dummy_target.position = Vector2(0, 1000)
    add_child_autofree(dummy_target)
    # Ensure creep does not move or process path finding logic
    dummy_target.stun(10)

    # =====================
    # CREATE BULLET SPAWNER
    # =====================
    var bullet_spawner = StarFormationBulletSpawner.new()
    bullet_spawner.__bullet_damage = 10
    bullet_spawner.__bullet_speed = 10
    bullet_spawner.__bullets_per_launch = 4
    bullet_spawner.BULLET_PRELOAD = ProjectileConstants.BulletsForSpawner.BLACK_MARBLE_LVL_1
    bullet_spawner.__detection_range = 100
    add_child_autofree(bullet_spawner)

    # Simulate properties which bullet spawner must have to launch bullet towards target
    bullet_spawner.__target = dummy_target
    var simulated_targets_in_range: Array[Creep] = [dummy_target]
    # Add to hurtbox range to simulate the target having entered its range
    bullet_spawner.__hurtbox.__creeps_in_range = simulated_targets_in_range

    # Process frame which adds bullet and spawner to the scene
    await get_tree().process_frame  

    # Verify initial values
    assert_eq(bullet_spawner.position, Vector2.ZERO, "Bullet spawner should be at origin")
    assert_eq(dummy_target.position, Vector2(0, 1000), "Dummy target should be at (0, 1000)")
    assert_eq(bullet_spawner.__target, dummy_target, "Bullet spawner should have target set to dummy target")
    assert_eq(bullet_spawner.__hurtbox.__creeps_in_range, simulated_targets_in_range, "Hurtbox should have target in range")

    # ============
    # CONDUCT TEST
    # ============
    bullet_spawner._launch_projectiles()
    # Process frame to ensure bullet is launched
    await get_tree().process_frame

    # ==============
    # VERIFY RESULTS
    # ==============
    #Verify that a bullet was launched
    var found_bullets: Array[Projectile] = []
    for child in bullet_spawner.get_children():
        if child is Projectile:
            found_bullets.append(child)

    var expected_velocities = [
    Vector2(1.0, 0.0),
    Vector2(-1.0, 0.0),
    Vector2(0.0, 1.0),
    Vector2(0.0, -1.0)
    ]

    # Ensure four bullets were launched
    assert_eq(found_bullets.size(), 4, "Four bullets should have been launched")

    # Extract velocities and compare
    var actual_velocities = []
    for bullet in found_bullets:
        actual_velocities.append(bullet.get_velocity())  # Assuming a get_velocity() method

    # Sort both lists to avoid order mismatch issues
    actual_velocities.sort()
    expected_velocities.sort()

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
    
    # Compare each bullet's velocity with precision of 0.1
    assert_almost_eq(actual_0.x, expected_0.x, 0.1, "Bullet 0 velocity X does not match expected")
    assert_almost_eq(actual_0.y, expected_0.y, 0.1, "Bullet 0 velocity Y does not match expected")
    
    assert_almost_eq(actual_1.x, expected_1.x, 0.1, "Bullet 1 velocity X does not match expected")
    assert_almost_eq(actual_1.y, expected_1.y, 0.1, "Bullet 1 velocity Y does not match expected")
    
    assert_almost_eq(actual_2.x, expected_2.x, 0.1, "Bullet 2 velocity X does not match expected")
    assert_almost_eq(actual_2.y, expected_2.y, 0.1, "Bullet 2 velocity Y does not match expected")
    
    assert_almost_eq(actual_3.x, expected_3.x, 0.1, "Bullet 3 velocity X does not match expected")
    assert_almost_eq(actual_3.y, expected_3.y, 0.1, "Bullet 3 velocity Y does not match expected")



    # Clean up
    bullet_spawner.queue_free()
    dummy_target.queue_free()
