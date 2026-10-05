extends GutTest

func test_move_north_west():
    # Create test creep
    var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
    test_creep.position = Vector2.ZERO
    test_creep.set_path_points([Vector2i.ZERO, Vector2i(0, -10)])
    test_creep.set_starting_speed(5)

    # Add test creep to scene
    add_child_autofree(test_creep)

    # Verify initial compass direction
    assert_eq(CreepConstants.CompassDirections.NORTH_WEST, test_creep.get_curr_compass_direction())
    # Verify initial position
    assert_eq(Vector2.ZERO, test_creep.position)
    # Verify that creep is in moving state
    assert_eq(test_creep.States.MOVING, test_creep.get_curr_state())

    # Simulate creep movement
    test_creep._handle_movement()

    # Assert that the creep has moved in the desired direction
    assert_eq(Vector2(0, -2.5), test_creep.position)
    # Assert current compass direction is correct
    assert_eq(CreepConstants.CompassDirections.NORTH_WEST, test_creep.get_curr_compass_direction())

    # Clean up
    test_creep.queue_free()

func test_move_south_east():
    # Create test creep
    var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
    test_creep.position = Vector2.ZERO
    test_creep.set_path_points([Vector2i.ZERO, Vector2i(0, 10)])
    test_creep.set_starting_speed(5)

    # Add test creep to scene
    add_child_autofree(test_creep)

    # Verify initial compass direction
    assert_eq(CreepConstants.CompassDirections.SOUTH_EAST, test_creep.get_curr_compass_direction())
    # Verify initial position
    assert_eq(Vector2.ZERO, test_creep.position)
    # Verify that creep is in moving state
    assert_eq(test_creep.States.MOVING, test_creep.get_curr_state())

    # Simulate creep movement
    test_creep._handle_movement()

    # Assert that the creep has moved in the desired direction
    assert_eq(Vector2(0, 2.5), test_creep.position)
    # Assert current compass direction is correct
    assert_eq(CreepConstants.CompassDirections.SOUTH_EAST, test_creep.get_curr_compass_direction())

    # Clean up
    test_creep.queue_free()

func test_move_north_east():
    # Create test creep
    var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
    test_creep.position = Vector2.ZERO
    test_creep.set_path_points([Vector2i.ZERO, Vector2i(10, 0)])
    test_creep.set_starting_speed(5)

    # Add test creep to scene
    add_child_autofree(test_creep)

    # Verify initial compass direction
    assert_eq(CreepConstants.CompassDirections.NORTH_EAST, test_creep.get_curr_compass_direction())
    # Verify initial position
    assert_eq(Vector2.ZERO, test_creep.position)
    # Verify that creep is in moving state
    assert_eq(test_creep.States.MOVING, test_creep.get_curr_state())
    
    # Simulate creep movement
    test_creep._handle_movement()

    # Assert that the creep has moved in the desired direction
    assert_eq(Vector2(5, 0), test_creep.position)
    # Assert current compass direction is correct
    assert_eq(CreepConstants.CompassDirections.NORTH_EAST, test_creep.get_curr_compass_direction())

    # Clean up
    test_creep.queue_free()

func test_move_south_west():
    # Create test creep
    var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
    test_creep.position = Vector2.ZERO
    test_creep.set_path_points([Vector2i.ZERO, Vector2i(-10, 0)])
    test_creep.set_starting_speed(5)

    # Add test creep to scene
    add_child_autofree(test_creep)

    # Verify initial compass direction
    assert_eq(CreepConstants.CompassDirections.SOUTH_WEST, test_creep.get_curr_compass_direction())
    # Verify initial position
    assert_eq(Vector2.ZERO, test_creep.position)
    # Verify that creep is in moving state
    assert_eq(test_creep.States.MOVING, test_creep.get_curr_state())

    # Simulate creep movement
    test_creep._handle_movement()

    # Assert that the creep has moved in the desired direction
    assert_eq(Vector2(-5, 0), test_creep.position)
    # Assert current compass direction is correct
    assert_eq(CreepConstants.CompassDirections.SOUTH_WEST, test_creep.get_curr_compass_direction())

    # Clean up
    test_creep.queue_free()