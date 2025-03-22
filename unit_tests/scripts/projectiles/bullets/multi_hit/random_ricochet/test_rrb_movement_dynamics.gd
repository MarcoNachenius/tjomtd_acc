extends GutTest

## Reset before each test case
func before_each():
    await get_tree().process_frame  # Ensure previous nodes are fully freed.

func test_ricochet_movement_change():
    # Create test creep
    var test_creep: Creep = CreepConstants.CreepPreloads[0].instantiate()
    # Set position of the test creep
    test_creep.set_position(Vector2(20, 0))
    # Ensure that the test creep does not die from the damage inflicted by the bullet
    test_creep.set_curr_health(100)

    # Create test bullet
    var test_bullet: RandomRicochetBullet = RandomRicochetBullet.new()
    # Set the position of the test bullet
    test_bullet.set_position(Vector2.ZERO)
    # Ensre that the bullet does not inflict any damage
    test_bullet.set_damage(0)

    # Add test objects to the scene
    add_child_autofree(test_creep)
    add_child_autofree(test_bullet)

    # Set the velocity of the test bullet
    test_bullet.set_target(test_creep)

    # Capture initial velocity of the test bullet
    var initial_velocity = test_bullet.__velocity

    # Verify intitial velocity of the test bullet
    assert_eq(initial_velocity, Vector2(1, 0))

    # Inflict damage on test creep
    test_bullet._inflict_damange(test_creep)

    # Verify that the velocity of the test bullet has changed
    assert_ne(test_bullet.__velocity, initial_velocity)

    # Verify that the test bullet is still moving
    assert_ne(test_bullet.__velocity, Vector2.ZERO)

    # Clean up
    test_creep.queue_free()
    test_bullet.queue_free()