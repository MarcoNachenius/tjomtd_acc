extends ProjectileSpawner
class_name SingleMissileSpawner

@export var MISSILE_PRELOAD: ProjectileConstants.SingleHitMissiles
@export var __missile_damage: int
@export var __missile_speed: int

func _launch_projectiles():
	# Create bullet
	var new_missile: SingleHitMissile = ProjectileConstants.SINGLE_HIT_MISSILE_LOADS[MISSILE_PRELOAD].instantiate()
	assert(new_missile != null, "Failed to instantiate missile")
	add_child(new_missile)
	# set Target
	assert(__target, "No target provided")
	new_missile.set_target(__target)
	# set Damage
	new_missile.set_damage(__missile_damage)
	# set Speed
	new_missile.set_speed(__missile_speed)
