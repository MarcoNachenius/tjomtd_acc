extends Node2D
class_name Projectile

@export var __hurtbox_radius: int = 5

var __isometric_speed: float
var __speed: int
var __target: Creep
var __velocity: Vector2
var __hurtbox: ProjectileHurtbox

func _ready():
	_create_hurtbox()
	_extended_onready()

## Updates non-isometric velocity towards creep
func update_velocity_towards_target():
	assert(__target, "No current target asigned")
	var new_velocity = (__target.global_position - global_position).normalized()
	__velocity = new_velocity

# *******
# PUBLICS
# *******
func update_isometric_speed():
	assert(__target, "Cannot calculate isometric speed. No target provided")
	__isometric_speed = _calculated_isometric_speed()

# ********
# PRIVATES
# ********

func _calculated_isometric_speed() -> float:
	var direction_angle = global_position.angle_to_point(__target.global_position)
	return (0.5 * abs(cos(direction_angle)) + 0.5) * __speed

## Abstract method. Handles commands that follow the creation of the projectile's hitbox on ready.
func _extended_onready():
	pass

func _create_hurtbox():
	var new_hurtbox: ProjectileHurtbox = ProjectileConstants.HURTBOX_PRELOAD.instantiate()
	add_child(new_hurtbox)
	new_hurtbox.set_base_radius(__hurtbox_radius)
	__hurtbox = new_hurtbox
	__hurtbox.area_entered.connect(_on_hurtbox_entered)


## Updates the velocity and isometric speed of the projectile towards the target.
func set_target(target: Creep):
	assert(target, "No target provided")
	__target = target
	update_velocity_towards_target()
	update_isometric_speed()


func set_speed(amount: int):
	__speed = amount
# *******

# *******
# SIGNALS
# *******

func _on_hurtbox_entered(area):
	pass
