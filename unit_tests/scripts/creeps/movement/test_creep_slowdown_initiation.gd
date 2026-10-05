extends GutTest

func before_each():
    await get_tree().process_frame

func test_single_slow_timer_addition():
    # Create test slowdown values
    var test_slowdown_percentage: int = 20
    var test_slowdown_duration: float = 15.0
    var found_slow_timer_child_scene: bool = false
    var number_of_slow_timers_found: int = 0
    # Create test creep
    var test_creep_starting_speed: int = 10
    var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    test_creep.set_starting_speed(test_creep_starting_speed)
    add_child_autofree(test_creep)
    test_creep.stun(10)

    # Confirm starting state
    # Ensure no slow timers are present in the creep scene before slow infiction
    for child in test_creep.get_children():
        if child is SlowTimer:
            found_slow_timer_child_scene = true
            number_of_slow_timers_found += 1
    assert_false(found_slow_timer_child_scene, "Slow timer has not been added before slow effect initiated")
    assert_eq(number_of_slow_timers_found, 0, "0 Slow timers detected")
    assert_not_null(test_creep, "Test creep is properly loaded and added to scene")
    assert_eq(test_creep.__num_of_active_slow_effects, 0, "No active slow effects upon add")
    assert_eq(test_creep.get_curr_state(), Creep.States.IDLE, "Creep has been stunned")
    assert_eq(test_creep.get_curr_speed(), test_creep_starting_speed, "Speed has been properly initialized")

    # CONDUCT TEST
    test_creep.slow(test_slowdown_percentage, test_slowdown_duration)

    # Process frame to add slow timer
    await get_tree().process_frame

    # Ensure slow timer is now added to creep scene
    for child in test_creep.get_children():
        if child is SlowTimer:
            found_slow_timer_child_scene = true
            number_of_slow_timers_found += 1
    assert_true(found_slow_timer_child_scene, "Slow timer has been added as child of creep")
    assert_eq(number_of_slow_timers_found, 1, "1 Slow timer detected")

    # Clean up 
    test_creep.queue_free()
    await get_tree().process_frame

func test_slow_timer_captured_speed_points():
    var retrieved_slow_timer: SlowTimer
    # Create test slowdown values
    var test_slowdown_percentage: int = 20
    var test_slowdown_duration: float = 15.0
    # Create test creep
    var test_creep_starting_speed: int = 10
    var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    test_creep.set_starting_speed(test_creep_starting_speed)
    add_child_autofree(test_creep)
    test_creep.stun(10)


    # CONDUCT TEST
    test_creep.slow(test_slowdown_percentage, test_slowdown_duration)

    # Process frame to add slow timer
    await get_tree().process_frame

    # Retrieve slow timer
    for child in test_creep.get_children():
        if child is SlowTimer:
            retrieved_slow_timer = child
            break

    # Ensure slow timer has been  found
    assert_not_null(retrieved_slow_timer, "Slow timer has been found retrieved")

    var expected_capured_speed_points: int = 2
    assert_eq(retrieved_slow_timer.get_speed_points_claimed(), expected_capured_speed_points, "Right number of speed points captured")

    # Clean up 
    test_creep.queue_free()
    await get_tree().process_frame

func test_two_slow_timers_addition():
    # Create test slowdown values
    var test_slowdown_percentage: int = 20
    var test_slowdown_duration: float = 15.0
    var found_slow_timer_child_scene: bool = false
    var number_of_slow_timers_found: int = 0
    # Create test creep
    var test_creep_starting_speed: int = 10
    var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    test_creep.set_starting_speed(test_creep_starting_speed)
    add_child_autofree(test_creep)
    test_creep.stun(10)

    # Confirm starting state
    # Ensure no slow timers are present in the creep scene before slow infiction
    for child in test_creep.get_children():
        if child is SlowTimer:
            found_slow_timer_child_scene = true
            number_of_slow_timers_found += 1
    assert_false(found_slow_timer_child_scene, "Slow timer has not been added before slow effect initiated")
    assert_eq(number_of_slow_timers_found, 0, "0 Slow timers detected")
    assert_not_null(test_creep, "Test creep is properly loaded and added to scene")
    assert_eq(test_creep.__num_of_active_slow_effects, 0, "No active slow effects upon add")
    assert_eq(test_creep.get_curr_state(), Creep.States.IDLE, "Creep has been stunned")
    assert_eq(test_creep.get_curr_speed(), test_creep_starting_speed, "Speed has been properly initialized")

    # CONDUCT TEST
    # Add first slow timer
    test_creep.slow(test_slowdown_percentage, test_slowdown_duration)
    # Process frame to add first slow timer
    await get_tree().process_frame

    # Add second slow timer
    test_creep.slow(test_slowdown_percentage, test_slowdown_duration)
    # Process frame to add second slow timer
    await get_tree().process_frame

    # Ensure slow timer is now added to creep scene
    for child in test_creep.get_children():
        if child is SlowTimer:
            found_slow_timer_child_scene = true
            number_of_slow_timers_found += 1
    assert_true(found_slow_timer_child_scene, "Slow timer has been added as child of creep")
    assert_eq(number_of_slow_timers_found, 2, "2 Slow timer detected")

    # Clean up 
    test_creep.queue_free()
    await get_tree().process_frame

func test_single_slowdown_infliction():
    # Create test slowdown values
    var test_slowdown_percentage: int = 20
    var test_slowdown_duration: float = 15.0 
    # Create test creep
    var test_creep_starting_speed: int = 10
    var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    test_creep.set_starting_speed(test_creep_starting_speed)
    add_child_autofree(test_creep)
    test_creep.stun(10)

    await get_tree().process_frame

    # Confirm starting state
    assert_not_null(test_creep, "Test creep is properly loaded and added to scene")
    assert_eq(test_creep.__num_of_active_slow_effects, 0, "No active slow effects upon add")
    assert_eq(test_creep.get_curr_state(), Creep.States.IDLE, "Creep has been stunned")
    assert_eq(test_creep.get_curr_speed(), test_creep_starting_speed, "Speed has been properly initialized")

    # CONDUCT TEST
    test_creep.slow(test_slowdown_percentage, test_slowdown_duration)


    # Create expected values
    var expected_creep_curr_speed: int = 8

    # Asses results
    assert_false(test_creep.get_curr_speed() == test_creep_starting_speed, "slow() function results in alteration of current speed")
    assert_eq(test_creep.get_curr_speed(), expected_creep_curr_speed, "Creep speed alligns with expected altered creep speed")

    # Clean up 
    test_creep.queue_free()
    await get_tree().process_frame