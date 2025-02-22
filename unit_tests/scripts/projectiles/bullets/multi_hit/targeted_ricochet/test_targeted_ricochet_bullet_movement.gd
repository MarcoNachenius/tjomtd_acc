extends GutTest

## Reset before each test case
func before_each():
	await get_tree().process_frame  # Ensure previous nodes are fully freed.

# 1) SOUTH-EAST: Downwards (positive Y)
func test_isometric_movement_south_east():
	var single_hit_bullet = TargetedRicochetBullet.new()
	single_hit_bullet.set_speed(30)
	single_hit_bullet.position = Vector2.ZERO  # Explicitly reset position
	
	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	# Place the target BELOW (positive Y).
	dummy_target.position = Vector2(0, 1000)

	add_child_autofree(single_hit_bullet)
	add_child_autofree(dummy_target)

	single_hit_bullet.set_target(dummy_target)
	dummy_target.stun(10)

	assert_eq(single_hit_bullet.position, Vector2.ZERO, "Bullet should start at (0, 0) after being added to the scene tree.")
	assert_eq(dummy_target.position, Vector2(0, 1000), "Target should start at (0, 1000) after being added to the scene tree.")

	await get_tree().process_frame

	assert_almost_eq(single_hit_bullet.position.x, 0.0, 0.01, "X-coordinate should remain 0.0")
	assert_almost_eq(single_hit_bullet.position.y, 15.0, 0.01, "Y-coordinate should be approximately 15.0 (moved down by 15 units).")
	assert_almost_eq(single_hit_bullet.__isometric_speed, 15.0, 0.01, "Isometric speed should be near 15")
	assert_eq(single_hit_bullet.__velocity, Vector2(0, 1), "Velocity should be (0, 1)")

	single_hit_bullet.queue_free()
	dummy_target.queue_free()
	await get_tree().process_frame  # Ensure they are removed before the next test

## Test the movement of the bullet when the target is directly above the bullet on the screen.
func test_isometric_movement_north_west():
	var single_hit_bullet = TargetedRicochetBullet.new()
	single_hit_bullet.set_speed(30)
	single_hit_bullet.position = Vector2.ZERO  # Explicitly reset position

	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	# Place the target ABOVE (negative Y).
	dummy_target.position = Vector2(0, -1000)

	add_child_autofree(single_hit_bullet)
	add_child_autofree(dummy_target)

	single_hit_bullet.set_target(dummy_target)
	dummy_target.stun(10)

	assert_eq(single_hit_bullet.position, Vector2.ZERO, "Bullet should start at (0, 0) after being added to the scene tree.")
	assert_eq(dummy_target.position, Vector2(0, -1000), "Target should start at (0, -1000) after being added to the scene tree.")

	await get_tree().process_frame

	assert_almost_eq(single_hit_bullet.position.x, 0.0, 0.01, "X-coordinate should remain 0.0")
	assert_almost_eq(single_hit_bullet.position.y, -15.0, 0.01, "Y-coordinate should be approximately 15.0 (moved up by 15 units).")
	assert_almost_eq(single_hit_bullet.__isometric_speed, 15.0, 0.01, "Isometric speed should be near 15")
	assert_eq(single_hit_bullet.__velocity, Vector2(0, -1), "Velocity should be (0, -1)")

	single_hit_bullet.queue_free()
	dummy_target.queue_free()
	await get_tree().process_frame  # Ensure they are removed before the next test


## Test the movement of the bullet when the target is directly left of the bullet on the screen.
func test_isometric_movement_south_west():
	var single_hit_bullet = TargetedRicochetBullet.new()
	single_hit_bullet.set_speed(30)
	single_hit_bullet.position = Vector2.ZERO  # Explicitly reset position

	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	# Place the target left (negative X).
	dummy_target.position = Vector2(-1000, 0)

	add_child_autofree(single_hit_bullet)
	add_child_autofree(dummy_target)

	single_hit_bullet.set_target(dummy_target)
	dummy_target.stun(10)

	assert_eq(single_hit_bullet.position, Vector2.ZERO, "Bullet should start at (0, 0) after being added to the scene tree.")
	assert_eq(dummy_target.position, Vector2(-1000, 0), "Target should start at (-1000, 0) after being added to the scene tree.")

	await get_tree().process_frame

	assert_almost_eq(single_hit_bullet.position.y, 0.0, 0.01, "Y-coordinate should remain 0.0")
	assert_almost_eq(single_hit_bullet.position.x, -30.0, 0.01, "X-coordinate should be approximately -30.0 (moved left by 30 units).")
	assert_almost_eq(single_hit_bullet.__isometric_speed, 30.0, 0.01, "Isometric speed should be near 30")
	assert_eq(single_hit_bullet.__velocity, Vector2(-1, 0), "Velocity should be (-1, 0)")

	single_hit_bullet.queue_free()
	dummy_target.queue_free()
	await get_tree().process_frame  # Ensure they are removed before the next test


## Test the movement of the bullet when the target is directly right of the bullet on the screen.
func test_isometric_movement_north_east():
	var single_hit_bullet = TargetedRicochetBullet.new()
	single_hit_bullet.set_speed(30)
	single_hit_bullet.position = Vector2.ZERO  # Explicitly reset position

	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	# Place the target right (positive X).
	dummy_target.position = Vector2(1000, 0)

	add_child_autofree(single_hit_bullet)
	add_child_autofree(dummy_target)

	single_hit_bullet.set_target(dummy_target)
	dummy_target.stun(10)

	assert_eq(single_hit_bullet.position, Vector2.ZERO, "Bullet should start at (0, 0) after being added to the scene tree.")
	assert_eq(dummy_target.position, Vector2(1000, 0), "Target should start at (1000, 0) after being added to the scene tree.")

	await get_tree().process_frame

	assert_almost_eq(single_hit_bullet.position.y, 0.0, 0.01, "Y-coordinate should remain 0.0")
	assert_almost_eq(single_hit_bullet.position.x, 30.0, 0.01, "X-coordinate should be approximately 30.0 (moved right by 30 units).")
	assert_almost_eq(single_hit_bullet.__isometric_speed, 30.0, 0.01, "Isometric speed should be near 30")
	assert_eq(single_hit_bullet.__velocity, Vector2(1, 0), "Velocity should be (1, 0)")

	single_hit_bullet.queue_free()
	dummy_target.queue_free()
	await get_tree().process_frame  # Ensure they are removed before the next test
