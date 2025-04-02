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
		# Set first bullet's target and add it to the scene
		var first_bullet = load(ProjectileConstants.BULLET_PATHS[BULLET_PRELOAD]).instantiate()
		first_bullet.set_speed(__bullet_speed)
		first_bullet.set_damage(__bullet_damage)
		# Set target after speed is set to ensure the bullet can calculate its velocity
		# and isometric speed.
		first_bullet.set_target(__target)
		add_child(first_bullet)

		# Retrieve the angle to the first bullet based on its velocity
		var first_bullet_angle: float = Vector2.ZERO.angle_to_point(first_bullet.get_velocity())
		
		for i in range(1, __launch_angles.size()):
			# Rotate the angles such that the first element is the first bullet's angle towards the target,
			# and the rest are rotated around it equally spaced.
			var bullet_launch_angle = __launch_angles[i] + first_bullet_angle
			# Launch the bullet at the calculated angle
			var new_bullet = load(ProjectileConstants.BULLET_PATHS[BULLET_PRELOAD]).instantiate()
			new_bullet.set_speed(__bullet_speed)
			new_bullet.set_damage(__bullet_damage)
			# Set angle of movement after speed is set to ensure the bullet can calculate its
			# velocity and isometric speed.
			new_bullet.update_movement_towards_angle(bullet_launch_angle)
			add_child(new_bullet)


# ===========================
# EXTENDED BASE CLASS METHODS
# ===========================

func _execute_extended_onready_commands():
	# Create a new array which holds the angle of launch for each bullet
	var angle_increment: float = (2*PI) / __bullets_per_launch
	for i in range(__bullets_per_launch):
		__launch_angles.append(i * angle_increment)
