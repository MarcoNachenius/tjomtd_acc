extends GutTest

## Reset before each test case
func before_each():
    await get_tree().process_frame  # Ensure previous nodes are fully freed.

func test_spawner_with_two_targets_per_launch_with_two_targets_in_range():
    # ===================
    # CREATE DUMMY CREEPS
    # ===================
    var first_dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
    # Place the target BELOW (positive Y).
    # Ensure the target is far enough away from the spawner to not be detected by the hurtbox.
    first_dummy_target.position = Vector2(0, 1000)
    add_child_autofree(first_dummy_target)
    # Ensure creep does not move or process path finding logic
    first_dummy_target.stun(10)

    var second_dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
    # Place the target BELOW (positive Y).
    # Ensure the target is far enough away from the spawner to not be detected by the hurtbox.
    second_dummy_target.position = Vector2(0, -1000)
    add_child_autofree(second_dummy_target)
    # Ensure creep does not move or process path finding logic
    second_dummy_target.stun(10)
    

    # =====================
    # CREATE BULLET SPAWNER
    # =====================
    var bullet_spawner = MultiTargetSingleHitSingleBulletSpawner.new()
    bullet_spawner.__bullet_damage = 10
    bullet_spawner.__bullet_speed = 10
    bullet_spawner.BULLET_PRELOAD = ProjectileConstants.SingleHitBullets.BLACK_MARBLE_LVL_1
    bullet_spawner.__detection_range = 100
    bullet_spawner.__bullets_per_launch = 2
    add_child_autofree(bullet_spawner)

    # Simulate properties which bullet spawner must have to launch bullet towards target
    bullet_spawner.__target = first_dummy_target
    var simulated_targets_in_range: Array[Creep] = [first_dummy_target, second_dummy_target]
    # Add to hurtbox range to simulate the target having entered its range
    bullet_spawner.__hurtbox.__creeps_in_range = simulated_targets_in_range

    # Process frame which adds bullet and spawner to the scene
    await get_tree().process_frame  

    # Verify initial values
    assert_eq(bullet_spawner.position, Vector2.ZERO, "Bullet spawner should be at origin")
    assert_eq(first_dummy_target.position, Vector2(0, 1000), "Dummy target should be at (0, 1000)")
    assert_eq(second_dummy_target.position, Vector2(0, -1000), "Dummy target should be at (0, -1000)")
    assert_eq(bullet_spawner.__target, first_dummy_target, "Bullet spawner should have target set to dummy target")
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
    # Create search vars
    var found_bullets: Array[SingleHitBullet]

    # Search for relevant values
    for child in bullet_spawner.get_children():
        if child is SingleHitBullet:
            found_bullets.append(child)
    
    # Test if two bullets have been launched
    assert_eq(found_bullets.size(), 2, "Two bullets have been launched")

    # Assign found bullets to individual test objects
    var first_launched_bullet: SingleHitBullet = found_bullets[0]
    var second_launched_bullet: SingleHitBullet = found_bullets[1]

    # Test if bullets have been assigned correct target
    assert_eq(first_launched_bullet.__target, first_dummy_target, "First launched bullet targets first entered target")
    assert_eq(second_launched_bullet.__target, second_dummy_target, "Second launched bullet targets second entered target")

    # Test expected velocities of launched bullets
    assert_almost_eq(first_launched_bullet.__velocity.x, 0.0, 0.1)
    assert_almost_eq(first_launched_bullet.__velocity.y, 1.0, 0.1)
    assert_almost_eq(second_launched_bullet.__velocity.x, 0.0, 0.1)
    assert_almost_eq(second_launched_bullet.__velocity.y, -1.0, 0.1)

    # Clean up
    bullet_spawner.queue_free()
    first_dummy_target.queue_free()
    second_dummy_target.queue_free()


func test_spawner_with_two_targets_per_launch_with_three_targets_in_range():
    # ===================
    # CREATE DUMMY CREEPS
    # ===================
    var first_dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
    # Place the target BELOW (positive Y).
    # Ensure the target is far enough away from the spawner to not be detected by the hurtbox.
    first_dummy_target.position = Vector2(0, 1000)
    add_child_autofree(first_dummy_target)
    # Ensure creep does not move or process path finding logic
    first_dummy_target.stun(10)

    var second_dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
    # Place the target BELOW (positive Y).
    # Ensure the target is far enough away from the spawner to not be detected by the hurtbox.
    second_dummy_target.position = Vector2(0, -1000)
    add_child_autofree(second_dummy_target)
    # Ensure creep does not move or process path finding logic
    second_dummy_target.stun(10)
    
    var third_dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
    # Place the target BELOW (positive Y).
    # Ensure the target is far enough away from the spawner to not be detected by the hurtbox.
    third_dummy_target.position = Vector2(0, -1000)
    add_child_autofree(third_dummy_target)
    # Ensure creep does not move or process path finding logic
    third_dummy_target.stun(10)

    # =====================
    # CREATE BULLET SPAWNER
    # =====================
    var bullet_spawner = MultiTargetSingleHitSingleBulletSpawner.new()
    bullet_spawner.__bullet_damage = 10
    bullet_spawner.__bullet_speed = 10
    bullet_spawner.BULLET_PRELOAD = ProjectileConstants.SingleHitBullets.BLACK_MARBLE_LVL_1
    bullet_spawner.__detection_range = 100
    bullet_spawner.__bullets_per_launch = 2
    add_child_autofree(bullet_spawner)

    # Simulate properties which bullet spawner must have to launch bullet towards target
    bullet_spawner.__target = first_dummy_target
    var simulated_targets_in_range: Array[Creep] = [first_dummy_target, second_dummy_target, third_dummy_target]
    # Add to hurtbox range to simulate the target having entered its range
    bullet_spawner.__hurtbox.__creeps_in_range = simulated_targets_in_range

    # Process frame which adds bullet and spawner to the scene
    await get_tree().process_frame  

    # Verify initial values
    assert_eq(bullet_spawner.position, Vector2.ZERO, "Bullet spawner should be at origin")
    assert_eq(first_dummy_target.position, Vector2(0, 1000), "Dummy target should be at (0, 1000)")
    assert_eq(second_dummy_target.position, Vector2(0, -1000), "Dummy target should be at (0, -1000)")
    assert_eq(bullet_spawner.__target, first_dummy_target, "Bullet spawner should have target set to dummy target")
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
    # Create search vars
    var found_bullets: Array[SingleHitBullet]

    # Search for relevant values
    for child in bullet_spawner.get_children():
        if child is SingleHitBullet:
            found_bullets.append(child)
    
    # Test if two bullets have been launched
    assert_eq(found_bullets.size(), 2, "Two bullets have been launched")

    # Assign found bullets to individual test objects
    var first_launched_bullet: SingleHitBullet = found_bullets[0]
    var second_launched_bullet: SingleHitBullet = found_bullets[1]

    # Test if bullets have been assigned correct target
    assert_eq(first_launched_bullet.__target, first_dummy_target, "First launched bullet targets first entered target")
    assert_eq(second_launched_bullet.__target, second_dummy_target, "Second launched bullet targets second entered target")

    # Test expected velocities of launched bullets
    assert_almost_eq(first_launched_bullet.__velocity.x, 0.0, 0.1)
    assert_almost_eq(first_launched_bullet.__velocity.y, 1.0, 0.1)
    assert_almost_eq(second_launched_bullet.__velocity.x, 0.0, 0.1)
    assert_almost_eq(second_launched_bullet.__velocity.y, -1.0, 0.1)

    # Clean up
    bullet_spawner.queue_free()
    first_dummy_target.queue_free()
    second_dummy_target.queue_free()


func test_spawner_with_infinite_targets_per_launch_with_two_targets_in_range():
    # ===================
    # CREATE DUMMY CREEPS
    # ===================
    var first_dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
    # Place the target BELOW (positive Y).
    # Ensure the target is far enough away from the spawner to not be detected by the hurtbox.
    first_dummy_target.position = Vector2(0, 1000)
    add_child_autofree(first_dummy_target)
    # Ensure creep does not move or process path finding logic
    first_dummy_target.stun(10)

    var second_dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
    # Place the target BELOW (positive Y).
    # Ensure the target is far enough away from the spawner to not be detected by the hurtbox.
    second_dummy_target.position = Vector2(0, -1000)
    add_child_autofree(second_dummy_target)
    # Ensure creep does not move or process path finding logic
    second_dummy_target.stun(10)
    

    # =====================
    # CREATE BULLET SPAWNER
    # =====================
    var bullet_spawner = MultiTargetSingleHitSingleBulletSpawner.new()
    bullet_spawner.__bullet_damage = 10
    bullet_spawner.__bullet_speed = 10
    bullet_spawner.BULLET_PRELOAD = ProjectileConstants.SingleHitBullets.BLACK_MARBLE_LVL_1
    bullet_spawner.__detection_range = 100
    bullet_spawner.__infinite_targets_per_launch = true
    add_child_autofree(bullet_spawner)

    # Simulate properties which bullet spawner must have to launch bullet towards target
    bullet_spawner.__target = first_dummy_target
    var simulated_targets_in_range: Array[Creep] = [first_dummy_target, second_dummy_target]
    # Add to hurtbox range to simulate the target having entered its range
    bullet_spawner.__hurtbox.__creeps_in_range = simulated_targets_in_range

    # Process frame which adds bullet and spawner to the scene
    await get_tree().process_frame  

    # Verify initial values
    assert_eq(bullet_spawner.position, Vector2.ZERO, "Bullet spawner should be at origin")
    assert_eq(first_dummy_target.position, Vector2(0, 1000), "Dummy target should be at (0, 1000)")
    assert_eq(second_dummy_target.position, Vector2(0, -1000), "Dummy target should be at (0, -1000)")
    assert_eq(bullet_spawner.__target, first_dummy_target, "Bullet spawner should have target set to dummy target")
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
    # Create search vars
    var found_bullets: Array[SingleHitBullet]

    # Search for relevant values
    for child in bullet_spawner.get_children():
        if child is SingleHitBullet:
            found_bullets.append(child)
    
    # Test if two bullets have been launched
    assert_eq(found_bullets.size(), 2, "Two bullets have been launched")

    # Assign found bullets to individual test objects
    var first_launched_bullet: SingleHitBullet = found_bullets[0]
    var second_launched_bullet: SingleHitBullet = found_bullets[1]

    # Test if bullets have been assigned correct target
    assert_eq(first_launched_bullet.__target, first_dummy_target, "First launched bullet targets first entered target")
    assert_eq(second_launched_bullet.__target, second_dummy_target, "Second launched bullet targets second entered target")

    # Test expected velocities of launched bullets
    assert_almost_eq(first_launched_bullet.__velocity.x, 0.0, 0.1)
    assert_almost_eq(first_launched_bullet.__velocity.y, 1.0, 0.1)
    assert_almost_eq(second_launched_bullet.__velocity.x, 0.0, 0.1)
    assert_almost_eq(second_launched_bullet.__velocity.y, -1.0, 0.1)

    # Clean up
    bullet_spawner.queue_free()
    first_dummy_target.queue_free()
    second_dummy_target.queue_free()