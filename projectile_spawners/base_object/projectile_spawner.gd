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

# LOCALS
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
	_execute_extended_onready_commands()

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
## Retrurns the range of the projectile spawner in pixels.
func get_detection_range() -> int:
	return __detection_range

func get_cooldown_duration() -> float:
	return __cooldown_duration