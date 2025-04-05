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

	# TARGETED formation
	if __formation_policy == FormationPolicy.TARGETED:
		# Retreive targeted angle
		var angle_to_target: float = _angle_to_targeted_creep()
		# Create launch angles
		var adjusted_launch_angles: Array[float] = __launch_angles
		for i in range(adjusted_launch_angles.size()):
			adjusted_launch_angles[i] += angle_to_target
			# Ensure angle between target is between 0 and 2PI
			if adjusted_launch_angles[i] >= 2 * PI:
				adjusted_launch_angles[i] -= 2 * PI
		# Launch bullets
		var bullet_load = load(ProjectileConstants.BULLET_PATHS[ProjectileConstants.BulletsForSpawner.BLACK_MARBLE_LVL_1])
		for angle in adjusted_launch_angles:
			var new_bullet = bullet_load.instantiate()
			new_bullet.set_speed(__bullet_speed)
			new_bullet.set_damage(__bullet_damage)
			add_child(new_bullet)
			new_bullet.update_movement_towards_angle(angle)
			


# ===========================
# EXTENDED BASE CLASS METHODS
# ===========================

func _execute_extended_onready_commands():
	# Create a new array which holds the angle of launch for each bullet
	var angle_increment: float = (2*PI) / __bullets_per_launch
	for i in range(__bullets_per_launch):
		__launch_angles.append(angle_increment * i)
