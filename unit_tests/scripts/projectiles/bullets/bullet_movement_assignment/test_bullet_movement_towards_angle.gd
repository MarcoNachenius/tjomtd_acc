extends GutTest

## Reset before each test case
func before_each():
	await get_tree().process_frame  # Ensure previous nodes are fully freed.


# *******************************
# update_movement_towards_angle()
# *******************************
func test_update_movement_towards_angle_south_east():
	# Create a new SingleHitBullet instance.
	var single_hit_bullet = SingleHitBullet.new()
	# Create test speed
	var test_speed: int = 30
	# Set the speed of the bullet.
	single_hit_bullet.set_speed(test_speed)
	# Set the position of the bullet.
	single_hit_bullet.position = Vector2.ZERO
	# Add the bullet to the scene tree.
	add_child_autofree(single_hit_bullet)

	# Ensure the bullet is at the correct starting position.
	assert_eq(single_hit_bullet.position, Vector2.ZERO, "Bullet should start at (0, 0) after being added to the scene tree.")

	# Update velocity and isometric speed towards target position.
	single_hit_bullet.update_movement_towards_angle(PI/2)

	# Move the bullet towards the target position.
	single_hit_bullet._handle_movement()

	# Test results
	assert_almost_eq(single_hit_bullet.position.x, 0.0, 0.01, "X-coordinate should remain 0.0")
	assert_almost_eq(single_hit_bullet.position.y, (float(test_speed)/2), 0.01, "Y-coordinate should be approximately (float(test_speed)/2) (moved DOWN by 15 units).")
	assert_almost_eq(single_hit_bullet.__isometric_speed, (float(test_speed)/2), 0.01, "Isometric speed should be near 15")
	assert_almost_eq(single_hit_bullet.__velocity.x, 0.0, 0.01, "Velocity.x should be 0")
	assert_almost_eq(single_hit_bullet.__velocity.y, 1.0, 0.01, "Velocity.y should be 1")

	# Clean up
	single_hit_bullet.queue_free()

func test_update_movement_towards_angle_north_west():
	# Create a new SingleHitBullet instance.
	var single_hit_bullet = SingleHitBullet.new()
	# Create test speed
	var test_speed: int = 30
	# Set the speed of the bullet.
	single_hit_bullet.set_speed(test_speed)
	# Set the position of the bullet.
	single_hit_bullet.position = Vector2.ZERO
	# Add the bullet to the scene tree.
	add_child_autofree(single_hit_bullet)

	# Ensure the bullet is at the correct starting position.
	assert_eq(single_hit_bullet.position, Vector2.ZERO, "Bullet should start at (0, 0) after being added to the scene tree.")

	# Update velocity and isometric speed towards target position.
	single_hit_bullet.update_movement_towards_angle(3*PI/2)

	# Move the bullet towards the target position.
	single_hit_bullet._handle_movement()

	# Test results
	assert_almost_eq(single_hit_bullet.position.x, 0.0, 0.01, "X-coordinate should remain 0.0")
	assert_almost_eq(single_hit_bullet.position.y, -(float(test_speed)/2), 0.01, "Y-coordinate should be approximately (float(test_speed)/2) (moved DOWN by 15 units).")
	assert_almost_eq(single_hit_bullet.__isometric_speed, (float(test_speed)/2), 0.01, "Isometric speed should be near 15")
	assert_almost_eq(single_hit_bullet.__velocity.x, 0.0, 0.01, "Velocity.x should be 0")
	assert_almost_eq(single_hit_bullet.__velocity.y, -1.0, 0.01, "Velocity.y should be -1")

	# Clean up
	single_hit_bullet.queue_free()

func test_update_movement_towards_angle_south_west():
	# Create a new SingleHitBullet instance.
	var single_hit_bullet = SingleHitBullet.new()
	# Create test speed
	var test_speed: int = 30
	# Set the speed of the bullet.
	single_hit_bullet.set_speed(test_speed)
	# Set the position of the bullet.
	single_hit_bullet.position = Vector2.ZERO
	# Add the bullet to the scene tree.
	add_child_autofree(single_hit_bullet)

	# Ensure the bullet is at the correct starting position.
	assert_eq(single_hit_bullet.position, Vector2.ZERO, "Bullet should start at (0, 0) after being added to the scene tree.")

	# Update velocity and isometric speed towards target position.
	single_hit_bullet.update_movement_towards_angle(PI)

	# Move the bullet towards the target position.
	single_hit_bullet._handle_movement()

	# Test results
	assert_almost_eq(single_hit_bullet.position.x, -float(test_speed), 0.01, "X-coordinate should remain be approximately -30 (moved LEFT by 30 units).")
	assert_almost_eq(single_hit_bullet.position.y, 0.0, 0.01, "Y-coordinate should be remain 0.")
	assert_almost_eq(single_hit_bullet.__isometric_speed, float(test_speed), 0.01, "Isometric speed should be near 30")
	assert_almost_eq(single_hit_bullet.__velocity.x, -1.0, 0.01, "Velocity.x should be -1")
	assert_almost_eq(single_hit_bullet.__velocity.y, 0.0, 0.01, "Velocity.y should be 0")

	# Clean up
	single_hit_bullet.queue_free()
