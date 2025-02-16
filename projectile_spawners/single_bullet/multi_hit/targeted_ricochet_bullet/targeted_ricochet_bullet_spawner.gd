extends ProjectileSpawner
class_name TargetedRicochetBulletSpawner

@export var __bullet_damage: int
@export var __bullet_speed: int
@export var BULLET_PRELOAD: ProjectileConstants.TargetedRicochetBullets

func _launch_projectiles():
	# Create bullet
	var new_bullet: TargetedRicochetBullet = ProjectileConstants.TARGETED_RICOCHET_BULLET_LOADS[BULLET_PRELOAD].instantiate()
	add_child(new_bullet)
	# set Target
	assert(__target, "No target provided")
	new_bullet.set_target(__target)
	# set Velocity
	new_bullet.update_velocity_towards_target()
	# set Damage
	new_bullet.set_damage(__bullet_damage)
	# set Speed
	new_bullet.set_speed(__bullet_speed)
	# set Isometric Speed
	new_bullet.update_isometric_speed()
