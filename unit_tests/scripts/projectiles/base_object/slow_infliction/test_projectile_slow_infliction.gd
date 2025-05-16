extends GutTest

func before_each():
    await get_tree().process_frame

func test_single_hit_bullet_slow_infliction():
    # Create test slowdown values
    var test_slowdown_percentage: int = 20
    var test_slowdown_duration: float = 15.0 
    
    # Create test creep
    var test_creep_starting_speed: int = 10
    var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    test_creep.set_starting_health(100)
    test_creep.set_starting_speed(test_creep_starting_speed)
    add_child_autofree(test_creep)
    test_creep.stun(10)
    await get_tree().process_frame
    
    # Create test projectile
    var test_projectile: SingleHitBullet = ProjectileConstants.SINGLE_HIT_BULLET_LOADS[ProjectileConstants.SingleHitBullets.BLACK_MARBLE_LVL_1].instantiate()
    test_projectile.set_speed(1)
    test_projectile.set_damage(0) # Avoid damage infliction resulting in death
    
    # Place projectile far enough away from creep to avoid area entry happening when frame is processed
    add_child_autofree(test_projectile)
    test_projectile.global_position = Vector2(1000, 1000)
    
    # Simulate projectile having slow slow ability
    test_projectile.set_can_slow(true)
    test_projectile.set_slow_duration_seconds(test_slowdown_duration)
    test_projectile.set_slow_speed_reduction_percentage(test_slowdown_percentage)
    await  get_tree().process_frame

    # Ensure initial state
    assert_eq(test_creep.get_curr_speed(), test_creep_starting_speed, "Initial speed of creep is correct")

    # Create expected value
    var expected_altered_speed: int = 8

    # Simulate projectile inflicting damage
    test_projectile._inflict_damange(test_creep)

    # Verify results
    assert_eq(test_creep.get_curr_speed(), expected_altered_speed, "Speed has been reduced by 2 after damage infliction")

    # Clean up
    test_projectile.queue_free()
    test_creep.queue_free()

    # Process removal of objects
    await get_tree().process_frame