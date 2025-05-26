extends GutTest

## Reset before each test case
func before_each():
    await get_tree().process_frame  # Ensure previous nodes are fully freed.

func test_ricochet_movement_change():
    # Create test creep
    var test_creep: Creep = CreepConstants.CreepPreloads[0].instantiate()
    # Set position of the test creep
    test_creep.set_position(Vector2(20, 0))
    # Ensure that the test creep does not die from the damage inflicted by the missile
    test_creep.set_curr_health(100)

    # Create test missile
    var test_missile: RandomRicochetMissile = ProjectileConstants.RANDOM_RICOCHET_MISSILE_LOADS[ProjectileConstants.RandomRicochetMissiles.TOMBSTONE_LVL_1].instantiate()
    # Set the position of the test missile
    test_missile.set_position(Vector2.ZERO)
    # Ensre that the missile does not inflict any damage
    test_missile.set_damage(0)

    # Add test objects to the scene
    add_child_autofree(test_creep)
    add_child_autofree(test_missile)

    # Set the velocity of the test missile
    test_missile.set_target(test_creep)

    # Capture initial velocity of the test missile
    var initial_velocity = test_missile.__velocity

    # Verify intitial velocity of the test missile
    assert_eq(initial_velocity, Vector2(1, 0))

    # Inflict damage on test creep
    test_missile._inflict_damange(test_creep)

    # Verify that the velocity of the test missile has changed
    assert_ne(test_missile.__velocity, initial_velocity)

    # Verify that the test missile is still moving
    assert_ne(test_missile.__velocity, Vector2.ZERO)

    # REPEAT ENTIRE TEST ONCE MORE TO RULE OUT A FALSE POSITIVE DUE TO
    # PROBABILISTIC ANOMALIES CAUSED BY THE RANDOMNESS OF THE RICOCHET MECHANISM
    # --------------------------------------------------------------------------
    # Set the velocity of the test missile
    test_missile.set_target(test_creep)

    # Capture initial velocity of the test missile
    initial_velocity = test_missile.__velocity

    # Verify intitial velocity of the test missile
    assert_eq(initial_velocity, Vector2(1, 0))

    # Inflict damage on test creep
    test_missile._inflict_damange(test_creep)

    # Verify that the velocity of the test missile has changed
    assert_ne(test_missile.__velocity, initial_velocity)

    # Verify that the test missile is still moving
    assert_ne(test_missile.__velocity, Vector2.ZERO)

    # Clean up
    test_creep.queue_free()
    test_missile.queue_free()