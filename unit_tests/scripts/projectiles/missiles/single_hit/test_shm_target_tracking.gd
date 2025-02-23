extends GutTest

# Compass directions:
#	SE = Down
#	SW = Left
#	NW = Up
#	NE = Right
#	N = Up-Right
#	S = Down-Left
#	W = Up-Left
#	E = Down-Right


func test_se_to_sw_tracking():
    # Create missile
	var single_hit_missile = ProjectileConstants.SINGLE_HIT_MISSILE_LOADS[ProjectileConstants.SingleHitMissiles.BISMUTH_LVL_1].instantiate()
	single_hit_missile.set_speed(30)
	single_hit_missile.position = Vector2.ZERO
	
	# Create target
	var target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	
	# Add missile and target to scene tree
	add_child_autofree(single_hit_missile)
	add_child_autofree(target)

    # Move the target SOUTH-EAST of the missile 
	target.position = Vector2(0, 1000)

    # Assign the target to the missile
	single_hit_missile.set_target(target)

	# Verify initial positions
	assert_eq(single_hit_missile.position, Vector2.ZERO, "Missile should start at (0, 0) after being added to the scene tree.")
	assert_eq(target.position, Vector2(0, 1000), "Target should start at (0, 1000) after being added to the scene tree.")

	# Move the missile towards the target
	single_hit_missile._handle_movement()

	# Verify the missile's new position
	assert_almost_eq(single_hit_missile.position.x, 0.0, 0.01, "X-coordinate should remain 0.0")
	assert_almost_eq(single_hit_missile.position.y, 15.0, 0.01, "Y-coordinate should be approximately 15.0 (moved down by 15 units).")
	assert_almost_eq(single_hit_missile.__isometric_speed, 15.0, 0.01, "Isometric speed should be near 15")
	assert_eq(single_hit_missile.__velocity, Vector2(0, 1), "Velocity should be (0, 1)")

	# Move the target directly SOUTH-WEST of the missile
	target.position = Vector2(-1000, 15)

	# Move the missile towards the target
	single_hit_missile._handle_movement()
	
	# Verify the missile's new position
	assert_almost_eq(single_hit_missile.position.x, -30.0, 0.01, "X-coordinate should be approximately -30.0 (moved left by 15 units).")
	assert_almost_eq(single_hit_missile.position.y, 15.0, 0.01, "Y-coordinate should remain 15.0")

	single_hit_missile.queue_free()
	target.queue_free()