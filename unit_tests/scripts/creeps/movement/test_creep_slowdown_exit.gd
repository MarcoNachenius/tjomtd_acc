extends GutTest

func before_each():
    await get_tree().process_frame

func test_single_slow_timer_removal():
    # Create test slowdown values
    var test_slowdown_percentage: int = 20
    var test_slowdown_duration: float = 15.0
    var found_slow_timer_child_scene: bool = false
    var retrieved_slow_timer: SlowTimer
    var number_of_slow_timers_found: int = 0
    # Create test creep
    var test_creep_starting_speed: int = 10
    var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    test_creep.set_starting_speed(test_creep_starting_speed)
    add_child_autofree(test_creep)
    test_creep.stun(10)

    # Inflict slow
    test_creep.slow(test_slowdown_percentage, test_slowdown_duration)

    # Process frame to add slow timer
    await get_tree().process_frame

    # Ensure slow timer is now added to creep scene
    for child in test_creep.get_children():
        if child is SlowTimer:
            found_slow_timer_child_scene = true
            number_of_slow_timers_found += 1
            retrieved_slow_timer = child
    
    assert_true(found_slow_timer_child_scene, "Slow timer has been added as child of creep")
    assert_eq(number_of_slow_timers_found, 1, "1 Slow timer detected")
    assert_not_null(retrieved_slow_timer, "Found slow timer is not null")

    # Simulate slow effect being stopped
    retrieved_slow_timer.timeout.emit()

    # Process frame to remove slow timer
    await get_tree().process_frame
    # Reset search vars
    found_slow_timer_child_scene = false
    number_of_slow_timers_found = 0
    retrieved_slow_timer = null

    # Double check that values have been properly resetted
    assert_false(found_slow_timer_child_scene, "Slow timer search value has been properly reset")
    assert_eq(number_of_slow_timers_found, 0, "Number of found timers search value has been properly reset")

    # Process frame to remove slow timer
    await get_tree().process_frame

    # Check if slow tower has been removed from scene
    for child in test_creep.get_children():
        if child is SlowTimer:
            found_slow_timer_child_scene = true
            number_of_slow_timers_found += 1
    
    # Test that slow timer has been removed from scene after timeout
    assert_false(found_slow_timer_child_scene, "Slow timer has been removed")
    assert_eq(number_of_slow_timers_found, 0, "No slow timers found")

    # Clean up 
    test_creep.queue_free()
    await get_tree().process_frame


func test_single_slow_effect_removal():
    # Create test slowdown values
    var test_slowdown_percentage: int = 20
    var test_slowdown_duration: float = 15.0
    var retrieved_slow_timer: SlowTimer
    # Create test creep
    var test_creep_starting_speed: int = 10
    var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    test_creep.set_starting_speed(test_creep_starting_speed)
    add_child_autofree(test_creep)
    test_creep.stun(10)

    # Inflict slow
    test_creep.slow(test_slowdown_percentage, test_slowdown_duration)

    # Ensure creep has been slowed down
    assert_eq(test_creep.get_curr_speed(), 8)

    # Process frame to add slow timer
    await get_tree().process_frame

    for child in test_creep.get_children():
        if child is SlowTimer:
            retrieved_slow_timer = child
            break

    # Simulate slow effect being stopped
    retrieved_slow_timer.timeout.emit()

    # Process frame to remove slow timer
    await get_tree().process_frame

    assert_eq(test_creep.get_curr_speed(), test_creep_starting_speed)

    # Clean up 
    test_creep.queue_free()
    await get_tree().process_frame

func test_two_active_slow_effect_single_removal():
    # Create test slowdown values
    var test_slowdown_percentage: int = 20
    var test_slowdown_duration: float = 15.0
    var retrieved_slow_timer: SlowTimer
    # Create test creep
    var test_creep_starting_speed: int = 10
    var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    test_creep.set_starting_speed(test_creep_starting_speed)
    add_child_autofree(test_creep)
    test_creep.stun(10)

    # Inflict slow
    test_creep.slow(test_slowdown_percentage, test_slowdown_duration)

    # Ensure creep has been slowed down
    assert_eq(test_creep.get_curr_speed(), 8)

    # Process frame to add slow timer
    await get_tree().process_frame

    # Inflict slow
    test_creep.slow(test_slowdown_percentage, test_slowdown_duration)

    # Ensure creep has been slowed down
    assert_eq(test_creep.get_curr_speed(), 6)

    # Process frame to add slow timer
    await get_tree().process_frame

    for child in test_creep.get_children():
        if child is SlowTimer:
            retrieved_slow_timer = child
            break

    # Simulate slow effect being stopped
    retrieved_slow_timer.timeout.emit()

    # Process frame to remove slow timer
    await get_tree().process_frame

    assert_eq(test_creep.get_curr_speed(), 8)

    # Clean up 
    test_creep.queue_free()
    await get_tree().process_frame