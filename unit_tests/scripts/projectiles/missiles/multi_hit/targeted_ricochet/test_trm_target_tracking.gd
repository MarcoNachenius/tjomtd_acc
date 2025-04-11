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
	var targeted_ricochet_missile = ProjectileConstants.TARGETED_RICOCHET_MISSILE_LOADS[ProjectileConstants.TargetedRicochetMissiles.TEST_TARGETED_RICOCHET_MISSILE].instantiate()
	targeted_ricochet_missile.set_speed(30)
	targeted_ricochet_missile.position = Vector2.ZERO

	# Create target
	var target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()

	# Add missile and target to scene tree
	add_child_autofree(targeted_ricochet_missile)
	add_child_autofree(target)

	# Move the target SOUTH-EAST of the missile 
	target.position = Vector2(0, 1000)

	# Assign the target to the missile
	targeted_ricochet_missile.set_target(target)

	# Verify initial positions
	assert_eq(targeted_ricochet_missile.position, Vector2.ZERO, "Missile should start at (0, 0) after being added to the scene tree.")
	assert_eq(target.position, Vector2(0, 1000), "Target should start at (0, 1000) after being added to the scene tree.")

	# Move the missile towards the target
	targeted_ricochet_missile._handle_movement()

	# Verify the missile's new position
	assert_almost_eq(targeted_ricochet_missile.position.x, 0.0, 0.01, "X-coordinate should remain 0.0")
	assert_almost_eq(targeted_ricochet_missile.position.y, 15.0, 0.01, "Y-coordinate should be approximately 15.0 (moved down by 15 units).")

	# Move the target directly SOUTH-WEST of the missile
	target.position = Vector2(-1000, 0) + targeted_ricochet_missile.position

	# Move the missile towards the target
	targeted_ricochet_missile._handle_movement()

	# Verify the missile's new position
	assert_almost_eq(targeted_ricochet_missile.position.x, -30.0, 0.01, "X-coordinate should be approximately -30.0 (moved left by 30 units).")
	assert_almost_eq(targeted_ricochet_missile.position.y, 15.0, 0.01, "Y-coordinate should remain 15.0")

	# Clean up
	targeted_ricochet_missile.queue_free()
	target.queue_free()

func test_nw_to_ne_tracking():
	# Create missile
	var targeted_ricochet_missile = ProjectileConstants.TARGETED_RICOCHET_MISSILE_LOADS[ProjectileConstants.TargetedRicochetMissiles.TEST_TARGETED_RICOCHET_MISSILE].instantiate()
	targeted_ricochet_missile.set_speed(30)
	targeted_ricochet_missile.position = Vector2.ZERO

	# Create target
	var target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()

	# Add missile and target to scene tree
	add_child_autofree(targeted_ricochet_missile)
	add_child_autofree(target)

	# Move the target NORTH-WEST of the missile
	target.position = Vector2(0, -1000)

	# Assign the target to the missile
	targeted_ricochet_missile.set_target(target)

	# Verify initial positions
	assert_eq(targeted_ricochet_missile.position, Vector2.ZERO, "Missile should start at (0, 0)")
	assert_eq(target.position, Vector2(0, -1000), "Target should start at (0, -1000)")

	# Move the missile towards the target
	targeted_ricochet_missile._handle_movement()

	# Verify the missile's new position
	assert_almost_eq(targeted_ricochet_missile.position.x, 0.0, 0.01, "X-coordinate should remain 0.0")
	assert_almost_eq(targeted_ricochet_missile.position.y, -15.0, 0.01, "Y-coordinate should be approximately -15.0 (moved up)")

	# Move the target directly NORTH-EAST of the missile
	target.position = Vector2(1000, 0) + targeted_ricochet_missile.position

	# Move the missile towards the target
	targeted_ricochet_missile._handle_movement()

	# Verify the missile's new position
	assert_almost_eq(targeted_ricochet_missile.position.x, 30.0, 0.01, "X-coordinate should be approximately 30.0 (moved right)")
	assert_almost_eq(targeted_ricochet_missile.position.y, -15.0, 0.01, "Y-coordinate should remain -15.0")

func test_n_to_s_tracking():
	# Create missile
	var targeted_ricochet_missile = ProjectileConstants.TARGETED_RICOCHET_MISSILE_LOADS[ProjectileConstants.TargetedRicochetMissiles.TEST_TARGETED_RICOCHET_MISSILE].instantiate()
	targeted_ricochet_missile.set_speed(30)
	targeted_ricochet_missile.position = Vector2.ZERO

	# Create target
	var target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()

	# Add missile and target to scene tree
	add_child_autofree(targeted_ricochet_missile)
	add_child_autofree(target)

	# Move the target NORTH of the missile
	target.position = Vector2(1000, -1000)

	# Assign the target to the missile
	targeted_ricochet_missile.set_target(target)

	# Move the missile towards the target
	targeted_ricochet_missile._handle_movement()

	# Verify the missile's new position
	assert_almost_eq(targeted_ricochet_missile.position.x, 18.106, 0.01, "X-coordinate should be approximately 18.106")
	assert_almost_eq(targeted_ricochet_missile.position.y, -18.106, 0.01, "Y-coordinate should be approximately -18.106")

	# Move the target SOUTH of the missile
	target.position = Vector2(-1000, 1000) + targeted_ricochet_missile.position

	# Move the missile towards the target
	targeted_ricochet_missile._handle_movement()

	# Verify the missile's new position
	assert_almost_eq(targeted_ricochet_missile.position.x, 0.0, 0.01, "X-coordinate should be approximately 0")
	assert_almost_eq(targeted_ricochet_missile.position.y, 0.0, 0.01, "Y-coordinate should be approximately 0")

func test_w_to_e_tracking():
	# Create missile
	var targeted_ricochet_missile = ProjectileConstants.TARGETED_RICOCHET_MISSILE_LOADS[ProjectileConstants.TargetedRicochetMissiles.TEST_TARGETED_RICOCHET_MISSILE].instantiate()
	targeted_ricochet_missile.set_speed(30)
	targeted_ricochet_missile.position = Vector2.ZERO

	# Create target
	var target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()

	# Add missile and target to scene tree
	add_child_autofree(targeted_ricochet_missile)
	add_child_autofree(target)

	# Move the target WEST of the missile
	target.position = Vector2(-1000, -1000)

	# Assign the target to the missile
	targeted_ricochet_missile.set_target(target)

	# Move the missile towards the target
	targeted_ricochet_missile._handle_movement()

	# Verify the missile's new position
	assert_almost_eq(targeted_ricochet_missile.position.x, -18.106, 0.01, "X-coordinate should be approximately -18.106")
	assert_almost_eq(targeted_ricochet_missile.position.y, -18.106, 0.01, "Y-coordinate should be approximately -18.106")

	# Move the target EAST of the missile
	target.position = Vector2(1000, 1000) + targeted_ricochet_missile.position

	# Move the missile towards the target
	targeted_ricochet_missile._handle_movement()

	# Verify the missile's new position
	assert_almost_eq(targeted_ricochet_missile.position.x, 0.0, 0.01, "X-coordinate should be approximately 0")
	assert_almost_eq(targeted_ricochet_missile.position.y, 0.0, 0.01, "Y-coordinate should be approximately 0")
