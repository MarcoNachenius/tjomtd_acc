extends GutTest


## Screen movement to compass directions is tested in this file.
## The bullet is tested to move in the following directions:
## - North-West: Upwarts movement on the screen.
## - North-East: Rightwards movement on the screen.
## - South-West: Leftwards movement on the screen.
## - South-East: Downwards movement on the screen.
## - North: Up-right movement on the screen.
## - South: Down-left movement on the screen.
## - West: Up-left movement on the screen.
## - East: Down-right movement on the screen.



## Test the movement of the bullet when the target is directly below the bullet on the screen.
## Keep in mind that there is an inverted y-axis in Godot, so moving down
## means increasing the y-coordinate.
func test_isometric_movement_south_east():
	# Create bullet
	var single_hit_bullet = SingleHitBullet.new()
	single_hit_bullet.set_speed(30)
	single_hit_bullet.position = Vector2.ZERO

	# Create target
	var dummy_target: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	# The distance from the bullet to the target is set high to avoid collision
	# between the bullet and the target during the test.
	dummy_target.position = Vector2(0, 1000)

	# Add nodes to the scene tree so that _process() runs.
	add_child_autofree(single_hit_bullet)
	add_child_autofree(dummy_target)

	# Set the target and run _process() to test if _handle_movement() works.
	single_hit_bullet.set_target(dummy_target)

	# Make the target idle so that it doesn't move.
	dummy_target._switch_state(dummy_target.States.IDLE)


	# Process the frame which adds the bullet and target to the scene tree.
	await  get_tree().process_frame

	# Confirm that the bullet and target are in the correct positions before moving.
	assert_eq(single_hit_bullet.position, Vector2.ZERO, "Bullet should start at (0, 0) after being added to the scene tree.")
	assert_eq(dummy_target.position, Vector2(0, 1000), "Target should start at (0, 1000) after being added to the scene tree.")

	# Process the frame which moves the bullet.
	await  get_tree().process_frame

	# Now, _process() should have updated the position.
	# Check that the bullet moved down by 15 units.
	assert_almost_eq(single_hit_bullet.position.x, 0.0, 0.01, "X should remain 0.0")
	assert_almost_eq(single_hit_bullet.position.y, 15.0, 0.01, "Y should be approximately 15.0 (moved down by 15 units).")

