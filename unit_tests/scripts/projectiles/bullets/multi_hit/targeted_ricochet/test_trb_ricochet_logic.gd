extends GutTest

## This test verifies the ricochet logic of the TargetedRicochetBullet, 
## ensuring that the bullet correctly bounces between available targets. 

func test_ricochet_between_two_targets_with_handle_ricochet_method():

	# Test vars
	var bullet_speed: int = 5
	var bullet_starting_position: Vector2 = Vector2(50, 0)
	var first_creep_starting_position: Vector2 = Vector2.ZERO
	var second_creep_starting_position: Vector2 = Vector2(100, 0)

	# Create test creeps
	var first_entered_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER].instantiate()
	var second_entered_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER].instantiate()
	# Set creep health to 100 to avoid killing the creeps
	first_entered_creep.__curr_health = 100
	second_entered_creep.__curr_health = 100
	
	# Create test bullet
	var ricochet_bullet: TargetedRicochetBullet = TargetedRicochetBullet.new()
	# Set bullet damage to 0 to avoid killing the creeps
	ricochet_bullet.__damage = 0
	# Enable infinite ricochets
	ricochet_bullet.__infinite_ricochets = true
	# Set bullet speed
	ricochet_bullet.__speed = bullet_speed

	# Place bullet between the two creeps
	first_entered_creep.position = first_creep_starting_position
	second_entered_creep.position = second_creep_starting_position
	ricochet_bullet.position = Vector2(50, 0)

	# Add test objects to scene
	add_child_autofree(first_entered_creep)
	add_child_autofree(second_entered_creep)
	add_child_autofree(ricochet_bullet)

	# Simulate two creeps entering the bullet ricochet detection area
	ricochet_bullet.__ricochet_detection_hurtbox.__creeps_in_range = [first_entered_creep, second_entered_creep]

	# Verify initial positions of the creeps and the bullet
	assert_eq(first_entered_creep.position, first_creep_starting_position, "First entered creep starting position should be at position (0, 0)")
	assert_eq(second_entered_creep.position, second_creep_starting_position, "Second entered creep starting position should be at position (100, 0)")
	assert_eq(ricochet_bullet.position, Vector2(50, 0), "Ricochet bullet starting should be at position (50, 0)")

	# Set bullet target to the first creep
	ricochet_bullet.set_target(first_entered_creep)

	# Verify starting isometric speed and normalized verlocity of the bullet
	assert_almost_eq(ricochet_bullet.__isometric_speed, float(bullet_speed), 0.01, "Ricochet bullet isometric speed should be 5")
	assert_almost_eq(ricochet_bullet.__velocity.x, -1.0, 0.01, "Ricochet bullet normalized velocity x should be -1")
	assert_almost_eq(ricochet_bullet.__velocity.y, 0.0, 0.01, "Ricochet bullet normalized velocity y should be 0")

	# Simlilate bullet's ricochet movement being triggered
	ricochet_bullet._handle_ricochet(first_entered_creep)

	# Assert that the bullet is now targeting the second creep
	assert_almost_eq(ricochet_bullet.__isometric_speed, float(bullet_speed), 0.01, "Ricochet bullet isometric speed should be 5")
	assert_almost_eq(ricochet_bullet.__velocity.x, 1.0, 0.01, "Ricochet bullet normalized velocity x should be 1")
	assert_almost_eq(ricochet_bullet.__velocity.y, 0.0, 0.01, "Ricochet bullet normalized velocity y should be 0")

	# Clean up
	first_entered_creep.queue_free()
	second_entered_creep.queue_free()
	ricochet_bullet.queue_free()


## The only scenation where the bullet's ricochet logic is triggered is when it inflicts damage on a creep.
## Therefore, testing the implementation of TargetedRicochetBullet._handle_ricochet() is sufficient to verify
## by testing the TargetedRicochetBullet._inflict_damage() method.
func test_ricochet_between_two_targets_with_damage_infliction():

	# Test vars
	var bullet_speed: int = 5
	var bullet_starting_position: Vector2 = Vector2(50, 0)
	var first_creep_starting_position: Vector2 = Vector2.ZERO
	var second_creep_starting_position: Vector2 = Vector2(100, 0)
	
	# Create test creeps
	var first_entered_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER].instantiate()
	var second_entered_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER].instantiate()
	# Set creep health to 100 to avoid killing the creeps
	first_entered_creep.__curr_health = 100
	second_entered_creep.__curr_health = 100
	
	# Create test bullet
	var ricochet_bullet: TargetedRicochetBullet = TargetedRicochetBullet.new()
	# Set bullet damage to 0 to avoid killing the creeps
	ricochet_bullet.__damage = 0
	# Enable infinite ricochets
	ricochet_bullet.__infinite_ricochets = true
	# Set bullet speed
	ricochet_bullet.__speed = bullet_speed

	# Place bullet between the two creeps
	first_entered_creep.position = first_creep_starting_position
	second_entered_creep.position = second_creep_starting_position
	ricochet_bullet.position = Vector2(50, 0)

	# Add test objects to scene
	add_child_autofree(first_entered_creep)
	add_child_autofree(second_entered_creep)
	add_child_autofree(ricochet_bullet)

	# Simulate two creeps entering the bullet ricochet detection area
	ricochet_bullet.__ricochet_detection_hurtbox.__creeps_in_range = [first_entered_creep, second_entered_creep]

	# Verify initial positions of the creeps and the bullet
	assert_eq(first_entered_creep.position, first_creep_starting_position, "First entered creep starting position should be at position (0, 0)")
	assert_eq(second_entered_creep.position, second_creep_starting_position, "Second entered creep starting position should be at position (100, 0)")
	assert_eq(ricochet_bullet.position, bullet_starting_position, "Ricochet bullet starting should be at position (50, 0)")

	# Set bullet target to the first creep
	ricochet_bullet.set_target(first_entered_creep)

	# Verify starting isometric speed and normalized verlocity of the bullet
	assert_almost_eq(ricochet_bullet.__isometric_speed, float(bullet_speed), 0.01, "Ricochet bullet isometric speed should be 5")
	assert_almost_eq(ricochet_bullet.__velocity.x, -1.0, 0.01, "Ricochet bullet normalized velocity x should be -1")
	assert_almost_eq(ricochet_bullet.__velocity.y, 0.0, 0.01, "Ricochet bullet normalized velocity y should be 0")

	# Verify that there is no last damaged creep
	assert_null(ricochet_bullet.__last_damaged_creep, "Ricochet bullet last damaged creep should be null")

	# Simlilate bullet's ricochet from the first creep to the second creep
	ricochet_bullet._inflict_damange(first_entered_creep)

	# Assert that the bullet is now targeting the second creep
	assert_almost_eq(ricochet_bullet.__isometric_speed, float(bullet_speed), 0.01, "Ricochet bullet isometric speed should be 5")
	assert_almost_eq(ricochet_bullet.__velocity.x, 1.0, 0.01, "Ricochet bullet normalized velocity x should be 1")
	assert_almost_eq(ricochet_bullet.__velocity.y, 0.0, 0.01, "Ricochet bullet normalized velocity y should be 0")

	# Assert that the last damaged creep is the first entered creep
	assert_eq(ricochet_bullet.__last_damaged_creep, first_entered_creep, "Ricochet bullet last damaged creep should be the first entered creep")

	# Simlilate bullet's ricochet from the second creep to the first creep
	ricochet_bullet._inflict_damange(second_entered_creep)

	# Assert that the bullet is now targeting the first creep again
	assert_almost_eq(ricochet_bullet.__isometric_speed, float(bullet_speed), 0.01, "Ricochet bullet isometric speed should be 5")
	assert_almost_eq(ricochet_bullet.__velocity.x, -1.0, 0.01, "Ricochet bullet normalized velocity x should be -1")
	assert_almost_eq(ricochet_bullet.__velocity.y, 0.0, 0.01, "Ricochet bullet normalized velocity y should be 0")

	# Assert that the last damaged creep is the first entered creep
	assert_eq(ricochet_bullet.__last_damaged_creep, second_entered_creep, "Ricochet bullet last damaged creep should be the first entered creep")

	# Clean up
	first_entered_creep.queue_free()
	second_entered_creep.queue_free()
	ricochet_bullet.queue_free()
