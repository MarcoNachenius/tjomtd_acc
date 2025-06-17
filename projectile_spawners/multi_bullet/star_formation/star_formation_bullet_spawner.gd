extends ProjectileSpawner
class_name StarFormationBulletSpawner

@export var __bullet_damage: int
@export var __bullet_speed: int
@export var __bullets_per_launch: int = 3
@export var BULLET_ID: ProjectileConstants.BulletsForSpawner
@export var __formation_policy: FormationPolicy = FormationPolicy.TARGETED

# LOCALS
var __bullet_load
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
			var new_bullet = __bullet_load.instantiate()
			new_bullet.set_speed(__bullet_speed)
			new_bullet.set_damage(__bullet_damage)
			add_child(new_bullet)
			new_bullet.update_movement_towards_angle(adjusted_launch_angle)
		
	if __formation_policy == FormationPolicy.RANDOM:
		# Calculate angle to targeted creep
		var angle_to_target: float = randf_range(0.0, TAU/__bullets_per_launch)
		# Create launch angles
		for i in range(__launch_angles.size()):
			var adjusted_launch_angle: float = __launch_angles[i] + angle_to_target
			# Ensure angle between target is between 0 and 2PI
			if adjusted_launch_angle >= TAU:
				adjusted_launch_angle -= TAU
			# Launch bullets
			var new_bullet = __bullet_load.instantiate()
			new_bullet.set_speed(__bullet_speed)
			new_bullet.set_damage(__bullet_damage)
			add_child(new_bullet)
			new_bullet.update_movement_towards_angle(adjusted_launch_angle)
	
	if __formation_policy == FormationPolicy.STATIC:
		# Create launch angles
		for i in range(__launch_angles.size()):
			var adjusted_launch_angle: float = __launch_angles[i] + __static_launch_angle
			# Ensure angle between target is between 0 and 2PI
			if adjusted_launch_angle >= TAU:
				adjusted_launch_angle -= TAU
			# Launch bullets
			var new_bullet = __bullet_load.instantiate()
			new_bullet.set_speed(__bullet_speed)
			new_bullet.set_damage(__bullet_damage)
			add_child(new_bullet)
			new_bullet.update_movement_towards_angle(adjusted_launch_angle)


# ===========================
# EXTENDED BASE CLASS METHODS
# ===========================

func _execute_extended_onready_commands():
	# Create instance of bullet
	__bullet_load = load(ProjectileConstants.BULLET_PATHS[BULLET_ID])
	
	# Create a new array which holds the angle of launch for each bullet
	var angle_increment: float = (TAU) / __bullets_per_launch
	for i in range(__bullets_per_launch):
		__launch_angles.append(angle_increment * i)
	# Create static angle if formation policy is set to static
	if __formation_policy == FormationPolicy.STATIC:
		__static_launch_angle = randf_range(0.0, TAU/__bullets_per_launch)

func get_damage() -> int:
	return __bullet_damage