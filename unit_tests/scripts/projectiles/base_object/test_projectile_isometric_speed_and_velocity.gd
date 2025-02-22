extends GutTest
class_name TestProjectileMovement

# --------------------------------------------------------------------------
# The tests below verify that the projectile's movement processing (its
# computed isometric speed and velocity) behaves as expected according
# to YOUR custom naming conventions. In Godot's 2D coordinate space,
# Y increases downward on screen, so "upwards" means negative Y, and
# "downwards" means positive Y.
#
# The isometric speed is calculated as:
#     (0.5 * abs(cos(direction_angle)) + 0.5) * __speed
#
# where direction_angle is the angle from the projectile's global_position
# to the target's global_position, and the velocity is the normalized vector
# from the projectile to the target.
# --------------------------------------------------------------------------


# 1) NORTH-WEST: Upwards (negative Y)
func test_isometric_speed_north_west():
	var projectile = Projectile.new()
	projectile.set_speed(10)
	projectile.position = Vector2.ZERO
	add_child_autofree(projectile)
	
	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	add_child_autofree(dummy_target)
	
	# Place the target directly ABOVE (negative Y).
	dummy_target.position = Vector2(0, -10)
	
	projectile.set_target(dummy_target)
	# Angle from (0,0) to (0, -10) is -PI/2, so cos(-PI/2) = 0 => isometric_speed = 5.
	# Velocity
	# --------
	# __velocity = (projectile.__target.global_position - projectile.global_position).normalized()
	# velocity = (0, -1) => up on the screen.
	assert_almost_eq(projectile.__isometric_speed, 5.0, 0.01,
		"Isometric speed should be 5 when target is directly above (negative Y).")
	assert_eq(projectile.__velocity, Vector2(0, -1),
		"Velocity should be set to Vector2(0, -1) when target is above.")
	


# 2) NORTH-EAST: Rightwards (positive X)
func test_isometric_speed_north_east():
	var projectile = Projectile.new()
	projectile.set_speed(10)
	projectile.position = Vector2.ZERO
	add_child_autofree(projectile)
	
	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	add_child_autofree(dummy_target)
	
	# Place the target to the RIGHT (positive X).
	dummy_target.position = Vector2(10, 0)
	
	projectile.set_target(dummy_target)
	# Angle from (0,0) to (10,0) is 0 => cos(0) = 1 => isometric_speed = 10.
	# Velocity
	# --------
	# __velocity = (projectile.__target.global_position - projectile.global_position).normalized()
	# velocity = (1, 0) => moves right on screen.
	assert_almost_eq(projectile.__isometric_speed, 10.0, 0.01,
		"Isometric speed should equal 10 when target is to the right.")
	assert_eq(projectile.__velocity, Vector2(1, 0),
		"Velocity should be Vector2.RIGHT when target is to the right.")


# 3) SOUTH-WEST: Leftwards (negative X)
func test_isometric_speed_south_west():
	var projectile = Projectile.new()
	projectile.set_speed(10)
	projectile.position = Vector2.ZERO
	add_child_autofree(projectile)
	
	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	add_child_autofree(dummy_target)
	
	# Place the target to the LEFT (negative X).
	dummy_target.position = Vector2(-10, 0)
	
	projectile.set_target(dummy_target)
	# Angle from (0,0) to (-10,0) is PI => cos(PI) = -1 => abs(-1)=1 => isometric_speed=10.
	# Velocity
	# --------
	# __velocity = (projectile.__target.global_position - projectile.global_position).normalized()
	# velocity = (-1, 0) => moves left on screen.
	assert_almost_eq(projectile.__isometric_speed, 10.0, 0.01,
		"Isometric speed should equal 10 when target is to the left.")
	assert_eq(projectile.__velocity, Vector2(-1, 0),
		"Velocity should be Vector2.LEFT when target is to the left.")


# 4) SOUTH-EAST: Downwards (positive Y)
func test_isometric_speed_south_east():
	var projectile = Projectile.new()
	projectile.set_speed(10)
	projectile.position = Vector2.ZERO
	add_child_autofree(projectile)
	
	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	add_child_autofree(dummy_target)
	
	# Place the target BELOW (positive Y).
	dummy_target.position = Vector2(0, 10)
	
	projectile.set_target(dummy_target)
	# Angle from (0,0) to (0,10) is PI/2 => cos(PI/2)=0 => isometric_speed=5.
	# Velocity
	# --------
	# __velocity = (projectile.__target.global_position - projectile.global_position).normalized()
	# velocity = (0, 1) => moves down on screen.
	assert_almost_eq(projectile.__isometric_speed, 5.0, 0.01,
		"Isometric speed should be 5 when target is directly below (positive Y).")
	assert_eq(projectile.__velocity, Vector2(0, 1),
		"Velocity should be Vector2.DOWN when target is directly below.")


# 5) NORTH: Up-right (x>0, y<0)
func test_isometric_speed_north():
	var projectile = Projectile.new()
	projectile.set_speed(10)
	projectile.position = Vector2.ZERO
	add_child_autofree(projectile)
	
	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	add_child_autofree(dummy_target)
	
	# Place the target up-right: x positive, y negative.
	dummy_target.position = Vector2(10, -10)
	
	projectile.set_target(dummy_target)
	# Angle from (0,0) to (10, -10) is -PI/4 => cos(-PI/4)=0.7071 => factor=0.85 => ~8.5355
	# Velocity
	# --------
	# __velocity = (projectile.__target.global_position - projectile.global_position).normalized()
	# velocity ~ (0.7071, -0.7071) => moves up-right.
	assert_almost_eq(projectile.__isometric_speed, 8.5355, 0.01,
		"Isometric speed should be ~8.5355 when target is up-right.")
	assert_almost_eq(projectile.__velocity.x, 0.7071, 0.01,
		"Velocity.x should be ~0.7071 for up-right movement.")
	assert_almost_eq(projectile.__velocity.y, -0.7071, 0.01,
		"Velocity.y should be ~-0.7071 for up-right movement.")


# 6) SOUTH: Down-left (x<0, y>0)
func test_isometric_speed_south():
	var projectile = Projectile.new()
	projectile.set_speed(10)
	projectile.position = Vector2.ZERO
	add_child_autofree(projectile)
	
	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	add_child_autofree(dummy_target)
	
	# Place the target down-left: x negative, y positive.
	dummy_target.position = Vector2(-10, 10)
	
	projectile.set_target(dummy_target)
	# Angle from (0,0) to (-10,10) is 3*PI/4 => cos(3*PI/4)=-0.7071 => abs=>0.7071 => factor=0.85 => ~8.5355
	assert_almost_eq(projectile.__isometric_speed, 8.5355, 0.01,
		"Isometric speed should be ~8.5355 when target is down-left.")
	
	# Velocity
	# --------
	# __velocity = (projectile.__target.global_position - projectile.global_position).normalized()
	# velocity ~ (-0.7071, 0.7071) => moves down-left.
	assert_almost_eq(projectile.__velocity.x, -0.7071, 0.01,
		"Velocity.x should be ~-0.7071 for down-left movement.")
	assert_almost_eq(projectile.__velocity.y, 0.7071, 0.01,
		"Velocity.y should be ~0.7071 for down-left movement.")


# 7) WEST: Up-left (x<0, y<0)
func test_isometric_speed_west():
	var projectile = Projectile.new()
	projectile.set_speed(10)
	projectile.position = Vector2.ZERO
	add_child_autofree(projectile)
	
	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	add_child_autofree(dummy_target)

	# Place the target up-left: x negative, y negative.
	dummy_target.position = Vector2(-10, -10)
	
	projectile.set_target(dummy_target)
	# Angle from (0,0) to (-10,-10) is -3*PI/4 => cos(-3*PI/4)=-0.7071 => abs=>0.7071 => ~8.5355
	assert_almost_eq(projectile.__isometric_speed, 8.5355, 0.01,
		"Isometric speed should be ~8.5355 when target is up-left.")
	
	# Velocity
	# --------
	# __velocity = (projectile.__target.global_position - projectile.global_position).normalized()
	# velocity ~ (-0.7071, -0.7071) => moves up-left.
	assert_almost_eq(projectile.__velocity.x, -0.7071, 0.01,
		"Velocity.x should be ~-0.7071 for up-left movement.")
	assert_almost_eq(projectile.__velocity.y, -0.7071, 0.01,
		"Velocity.y should be ~-0.7071 for up-left movement.")


# 8) EAST: Down-right (x>0, y>0)
func test_isometric_speed_east():
	var projectile = Projectile.new()
	projectile.set_speed(10)
	projectile.position = Vector2.ZERO
	add_child_autofree(projectile)
	
	var dummy_target = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	add_child_autofree(dummy_target)

	# Place the target down-right: x positive, y positive.
	dummy_target.position = Vector2(10, 10)
	
	projectile.set_target(dummy_target)
	
	# Isometric speed
	# ---------------
	# __isometric_speed = (0.5 * abs(cos(direction_angle)) + 0.5) * __speed
	# Angle from (0,0) to (10,10) is PI/4 => cos(PI/4)=0.7071 => factor=0.85 => ~8.5355
	assert_almost_eq(projectile.__isometric_speed, 8.5355, 0.01,
		"Isometric speed should be ~8.5355 when target is down-right.")
	
	# Velocity
	# --------
	# __velocity = (projectile.__target.global_position - projectile.global_position).normalized()
	# velocity ~ (0.7071, 0.7071) => moves down-right.
	assert_almost_eq(projectile.__velocity.x, 0.7071, 0.01,
		"Velocity.x should be ~0.7071 for down-right movement.")
	assert_almost_eq(projectile.__velocity.y, 0.7071, 0.01,
		"Velocity.y should be ~0.7071 for down-right movement.")
