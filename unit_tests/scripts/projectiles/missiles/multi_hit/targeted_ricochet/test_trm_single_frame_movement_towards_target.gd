extends GutTest

## Reset before each test case
func before_each():
	await get_tree().process_frame  # Ensure previous nodes are fully freed.

# 1) SOUTH-EAST: Downwards (positive Y)
func test_isometric_movement_south_east():
	var targeted_ricochet_hit_missile = ProjectileConstants.TARGETED_RICOCHET_MISSILE_LOADS[ProjectileConstants.TargetedRicochetMissiles.TEST_TARGETED_RICOCHET_MISSILE].instantiate()
	targeted_ricochet_hit_missile.set_speed(30)
	targeted_ricochet_hit_missile.position = Vector2.ZERO  # Explicitly reset position
	
	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	# Place the target BELOW (positive Y).
	dummy_target.position = Vector2(0, 1000)

	add_child_autofree(targeted_ricochet_hit_missile)
	add_child_autofree(dummy_target)

	targeted_ricochet_hit_missile.set_target(dummy_target)
	dummy_target.stun(10)

	assert_eq(targeted_ricochet_hit_missile.position, Vector2.ZERO, "Missile should start at (0, 0) after being added to the scene tree.")
	assert_eq(dummy_target.position, Vector2(0, 1000), "Target should start at (0, 1000) after being added to the scene tree.")

	# _handle_movement() should move the missile towards the target
	await get_tree().process_frame

	assert_almost_eq(targeted_ricochet_hit_missile.position.x, 0.0, 0.01, "X-coordinate should remain 0.0")
	assert_almost_eq(targeted_ricochet_hit_missile.position.y, 15.0, 0.01, "Y-coordinate should be approximately 15.0 (moved down by 15 units).")
	assert_almost_eq(targeted_ricochet_hit_missile.__isometric_speed, 15.0, 0.01, "Isometric speed should be near 15")
	assert_eq(targeted_ricochet_hit_missile.__velocity, Vector2(0, 1), "Velocity should be (0, 1)")

	targeted_ricochet_hit_missile.queue_free()
	dummy_target.queue_free()
	await get_tree().process_frame  # Ensure they are removed before the next test

## Test the movement of the missile when the target is directly above the missile on the screen.
func test_isometric_movement_north_west():
	var targeted_ricochet_hit_missile = ProjectileConstants.TARGETED_RICOCHET_MISSILE_LOADS[ProjectileConstants.TargetedRicochetMissiles.TEST_TARGETED_RICOCHET_MISSILE].instantiate()
	targeted_ricochet_hit_missile.set_speed(30)
	targeted_ricochet_hit_missile.position = Vector2.ZERO  # Explicitly reset position

	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	# Place the target ABOVE (negative Y).
	dummy_target.position = Vector2(0, -1000)

	add_child_autofree(targeted_ricochet_hit_missile)
	add_child_autofree(dummy_target)

	targeted_ricochet_hit_missile.set_target(dummy_target)
	dummy_target.stun(10)

	assert_eq(targeted_ricochet_hit_missile.position, Vector2.ZERO, "Missile should start at (0, 0) after being added to the scene tree.")
	assert_eq(dummy_target.position, Vector2(0, -1000), "Target should start at (0, -1000) after being added to the scene tree.")

	# _handle_movement() should move the missile towards the target
	await get_tree().process_frame

	assert_almost_eq(targeted_ricochet_hit_missile.position.x, 0.0, 0.01, "X-coordinate should remain 0.0")
	assert_almost_eq(targeted_ricochet_hit_missile.position.y, -15.0, 0.01, "Y-coordinate should be approximately 15.0 (moved up by 15 units).")
	assert_almost_eq(targeted_ricochet_hit_missile.__isometric_speed, 15.0, 0.01, "Isometric speed should be near 15")
	assert_eq(targeted_ricochet_hit_missile.__velocity, Vector2(0, -1), "Velocity should be (0, -1)")

	targeted_ricochet_hit_missile.queue_free()
	dummy_target.queue_free()
	await get_tree().process_frame  # Ensure they are removed before the next test


## Test the movement of the missile when the target is directly left of the missile on the screen.
func test_isometric_movement_south_west():
	var targeted_ricochet_hit_missile = ProjectileConstants.TARGETED_RICOCHET_MISSILE_LOADS[ProjectileConstants.TargetedRicochetMissiles.TEST_TARGETED_RICOCHET_MISSILE].instantiate()
	targeted_ricochet_hit_missile.set_speed(30)
	targeted_ricochet_hit_missile.position = Vector2.ZERO  # Explicitly reset position

	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	# Place the target left (negative X).
	dummy_target.position = Vector2(-1000, 0)

	add_child_autofree(targeted_ricochet_hit_missile)
	add_child_autofree(dummy_target)

	targeted_ricochet_hit_missile.set_target(dummy_target)
	dummy_target.stun(10)

	assert_eq(targeted_ricochet_hit_missile.position, Vector2.ZERO, "Missile should start at (0, 0) after being added to the scene tree.")
	assert_eq(dummy_target.position, Vector2(-1000, 0), "Target should start at (-1000, 0) after being added to the scene tree.")

	# _handle_movement() should move the missile towards the target
	await get_tree().process_frame

	assert_almost_eq(targeted_ricochet_hit_missile.position.y, 0.0, 0.01, "Y-coordinate should remain 0.0")
	assert_almost_eq(targeted_ricochet_hit_missile.position.x, -30.0, 0.01, "X-coordinate should be approximately -30.0 (moved left by 30 units).")
	assert_almost_eq(targeted_ricochet_hit_missile.__isometric_speed, 30.0, 0.01, "Isometric speed should be near 30")
	assert_eq(targeted_ricochet_hit_missile.__velocity, Vector2(-1, 0), "Velocity should be (-1, 0)")

	targeted_ricochet_hit_missile.queue_free()
	dummy_target.queue_free()
	await get_tree().process_frame  # Ensure they are removed before the next test


## Test the movement of the missile when the target is directly right of the missile on the screen.
func test_isometric_movement_north_east():
	var targeted_ricochet_hit_missile = ProjectileConstants.TARGETED_RICOCHET_MISSILE_LOADS[ProjectileConstants.TargetedRicochetMissiles.TEST_TARGETED_RICOCHET_MISSILE].instantiate()
	targeted_ricochet_hit_missile.set_speed(30)
	targeted_ricochet_hit_missile.position = Vector2.ZERO  # Explicitly reset position

	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	# Place the target right (positive X).
	dummy_target.position = Vector2(1000, 0)

	add_child_autofree(targeted_ricochet_hit_missile)
	add_child_autofree(dummy_target)

	targeted_ricochet_hit_missile.set_target(dummy_target)
	dummy_target.stun(10)

	assert_eq(targeted_ricochet_hit_missile.position, Vector2.ZERO, "Missile should start at (0, 0) after being added to the scene tree.")
	assert_eq(dummy_target.position, Vector2(1000, 0), "Target should start at (1000, 0) after being added to the scene tree.")

	# _handle_movement() should move the missile towards the target
	await get_tree().process_frame

	assert_almost_eq(targeted_ricochet_hit_missile.position.y, 0.0, 0.01, "Y-coordinate should remain 0.0")
	assert_almost_eq(targeted_ricochet_hit_missile.position.x, 30.0, 0.01, "X-coordinate should be approximately 30.0 (moved right by 30 units).")
	assert_almost_eq(targeted_ricochet_hit_missile.__isometric_speed, 30.0, 0.01, "Isometric speed should be near 30")
	assert_eq(targeted_ricochet_hit_missile.__velocity, Vector2(1, 0), "Velocity should be (1, 0)")

	targeted_ricochet_hit_missile.queue_free()
	dummy_target.queue_free()
	await get_tree().process_frame  # Ensure they are removed before the next test


## Test the movement of the missile when the target is directly top-right of the missile on the screen.
func test_isometric_movement_north():
	# Create test missile
	var targeted_ricochet_hit_missile = ProjectileConstants.TARGETED_RICOCHET_MISSILE_LOADS[ProjectileConstants.TargetedRicochetMissiles.TEST_TARGETED_RICOCHET_MISSILE].instantiate()
	targeted_ricochet_hit_missile.set_speed(30)
	targeted_ricochet_hit_missile.position = Vector2.ZERO  # Explicitly reset position

	# Create test target
	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	# Place the target top-right (positive X, negative Y).
	dummy_target.position = Vector2(1000, -1000)

	# Add the missile and target to the scene tree
	add_child_autofree(targeted_ricochet_hit_missile)
	add_child_autofree(dummy_target)

	# Assign the target to the missile
	targeted_ricochet_hit_missile.set_target(dummy_target)

	# Prevent the target from moving during the test.
	dummy_target.stun(10)

	# Verify the initial positions of the missile and target
	assert_eq(targeted_ricochet_hit_missile.position, Vector2.ZERO, "Missile should start at (0, 0) after being added to the scene tree.")
	assert_eq(dummy_target.position, Vector2(1000, -1000), "Target should start at (1000, -1000) after being added to the scene tree.")

	# Process a frame to update the missile's position
	await get_tree().process_frame

	# Evaluate the missile's position change
	assert_almost_eq(targeted_ricochet_hit_missile.position.y, -18.106, 0.01, "Y-coordinate should be approximately -18.106 (moved up by 18.106 units).")
	assert_almost_eq(targeted_ricochet_hit_missile.position.x, 18.106, 0.01, "X-coordinate should be approximately 18.106 (moved right by 18.106 units).")

	# Evaluate the missile's isometric speed
	assert_almost_eq(targeted_ricochet_hit_missile.__isometric_speed, 25.6065, 0.01, "Isometric speed should be near 25.6065")

	# Evaluate the missile's velocity
	assert_almost_eq(targeted_ricochet_hit_missile.__velocity.x, 0.7071, 0.01, "Velocity.x should be ~0.7071 for rightwards movement.")
	assert_almost_eq(targeted_ricochet_hit_missile.__velocity.y, -0.7071, 0.01, "Velocity.y should be ~0.7071 for upwards movement.")

	# Clean up test nodes
	targeted_ricochet_hit_missile.queue_free()
	dummy_target.queue_free()
	await get_tree().process_frame  # Ensure they are removed before the next test

## Test movement south (down-left)
func test_isometric_movement_south():
	var targeted_ricochet_hit_missile = ProjectileConstants.TARGETED_RICOCHET_MISSILE_LOADS[ProjectileConstants.TargetedRicochetMissiles.TEST_TARGETED_RICOCHET_MISSILE].instantiate()
	targeted_ricochet_hit_missile.set_speed(30)
	targeted_ricochet_hit_missile.position = Vector2.ZERO

	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	dummy_target.position = Vector2(-1000, 1000)

	add_child_autofree(targeted_ricochet_hit_missile)
	add_child_autofree(dummy_target)
	targeted_ricochet_hit_missile.set_target(dummy_target)
	dummy_target.stun(10)

	# _handle_movement() should move the missile towards the target
	await get_tree().process_frame

	assert_almost_eq(targeted_ricochet_hit_missile.position.y, 18.106, 0.01, "Y should be approximately 18.106 (moved down).")
	assert_almost_eq(targeted_ricochet_hit_missile.position.x, -18.106, 0.01, "X should be approximately -18.106 (moved left).")

	assert_almost_eq(targeted_ricochet_hit_missile.__velocity.x, -0.7071, 0.01, "Velocity.x should be ~-0.7071 for leftwards movement.")
	assert_almost_eq(targeted_ricochet_hit_missile.__velocity.y, 0.7071, 0.01, "Velocity.y should be ~0.7071 for downwards movement.")

	targeted_ricochet_hit_missile.queue_free()
	dummy_target.queue_free()
	await get_tree().process_frame

## Test movement east (down-right)
func test_isometric_movement_east():
	var targeted_ricochet_hit_missile = ProjectileConstants.TARGETED_RICOCHET_MISSILE_LOADS[ProjectileConstants.TargetedRicochetMissiles.TEST_TARGETED_RICOCHET_MISSILE].instantiate()
	targeted_ricochet_hit_missile.set_speed(30)
	targeted_ricochet_hit_missile.position = Vector2.ZERO

	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	dummy_target.position = Vector2(1000, 1000)

	add_child_autofree(targeted_ricochet_hit_missile)
	add_child_autofree(dummy_target)
	targeted_ricochet_hit_missile.set_target(dummy_target)
	dummy_target.stun(10)

	# _handle_movement() should move the missile towards the target
	await get_tree().process_frame

	assert_almost_eq(targeted_ricochet_hit_missile.position.y, 18.106, 0.01, "Y should be approximately 18.106 (moved down).")
	assert_almost_eq(targeted_ricochet_hit_missile.position.x, 18.106, 0.01, "X should be approximately 18.106 (moved right).")

	assert_almost_eq(targeted_ricochet_hit_missile.__velocity.x, 0.7071, 0.01, "Velocity.x should be ~0.7071 for rightwards movement.")
	assert_almost_eq(targeted_ricochet_hit_missile.__velocity.y, 0.7071, 0.01, "Velocity.y should be ~0.7071 for downwards movement.")

	targeted_ricochet_hit_missile.queue_free()
	dummy_target.queue_free()
	await get_tree().process_frame

## Test movement west (up-left)
func test_isometric_movement_west():
	var targeted_ricochet_hit_missile = ProjectileConstants.TARGETED_RICOCHET_MISSILE_LOADS[ProjectileConstants.TargetedRicochetMissiles.TEST_TARGETED_RICOCHET_MISSILE].instantiate()
	targeted_ricochet_hit_missile.set_speed(30)
	targeted_ricochet_hit_missile.position = Vector2.ZERO

	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	dummy_target.position = Vector2(-1000, -1000)

	add_child_autofree(targeted_ricochet_hit_missile)
	add_child_autofree(dummy_target)
	targeted_ricochet_hit_missile.set_target(dummy_target)
	dummy_target.stun(10)

	# _handle_movement() should move the missile towards the target
	await get_tree().process_frame

	assert_almost_eq(targeted_ricochet_hit_missile.position.y, -18.106, 0.01, "Y should be approximately -18.106 (moved up).")
	assert_almost_eq(targeted_ricochet_hit_missile.position.x, -18.106, 0.01, "X should be approximately -18.106 (moved left).")

	assert_almost_eq(targeted_ricochet_hit_missile.__velocity.x, -0.7071, 0.01, "Velocity.x should be ~-0.7071 for leftwards movement.")
	assert_almost_eq(targeted_ricochet_hit_missile.__velocity.y, -0.7071, 0.01, "Velocity.y should be ~-0.7071 for upwards movement.")

	targeted_ricochet_hit_missile.queue_free()
	dummy_target.queue_free()
	await get_tree().process_frame
