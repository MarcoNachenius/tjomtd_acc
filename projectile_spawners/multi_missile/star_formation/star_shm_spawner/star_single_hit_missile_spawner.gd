extends ProjectileSpawner
class_name StarSingleHitMissileSpawner

@export var __missile_damage: int
@export var __missile_speed: int
@export var __missiles_per_launch: int = 3
@export var MISSILE_ID: ProjectileConstants.SingleHitMissiles
@export var __formation_policy: FormationPolicy = FormationPolicy.TARGETED

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
@export var __aoe_slow_duration: int


# LOCALS
var __launch_angles: Array[float] = []
# Only used when formation policy is set to static
var __static_launch_angle: float

enum FormationPolicy {
	TARGETED,
	RANDOM,
	STATIC,
}


func _launch_projectiles():
	assert(__target, "No target for launch has been set")
	# TARGETED formation
	if __formation_policy == FormationPolicy.TARGETED:
		# Calculate velocity
		var velocity_towards_target: Vector2 = (__target.global_position - global_position).normalized()
		# Calculate angle to targeted creep
		var angle_to_target: float = Vector2(1, 0).angle_to(velocity_towards_target)
		# Create launch angles
		for i in range(__launch_angles.size()):
			var adjusted_launch_angle: float = __launch_angles[i] + angle_to_target
			# Ensure angle between target is between 0 and 2PI
			if adjusted_launch_angle >= TAU:
				adjusted_launch_angle -= TAU
			# Instantiate missile
			var new_missile: SingleHitMissile = ProjectileConstants.SINGLE_HIT_MISSILE_LOADS[MISSILE_ID].instantiate()
			# Assign required properties
			new_missile.set_speed(__missile_speed)
			new_missile.set_damage(__missile_damage)
			# Assign stun properties
			new_missile.set_can_stun(__can_stun)
			new_missile.set_stun_probability_percentage(__stun_probability_percentage)
			new_missile.set_stun_duration_seconds(__stun_duration_seconds)
			# Assign retarget properties
			new_missile.set_retargetable(__retargetable)
			new_missile.set_retarget_radius(__retarget_radius)
			# Assign slow properties
			new_missile.set_can_slow(__can_slow)
			new_missile.set_slow_duration_seconds(__slow_duration_seconds)
			new_missile.set_slow_speed_reduction_percentage(__slow_speed_reduction_percentage)
			# Assign aoe properties
			new_missile.set_aoe_enabled(__aoe_enabled)
			new_missile.set_aoe_detection_radius(__aoe_detection_radius)
			new_missile.set_aoe_damage_amount(__aoe_damage_amount)
			# Area‑of‑effect slow parameters
			new_missile.set_aoe_slow_enabled(__aoe_slow_enabled)
			new_missile.set_aoe_slow_detection_radius(__aoe_slow_detection_radius)
			new_missile.set_aoe_slow_percentage(__aoe_slow_percentage)
			new_missile.set_aoe_slow_duration(__aoe_slow_duration)

			# Only assign target to first launched missile
			if i == 0:
				new_missile.set_target(__target)
				# No movement update required if target is set
				add_child(new_missile)
				continue
			# Manually create movement for missiles which do not have a target assigned
			add_child(new_missile)
			new_missile.update_movement_towards_angle(adjusted_launch_angle)
			new_missile.MISSILE_SPRITE.rotate(adjusted_launch_angle)
		
	if __formation_policy == FormationPolicy.RANDOM:
		# Calculate angle to targeted creep
		var angle_to_target: float = randf_range(0.0, TAU/__missiles_per_launch)
		# Create launch angles
		for i in range(__launch_angles.size()):
			var adjusted_launch_angle: float = __launch_angles[i] + angle_to_target
			# Ensure angle between target is between 0 and 2PI
			if adjusted_launch_angle >= TAU:
				adjusted_launch_angle -= TAU
			# Instantiate missile
			var new_missile: SingleHitMissile = ProjectileConstants.SINGLE_HIT_MISSILE_LOADS[MISSILE_ID].instantiate()
			# Assign required properties
			new_missile.set_speed(__missile_speed)
			new_missile.set_damage(__missile_damage)
			# Assign stun properties
			new_missile.set_can_stun(__can_stun)
			new_missile.set_stun_probability_percentage(__stun_probability_percentage)
			new_missile.set_stun_duration_seconds(__stun_duration_seconds)
			# Assign retarget properties
			new_missile.set_retargetable(__retargetable)
			new_missile.set_retarget_radius(__retarget_radius)
			# Assign slow properties
			new_missile.set_can_slow(__can_slow)
			new_missile.set_slow_duration_seconds(__slow_duration_seconds)
			new_missile.set_slow_speed_reduction_percentage(__slow_speed_reduction_percentage)
			# Assign aoe properties
			new_missile.set_aoe_enabled(__aoe_enabled)
			new_missile.set_aoe_detection_radius(__aoe_detection_radius)
			new_missile.set_aoe_damage_amount(__aoe_damage_amount)

			add_child(new_missile)
			new_missile.update_movement_towards_angle(adjusted_launch_angle)
			new_missile.MISSILE_SPRITE.rotate(adjusted_launch_angle)

	if __formation_policy == FormationPolicy.STATIC:
		# Create launch angles
		for i in range(__launch_angles.size()):
			var adjusted_launch_angle: float = __launch_angles[i] + __static_launch_angle
			# Ensure angle between target is between 0 and 2PI
			if adjusted_launch_angle >= TAU:
				adjusted_launch_angle -= TAU
			# Instantiate missile
			var new_missile: SingleHitMissile = ProjectileConstants.SINGLE_HIT_MISSILE_LOADS[MISSILE_ID].instantiate()
			# Assign required properties
			new_missile.set_speed(__missile_speed)
			new_missile.set_damage(__missile_damage)
			# Assign stun properties
			new_missile.set_can_stun(__can_stun)
			new_missile.set_stun_probability_percentage(__stun_probability_percentage)
			new_missile.set_stun_duration_seconds(__stun_duration_seconds)
			# Assign retarget properties
			new_missile.set_retargetable(__retargetable)
			new_missile.set_retarget_radius(__retarget_radius)
			# Assign slow properties
			new_missile.set_can_slow(__can_slow)
			new_missile.set_slow_duration_seconds(__slow_duration_seconds)
			new_missile.set_slow_speed_reduction_percentage(__slow_speed_reduction_percentage)
			# Assign aoe properties
			new_missile.set_aoe_enabled(__aoe_enabled)
			new_missile.set_aoe_detection_radius(__aoe_detection_radius)
			new_missile.set_aoe_damage_amount(__aoe_damage_amount)

			add_child(new_missile)
			new_missile.update_movement_towards_angle(adjusted_launch_angle)
			new_missile.MISSILE_SPRITE.rotate(adjusted_launch_angle)



# ===========================
# EXTENDED BASE CLASS METHODS
# ===========================

func _execute_extended_onready_commands():
	# Create a new array which holds the angle of launch for each missile
	var angle_increment: float = (TAU) / __missiles_per_launch
	for i in range(__missiles_per_launch):
		__launch_angles.append(angle_increment * i)
	# Create static angle if formation policy is set to static
	if __formation_policy == FormationPolicy.STATIC:
		__static_launch_angle = randf_range(0.0, TAU/__missiles_per_launch)

func get_damage() -> int:
	return __missile_damage