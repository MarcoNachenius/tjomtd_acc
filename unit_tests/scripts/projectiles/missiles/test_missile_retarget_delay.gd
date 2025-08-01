extends GutTest

# This test checks the retarget delay functionality of single hit missiles.
# It ensures that the missile does not retarget until it has traveled a specified distance.

# Missile types that have retarget delay functionality:
#   - SingleHitMissile
#   - TargetedRicochetMissile

## Reset before each test case
func before_each():
    await get_tree().process_frame  # Ensure previous nodes are fully freed.

func test_single_hit_missile_retarget_delay():
    # Instantiate missile
    var single_hit_missile: SingleHitMissile = ProjectileConstants.SINGLE_HIT_MISSILE_LOADS[ProjectileConstants.SingleHitMissiles.BISMUTH_LVL_1].instantiate()

    # Assign speed
    const TEST_SPEED: int = 10
    single_hit_missile.set_speed(TEST_SPEED)

    # Assign retargetability
    single_hit_missile.set_retargetable(true)
    single_hit_missile.set_retarget_radius(50) # Radius amount is arbitrary for this test

    # Assign movement (movement to right)
    single_hit_missile.update_movement_towards_angle(0)

    # Ensure calculated velocity in _handle_retarget_delay() is correctly calculated
    const EXPECTED_CALCULATED_VELOCITY: Vector2 = Vector2(TEST_SPEED, 0)
    var returned_calculated_velocity: Vector2 = single_hit_missile.__velocity * single_hit_missile.__speed
    assert_eq(EXPECTED_CALCULATED_VELOCITY, returned_calculated_velocity, "Calculated velocity matches expected value.")

    # Enable retarget delay
    const RETARGET_DELAY_DISTANCE: int = 20
    single_hit_missile.delay_retargeting(RETARGET_DELAY_DISTANCE)

    # Add missile to scene
    add_child_autofree(single_hit_missile)

    # Ensure starting position is (0, 0)
    assert_eq(single_hit_missile.global_position, Vector2(0, 0), "Initial global position is (0, 0)")

    # Ensure retarget hurtbox has been created
    assert_not_null(single_hit_missile.__retarget_hurtbox, "Retarget hurtbox has been created")

    # Ensure retarget delay has been enabled
    assert_true(single_hit_missile.__delay_retargeting, "Retarget delay has been enabled")

    # Have missile move one frame
    await  get_tree().process_frame

    # Ensure missile has moved to (10, 0)
    assert_eq(single_hit_missile.global_position, Vector2(10, 0), "Initial global position is (10, 0)")

    # Ensure distance travelled has been correctly tracked under the hood
    assert_eq(single_hit_missile.__distance_travelled, 10.0, "Distance travelled after one frame is 10.0")

    # Ensure retarget delay is still enabled
    assert_true(single_hit_missile.__delay_retargeting, "Retarget delay has been enabled")

    # Have missile move one frame
    # At this stage monitoring should be enabled again because retarget delay distance is set to 20 
    await  get_tree().process_frame

    # Ensure missile has moved to (20, 0)
    assert_eq(single_hit_missile.global_position, Vector2(20, 0), "Initial global position is (20, 0)")

    # Ensure distance travelled has been correctly tracked under the hood
    assert_eq(single_hit_missile.__distance_travelled, float(RETARGET_DELAY_DISTANCE))

    # Ensure retarget delay is no longer active
    assert_false(single_hit_missile.__delay_retargeting, "Retarget delay has been enabled")

    single_hit_missile.queue_free()


func test_targeted_ricochet_missile_retarget_delay():
    # Instantiate missile
    var targeted_ricochet_missile: TargetedRicochetMissile = ProjectileConstants.TARGETED_RICOCHET_MISSILE_LOADS[ProjectileConstants.TargetedRicochetMissiles.BISMUTH_LVL_3].instantiate()

    # Assign speed
    const TEST_SPEED: int = 10
    targeted_ricochet_missile.set_speed(TEST_SPEED)

    # Assign retargetability
    targeted_ricochet_missile.set_retargetable(true)
    targeted_ricochet_missile.set_retarget_radius(50) # Radius amount is arbitrary for this test

    # Assign movement (movement to right)
    targeted_ricochet_missile.update_movement_towards_angle(0)

    # Ensure calculated velocity in _handle_retarget_delay() is correctly calculated
    const EXPECTED_CALCULATED_VELOCITY: Vector2 = Vector2(TEST_SPEED, 0)
    var returned_calculated_velocity: Vector2 = targeted_ricochet_missile.__velocity * targeted_ricochet_missile.__speed
    assert_eq(EXPECTED_CALCULATED_VELOCITY, returned_calculated_velocity, "Calculated velocity matches expected value.")

    # Enable retarget delay
    const RETARGET_DELAY_DISTANCE: int = 20
    targeted_ricochet_missile.delay_retargeting(RETARGET_DELAY_DISTANCE)

    # Add missile to scene
    add_child_autofree(targeted_ricochet_missile)

    # Ensure starting position is (0, 0)
    assert_eq(targeted_ricochet_missile.global_position, Vector2(0, 0), "Initial global position is (0, 0)")

    # Ensure retarget hurtbox has been created
    assert_not_null(targeted_ricochet_missile.__retarget_hurtbox, "Retarget hurtbox has been created")

    # Ensure retarget delay has been enabled
    assert_true(targeted_ricochet_missile.__delay_retargeting, "Retarget delay has been enabled")

    # Have missile move one frame
    await  get_tree().process_frame

    # Ensure missile has moved to (10, 0)
    assert_eq(targeted_ricochet_missile.global_position, Vector2(10, 0), "Initial global position is (10, 0)")

    # Ensure distance travelled has been correctly tracked under the hood
    assert_eq(targeted_ricochet_missile.__distance_travelled, 10.0, "Distance travelled after one frame is 10.0")

    # Ensure retarget delay is still enabled
    assert_true(targeted_ricochet_missile.__delay_retargeting, "Retarget delay has been enabled")

    # Have missile move one frame
    # At this stage monitoring should be enabled again because retarget delay distance is set to 20 
    await  get_tree().process_frame

    # Ensure missile has moved to (20, 0)
    assert_eq(targeted_ricochet_missile.global_position, Vector2(20, 0), "Initial global position is (20, 0)")

    # Ensure distance travelled has been correctly tracked under the hood
    assert_eq(targeted_ricochet_missile.__distance_travelled, float(RETARGET_DELAY_DISTANCE))

    # Ensure retarget delay is no longer active
    assert_false(targeted_ricochet_missile.__delay_retargeting, "Retarget delay has been enabled")

    targeted_ricochet_missile.queue_free()