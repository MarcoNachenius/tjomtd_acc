extends Node2D
class_name Projectile

# EXPORT VARS
@export var __hurtbox_radius: int = 5
## If set to true, a stun hurtbox will be created on ready.
## The stun hurbox's radius will be the equal to the projectile's hurtbox radius.
@export var __can_stun: bool = false
## Duration of the stun in seconds.
@export var __stun_duration_seconds: float = 0.0
## Percentage chance(0-100) of stunning the creep.
@export var __stun_probability_percentage: int = 0
## If enabled, the projectile will assign a target to the projectile's hurtbox when it enters the area,
## and the projectile does not have a target assigned.
@export var __retargetable: bool = false
## The radius of the retargetable area.
@export var __retarget_radius: int


# PRIVATE VARS
var __isometric_speed: float
var __speed: int
var __target: Creep
var __velocity: Vector2
var __hurtbox: ProjectileHurtbox
var __retarget_hurtbox: RetargetHurtbox

# ********
# BUILTINS
# ********
func _ready():
	_create_hurtbox()
	# Only creates stun hurtbox if self.__can_stun export is set to true
	_create_stun_hurtbox()
	# Only creates retarget hurtbox if self.__retargetable export is set to true
	_create_retarget_hurtbox()
	_extended_onready()

# *******
# PUBLICS
# *******
func get_velocity() -> Vector2:
	return __velocity

## Updates the velocity and isometric speed of the projectile towards the target.
func set_target(target: Creep):
	assert(target, "No target provided")
	__target = target
	update_velocity_towards_target()
	update_isometric_speed()

func set_speed(amount: int):
	__speed = amount

func update_isometric_speed():
	assert(__target, "Cannot calculate isometric speed. No target provided")
	__isometric_speed = _calculated_isometric_speed()

## Updates the projectile's velocity and isometric speed towards the provided angle in radians.
func update_movement_towards_angle(AngleInRadians: float):
	var launch_angle: float = AngleInRadians
	if AngleInRadians >= 2 * PI:
		launch_angle -= 2 * PI
	# Update velocity
	__velocity = Vector2(1, 0).rotated(launch_angle)
	# Update isometric speed
	__isometric_speed = (0.5 * abs(cos(launch_angle)) + 0.5) * __speed

## Updates the projectile's velocity and isometric speed towards the target.
func update_movement_towards_assigned_target():
	# This order of method calls is important because the projectile's isometric speed
	# is calculated based on the projectile's velocity.
	update_velocity_towards_target()
	update_isometric_speed()

## Updates the projectile's velocity and isometric speed towards the target position.
## Note: TargetPosition does not refer to the global position of the target,
## use update_movement_towards_target_position() for that.
func update_movement_towards_target_position(TargetPosition: Vector2):
	# Update velocity
	__velocity = (TargetPosition - position).normalized()
	# Update isometric speed
	var direction_angle = position.angle_to_point(TargetPosition)
	__isometric_speed = (0.5 * abs(cos(direction_angle)) + 0.5) * __speed

## Updates the projectile's velocity and isometric speed towards the target global position.
func update_movement_towards_target_global_position(TargetGlobalPosition: Vector2):
	# Update velocity
	__velocity = (TargetGlobalPosition - global_position).normalized()
	# Update isometric speed
	var direction_angle = global_position.angle_to_point(TargetGlobalPosition)
	__isometric_speed = (0.5 * abs(cos(direction_angle)) + 0.5) * __speed

## Updates non-isometric velocity towards creep
func update_velocity_towards_target():
	assert(__target, "No current target asigned")
	var new_velocity = (__target.global_position - global_position).normalized()
	__velocity = new_velocity

# ********
# PRIVATES
# ********
func _calculated_isometric_speed() -> float:
	var direction_angle = global_position.angle_to_point(__target.global_position)
	return (0.5 * abs(cos(direction_angle)) + 0.5) * __speed

func _create_hurtbox():
	var new_hurtbox: ProjectileHurtbox = ProjectileConstants.HURTBOX_PRELOAD.instantiate()
	add_child(new_hurtbox)
	new_hurtbox.set_base_radius(__hurtbox_radius)
	__hurtbox = new_hurtbox
	__hurtbox.area_entered.connect(_on_hurtbox_entered)

## Creates the retarget hurtbox if the __retargetable export is set to true.
func _create_retarget_hurtbox():
	# Only create retarget hurtbox if self.__retargetable export is set to true
	if !__retargetable:
		return
	
	# Check if the retargetable radius is valid
	assert(__retarget_radius > 0, "Retargetable radius must be greater than 0")

	# Instantiate retarget hurtbox
	var new_retarget_hurtbox: RetargetHurtbox = ProjectileConstants.RETARGET_HURTBOX_PRELOAD.instantiate()
	add_child(new_retarget_hurtbox)
	new_retarget_hurtbox.set_base_radius(__retarget_radius)
	# Set retarget hurtbox
	__retarget_hurtbox = new_retarget_hurtbox
	# Connect retarget hurtbox area entered signal
	__retarget_hurtbox.area_entered.connect(_on_retarget_hurtbox_entered)

## Creates the stun hurtbox if the __can_stun export is set to true.
## The stun hurtbox's radius will be equal to the projectile's hurtbox radius.
func _create_stun_hurtbox():
	# Only creates stun hurtbox if self.__can_stun export is set to true
	if !__can_stun:
		return
	
	# Instatiate stun hurtbox
	var new_stun_hurtbox: ProjectileStunHurtbox = ProjectileConstants.STUN_HURTBOX_PRELOAD.instantiate()
	add_child(new_stun_hurtbox)
	new_stun_hurtbox.set_stun_duration_seconds(__stun_duration_seconds)
	new_stun_hurtbox.set_stun_probability_percentage(__stun_probability_percentage)
	# Set stun hurtbox radius equal to hurtbox radius
	new_stun_hurtbox.set_base_radius(__hurtbox_radius)

## Abstract method. Handles commands that follow the creation of the projectile's hitbox on ready.
func _extended_onready():
	pass

# *******
# SIGNALS
# *******

func _on_hurtbox_entered(area):
	pass


func _on_retarget_hurtbox_entered(area):
	# Ignore retargeting if current target is assigned, not being queued free and still detectable
	if __target and is_instance_valid(__target) and __target.is_detectable():
		return
	
	# Check if the area is a creep
	if !area.get_parent() is Creep:
		# If the area is not a creep, the dev should be notified because this is a bug.
		# Only the retarget hurtbox should be able to detect creeps.
		printerr("Retarget hurtbox entered area is not a creep")
		return
	
	# Extract the creep from the area
	var entered_creep: Creep = area.get_parent()
	# Reassign target if it is detectable
	if entered_creep.is_detectable():
		__target = entered_creep
		# This allows for bullets to retarget creeps.
		update_movement_towards_assigned_target()

# *******
# SETTERS
# *******

## Sets whether this projectile can stun on hit.
## If enabled, a stun hurtbox will be created on ready using the projectile's hurtbox radius.
func set_can_stun(enable_stun: bool) -> void:
	__can_stun = enable_stun

## Sets the duration of the stun effect in seconds.
## This value is only used if stun is enabled.
func set_stun_duration_seconds(duration_seconds: float) -> void:
	__stun_duration_seconds = duration_seconds

## Sets the percentage chance (0–100) that the projectile will stun a creep.
## Values are clamped between 0 and 100.
func set_stun_probability_percentage(stun_chance_percent: int) -> void:
	__stun_probability_percentage = clamp(stun_chance_percent, 0, 100)

## Sets whether the projectile can retarget if it has no current target
## and enters an area with available targets.
func set_retargetable(enable_retargeting: bool) -> void:
	__retargetable = enable_retargeting

## Sets the radius of the retargeting area in pixels.
## Cannot be negative.
func set_retarget_radius(retarget_area_radius: int) -> void:
	__retarget_radius = max(retarget_area_radius, 0)
