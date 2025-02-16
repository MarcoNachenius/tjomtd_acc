extends Node2D
class_name CreepSpawner

var __game_map: GameMap
var __spawn_cooldown_timer: Timer
var __wave_creep_preload: PackedScene
var __curr_wave_creeps_spawned: int
var __total_wave_creeps_spawned: int
var __wave_number: int
var __wave_size: int
var __wave_creep_spawn_cooldown_time: float # Time in seconds 
var __wave_creep_properties: Dictionary

signal creep_spawned(creep: Creep)

func _ready():
	__wave_number = 0
	_create_spawn_cooldown_timer()

func _create_spawn_cooldown_timer():
	# Create the Timer instance
	var new_timer = Timer.new()
	
	# Configure the Timer
	new_timer.wait_time = __wave_creep_spawn_cooldown_time
	new_timer.one_shot = true
	
	# Add the Timer as a child to the current node
	add_child(new_timer)
	
	# Connect the Timer's timeout signal to a function in this script
	new_timer.timeout.connect(_on_spawn_cooldown_timer_timeout)
	
	__spawn_cooldown_timer = new_timer
	__curr_wave_creeps_spawned = 0


func _spawn_wave_creep():
	assert(__wave_creep_preload, "CreepSpawner error: No creep preload has been set")
	if __total_wave_creeps_spawned == __wave_size:
		return
	var new_creep: Creep = __wave_creep_preload.instantiate() as Creep
	new_creep.creep_death.connect(__game_map._on_creep_death)
	new_creep.end_of_path_reached.connect(__game_map._on_creep_end_of_path_reached)
	# Create and add creep 
	new_creep.position = __game_map.__main_tileset.map_to_local(__game_map.__path_start_point)
	new_creep.position.x += 64 # I have no idea why this is fixes creep starting position
	add_child(new_creep)
	# Set creep properties
	new_creep.set_path_points(__game_map.creep_mapped_to_local_path_positions())
	new_creep.set_starting_health(__wave_creep_properties[WaveConstants.WaveProperties.CREEP_HEALTH])
	new_creep.set_starting_speed(__wave_creep_properties[WaveConstants.WaveProperties.CREEP_SPEED])
	new_creep.set_detectability(true)
	new_creep.set_is_wave_creep(true)
	# Emit signal
	creep_spawned.emit(new_creep)
	# Update counter
	__total_wave_creeps_spawned += 1
	# Start cooldown timer
	__spawn_cooldown_timer.start()

func initiate_new_wave():
	# Retireve wave properties
	__wave_creep_properties = WaveConstants.WAVES[__wave_number]
	__total_wave_creeps_spawned = 0
	# Set wave spawn properties 
	__wave_creep_preload = CreepConstants.CreepPreloads[__wave_creep_properties[WaveConstants.WaveProperties.CREEP_ID]]
	__spawn_cooldown_timer.wait_time = __wave_creep_properties[WaveConstants.WaveProperties.SPAWN_COOLDOWN_TIME]
	__wave_size = __wave_creep_properties[WaveConstants.WaveProperties.WAVE_SIZE]
	_spawn_wave_creep()
	__wave_number += 1

# *******
# SIGNALS
# *******
func _on_spawn_cooldown_timer_timeout():
	_spawn_wave_creep()

# *******
# SETTERS
# *******

# Setter for __wave_creep_preload
func set_creep_preload(scene: PackedScene) -> void:
	if scene is PackedScene:
		__wave_creep_preload = scene
	else:
		push_error("Invalid value for __wave_creep_preload: Expected PackedScene.")

# Setter for __curr_wave_creeps_spawned
func set_curr_wave_creeps_spawned(value: int) -> void:
	if value >= 0:
		__curr_wave_creeps_spawned = value
	else:
		push_error("Invalid value for __curr_wave_creeps_spawned: Cannot be negative.")

# Setter for __total_wave_creeps_spawned
func set_total_wave_creeps_spawned(value: int) -> void:
	if value >= 0:
		__total_wave_creeps_spawned = value
	else:
		push_error("Invalid value for __total_wave_creeps_spawned: Cannot be negative.")

# Setter for __wave_size
func set_wave_size(value: int) -> void:
	if value >= 0:
		__wave_size = value
	else:
		push_error("Invalid value for __wave_size: Cannot be negative.")

# Setter for __wave_creep_spawn_cooldown_time
func set_wave_creep_spawn_cooldown(value: float) -> void:
	if value >= 0.0:
		__wave_creep_spawn_cooldown_time = value
	else:
		push_error("Invalid value for __wave_creep_spawn_cooldown_time: Cannot be negative.")

## Returns true if the wave initiation is in progress
func wave_initiation_in_progress() -> bool:
	return __total_wave_creeps_spawned != __wave_size

# Setter for __game_map
func set_game_map(game_map: GameMap) -> void:
	__game_map = game_map
