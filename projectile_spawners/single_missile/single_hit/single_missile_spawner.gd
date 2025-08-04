extends ProjectileSpawner
class_name SingleMissileSpawner

@export var MISSILE_PRELOAD: ProjectileConstants.SingleHitMissiles
@export var __missile_damage: int
@export var __missile_speed: int
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
## If enabled, the projectile will assign a target to the projectile's hurtbox when it enters the area,
## and the projectile does not have a target assigned.
@export var __retargetable: bool = false
## The radius of the retargetable area.
@export var __retarget_radius: int
## If value is larger than 0 and __retargetable is true,
## missile's retargeting ability will only be enabled after
## it has travelled the given distance. 
@export var __retarget_delay_distance: int
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
	# Play sound effect
	play_launch_projectile_sound_effect()

	# Create bullet
	var new_missile: SingleHitMissile = ProjectileConstants.SINGLE_HIT_MISSILE_LOADS[MISSILE_PRELOAD].instantiate()

	# ──────── Setters ────────

	# Base damage
	new_missile.set_damage(__missile_damage)

	# Stun parameters
	new_missile.set_can_stun(__can_stun)
	new_missile.set_stun_duration_seconds(__stun_duration_seconds)
	new_missile.set_stun_probability_percentage(__stun_probability_percentage)

	# Slow parameters
	new_missile.set_can_slow(__can_slow)
	new_missile.set_slow_duration_seconds(__slow_duration_seconds)
	new_missile.set_slow_speed_reduction_percentage(__slow_speed_reduction_percentage)

	# Retargeting parameters
	new_missile.set_retargetable(__retargetable)
	new_missile.set_retarget_radius(__retarget_radius)

	# Area‑of‑effect parameters
	new_missile.set_aoe_enabled(__aoe_enabled)
	new_missile.set_aoe_detection_radius(__aoe_detection_radius)
	new_missile.set_aoe_damage_amount(__aoe_damage_amount)

	# Area‑of‑effect slow parameters
	new_missile.set_aoe_slow_enabled(__aoe_slow_enabled)
	new_missile.set_aoe_slow_detection_radius(__aoe_slow_detection_radius)
	new_missile.set_aoe_slow_percentage(__aoe_slow_percentage)
	new_missile.set_aoe_slow_duration(__aoe_slow_duration)

	# Assign retarget delay
	if __retargetable and __retarget_delay_distance > 0:
		new_missile.delay_retargeting(__retarget_delay_distance)

	add_child(new_missile)

	# Target
	assert(__target, "No target provided")
	new_missile.set_target(__target)

	# Velocity / speed
	new_missile.update_velocity_towards_target()
	new_missile.set_speed(__missile_speed)
	new_missile.update_isometric_speed()

func get_damage() -> int:
	return __missile_damage