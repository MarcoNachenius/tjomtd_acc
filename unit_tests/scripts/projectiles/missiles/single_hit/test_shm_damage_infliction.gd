extends GutTest

var t_missile: SingleHitMissile = null
var t_creep: Creep = null


## Test the damage infliction on detectable creeps without state assignment.
func test_damage_infliction_on_detectable_creep():
	# Instantiate creep
	t_creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER].instantiate()
	t_creep.__curr_health = 50
	t_creep.__detectable = true
	add_child_autofree(t_creep)
	# Instantiate bullet
	t_missile = ProjectileConstants.SINGLE_HIT_MISSILE_LOADS[ProjectileConstants.SingleHitMissiles.BISMUTH_LVL_1].instantiate()
	t_missile.__damage = 10
	add_child_autofree(t_missile)
	
	# Simulate the bullet hitting the creep by calling bullet's signal method
	t_missile._on_hurtbox_entered(t_creep.__hitbox)

	# Assert that the creep took damage from the bullet
	assert_true(t_creep.__curr_health == 40, "Creep did not take damage from bullet")
	# Assert that the bullet self destructed after dealing damage
	assert_true(t_missile.is_queued_for_deletion(), "Bullet did not self destruct after dealing damage")


func test_ignore_damage_infliction_on_hidden_creep():
	# Instantiate creep
	t_creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER].instantiate()
	t_creep.__curr_health = 50
	add_child_autofree(t_creep)
	t_creep.__detectable = false
	# Instantiate bullet
	t_missile = ProjectileConstants.SINGLE_HIT_MISSILE_LOADS[ProjectileConstants.SingleHitMissiles.BISMUTH_LVL_1].instantiate()
	t_missile.__damage = 10
	add_child_autofree(t_missile)
	
	# Simulate the bullet hitting the creep by calling bullet's signal method
	t_missile._on_hurtbox_entered(t_creep.__hitbox)

	# Assert that the creep did not take damage from the bullet
	assert_true(t_creep.__curr_health == 50, "Creep took damage from bullet even though it was not detectable")
	# Assert that the bullet did not self destruct.
	assert_false(t_missile.is_queued_for_deletion(), "Bullet self destructed even though it did not deal damage")


func test_ignore_damage_infliction_dead_creep():
	# Instantiate creep
	t_creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER].instantiate()
	t_creep.__curr_health = 0
	add_child_autofree(t_creep)
	# Instantiate bullet
	t_missile = ProjectileConstants.SINGLE_HIT_MISSILE_LOADS[ProjectileConstants.SingleHitMissiles.BISMUTH_LVL_1].instantiate()
	t_missile.__damage = 10
	add_child_autofree(t_missile)
	
	# Switch state to dying to prevent any further damage
	t_creep._switch_state(t_creep.States.DYING)
	# Simulate the bullet hitting the creep by calling bullet's signal method
	t_missile._on_hurtbox_entered(t_creep.__hitbox)
	
	# Assert that the creep took damage from the bullet
	assert_true(t_creep.__curr_health == 0, "Creep took damage from bullet even though it was dead")
	# Assert that the bullet self destructed after dealing damage
	assert_false(t_missile.is_queued_for_deletion(), "Bullet self destructed even though it attacked a dead creep")

## Test the damage infliction on moving creeps.
func test_damage_infliction_on_moving_creep():
	# Instantiate creep
	t_creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER].instantiate()
	t_creep.__curr_health = 50
	add_child_autofree(t_creep)
	# Instantiate bullet
	t_missile = ProjectileConstants.SINGLE_HIT_MISSILE_LOADS[ProjectileConstants.SingleHitMissiles.BISMUTH_LVL_1].instantiate()
	t_missile.__damage = 10
	add_child_autofree(t_missile)
	
	# Simulate the bullet hitting the creep by calling bullet's signal method
	t_missile._on_hurtbox_entered(t_creep.__hitbox)

	# Assert that the creep took damage from the bullet
	assert_true(t_creep.__curr_health == 40, "Creep did not take damage from bullet")
	# Assert that the bullet self destructed after dealing damage
	assert_true(t_missile.is_queued_for_deletion(), "Bullet did not self destruct after dealing damage")

