extends ProjectileSpawner
class_name StarSingleHitMissileSpawner

@export var __missile_damage: int
@export var __missile_speed: int
@export var __missiles_per_launch: int = 3
@export var MISSILE_ID: ProjectileConstants.SingleHitMissiles
@export var __formation_policy: FormationPolicy = FormationPolicy.TARGETED

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
			# Launch bullets
			var new_missile: SingleHitMissile = ProjectileConstants.SINGLE_HIT_MISSILE_LOADS[MISSILE_ID].instantiate()
			new_missile.set_speed(__missile_speed)
			new_missile.set_damage(__missile_damage)
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
			# Launch bullets
			var new_missile: SingleHitMissile = ProjectileConstants.SINGLE_HIT_MISSILE_LOADS[MISSILE_ID].instantiate()
			new_missile.set_speed(__missile_speed)
			new_missile.set_damage(__missile_damage)
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
			# Launch bullets
			var new_missile: SingleHitMissile = ProjectileConstants.SINGLE_HIT_MISSILE_LOADS[MISSILE_ID].instantiate()
			new_missile.set_speed(__missile_speed)
			new_missile.set_damage(__missile_damage)
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
