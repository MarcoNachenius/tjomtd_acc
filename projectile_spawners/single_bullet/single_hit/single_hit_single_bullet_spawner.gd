extends ProjectileSpawner
class_name SingleHitSingleBulletSpawner

@export var __bullet_damage: int
@export var __bullet_speed: int
@export var BULLET_PRELOAD: ProjectileConstants.SingleHitBullets
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
	var new_bullet: SingleHitBullet = ProjectileConstants.SINGLE_HIT_BULLET_LOADS[BULLET_PRELOAD].instantiate()
	

	# ──────── Setters ────────

	# Area‑of‑effect slow parameters
	new_bullet.set_aoe_slow_enabled(__aoe_slow_enabled)
	new_bullet.set_aoe_slow_detection_radius(__aoe_slow_detection_radius)
	new_bullet.set_aoe_slow_percentage(__aoe_slow_percentage)
	new_bullet.set_aoe_slow_duration(__aoe_slow_duration)

	# Area‑of‑effect parameters
	new_bullet.set_aoe_enabled(__aoe_enabled)
	new_bullet.set_aoe_detection_radius(__aoe_detection_radius)
	new_bullet.set_aoe_damage_amount(__aoe_damage_amount)

	# Retargeting parameters
	new_bullet.set_retargetable(__retargetable)
	new_bullet.set_retarget_radius(__retarget_radius)

	add_child(new_bullet)

	# Target
	assert(__target, "No target provided")
	new_bullet.set_target(__target)

	# Velocity / speed
	new_bullet.update_velocity_towards_target()
	new_bullet.set_speed(__bullet_speed)
	new_bullet.update_isometric_speed()

	# Base damage
	new_bullet.set_damage(__bullet_damage)

	# Stun parameters
	new_bullet.set_can_stun(__can_stun)
	new_bullet.set_stun_duration_seconds(__stun_duration_seconds)
	new_bullet.set_stun_probability_percentage(__stun_probability_percentage)

	# Slow parameters
	new_bullet.set_can_slow(__can_slow)
	new_bullet.set_slow_duration_seconds(__slow_duration_seconds)
	new_bullet.set_slow_speed_reduction_percentage(__slow_speed_reduction_percentage)

func get_damage() -> int:
	return __bullet_damage