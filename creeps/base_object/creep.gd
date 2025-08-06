extends Node2D
class_name Creep

enum States {
	MOVING,
	IDLE,
	DYING
}

signal creep_death(creep: Creep)
signal end_of_path_reached(creep: Creep)

@export var DEATH_ANIMATIONS: AnimatedSprite2D
@export var IDLE_ANIMATIONS: AnimatedSprite2D
@export var MOVEMENT_ANIMATIONS: AnimatedSprite2D
@export var SPEED_TO_MOVEMENT_FPS_RATIO: float = 0.5
@export var FINAL_BOSS_MODE: bool = false
@export var TAKE_DAMAGE_AUDIO: AudioStreamPlayer2D
@export var DEATH_AUDIO: AudioStreamPlayer2D

var __curr_compass_direction: CreepConstants.CompassDirections
var __curr_health: int
var __curr_path_point: int
var __curr_speed: int
var __curr_state: States
var __curr_velocity: Vector2
var __death_in_progress: bool
var __detectable: bool
var __distance_to_next_point: float
var __hitbox: CreepHitbox
var __is_wave_creep: bool
## Tracks the time at which the final boss starts maze.
var __maze_start_millisecond_timestamp: int
var __num_of_active_stun_effects: int
var __num_of_active_slow_effects: int
var __points_for_death: int
var __path_compass_directions: Array[CreepConstants.CompassDirections]
var __path_points: Array[Vector2i]
var __path_velocities: Array[Vector2]
var __penultimate_point_reached: bool
var __starting_health: int
var __starting_speed: int
var __stun_timer: Timer
var __total_distance_travelled: float
var __total_path_points: int



# ********
# BUILTINS
# ********
func _ready():
	_create_stun_timer()
	_create_hitbox()
	_set_ordering()
	_switch_state(States.MOVING)

	if FINAL_BOSS_MODE:
		_create_maze_completion_timer()


func _process(delta):
	match __curr_state:
		States.MOVING:
			_handle_movement()
		States.DYING:
			_handle_death()
		States.IDLE:
			_handle_idle()

# ***************
# PRIVATE METHODS
# ***************
## Creates and starts maze completion timer.
func _create_maze_completion_timer():
	# Milliseconds since engine start
	__maze_start_millisecond_timestamp = Time.get_ticks_msec()  

## Returns the number of seconds that have elapsed since the creep started its maze.
func get_elapsed_travel_time() -> float:
	return (Time.get_ticks_msec() - __maze_start_millisecond_timestamp) / 1000.0  # Convert to seconds

func _create_hitbox():
	var new_hitbox: CreepHitbox = CreepConstants.HITBOX_PRELOAD.instantiate() as CreepHitbox
	add_child(new_hitbox)
	__hitbox = new_hitbox

func _set_ordering():
	# Scene root
	z_index = 4
	z_as_relative = false
	y_sort_enabled = true
	# Animations
	MOVEMENT_ANIMATIONS.z_index = 0
	MOVEMENT_ANIMATIONS.z_as_relative = true
	MOVEMENT_ANIMATIONS.y_sort_enabled = true
	IDLE_ANIMATIONS.z_index = 0
	IDLE_ANIMATIONS.z_as_relative = true
	IDLE_ANIMATIONS.y_sort_enabled = true
	DEATH_ANIMATIONS.z_index = 0
	DEATH_ANIMATIONS.z_as_relative = true
	DEATH_ANIMATIONS.y_sort_enabled = true   

## This function creates a list of compass directions based on the differences between consecutive points in the __path_points array.
## It iterates through the __path_points array, calculates the difference between each pair of consecutive points, and appends the
## corresponding compass direction to the new_compass_directions array.
## The compass directions are determined based on the x and y differences between the points.
## The resulting list of compass directions is then assigned to the __path_compass_directions variable.
func _create_path_compass_directions():
	var new_compass_directions: Array[CreepConstants.CompassDirections] = []

	for i in range(__path_points.size() - 1):
		var from_point = __path_points[i]
		var to_point = __path_points[i + 1]
		var point_difference = to_point - from_point
		# NORTH-WEST
		if point_difference.x == 0 and point_difference.y < 0:
			new_compass_directions.append(CreepConstants.CompassDirections.NORTH_WEST)
			continue
		# SOUTH-EAST
		if point_difference.x == 0 and point_difference.y > 0:
			new_compass_directions.append(CreepConstants.CompassDirections.SOUTH_EAST)
			continue
		# NORTH-EAST
		if point_difference.x > 0 and point_difference.y == 0:
			new_compass_directions.append(CreepConstants.CompassDirections.NORTH_EAST)
			continue
		# SOUTH-WEST
		if point_difference.x < 0 and point_difference.y == 0:
			new_compass_directions.append(CreepConstants.CompassDirections.SOUTH_WEST)
			continue
		# NORTH
		if point_difference.x > 0 and point_difference.y < 0:
			new_compass_directions.append(CreepConstants.CompassDirections.NORTH)
			continue
		# EAST
		if point_difference.x > 0 and point_difference.y > 0:
			new_compass_directions.append(CreepConstants.CompassDirections.EAST)
			continue
		# SOUTH
		if point_difference.x < 0 and point_difference.y > 0:
			new_compass_directions.append(CreepConstants.CompassDirections.SOUTH)
			continue
		# WEST
		if point_difference.x < 0 and point_difference.y < 0:
			new_compass_directions.append(CreepConstants.CompassDirections.WEST)
			continue
		
	__path_compass_directions = new_compass_directions

## Creates a timer to handle the stun duration.
func _create_stun_timer():
	var new_timer: Timer = Timer.new()
	new_timer.one_shot = true
	__stun_timer = new_timer
	add_child(__stun_timer)

func _handle_death():
	if __death_in_progress and !DEATH_ANIMATIONS.is_playing():
		_destroy()


# Getters and Setters

func get_is_wave_creep() -> bool:
	return __is_wave_creep

func set_is_wave_creep(value: bool) -> void:
	__is_wave_creep = value

# Getter for __curr_health
func get_curr_health() -> int:
	return __curr_health

# Setter for __curr_health
func set_curr_health(value: int) -> void:
	__curr_health = value


func total_distance_travelled() -> float:
	return __total_distance_travelled

func is_detectable() -> bool:
	return __detectable

func set_detectability(value: bool):
	__detectable = value

func get_curr_compass_direction() -> CreepConstants.CompassDirections:
	return __curr_compass_direction

func set_curr_compass_direction(direction: CreepConstants.CompassDirections) -> void:
	__curr_compass_direction = direction

func get_curr_path_point() -> int:
	return __curr_path_point

func set_curr_path_point(path_point: int) -> void:
	__curr_path_point = path_point

func get_curr_speed() -> int:
	return __curr_speed

func set_curr_speed(speed: int) -> void:
	__curr_speed = speed

func set_points_for_death(points: int) -> void:
	__points_for_death = points

func get_points_for_death() -> int:
	return __points_for_death

func get_starting_speed() -> int:
	return __starting_speed

func get_curr_state() -> States:
	return __curr_state

func set_starting_health(health: int) -> void:
	__starting_health = health
	__curr_health = health

## Sets the starting speed for the creep.
## Also assigns current speed to the same value.
func set_starting_speed(speed: int) -> void:
	__starting_speed = speed
	__curr_speed = speed

func get_path_points() -> Array[Vector2i]:
	return __path_points

## Sets the path points for the creep to follow.
## This function initializes the __path_points array with the specified points
## and calculates the total number of points in the path.
## It then calls the _create_path_compass_directions and _create_path_velocities functions
## to create the corresponding compass directions and velocities for the path.
## Finally, it calls the _initiate_path_values function to set the initial path-related values for the creep.
func set_path_points(points: Array[Vector2i]) -> void:
	__path_points = points
	__total_path_points = points.size()
	_create_path_compass_directions()
	_create_path_velocities()
	_initiate_path_values()

	# Set penultimate point reached to true if there are no intermediate points
	# between the start and the end of the path.
	if __total_path_points == 1:
		__penultimate_point_reached = true


## Initializes the path-related values for the creep.
## This function sets the current path point, compass direction, velocity, 
## and calculates the distance to the next point in the path.
func _initiate_path_values():
	__curr_path_point = 0
	__curr_compass_direction = __path_compass_directions[__curr_path_point]
	__curr_velocity = __path_velocities[__curr_path_point]
	__distance_to_next_point = position.distance_to(Vector2(__path_points[__curr_path_point + 1]))

	__total_path_points = __path_points.size() - 1 ## -1 for index 0 start


## Assigns the next point in the path to the creep.
## Increments the current path point index and updates the creep's position, direction, velocity, and distance to the next point.
## If the penultimate point in the path is reached, sets a flag to true.
func _assign_next_point():
	__curr_path_point += 1
	
	# Check for penultimate point
	if __curr_path_point == __total_path_points - 1:
		__penultimate_point_reached = true

	# Snap to new position
	position = __path_points[__curr_path_point]

	# Update the current compass direction and velocity based on the new path point
	__curr_compass_direction = __path_compass_directions[__curr_path_point]
	__curr_velocity = __path_velocities[__curr_path_point]

	# Calculate the distance to the next point in the path
	__distance_to_next_point = position.distance_to(Vector2(__path_points[__curr_path_point + 1]))


## Creates a list of velocities for the creep's path based on compass directions.
## This function initializes the __path_velocities array with velocity vectors
## corresponding to each direction in the __path_compass_directions array.
## It then sets the current velocity (__curr_velocity) to the velocity at the
## current path point (__curr_path_point).
func _create_path_velocities():
	var new_path_velocities: Array[Vector2] = []
	for direction in __path_compass_directions:
		new_path_velocities.append(CreepConstants.CompassDirToVelocities[direction])
	__path_velocities = new_path_velocities
	__curr_velocity = __path_velocities[__curr_path_point]


## Destroys creep if the final point has been reached
func _handle_movement():
	# Handle point change
	if __distance_to_next_point <= 0:
		# Remove creep from the scene because the end of the path has been reached
		if __penultimate_point_reached:
			end_of_path_reached.emit(self)
			_destroy()
		else: # Handle non-penultimate point change
			_assign_next_point()
		return
	
	# Apply position change
	var position_change: Vector2 = __curr_speed * __curr_velocity
	# Calculate the distance travelled in this frame
	var distance_travelled = Vector2.ZERO.distance_to(position_change)
	# Update the distance to the next point
	__distance_to_next_point -= distance_travelled
	# Update the total distance travelled
	__total_distance_travelled += __curr_speed
	# Update the position
	position += position_change
	# Play movement animation
	MOVEMENT_ANIMATIONS.play(CreepConstants.CompassDirToMovementAnimations[__curr_compass_direction])
	# Adjust animation speed
	MOVEMENT_ANIMATIONS.speed_scale = __curr_speed * SPEED_TO_MOVEMENT_FPS_RATIO

# ***********
# WIP METHODS
# ***********

func _switch_state(state: States):
	# Update the current state
	__curr_state = state

	# Handle state-specific logic based on the new state
	match state:
		States.DYING:
			# Play death sound effect
			if DEATH_AUDIO:
				DEATH_AUDIO.play()
			creep_death.emit(self)
			__death_in_progress = true
			__detectable = false
			# Animation visibility
			DEATH_ANIMATIONS.visible = true
			MOVEMENT_ANIMATIONS.visible = false
			IDLE_ANIMATIONS.visible = false
			DEATH_ANIMATIONS.play(CreepConstants.CompassDirToDeathAnimations[__curr_compass_direction])
		States.IDLE:
			__detectable = true
			# Animation visibility
			DEATH_ANIMATIONS.visible = false
			MOVEMENT_ANIMATIONS.visible = false
			IDLE_ANIMATIONS.visible = true
		States.MOVING:
			__detectable = true
			__stun_timer.wait_time = 0.0
			# Animation visibility
			DEATH_ANIMATIONS.visible = false
			MOVEMENT_ANIMATIONS.visible = true
			IDLE_ANIMATIONS.visible = false

## Stuns the creep for a specified duration.
## If the stun timer is not running, it starts the timer and switches the creep's state to IDLE.
## If the stun timer is already running, it extends the remaining duration.
func stun(duration: float):
	assert(duration > 0, "Stun duration must be greater than 0.")
	# Start the stun timer if it is not running
	if __stun_timer.is_stopped():
		__stun_timer.wait_time = duration
		__stun_timer.start()
		_switch_state(States.IDLE)
		# Increase number of active stun effects
		__num_of_active_stun_effects += 1
		return
	
	# Do nothing if number of active stun effects is already at its maximum
	if __num_of_active_stun_effects >= GameConstants.MAX_SIMULTANEOUS_STUN_EFFECTS:
		return

	# Extend the remaining time by adding the new duration
	__stun_timer.wait_time = __stun_timer.time_left + duration
	__stun_timer.start()  # Restart the timer with the new wait time
	# Increase number of active stun effects
	__num_of_active_stun_effects += 1

## Reduces the creep's health by the specified amount.
## If the creep's health drops to or below 0, switches the creep's state to DYING.
func take_damage(amount: int, playSoundEffect: bool = true):
	# Final boss creep tracks damage dealt to it
	if FINAL_BOSS_MODE:
		__curr_health += amount
		return
	
	# Take damage
	__curr_health -= amount

	# Play take damae sound effect
	if TAKE_DAMAGE_AUDIO and playSoundEffect:
		TAKE_DAMAGE_AUDIO.play()
	
	# Switch state to dying if health has depleted
	if __curr_health < 1:
		_switch_state(States.DYING)

# ************
# TODO METHODS
# ************

func _destroy():
	queue_free()


func _handle_idle():
	# Check if the stun timer has expired
	if __stun_timer.is_stopped():
		_switch_state(States.MOVING)
		# Reset number of active stun effects
		__num_of_active_stun_effects = 0
		return
	# Play idle animation
	IDLE_ANIMATIONS.play(CreepConstants.CompassDirToIdleAnimations[__curr_compass_direction])

func slow(percentage: int, durationInSeconds: float):
	# Do nothing if new slow effect goes beyond cap of simultaneous slows at a time
	if __num_of_active_slow_effects >= GameConstants.MAX_SIMULTANEOUS_SLOW_EFFECTS:
		return
	
	# Calculate speed amount from provided percentage
	var speed_to_reduce: int = __starting_speed * percentage/100

	# Do nothing if intended slow effect will stop movement of creep
	if __curr_speed - speed_to_reduce < 1:
		return

	# Increase number of active slow effects
	__num_of_active_slow_effects += 1

	# Create Slowtimer instance
	var new_slow_timer = SlowTimer.new()
	add_child(new_slow_timer)
	
	# Ensure timer stops after timeout
	new_slow_timer.one_shot = true

	# Connect timer signal
	new_slow_timer.slow_timer_stopped.connect(_on_slow_timer_stopped)

	# Set duration of slow effect
	new_slow_timer.wait_time = durationInSeconds

	# Have slow timer store the amount of speed points it has claimed from the creep
	new_slow_timer.set_speed_points_claimed(speed_to_reduce)

	# Slow down creep
	__curr_speed -= speed_to_reduce

	# Start slow timer
	new_slow_timer.start()


func _on_slow_timer_stopped(slowTimer: SlowTimer):
	# Handle dying creep
	if __curr_state == States.DYING:
		slowTimer.queue_free()
		return
	
	# Restore speed
	__curr_speed += slowTimer.get_speed_points_claimed()

	# Decrease number of active slow effects
	__num_of_active_slow_effects -= 1

	# Remove timer from scene
	slowTimer.queue_free()



# **********
# DEGBUGGING
# **********

func debug_shit_on_ready():
	pass
