extends ProjectileSpawner
class_name RandomRicochetBulletSpawner

@export var __bullet_damage: int
@export var __bullet_speed: int
@export var __damage_degredation_enabled: bool = false
## rate at which bullet loses damage after hitting a creep.
@export var __damage_degredation_rate: int
@export var __infinite_ricochets: bool = false
@export var __total_ricochets: int = 2
@export var BULLET_PRELOAD: ProjectileConstants.RandomRicochetBullets

func _launch_projectiles():
	# Create bullet
	var new_bullet: RandomRicochetBullet = ProjectileConstants.RANDOM_RICOCHET_BULLET_LOADS[BULLET_PRELOAD].instantiate()
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
	# set Damage Degredation
	new_bullet.set_damage_degredation_enabled(__damage_degredation_enabled)
	# set Damage Degredation Rate
	new_bullet.set_damage_degredation_rate(__damage_degredation_rate)
	# set Infinite Ricochets
	new_bullet.set_infinite_ricochets(__infinite_ricochets)
	# set Total Ricochets
	new_bullet.set_total_ricochets(__total_ricochets)
