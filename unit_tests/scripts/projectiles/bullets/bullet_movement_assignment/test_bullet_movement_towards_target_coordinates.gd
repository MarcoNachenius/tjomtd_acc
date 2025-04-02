extends GutTest

## Reset before each test case
func before_each():
	await get_tree().process_frame  # Ensure previous nodes are fully freed.

# *****************************************
# update_movement_towards_target_position()
# *****************************************
func test_update_movement_towards_target_position_south_east():
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
	single_hit_bullet.update_movement_towards_target_position(Vector2(0, 1000))

	# Move the bullet towards the target position.
	single_hit_bullet._handle_movement()

	# Test results
	assert_almost_eq(single_hit_bullet.position.x, 0.0, 0.01, "X-coordinate should remain 0.0")
	assert_almost_eq(single_hit_bullet.position.y, (float(test_speed)/2), 0.01, "Y-coordinate should be approximately (float(test_speed)/2) (moved DOWN by 15 units).")
	assert_almost_eq(single_hit_bullet.__isometric_speed, (float(test_speed)/2), 0.01, "Isometric speed should be near 15")
	assert_eq(single_hit_bullet.__velocity, Vector2(0, 1), "Velocity should be (0, 1)")

	# Clean up
	single_hit_bullet.queue_free()

func test_update_movement_towards_target_position_north_west():
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
	single_hit_bullet.update_movement_towards_target_position(Vector2(0, -1000))

	# Move the bullet towards the target position.
	single_hit_bullet._handle_movement()

	# Test results
	assert_almost_eq(single_hit_bullet.position.x, 0.0, 0.01, "X-coordinate should remain 0.0")
	assert_almost_eq(single_hit_bullet.position.y, -(float(test_speed)/2), 0.01, "Y-coordinate should be approximately (float(test_speed)/2) (moved UP by 15 units).")
	assert_almost_eq(single_hit_bullet.__isometric_speed, (float(test_speed)/2), 0.01, "Isometric speed should be near 15")
	assert_eq(single_hit_bullet.__velocity, Vector2(0, -1), "Velocity should be (0, -1)")

	# Clean up
	single_hit_bullet.queue_free()

func test_update_movement_towards_target_position_north_east():
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
	single_hit_bullet.update_movement_towards_target_position(Vector2(-1000, 0))

	# Move the bullet towards the target position.
	single_hit_bullet._handle_movement()

	# Test results
	assert_almost_eq(single_hit_bullet.position.x, -float(test_speed), 0.01, "X-coordinate should remain be approximately -30 (moved LEFT by 30 units).")
	assert_almost_eq(single_hit_bullet.position.y, 0.0, 0.01, "Y-coordinate should be remain 0.")
	assert_almost_eq(single_hit_bullet.__isometric_speed, float(test_speed), 0.01, "Isometric speed should be near 30")
	assert_eq(single_hit_bullet.__velocity, Vector2(-1, 0), "Velocity should be (-1, 0)")

	# Clean up
	single_hit_bullet.queue_free()

func test_update_movement_towards_target_position_south_west():
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
	single_hit_bullet.update_movement_towards_target_position(Vector2(1000, 0))

	# Move the bullet towards the target position.
	single_hit_bullet._handle_movement()

	# Test results
	assert_almost_eq(single_hit_bullet.position.x, float(test_speed), 0.01, "X-coordinate should remain be approximately -30 (moved LEFT by 30 units).")
	assert_almost_eq(single_hit_bullet.position.y, 0.0, 0.01, "Y-coordinate should be remain 0.")
	assert_almost_eq(single_hit_bullet.__isometric_speed, float(test_speed), 0.01, "Isometric speed should be near 30")
	assert_eq(single_hit_bullet.__velocity, Vector2(1, 0), "Velocity should be (1, 0)")

	# Clean up
	single_hit_bullet.queue_free()


# ************************************************
# update_movement_towards_target_global_position()
# ************************************************
func test_update_movement_towards_target_global_position_south_east():
	# Create a new SingleHitBullet instance.
	var single_hit_bullet = SingleHitBullet.new()
	# Create test speed
	var test_speed: int = 30
	# Set the speed of the bullet.
	single_hit_bullet.set_speed(test_speed)
	# Set the position of the bullet.
	single_hit_bullet.global_position = Vector2.ZERO
	# Add the bullet to the scene tree.
	add_child_autofree(single_hit_bullet)

	# Ensure the bullet is at the correct starting position.
	assert_eq(single_hit_bullet.global_position, Vector2.ZERO, "Bullet should start at (0, 0) after being added to the scene tree.")

	# Update velocity and isometric speed towards target position.
	single_hit_bullet.update_movement_towards_target_global_position(Vector2(0, 1000))

	# Move the bullet towards the target position.
	single_hit_bullet._handle_movement()

	# Test results
	assert_almost_eq(single_hit_bullet.global_position.x, 0.0, 0.01, "X-coordinate should remain 0.0")
	assert_almost_eq(single_hit_bullet.global_position.y, (float(test_speed)/2), 0.01, "Y-coordinate should be approximately (float(test_speed)/2) (moved DOWN by 15 units).")
	assert_almost_eq(single_hit_bullet.__isometric_speed, (float(test_speed)/2), 0.01, "Isometric speed should be near 15")
	assert_eq(single_hit_bullet.__velocity, Vector2(0, 1), "Velocity should be (0, 1)")

	# Clean up
	single_hit_bullet.queue_free()

func test_update_movement_towards_target_global_position_north_west():
	# Create a new SingleHitBullet instance.
	var single_hit_bullet = SingleHitBullet.new()
	# Create test speed
	var test_speed: int = 30
	# Set the speed of the bullet.
	single_hit_bullet.set_speed(test_speed)
	# Set the position of the bullet.
	single_hit_bullet.global_position = Vector2.ZERO
	# Add the bullet to the scene tree.
	add_child_autofree(single_hit_bullet)

	# Ensure the bullet is at the correct starting position.
	assert_eq(single_hit_bullet.global_position, Vector2.ZERO, "Bullet should start at (0, 0) after being added to the scene tree.")

	# Update velocity and isometric speed towards target position.
	single_hit_bullet.update_movement_towards_target_global_position(Vector2(0, -1000))

	# Move the bullet towards the target position.
	single_hit_bullet._handle_movement()

	# Test results
	assert_almost_eq(single_hit_bullet.global_position.x, 0.0, 0.01, "X-coordinate should remain 0.0")
	assert_almost_eq(single_hit_bullet.global_position.y, -(float(test_speed)/2), 0.01, "Y-coordinate should be approximately (float(test_speed)/2) (moved UP by 15 units).")
	assert_almost_eq(single_hit_bullet.__isometric_speed, (float(test_speed)/2), 0.01, "Isometric speed should be near 15")
	assert_eq(single_hit_bullet.__velocity, Vector2(0, -1), "Velocity should be (0, -1)")

	# Clean up
	single_hit_bullet.queue_free()

func test_update_movement_towards_target_global_position_north_east():
	# Create a new SingleHitBullet instance.
	var single_hit_bullet = SingleHitBullet.new()
	# Create test speed
	var test_speed: int = 30
	# Set the speed of the bullet.
	single_hit_bullet.set_speed(test_speed)
	# Set the position of the bullet.
	single_hit_bullet.global_position = Vector2.ZERO
	# Add the bullet to the scene tree.
	add_child_autofree(single_hit_bullet)

	# Ensure the bullet is at the correct starting position.
	assert_eq(single_hit_bullet.global_position, Vector2.ZERO, "Bullet should start at (0, 0) after being added to the scene tree.")

	# Update velocity and isometric speed towards target position.
	single_hit_bullet.update_movement_towards_target_global_position(Vector2(-1000, 0))

	# Move the bullet towards the target position.
	single_hit_bullet._handle_movement()

	# Test results
	assert_almost_eq(single_hit_bullet.global_position.x, -float(test_speed), 0.01, "X-coordinate should remain be approximately -30 (moved LEFT by 30 units).")
	assert_almost_eq(single_hit_bullet.global_position.y, 0.0, 0.01, "Y-coordinate should be remain 0.")
	assert_almost_eq(single_hit_bullet.__isometric_speed, float(test_speed), 0.01, "Isometric speed should be near 30")
	assert_eq(single_hit_bullet.__velocity, Vector2(-1, 0), "Velocity should be (-1, 0)")

func test_update_movement_towards_target_global_position_south_west():
	# Create a new SingleHitBullet instance.
	var single_hit_bullet = SingleHitBullet.new()
	# Create test speed
	var test_speed: int = 30
	# Set the speed of the bullet.
	single_hit_bullet.set_speed(test_speed)
	# Set the position of the bullet.
	single_hit_bullet.global_position = Vector2.ZERO
	# Add the bullet to the scene tree.
	add_child_autofree(single_hit_bullet)

	# Ensure the bullet is at the correct starting position.
	assert_eq(single_hit_bullet.global_position, Vector2.ZERO, "Bullet should start at (0, 0) after being added to the scene tree.")

	# Update velocity and isometric speed towards target position.
	single_hit_bullet.update_movement_towards_target_global_position(Vector2(1000, 0))

	# Move the bullet towards the target position.
	single_hit_bullet._handle_movement()

	# Test results
	assert_almost_eq(single_hit_bullet.global_position.x, float(test_speed), 0.01, "X-coordinate should remain be approximately -30 (moved LEFT by 30 units).")
	assert_almost_eq(single_hit_bullet.global_position.y, 0.0, 0.01, "Y-coordinate should be remain 0.")
	assert_almost_eq(single_hit_bullet.__isometric_speed, float(test_speed), 0.01, "Isometric speed should be near 30")
	assert_eq(single_hit_bullet.__velocity, Vector2(1, 0), "Velocity should be (-1, 0)")
