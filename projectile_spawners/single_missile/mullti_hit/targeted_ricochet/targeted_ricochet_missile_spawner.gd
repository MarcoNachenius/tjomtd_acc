extends ProjectileSpawner
class_name TargetedRicochetMissileSpawner

@export var __missile_damage: int
@export var __missile_speed: int
@export var MISSILE_LOAD: ProjectileConstants.TargetedRicochetMissiles

func _launch_projectiles():
	# Create missile
	var new_missile: TargetedRicochetMissile = ProjectileConstants.TARGETED_RICOCHET_MISSILE_LOADS[MISSILE_LOAD].instantiate()
	add_child(new_missile)
	# set Target
	assert(__target, "No target provided")
    # Set Target
	new_missile.set_target(__target)
	# set Damage
	new_missile.set_damage(__missile_damage)
	# set Speed
	new_missile.set_speed(__missile_speed)