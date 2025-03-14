extends GutTest

func test_projectile_stun_hurtbox_creation():
	# Instantiate random projectile which does not have stun capabilities
	var t_bullet = ProjectileConstants.SINGLE_HIT_BULLET_LOADS[ProjectileConstants.SingleHitBullets.BLACK_MARBLE_LVL_1].instantiate()
	add_child_autofree(t_bullet)
	

	# ASSERT STATE BEFORE TEST
	# ------------------------


	# Create situation where stun hurtbox should be created
	t_bullet.__can_stun = true
	# Create stun hurtbox
	t_bullet._create_stun_hurtbox()
	

	# ASSERT STATE AFTER TEST
	# -----------------------
	# Check that test bullet has a ProjectileStunHurtbox as child node
	var projectile_stun_hurtbox_found: bool = false
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