extends ProjectileSpawner
class_name RandomRicochetMissileSpawner

@export var MISSILE_PRELOAD: ProjectileConstants.RandomRicochetMissiles
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
## If true, an aoe hurtbox will be created on ready 
## which allows for area of effect damage infliction
@export var __aoe_enabled: bool
## The radius of aoe damage infliction for projectile.
@export var __aoe_detection_radius: int
## The amount of damage that gets inflicted when triggered
@export var __aoe_damage_amount: int
## If true, damage will decrease after every hit
@export var __damage_degredation_enabled: bool = false
## Rate at which missile loses damage after hitting a creep.
@export var __damage_degredation_rate: int
@export var __infinite_ricochets: bool = false
@export var __total_ricochets: int = 2

func _launch_projectiles():
    # Create bullet
    var new_missile: RandomRicochetMissile = ProjectileConstants.RANDOM_RICOCHET_MISSILE_LOADS[MISSILE_PRELOAD].instantiate()
    add_child(new_missile)

    # ──────── Setters ────────
    # Target
    assert(__target, "No target provided")
    new_missile.set_target(__target)

    # Velocity / speed
    new_missile.update_velocity_towards_target()
    new_missile.set_speed(__missile_speed)
    new_missile.update_isometric_speed()

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

    # Damage degredation parameters
    new_missile.set_damage_degredation_enabled(__damage_degredation_enabled)
    new_missile.set_damage_degredation_rate(__damage_degredation_rate)

    # Ricochet parameters
    new_missile.set_infinite_ricochets(__infinite_ricochets)
    new_missile.set_total_ricochets(__total_ricochets)
