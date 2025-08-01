extends Node2D
class_name Projectile

# CONSTANTS
# =========
const PROJECTILE_Z_INDEX: int = 4
const PROJECTILE_Z_AS_RELATIVE: bool = false


# EXPORT VARS
# ===========
@export var __hurtbox_radius: int = 5
## If set to true, a stun hurtbox will be created on ready.
## The stun hurbox's radius will be the equal to the projectile's hurtbox radius.
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
## If true, the projectile will delay retargeting for a certain distance.
@export var __delay_retargeting: bool = false
## The distance in pixels after which the projectile will retarget.
## This is only used if __delay_retargeting is set to true.
@export var __retarget_delay_distance: int = 0
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


# PRIVATE VARS
# =============
## The distance travelled by the projectile in pixels.
## This is used to determine when to retarget the projectile if __delay_retargeting is set to true.
var __distance_travelled: float = 0
var __isometric_speed: float
var __speed: int
var __target: Creep
var __velocity: Vector2
var __hurtbox: ProjectileHurtbox
var __retarget_hurtbox: RetargetHurtbox
var __aoe_damage_hurtbox: ProjectileHurtbox
var __aoe_slow_hurtbox: ProjectileHurtbox

# SIGNALS
# =======
signal creep_hit(creep: Creep)

# ********
# BUILTINS
# ********
func _ready():
	_create_hurtbox()
	# Only creates stun hurtbox if self.__can_stun export is set to true
	_create_stun_hurtbox()
	# Only creates retarget hurtbox if self.__retargetable export is set to true
	_create_retarget_hurtbox()
	# Only creates AOE hurtbox if self.__aoe_enabled export is set to true
	_create_aoe_hurtbox()
	# Only creates AOE slow hurtbox if self.__aoe_slow_enabled export is set to true
	_create_aoe_slow_hurtbox()
	# Handle additional logic during _ready() method for subclasses
	_extended_onready()
	# Ensure human errors are avoided and ordering of prijectiles remains consistent
	_handle_ordering()

# *******
# PUBLICS
# *******
## Switch off monitoring of the retarget hurtbox until the projectile
## has travelled a certain distance.
func delay_retargeting(distance: int) -> void:
	# Ensure the distance is valid and the projectile is retargetable.
	assert(distance > 0, "Retarget delay distance must be greater than 0")
	assert(__retargetable, "Cannot delay retargeting if projectile is not retargetable")
	
	# Set the distance after which the projectile will retarget
	__delay_retargeting = true
	__retarget_delay_distance = distance


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
func _handle_ordering():
	y_sort_enabled = true
	z_as_relative = PROJECTILE_Z_AS_RELATIVE
	z_index = PROJECTILE_Z_INDEX

func _calculated_isometric_speed() -> float:
	var direction_angle = global_position.angle_to_point(__target.global_position)
	return (0.5 * abs(cos(direction_angle)) + 0.5) * __speed

## Creates the AOE hurtbox if the __aoe_enabled export is set to true.
func _create_aoe_hurtbox():
	# Only creates AOE hurtbox if self.__aoe_enabled export is set to true
	if !__aoe_enabled:
		return
	
	# Check if the AOE radius is valid
	assert(__aoe_detection_radius > 0, "AOE detection radius must be greater than 0")

	# Instantiate AOE hurtbox
	var new_aoe_hurtbox: ProjectileHurtbox = ProjectileConstants.HURTBOX_PRELOAD.instantiate()
	add_child(new_aoe_hurtbox)
	new_aoe_hurtbox.set_base_radius(__aoe_detection_radius)
	# Set AOE hurtbox
	__aoe_damage_hurtbox = new_aoe_hurtbox

## Creates the AOE slow hurtbox if the __aoe_slow_enabled export is set to true.
func _create_aoe_slow_hurtbox():
	# Only creates AOE hurtbox if self.__aoe_slow_enabled export is set to true
	if !__aoe_slow_enabled:
		return
	
	# Check if the AOE radius is valid
	assert(__aoe_slow_detection_radius > 0, "AOE slow detection radius must be greater than 0")

	# Instantiate AOE hurtbox
	var new_aoe_slow_hurtbox: ProjectileHurtbox = ProjectileConstants.HURTBOX_PRELOAD.instantiate()
	add_child(new_aoe_slow_hurtbox)
	new_aoe_slow_hurtbox.set_base_radius(__aoe_slow_detection_radius)
	# Set AOE hurtbox
	__aoe_slow_hurtbox = new_aoe_slow_hurtbox

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

## # Handle additional logic during _ready() method for subclasses
func _extended_onready():
	pass

## Handles the retargeting delay if __delay_retargeting is set to true.
## Does nothing if __delay_retargeting is set to false or if __retargetable is set to false.
func _handle_retarget_delay() -> void:
	# Do nothing if retargeting is not enabled
	if !__retargetable:
		return

	# Do nothing if retargeting delay is not enabled
	if !__delay_retargeting:
		return

	# Calculate and increment distance travelled
	var calculated_velocity: Vector2 = __velocity * __speed # Non-isometric distance
	__distance_travelled += Vector2.ZERO.distance_to(calculated_velocity)

	# Enable retargeting once distance travelled is greater or equal
	# than retarget delay distance.
	if __distance_travelled >= __retarget_delay_distance:
		# Ensure tracking of distance travelled is disabled.
		__delay_retargeting = false

## Does nothing if AOE is disabled. 
func _handle_aoe_damage_infliction():
	# Do nothing if AOE is disabled
	if !__aoe_enabled:
		return

	# Check if the AOE damage amount is valid
	assert(__aoe_damage_amount > 0, "AOE damage amount must be greater than 0")
	
	# Check if the AOE hurtbox is valid
	assert(__aoe_damage_hurtbox, "AOE hurtbox not created")
	
	# Inflict AOE damage to all creeps in the AOE hurtbox
	_inflict_aoe_damage()

## Inflicts AOE damage to all creeps in the AOE hurtbox.
## This method is called when the projectile inflicts damage to a creep.
func _inflict_aoe_damage():
	# Check if the AOE damage amount is valid
	assert(__aoe_damage_amount > 0, "AOE damage amount must be greater than 0")
	
	# Inflict damage to all creeps in the AOE hurtbox
	for creep in __aoe_damage_hurtbox.get_detectable_creeps_in_range():
		# Inflict damage to the creep
		creep.take_damage(__aoe_damage_amount)


## Does nothing if AOE is disabled. 
func _handle_aoe_slow_infliction():
	# Do nothing if AOE Slow is disabled
	if !__aoe_slow_enabled:
		return

	# Check if the AOE slow amounts are valid
	assert(__aoe_slow_duration > 0, "AOE slow duration must be greater than 0")
	assert(__aoe_slow_percentage > 0, "AOE slow percentage must be greater than 0")
	
	# Check if the AOE hurtbox is valid
	assert(__aoe_slow_hurtbox, "AOE hurtbox not created")
	
	# Inflict AOE damage to all creeps in the AOE hurtbox
	_inflict_aoe_slow()



## Inflicts AOE slow to all creeps in the AOE Slow hurtbox.
## This method is called when the projectile inflicts damage to a creep.
func _inflict_aoe_slow():
	# Check if the AOE slow amounts are valid
	assert(__aoe_slow_duration > 0, "AOE slow duration must be greater than 0")
	assert(__aoe_slow_percentage > 0, "AOE slow percentage must be greater than 0")
	
	# Inflict damage to all creeps in the AOE hurtbox
	for creep in __aoe_slow_hurtbox.get_detectable_creeps_in_range():
		# Inflict damage to the creep
		creep.slow(__aoe_slow_percentage, __aoe_slow_duration)

## Does nothing if projectile cannot inflict slow (i.e. __can_slow = false)
func _handle_slow_infliction(inflictedCreep: Creep):
	# Do nothing if projectile does not inflict slow
	if !__can_slow:
		return
	
	# Ensure slow specifiers have been provided
	assert(__slow_duration_seconds, "No slow duration provided")
	assert(__slow_speed_reduction_percentage, "No slow reduction percentage provided")

	# Inflict slow
	# This method already checks for creep state, speed reduction cap and max stackability of slow effects
	inflictedCreep.slow(__slow_speed_reduction_percentage, __slow_duration_seconds)

# *******
# SIGNALS
# *******

func _on_hurtbox_entered(area):
	pass


func _on_retarget_hurtbox_entered(area):
	# Do nothing if retargeting delay is active
	if __delay_retargeting:
		return

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


# Getter and Setter for __can_slow
func get_can_slow() -> bool:
	return __can_slow

func set_can_slow(value: bool) -> void:
	__can_slow = value


# Getter and Setter for __slow_duration_seconds
func get_slow_duration_seconds() -> float:
	return __slow_duration_seconds

func set_slow_duration_seconds(value: float) -> void:
	__slow_duration_seconds = value


# Getter and Setter for __slow_speed_reduction_percentage
func get_slow_speed_reduction_percentage() -> int:
	return __slow_speed_reduction_percentage

func set_slow_speed_reduction_percentage(value: int) -> void:
	__slow_speed_reduction_percentage = value

# ─────────── AOE Damage setters ───────────
func set_aoe_enabled(enabled: bool) -> void:
	__aoe_enabled = enabled

func set_aoe_detection_radius(radius: int) -> void:
	# Don’t let the radius go negative.
	__aoe_detection_radius = max(radius, 0)

func set_aoe_damage_amount(amount: int) -> void:
	# Clamp to zero or above so damage is never negative.
	__aoe_damage_amount = max(amount, 0)

# ─────────── AOE slow setters ───────────
func set_aoe_slow_enabled(enabled: bool) -> void:
	__aoe_slow_enabled = enabled

func set_aoe_slow_detection_radius(radius: int) -> void:
	# Don’t let the radius go negative.
	__aoe_slow_detection_radius = max(radius, 0)

func set_aoe_slow_percentage(percentage: int) -> void:
	# Clamp to zero or above so damage is never negative.
	__aoe_slow_percentage = max(percentage, 0)

func set_aoe_slow_duration(duration: float) -> void:
	# Clamp to zero or above so damage is never negative.
	__aoe_slow_duration = max(duration, 0)
