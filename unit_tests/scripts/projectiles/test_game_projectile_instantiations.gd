extends GutTest

## Reset before each test case
func before_each():
	await get_tree().process_frame  # Ensure previous nodes are fully freed.

func test_black_marble_lvl_1_projectile_instatiation():
	# Black Marble Level 1
	var t_bullet = ProjectileConstants.SINGLE_HIT_BULLET_LOADS[ProjectileConstants.SingleHitBullets.BLACK_MARBLE_LVL_1].instantiate()
	add_child_autofree(t_bullet)
	assert_not_null(t_bullet, "Black Marble Level 1 Bullet instantiated as null from ProjectileConstants")
	assert_true(t_bullet is SingleHitBullet, "Black Marble Level 1 Bullet is not an instance of SingleHitBullet")
	t_bullet.queue_free()
	t_bullet = null

func test_black_marble_lvl_2_projectile_instatiation():
	# Black Marble Level 2
	var t_bullet = ProjectileConstants.RANDOM_RICOCHET_BULLET_LOADS[ProjectileConstants.RandomRicochetBullets.BLACK_MARBLE_LVL_2].instantiate()
	add_child_autofree(t_bullet)
	assert_not_null(t_bullet, "Black Marble Level 2 Bullet instantiated as null from ProjectileConstants")
	assert_true(t_bullet is RandomRicochetBullet, "Black Marble Level 2 Bullet is not an instance of RandomRicochetBullet")
	t_bullet.queue_free()
	t_bullet = null

func test_bismuth_lvl_1_projectile_instatiation():
	# Bismuth Level 1
	var t_missile = ProjectileConstants.SINGLE_HIT_MISSILE_LOADS[ProjectileConstants.SingleHitMissiles.BISMUTH_LVL_1].instantiate()
	add_child_autofree(t_missile)
	assert_not_null(t_missile, "Bismuth Level 1 Missile instantiated as null from ProjectileConstants")
	assert_true(t_missile is SingleHitMissile, "Bismuth Level 1 SingleHitMissile is not an instance of SingleHitMissile")
	t_missile.queue_free()
	t_missile = null
