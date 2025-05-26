extends GutTest

## Reset before each test case
func before_each():
    await get_tree().process_frame  # Ensure previous nodes are fully freed.

func test_rrm_launch_north_west():
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
    # CREATE missile SPAWNER
    # =====================
    var missile_spawner = RandomRicochetMissileSpawner.new()
    missile_spawner.__missile_damage = 10
    missile_spawner.__missile_speed = 10
    missile_spawner.MISSILE_PRELOAD = ProjectileConstants.RandomRicochetMissiles.TOMBSTONE_LVL_1
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
    assert_eq(dummy_target.position, Vector2(0, 1000), "Dummy target should be at (0, 1000)")
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
    # Verify that a missile was launched
    var found_missile: RandomRicochetMissile
    for child in missile_spawner.get_children():
        if child is RandomRicochetMissile:
            found_missile = child
            break

    assert_not_null(found_missile, "missile should have been launched")
    assert_almost_eq(found_missile.__velocity.x, 0.0, 0.01, "missile should have no x velocity")
    assert_almost_eq(found_missile.__velocity.y, 1.0, 0.01, "missile should have y velocity of 1")
    assert_almost_eq(found_missile.__isometric_speed, 5.0, 0.01, "missile should have isometric speed of 5.0")


    # Clean up
    missile_spawner.queue_free()
    dummy_target.queue_free()


func test_rrm_launch_south_east():
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
    # CREATE missile SPAWNER
    # =====================
    var missile_spawner = RandomRicochetMissileSpawner.new()
    missile_spawner.__missile_damage = 10
    missile_spawner.__missile_speed = 10
    missile_spawner.MISSILE_PRELOAD = ProjectileConstants.RandomRicochetMissiles.TOMBSTONE_LVL_1
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
    assert_eq(dummy_target.position, Vector2(0, -1000), "Dummy target should be at (0, -1000)")
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
    # Verify that a missile was launched
    var found_missile: RandomRicochetMissile
    for child in missile_spawner.get_children():
        if child is RandomRicochetMissile:
            found_missile = child
            break

    assert_not_null(found_missile, "missile should have been launched")
    assert_almost_eq(found_missile.__velocity.x, 0.0, 0.01, "missile should have no x velocity")
    assert_almost_eq(found_missile.__velocity.y, -1.0, 0.01, "missile should have y velocity of -1")
    assert_almost_eq(found_missile.__isometric_speed, 5.0, 0.01, "missile should have isometric speed of 5.0")

    # Clean up
    missile_spawner.queue_free()
    dummy_target.queue_free()


func test_rrm_launch_south_west():
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
    # CREATE missile SPAWNER
    # =====================
    var missile_spawner = RandomRicochetMissileSpawner.new()
    missile_spawner.__missile_damage = 10
    missile_spawner.__missile_speed = 10
    missile_spawner.MISSILE_PRELOAD = ProjectileConstants.RandomRicochetMissiles.TOMBSTONE_LVL_1
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
    assert_eq(dummy_target.position, Vector2(-1000, 0), "Dummy target should be at (-1000, 0)")
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
    # Verify that a missile was launched
    var found_missile: RandomRicochetMissile
    for child in missile_spawner.get_children():
        if child is RandomRicochetMissile:
            found_missile = child
            break

    assert_not_null(found_missile, "missile should have been launched")
    assert_almost_eq(found_missile.__velocity.x, -1.0, 0.01, "missile should have x velocity of -1")
    assert_almost_eq(found_missile.__velocity.y, 0.0, 0.01, "missile should have y velocity of 0")
    assert_almost_eq(found_missile.__isometric_speed, 10.0, 0.01, "missile should have isometric speed of 10.0")

    # Clean up
    missile_spawner.queue_free()
    dummy_target.queue_free()


func test_rrm_launch_north_east():
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
    # CREATE missile SPAWNER
    # =====================
    var missile_spawner = RandomRicochetMissileSpawner.new()
    missile_spawner.__missile_damage = 10
    missile_spawner.__missile_speed = 10
    missile_spawner.MISSILE_PRELOAD = ProjectileConstants.RandomRicochetMissiles.TOMBSTONE_LVL_1
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
    assert_eq(dummy_target.position, Vector2(1000, 0), "Dummy target should be at (1000, 0)")
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
    # Verify that a missile was launched
    var found_missile: RandomRicochetMissile
    for child in missile_spawner.get_children():
        if child is RandomRicochetMissile:
            found_missile = child
            break

    assert_not_null(found_missile, "missile should have been launched")
    assert_almost_eq(found_missile.__velocity.x, 1.0, 0.01, "missile should have x velocity of 1")
    assert_almost_eq(found_missile.__velocity.y, 0.0, 0.01, "missile should have y velocity of 0")
    assert_almost_eq(found_missile.__isometric_speed, 10.0, 0.01, "missile should have isometric speed of 10.0")

    # Clean up
    missile_spawner.queue_free()
    dummy_target.queue_free()