extends ProjectileSpawner
class_name StarFormationBulletSpawner

@export var __bullet_damage: int
@export var __bullet_speed: int
@export var __bullets_per_launch: int = 3
@export var BULLET_PRELOAD: ProjectileConstants.BulletsForSpawner
@export var __formation_policy: FormationPolicy = FormationPolicy.TARGETED

var __launch_angles: Array[float] = []

enum FormationPolicy {
	TARGETED,
	RANDOM,
}

func _launch_projectiles():
	assert(__target, "No target for launch has been set")
	var bullet_load = load(ProjectileConstants.BULLET_PATHS[ProjectileConstants.BulletsForSpawner.BLACK_MARBLE_LVL_1])
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
			if adjusted_launch_angle >= 2 * PI:
				adjusted_launch_angle -= 2 * PI
			# Launch bullets
			var new_bullet = bullet_load.instantiate()
			new_bullet.set_speed(__bullet_speed)
			new_bullet.set_damage(__bullet_damage)
			add_child(new_bullet)
			new_bullet.update_movement_towards_angle(adjusted_launch_angle)
			


# ===========================
# EXTENDED BASE CLASS METHODS
# ===========================

func _execute_extended_onready_commands():
	# Create a new array which holds the angle of launch for each bullet
	var angle_increment: float = (2*PI) / __bullets_per_launch
	for i in range(__bullets_per_launch):
		__launch_angles.append(angle_increment * i)
