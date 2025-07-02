extends ProjectileSpawner
class_name TargetedRicochetMissileSpawner

@export var __missile_damage: int
@export var __missile_speed: int
@export var MISSILE_LOAD: ProjectileConstants.TargetedRicochetMissiles
## If set to true, the missile will lose damage every time it hits a creep.
@export var __damage_degredation_enabled: bool = false
## The rate at which the missile loses damage after hitting a creep.
@export var __damage_degredation_rate: int
@export var __infinite_ricochets: bool = false
@export var __ricochet_detection_radius: int = 100
@export var __total_ricochets: int = 3
@export var __can_stun: bool = false
## Duration of the stun in seconds.
@export var __stun_duration_seconds: float = 0.0
## Percentage chance(0-100) of stunning the creep.
@export var __stun_probability_percentage: int = 0
## If true, projectile will be able to slow creep
@export var __can_slow: bool
## Duration of slow effect in seconds
@export var __slow_duration_seconds: float = 0.0
## Percentage of speed reduction for creep when inflicted
@export var __slow_speed_reduction_percentage: int
@export var __aoe_enabled: bool
## The radius of aoe damage infliction for projectile.
@export var __aoe_detection_radius: int
## The amount of damage that gets inflicted when triggered
@export var __aoe_damage_amount: int

func _launch_projectiles():
	# Play sound effect
	play_launch_projectile_sound_effect()
	
	# Create missile
	var new_missile: TargetedRicochetMissile = ProjectileConstants.TARGETED_RICOCHET_MISSILE_LOADS[MISSILE_LOAD].instantiate()
	add_child(new_missile)
	# Target
	assert(__target, "No target provided")
	new_missile.set_target(__target)

	# Velocity / speed
	new_missile.update_velocity_towards_target()
	new_missile.set_speed(__missile_speed)
	new_missile.update_isometric_speed()

	# Base damage
	new_missile.set_damage(__missile_damage)
	# set Damage Degradation
	new_missile.set_damage_degredation_enabled(__damage_degredation_enabled)
	# set Damage Degradation Rate
	new_missile.set_damage_degredation_rate(__damage_degredation_rate)
	# set Infinite Ricochets
	new_missile.set_infinite_ricochets(__infinite_ricochets)
	# set Ricochet Detection Radius
	new_missile.set_ricochet_detection_radius(__ricochet_detection_radius)
	# set Total Ricochets
	new_missile.set_total_ricochets(__total_ricochets)
	# Stun parameters
	new_missile.set_can_stun(__can_stun)
	new_missile.set_stun_duration_seconds(__stun_duration_seconds)
	new_missile.set_stun_probability_percentage(__stun_probability_percentage)

	# Slow parameters
	new_missile.set_can_slow(__can_slow)
	new_missile.set_slow_duration_seconds(__slow_duration_seconds)
	new_missile.set_slow_speed_reduction_percentage(__slow_speed_reduction_percentage)


	# Area‑of‑effect parameters
	new_missile.set_aoe_enabled(__aoe_enabled)
	new_missile.set_aoe_detection_radius(__aoe_detection_radius)
	new_missile.set_aoe_damage_amount(__aoe_damage_amount)


func get_damage() -> int:
	return __missile_damage