extends Node2D
class_name ProjectileSpawner

enum TargetingPolicies {
	FIRST_TO_ENTER_RANGE,
	LAST_TO_ENTER_RANGE,
	MOST_HEALTH,
	LEAST_HEALTH,
	FURTHEST_FROM_EXIT,
	CLOSEST_TO_EXIT,
	FASTEST,
	SLOWEST
}

# EXPORTS
## Time in seconds
@export var __cooldown_duration: float
## Range in pixels
@export var __detection_range: int
@export var __enforce_targeting_policy: bool
@export var __targeting_policy: TargetingPolicies
@export var LAUNCH_PROJECTILE_AUDIO: AudioStreamPlayer2D
@export var ALLOW_DAMAGE_BUFFS: bool = true
@export var ALLOW_RANGE_BUFFS: bool = true
@export var ALLOW_SPEED_BUFFS: bool = true


# SIGNALS
## Emitted to tower in order to update range display shape 
signal range_altered(newRange: int)

# SINGLETONS
var INITIAL_DAMAGE: int
var INITIAL_RANGE: int
var INITIAL_SPEED: float

# PRIVATE VARS
var __cooldown_timer: Timer
var __target: Creep
var __hurtbox: ProjectileSpawnerHurtbox
var __launch_cooled_down: bool

# ********
# BUILTINS
# ********
func _ready():
	# HURTBOX
	self._create_hurtbox()
	# COOLDOWN TIMER
	self._create_cooldown_timer()
	__launch_cooled_down = true
	_capture_starting_values()
	# EXTENDED ONREADY COMMANDS
	_execute_extended_onready_commands()

# *******
# PUBLICS
# *******
## Plays the launch projectile sound effect if it exists.
## This method should be called in the _launch_projectiles method
## of the derived class.
func play_launch_projectile_sound_effect():
	if LAUNCH_PROJECTILE_AUDIO:
		LAUNCH_PROJECTILE_AUDIO.play()


## Returns amount of damage that has been added to initial damage. 
func total_bonus_damage() -> int:
	return get_damage() - INITIAL_DAMAGE


## Returns amount of range that has been added to initial range. 
func total_bonus_range() -> int:
	return get_detection_range() - INITIAL_RANGE


## Returns amount of time in seconds that has been subtracted from initial cooldown duration. 
func total_bonus_speed() -> float:
	return INITIAL_SPEED - __cooldown_duration


## Returns the ROUNDED amount of damage that will be added when a factor amount is applied to the initial damage.
func damage_factor_amount(factor: float) -> int:
	assert(factor > 0, "Factor must be greater than 0")
	return round(INITIAL_DAMAGE * factor)


## Returns the ROUNDED amount of range that will be added when a factor amount is applied to the initial range.
func range_factor_amount(factor: float) -> int:
	assert(factor > 0, "Factor must be greater than 0")
	return round(INITIAL_RANGE * factor)


## Returns the ROUNDED cooldown time that will be subtracted when a factor amount is applied to the initial cooldown duration.
func speed_factor_amount(factor: float) -> float:
	assert(factor > 0, "Factor must be greater than 0")
	return INITIAL_SPEED * factor


# ********
# PRIVATES
# ********

## Retrurns value in radians to global position of target creep (self.__target).
func _angle_to_targeted_creep() -> float:
	assert(__target, "No current target has been assigned")
	var angle_to_creep = global_position.angle_to_point(__target.global_position)
	if angle_to_creep >= -PI and angle_to_creep < 0:
		angle_to_creep += 2 * PI
	return angle_to_creep

func _capture_starting_values() -> void:
	INITIAL_RANGE = __detection_range
	INITIAL_DAMAGE = get_damage()
	INITIAL_SPEED = get_cooldown_duration()


func _create_hurtbox():
	var new_hurtbox: ProjectileSpawnerHurtbox = ProjectileSpawnerConstants.HURTBOX_PRELOAD.instantiate()
	add_child(new_hurtbox)
	new_hurtbox.set_base_radius(__detection_range)
	__hurtbox = new_hurtbox
	__hurtbox.area_entered.connect(_on_hurtbox_entered)
	__hurtbox.area_exited.connect(_on_hurtbox_exited)

func _create_cooldown_timer():
	# Create the Timer instance
	var timer = Timer.new()
	
	# Configure the Timer
	timer.wait_time = __cooldown_duration
	timer.one_shot = true
	
	# Add the Timer as a child to the current node
	add_child(timer)
	
	# Connect the Timer's timeout signal to a function in this script
	timer.timeout.connect(_on_cooldown_timer_timeout)
	
	__cooldown_timer = timer

func _update_target_selection():
	var detectable_creeps: Array[Creep] = __hurtbox.get_detectable_creeps_in_range()
	if detectable_creeps.is_empty():
		__target = null
		return
	# Continue if current target it still in range
	if __target and detectable_creeps.has(__target):
		return
	
	# Target selection policy is not necessary if there is only one detectable creep in range
	if detectable_creeps.size() == 1 or !__enforce_targeting_policy:
		__target = detectable_creeps[0]
		return

	_handle_targeting_policy(detectable_creeps)

func _start_cooldown_timer():
	__cooldown_timer.start()
	__launch_cooled_down = false


# *******
# SIGNALS
# *******
func _on_hurtbox_entered(area):
	if !__launch_cooled_down:
		return
	_update_target_selection()
	if __target:
		_start_cooldown_timer()
		_launch_projectiles()

func _on_hurtbox_exited(area):
	_update_target_selection()


# ****************
# ABSTRACT METHODS
# ****************
func _execute_extended_onready_commands():
	pass

func get_damage() -> int:
	return 0

## Increases damage of launched projectiles by specified amount.
func increase_damage(amount: int) -> void:
	print("WARNING: Empty abstract method called. This method does nothing")

## Decreases damage of launched projectiles by specified amount.
func decrease_damage(amount: int) -> void:
	print("WARNING: Empty abstract method called. This method does nothing")

## Increases range of projectile spawner 
func increase_range(amount: int) -> void:
	assert(amount > 0, "Zero or lower amounts are not allowed")
	var new_range: int = get_detection_range() + amount
	set_detection_range(new_range)

## Decreases range of projectile spawner 
func decrease_range(amount: int) -> void:
	assert(amount > 0, "Zero or lower amounts are not allowed")
	var new_range: int = get_detection_range() - amount
	assert(new_range > 1, "Range must be larger than 1")
	set_detection_range(new_range)


## Increases speed of projectile spawner 
func increase_speed(timeInSeconds: float) -> void:
	assert(timeInSeconds > 0, "Zero or lower amounts are not allowed")
	var new_speed: float = __cooldown_duration - timeInSeconds
	set_cooldown_duration(new_speed)


## Decreases speed of projectile spawner 
func decrease_speed(timeInSeconds: float) -> void:
	assert(timeInSeconds > 0, "Zero or lower amounts are not allowed")
	var new_speed: float = __cooldown_duration + timeInSeconds
	assert(new_speed > 0.0, "Cooldown duration must be positive number above 0")
	set_cooldown_duration(new_speed)


func _on_cooldown_timer_timeout():
	__launch_cooled_down = true
	_update_target_selection()
	if __target:
		_start_cooldown_timer()
		_launch_projectiles()
		__launch_cooled_down = false

## This method strictly handles the launching of projectiles.
## Any logic related to WHEN/IF to launch projectiles should be handled in the
## _on_hurtbox_entered and _on_hurtbox_exited methods.
func _launch_projectiles():
	pass

func _handle_targeting_policy(detectableCreeps: Array[Creep]):
	match __targeting_policy:
		TargetingPolicies.FIRST_TO_ENTER_RANGE: _target_first_creep_to_enter_range(detectableCreeps)
		TargetingPolicies.LAST_TO_ENTER_RANGE: _target_last_creep_to_enter_range(detectableCreeps)
		TargetingPolicies.MOST_HEALTH: _target_most_health_creep(detectableCreeps)
		TargetingPolicies.LEAST_HEALTH: _target_least_health_creep(detectableCreeps)
		TargetingPolicies.FURTHEST_FROM_EXIT: _target_creep_furthest_from_exit(detectableCreeps)
		TargetingPolicies.CLOSEST_TO_EXIT: _target_creep_closest_to_exit(detectableCreeps)
		TargetingPolicies.FASTEST: _target_fastest_creep(detectableCreeps)
		TargetingPolicies.SLOWEST: _target_slowest_creep(detectableCreeps)


## Helper method for _handle_targeting_policy
func _target_first_creep_to_enter_range(detectableCreeps: Array[Creep]):
	__target = detectableCreeps[0]

## Helper method for _handle_targeting_policy
func _target_last_creep_to_enter_range(detectableCreeps: Array[Creep]):
	__target = detectableCreeps[-1]

## Helper method for _handle_targeting_policy
func _target_creep_closest_to_exit(detectableCreeps: Array[Creep]):
	var closest_to_exit_creep: Creep = detectableCreeps[0]
	for i in range(1, detectableCreeps.size()):
		if detectableCreeps[i].total_distance_travelled() > closest_to_exit_creep.total_distance_travelled():
			closest_to_exit_creep = detectableCreeps[i]
	__target = closest_to_exit_creep

## Helper method for _handle_targeting_policy
func _target_creep_furthest_from_exit(detectableCreeps: Array[Creep]):
	var furthest_from_exit_creep: Creep = detectableCreeps[0]
	for i in range(1, detectableCreeps.size()):
		if detectableCreeps[i].total_distance_travelled() < furthest_from_exit_creep.total_distance_travelled():
			furthest_from_exit_creep = detectableCreeps[i]
	__target = furthest_from_exit_creep

## Helper method for _handle_targeting_policy
func _target_fastest_creep(detectableCreeps: Array[Creep]):
	var fastest_creep: Creep = detectableCreeps[0]
	for i in range(1, detectableCreeps.size()):
		if detectableCreeps[i].get_curr_speed() > fastest_creep.get_curr_speed():
			fastest_creep = detectableCreeps[i]
	__target = fastest_creep

## Helper method for _handle_targeting_policy
func _target_slowest_creep(detectableCreeps: Array[Creep]):
	var slowest_creep: Creep = detectableCreeps[0]
	for i in range(1, detectableCreeps.size()):
		if detectableCreeps[i].get_curr_speed() < slowest_creep.get_curr_speed():
			slowest_creep = detectableCreeps[i]
	__target = slowest_creep

## Helper method for _handle_targeting_policy
func _target_most_health_creep(detectableCreeps: Array[Creep]):
	var most_health_creep: Creep = detectableCreeps[0]
	for i in range(1, detectableCreeps.size()):
		if detectableCreeps[i].get_curr_health() > most_health_creep.get_curr_health():
			most_health_creep = detectableCreeps[i]
	__target = most_health_creep

## Helper method for _handle_targeting_policy
func _target_least_health_creep(detectableCreeps: Array[Creep]):
	var least_health_creep: Creep = detectableCreeps[0]
	for i in range(1, detectableCreeps.size()):
		if detectableCreeps[i].get_curr_health() < least_health_creep.get_curr_health():
			least_health_creep = detectableCreeps[i]
	__target = least_health_creep


# *******
# GETTERS
# *******
## Retrurns the CURRENT range of the projectile spawner in pixels.
func get_detection_range() -> int:
	return __detection_range


func get_cooldown_duration() -> float:
	return __cooldown_duration


# *******
# SETTERS
# *******
func set_detection_range(amount: int) -> void:
	__detection_range = amount
	__hurtbox.set_base_radius(amount)
	# Emit range altered signal
	range_altered.emit(amount)

func set_cooldown_duration(newDurationSeconds: float) -> void:
	__cooldown_timer.wait_time = newDurationSeconds
	__cooldown_duration = newDurationSeconds