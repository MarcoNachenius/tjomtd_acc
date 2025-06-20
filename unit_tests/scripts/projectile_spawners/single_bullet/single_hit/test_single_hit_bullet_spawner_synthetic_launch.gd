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
    var bullet_spawner = SingleHitSingleBulletSpawner.new()
    bullet_spawner.__bullet_damage = 10
    bullet_spawner.__bullet_speed = 10
    bullet_spawner.BULLET_PRELOAD = ProjectileConstants.SingleHitBullets.BLACK_MARBLE_LVL_1
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
    # Verify that a bullet was launched
    var found_bullet: SingleHitBullet
    for child in bullet_spawner.get_children():
        if child is SingleHitBullet:
            found_bullet = child
            break

    assert_not_null(found_bullet, "Bullet should have been launched")
    assert_almost_eq(found_bullet.__velocity.x, 0.0, 0.01, "Bullet should have no x velocity")
    assert_almost_eq(found_bullet.__velocity.y, 1.0, 0.01, "Bullet should have y velocity of 1")
    assert_almost_eq(found_bullet.__isometric_speed, 5.0, 0.01, "Bullet should have isometric speed of 5.0")


    # Clean up
    bullet_spawner.queue_free()
    dummy_target.queue_free()


func test_shb_launch_south_east():
    # ==================
    # CREATE DUMMY CREEP
    # ==================
    var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
    # Place the target ABOVE (negative Y).
    # Ensure the target is far enough away from the spawner to not be detected by the hurtbox.
    dummy_target.position = Vector2(0, -1000)
    add_child_autofree(dummy_target)
    # Ensure creep does not move or process path finding logic
    dummy_target.stun(10)

    # =====================
    # CREATE BULLET SPAWNER
    # =====================
    var bullet_spawner = SingleHitSingleBulletSpawner.new()
    bullet_spawner.__bullet_damage = 10
    bullet_spawner.__bullet_speed = 10
    bullet_spawner.BULLET_PRELOAD = ProjectileConstants.SingleHitBullets.BLACK_MARBLE_LVL_1
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
    assert_eq(dummy_target.position, Vector2(0, -1000), "Dummy target should be at (0, -1000)")
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
    # Verify that a bullet was launched
    var found_bullet: SingleHitBullet
    for child in bullet_spawner.get_children():
        if child is SingleHitBullet:
            found_bullet = child
            break

    assert_not_null(found_bullet, "Bullet should have been launched")
    assert_almost_eq(found_bullet.__velocity.x, 0.0, 0.01, "Bullet should have no x velocity")
    assert_almost_eq(found_bullet.__velocity.y, -1.0, 0.01, "Bullet should have y velocity of -1")
    assert_almost_eq(found_bullet.__isometric_speed, 5.0, 0.01, "Bullet should have isometric speed of 5.0")

    # Clean up
    bullet_spawner.queue_free()
    dummy_target.queue_free()


func test_shb_launch_south_west():
    # ==================
    # CREATE DUMMY CREEP
    # ==================
    var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
    # Place the target LEFT (negative X).
    # Ensure the target is far enough away from the spawner to not be detected by the hurtbox.
    dummy_target.position = Vector2(-1000, 0)
    add_child_autofree(dummy_target)
    # Ensure creep does not move or process path finding logic
    dummy_target.stun(10)

    # =====================
    # CREATE BULLET SPAWNER
    # =====================
    var bullet_spawner = SingleHitSingleBulletSpawner.new()
    bullet_spawner.__bullet_damage = 10
    bullet_spawner.__bullet_speed = 10
    bullet_spawner.BULLET_PRELOAD = ProjectileConstants.SingleHitBullets.BLACK_MARBLE_LVL_1
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
    assert_eq(dummy_target.position, Vector2(-1000, 0), "Dummy target should be at (-1000, 0)")
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
    # Verify that a bullet was launched
    var found_bullet: SingleHitBullet
    for child in bullet_spawner.get_children():
        if child is SingleHitBullet:
            found_bullet = child
            break

    assert_not_null(found_bullet, "Bullet should have been launched")
    assert_almost_eq(found_bullet.__velocity.x, -1.0, 0.01, "Bullet should have x velocity of -1")
    assert_almost_eq(found_bullet.__velocity.y, 0.0, 0.01, "Bullet should have y velocity of 0")
    assert_almost_eq(found_bullet.__isometric_speed, 10.0, 0.01, "Bullet should have isometric speed of 10.0")

    # Clean up
    bullet_spawner.queue_free()
    dummy_target.queue_free()


func test_shb_launch_north_east():
    # ==================
    # CREATE DUMMY CREEP
    # ==================
    var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
    # Place the target RIGHT (positive Y).
    # Ensure the target is far enough away from the spawner to not be detected by the hurtbox.
    dummy_target.position = Vector2(1000, 0)
    add_child_autofree(dummy_target)
    # Ensure creep does not move or process path finding logic
    dummy_target.stun(10)

    # =====================
    # CREATE BULLET SPAWNER
    # =====================
    var bullet_spawner = SingleHitSingleBulletSpawner.new()
    bullet_spawner.__bullet_damage = 10
    bullet_spawner.__bullet_speed = 10
    bullet_spawner.BULLET_PRELOAD = ProjectileConstants.SingleHitBullets.BLACK_MARBLE_LVL_1
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
    assert_eq(dummy_target.position, Vector2(1000, 0), "Dummy target should be at (1000, 0)")
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
    # Verify that a bullet was launched
    var found_bullet: SingleHitBullet
    for child in bullet_spawner.get_children():
        if child is SingleHitBullet:
            found_bullet = child
            break

    assert_not_null(found_bullet, "Bullet should have been launched")
    assert_almost_eq(found_bullet.__velocity.x, 1.0, 0.01, "Bullet should have x velocity of 1")
    assert_almost_eq(found_bullet.__velocity.y, 0.0, 0.01, "Bullet should have y velocity of 0")
    assert_almost_eq(found_bullet.__isometric_speed, 10.0, 0.01, "Bullet should have isometric speed of 10.0")

    # Clean up
    bullet_spawner.queue_free()
    dummy_target.queue_free()