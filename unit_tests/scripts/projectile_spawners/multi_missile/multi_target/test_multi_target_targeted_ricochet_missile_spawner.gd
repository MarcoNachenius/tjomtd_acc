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
    # CREATE MISSILE SPAWNER
    # =====================
    var missile_spawner = MultiTargetTargetedRicochetMissileSpawner.new()
    missile_spawner.__missile_damage = 10
    missile_spawner.__missile_speed = 10
    missile_spawner.MISSILE_PRELOAD = ProjectileConstants.TargetedRicochetMissiles.BISMUTH_LVL_3
    missile_spawner.__detection_range = 100
    missile_spawner.MAX_MISSILES_PER_LAUNCH = 2
    add_child_autofree(missile_spawner)

    # Simulate properties which missile spawner must have to launch missile towards target
    missile_spawner.__target = first_dummy_target
    var simulated_targets_in_range: Array[Creep] = [first_dummy_target, second_dummy_target]
    # Add to hurtbox range to simulate the target having entered its range
    missile_spawner.__hurtbox.__creeps_in_range = simulated_targets_in_range

    # Process frame which adds missile and spawner to the scene
    await get_tree().process_frame  

    # Verify initial values
    assert_eq(missile_spawner.position, Vector2.ZERO, "missile spawner should be at origin")
    assert_eq(first_dummy_target.position, Vector2(0, 1000), "Dummy target should be at (0, 1000)")
    assert_eq(second_dummy_target.position, Vector2(0, -1000), "Dummy target should be at (0, -1000)")
    assert_eq(missile_spawner.__target, first_dummy_target, "missile spawner should have target set to dummy target")
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
    # Create search vars
    var found_missiles: Array[TargetedRicochetMissile]

    # Search for relevant values
    for child in missile_spawner.get_children():
        if child is TargetedRicochetMissile:
            found_missiles.append(child)
    
    # Test if two missiles have been launched
    assert_eq(found_missiles.size(), 2, "Two missiles have been launched")

    # Assign found missiles to individual test objects
    var first_launched_missile: TargetedRicochetMissile = found_missiles[0]
    var second_launched_missile: TargetedRicochetMissile = found_missiles[1]

    # Test if missiles have been assigned correct target
    assert_eq(first_launched_missile.__target, first_dummy_target, "First launched missile targets first entered target")
    assert_eq(second_launched_missile.__target, second_dummy_target, "Second launched missile targets second entered target")

    # Test expected velocities of launched missiles
    assert_almost_eq(first_launched_missile.__velocity.x, 0.0, 0.1)
    assert_almost_eq(first_launched_missile.__velocity.y, 1.0, 0.1)
    assert_almost_eq(second_launched_missile.__velocity.x, 0.0, 0.1)
    assert_almost_eq(second_launched_missile.__velocity.y, -1.0, 0.1)

    # Clean up
    missile_spawner.queue_free()
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
    # CREATE MISSILE SPAWNER
    # =====================
    var missile_spawner = MultiTargetTargetedRicochetMissileSpawner.new()
    missile_spawner.__missile_damage = 10
    missile_spawner.__missile_speed = 10
    missile_spawner.MISSILE_PRELOAD = ProjectileConstants.TargetedRicochetMissiles.BISMUTH_LVL_3
    missile_spawner.__detection_range = 100
    missile_spawner.MAX_MISSILES_PER_LAUNCH = 2
    add_child_autofree(missile_spawner)

    # Simulate properties which missile spawner must have to launch missile towards target
    missile_spawner.__target = first_dummy_target
    var simulated_targets_in_range: Array[Creep] = [first_dummy_target, second_dummy_target, third_dummy_target]
    # Add to hurtbox range to simulate the target having entered its range
    missile_spawner.__hurtbox.__creeps_in_range = simulated_targets_in_range

    # Process frame which adds missile and spawner to the scene
    await get_tree().process_frame  

    # Verify initial values
    assert_eq(missile_spawner.position, Vector2.ZERO, "missile spawner should be at origin")
    assert_eq(first_dummy_target.position, Vector2(0, 1000), "Dummy target should be at (0, 1000)")
    assert_eq(second_dummy_target.position, Vector2(0, -1000), "Dummy target should be at (0, -1000)")
    assert_eq(missile_spawner.__target, first_dummy_target, "missile spawner should have target set to dummy target")
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
    # Create search vars
    var found_missiles: Array[TargetedRicochetMissile]

    # Search for relevant values
    for child in missile_spawner.get_children():
        if child is TargetedRicochetMissile:
            found_missiles.append(child)
    
    # Test if two missiles have been launched
    assert_eq(found_missiles.size(), 2, "Two missiles have been launched")

    # Assign found missiles to individual test objects
    var first_launched_missile: TargetedRicochetMissile = found_missiles[0]
    var second_launched_missile: TargetedRicochetMissile = found_missiles[1]

    # Test if missiles have been assigned correct target
    assert_eq(first_launched_missile.__target, first_dummy_target, "First launched missile targets first entered target")
    assert_eq(second_launched_missile.__target, second_dummy_target, "Second launched missile targets second entered target")

    # Test expected velocities of launched missiles
    assert_almost_eq(first_launched_missile.__velocity.x, 0.0, 0.1)
    assert_almost_eq(first_launched_missile.__velocity.y, 1.0, 0.1)
    assert_almost_eq(second_launched_missile.__velocity.x, 0.0, 0.1)
    assert_almost_eq(second_launched_missile.__velocity.y, -1.0, 0.1)

    # Clean up
    missile_spawner.queue_free()
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
    # CREATE MISSILE SPAWNER
    # =====================
    var missile_spawner = MultiTargetTargetedRicochetMissileSpawner.new()
    missile_spawner.__missile_damage = 10
    missile_spawner.__missile_speed = 10
    missile_spawner.MISSILE_PRELOAD = ProjectileConstants.TargetedRicochetMissiles.BISMUTH_LVL_3
    missile_spawner.__detection_range = 100
    missile_spawner.__infinite_targets_per_launch = true
    add_child_autofree(missile_spawner)

    # Simulate properties which missile spawner must have to launch missile towards target
    missile_spawner.__target = first_dummy_target
    var simulated_targets_in_range: Array[Creep] = [first_dummy_target, second_dummy_target]
    # Add to hurtbox range to simulate the target having entered its range
    missile_spawner.__hurtbox.__creeps_in_range = simulated_targets_in_range

    # Process frame which adds missile and spawner to the scene
    await get_tree().process_frame  

    # Verify initial values
    assert_eq(missile_spawner.position, Vector2.ZERO, "missile spawner should be at origin")
    assert_eq(first_dummy_target.position, Vector2(0, 1000), "Dummy target should be at (0, 1000)")
    assert_eq(second_dummy_target.position, Vector2(0, -1000), "Dummy target should be at (0, -1000)")
    assert_eq(missile_spawner.__target, first_dummy_target, "missile spawner should have target set to dummy target")
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
    # Create search vars
    var found_missiles: Array[TargetedRicochetMissile]

    # Search for relevant values
    for child in missile_spawner.get_children():
        if child is TargetedRicochetMissile:
            found_missiles.append(child)
    
    # Test if two missiles have been launched
    assert_eq(found_missiles.size(), 2, "Two missiles have been launched")

    # Assign found missiles to individual test objects
    var first_launched_missile: TargetedRicochetMissile = found_missiles[0]
    var second_launched_missile: TargetedRicochetMissile = found_missiles[1]

    # Test if missiles have been assigned correct target
    assert_eq(first_launched_missile.__target, first_dummy_target, "First launched missile targets first entered target")
    assert_eq(second_launched_missile.__target, second_dummy_target, "Second launched missile targets second entered target")

    # Test expected velocities of launched missiles
    assert_almost_eq(first_launched_missile.__velocity.x, 0.0, 0.1)
    assert_almost_eq(first_launched_missile.__velocity.y, 1.0, 0.1)
    assert_almost_eq(second_launched_missile.__velocity.x, 0.0, 0.1)
    assert_almost_eq(second_launched_missile.__velocity.y, -1.0, 0.1)

    # Clean up
    missile_spawner.queue_free()
    first_dummy_target.queue_free()
    second_dummy_target.queue_free()