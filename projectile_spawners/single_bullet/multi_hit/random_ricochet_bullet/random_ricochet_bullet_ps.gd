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
## If true, an aoe hurtbox will be created on ready 
## which allows for area of effect damage infliction
@export var __aoe_enabled: bool
## The radius of aoe damage infliction for projectile.
@export var __aoe_detection_radius: int
## The amount of damage that gets inflicted when triggered
@export var __aoe_damage_amount: int
## If true, an aoe show hurtbox will be created on ready 
## which allows for area of effect slow infliction
@export var __aoe_slow_enabled: bool
## The radius of aoe slow infliction for projectile.
@export var __aoe_slow_detection_radius: int
## The percentage a creep's speed will be reduced when triggered
@export var __aoe_slow_percentage: int
## The duration in seconds for which a creep will be slowed down
@export var __aoe_slow_duration: float


func _launch_projectiles():
	# Create bullet
	var new_bullet: RandomRicochetBullet = ProjectileConstants.RANDOM_RICOCHET_BULLET_LOADS[BULLET_PRELOAD].instantiate()

	# Parameters that require 
	# Area‑of‑effect parameters
	new_bullet.set_aoe_enabled(__aoe_enabled)
	new_bullet.set_aoe_detection_radius(__aoe_detection_radius)
	new_bullet.set_aoe_damage_amount(__aoe_damage_amount)

	# Area‑of‑effect slow parameters
	new_bullet.set_aoe_slow_enabled(__aoe_slow_enabled)
	new_bullet.set_aoe_slow_detection_radius(__aoe_slow_detection_radius)
	new_bullet.set_aoe_slow_percentage(__aoe_slow_percentage)
	new_bullet.set_aoe_slow_duration(__aoe_slow_duration)

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

func get_damage() -> int:
	return __bullet_damage