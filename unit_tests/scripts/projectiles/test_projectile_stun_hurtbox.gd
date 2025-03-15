extends GutTest

func test_projectile_stun_hurtbox_creation():
	# Instantiate random projectile which does not have stun capabilities
	var t_bullet = ProjectileConstants.SINGLE_HIT_BULLET_LOADS[ProjectileConstants.SingleHitBullets.BLACK_MARBLE_LVL_1].instantiate()
	add_child_autofree(t_bullet)
	
	# ASSERT STATE BEFORE TEST
	# ------------------------
	# Check that test bullet has a ProjectileStunHurtbox as child node
	var projectile_stun_hurtbox_found: bool = false
	# Scan children for ProjectileStunHurtbox object
	for child in t_bullet.get_children():
		if child is ProjectileStunHurtbox:
			projectile_stun_hurtbox_found = true
			break
	# Check if ProjectileStunHurtbox object was found
	assert_false(projectile_stun_hurtbox_found)

	# PERFORM TEST
	# ------------
	# Create situation where stun hurtbox should be created
	t_bullet.__can_stun = true
	# Create stun hurtbox
	t_bullet._create_stun_hurtbox()

	# ASSERT STATE AFTER TEST
	# -----------------------
	# Check that test bullet has a ProjectileStunHurtbox as child node
	projectile_stun_hurtbox_found = false
	var found_projectile_stun_hurtbox: ProjectileStunHurtbox
	# Scan children for ProjectileStunHurtbox object
	for child in t_bullet.get_children():
		if child is ProjectileStunHurtbox:
			projectile_stun_hurtbox_found = true
			found_projectile_stun_hurtbox = child
			break
	# Check if ProjectileStunHurtbox object was found
	assert_true(projectile_stun_hurtbox_found)

	# Check that ProjectileStunHurtbox has created a collision shape
	var projectile_stun_hurtbox_coll_shape_found: bool = false
	# Scan children for CollisionShape2D object
	for child in found_projectile_stun_hurtbox.get_children():
		if child is CollisionShape2D:
			projectile_stun_hurtbox_coll_shape_found = true
			break
	# Check if found projectile hurtbox has a collision shape
	assert_true(projectile_stun_hurtbox_coll_shape_found)

	# Clean up
	t_bullet.queue_free()
	t_bullet = null

func test_stun_creep_success_through_signal():
	# CREATE TEST PROJECTILE
	# Instantiate random projectile which does not have stun capabilities
	var test_bullet: SingleHitBullet = ProjectileConstants.SINGLE_HIT_BULLET_LOADS[ProjectileConstants.SingleHitBullets.BLACK_MARBLE_LVL_1].instantiate()
	add_child_autofree(test_bullet)
	# Create situation where stun hurtbox should be created
	test_bullet.__can_stun = true
	# Ensure stun is guaranteed to occur by setting stun probability to 100%
	test_bullet.__stun_probability_percentage = 100
	# Set long stun duration so that stun creep through signal can be tested
	test_bullet.__stun_duration_seconds = 10
	# Create stun hurtbox
	test_bullet._create_stun_hurtbox()

	# CREATE TEST CREEP
	var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	add_child_autofree(test_creep)

	# CONFIRM INITIAL STATE
	# Ensure initial state is correct before testing signal emission
	assert_eq(test_creep.__curr_state, Creep.States.MOVING)
	assert_true(test_creep.is_detectable())
	# Reteive stun hurtbox
	var test_projectile_stun_hurtbox: ProjectileStunHurtbox
	# Scan children for ProjectileStunHurtbox object
	for child in test_bullet.get_children():
		if child is ProjectileStunHurtbox:
			test_projectile_stun_hurtbox = child
			break
	# Check if ProjectileStunHurtbox object was found
	assert_not_null(test_projectile_stun_hurtbox)
	
	
	# PERFORM TEST
	test_projectile_stun_hurtbox._on_area_entered(test_creep.__hitbox)

	# EVALUATE RESULTS
	# Ensure creep has been stunned
	assert_eq(test_creep.__curr_state, test_creep.States.IDLE)

	# Clean up
	test_bullet.queue_free()
	test_creep.queue_free()


func test_stun_creep_failure_through_signal():
	# CREATE TEST PROJECTILE
	# Instantiate random projectile which does not have stun capabilities
	var test_bullet: SingleHitBullet = ProjectileConstants.SINGLE_HIT_BULLET_LOADS[ProjectileConstants.SingleHitBullets.BLACK_MARBLE_LVL_1].instantiate()
	add_child_autofree(test_bullet)
	# Create situation where stun hurtbox should be created
	test_bullet.__can_stun = true
	# Ensure stun is guaranteed not to occur by setting stun probability to 0%
	test_bullet.__stun_probability_percentage = 0
	# Set long stun duration so that stun creep through signal can be tested
	test_bullet.__stun_duration_seconds = 10
	# Create stun hurtbox
	test_bullet._create_stun_hurtbox()

	# CREATE TEST CREEP
	var test_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
	add_child_autofree(test_creep)

	# CONFIRM INITIAL STATE
	# Ensure initial state is correct before testing signal emission
	assert_eq(test_creep.__curr_state, Creep.States.MOVING)
	assert_true(test_creep.is_detectable())
	# Reteive stun hurtbox
	var test_projectile_stun_hurtbox: ProjectileStunHurtbox
	# Scan children for ProjectileStunHurtbox object
	for child in test_bullet.get_children():
		if child is ProjectileStunHurtbox:
			test_projectile_stun_hurtbox = child
			break
	# Check if ProjectileStunHurtbox object was found
	assert_not_null(test_projectile_stun_hurtbox)
	
	
	# PERFORM TEST
	test_projectile_stun_hurtbox._on_area_entered(test_creep.__hitbox)

	# EVALUATE RESULTS
	# Ensure creep has not been stunned
	assert_eq(test_creep.__curr_state, test_creep.States.MOVING)

	# Clean up
	test_bullet.queue_free()
	test_creep.queue_free()
