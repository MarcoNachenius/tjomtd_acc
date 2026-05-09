extends Node2D

@export var GAME_MAP: GameMap
@export var __creep_id: CreepConstants.CreepIDs
@export var __creep_speed: int = 20
@export var CAMERA: MapCamera
@export var FOLLOW_CREEP: bool = true


var __found_creep: Creep

@onready var WAVE_PROPERTIES: Dictionary = {
	WaveConstants.WaveProperties.CREEP_ID: __creep_id,
	WaveConstants.WaveProperties.CREEP_SPEED: __creep_speed,
	WaveConstants.WaveProperties.CREEP_HEALTH: 430,
	WaveConstants.WaveProperties.WAVE_SIZE: 1,
	WaveConstants.WaveProperties.SPAWN_COOLDOWN_TIME: 0.2,
	WaveConstants.WaveProperties.POINTS_FOR_DEATH: 19
}

func _ready() -> void:
	if FOLLOW_CREEP:
		CAMERA.zoom = Vector2(1, 1)
	 
	GAME_MAP.__curr_path = [
		Vector2i(20, 20),
		Vector2i(20, 30),
		Vector2i(30, 30),
		Vector2i(30, 20),
		Vector2i(20, 20),
		Vector2i(10, 10),
		Vector2i(0, 20),
		Vector2i(10, 30),
		Vector2i(20, 20),
		# Repeat
		Vector2i(20, 30),
		Vector2i(30, 30),
		Vector2i(30, 20),
		Vector2i(20, 20),
		Vector2i(10, 10),
		Vector2i(0, 20),
		Vector2i(10, 30),
		Vector2i(20, 20),
		# Repeat
		Vector2i(20, 30),
		Vector2i(30, 30),
		Vector2i(30, 20),
		Vector2i(20, 20),
		Vector2i(10, 10),
		Vector2i(0, 20),
		Vector2i(10, 30),
		Vector2i(20, 20),
	]
	GAME_MAP.update_path_line()
	GAME_MAP.show_path_line()
	
	
	# Hide barricades
	#for barricade in GAME_MAP.__barricades_on_map:
	#	barricade.visible = false

	# Set creep spawner values
	GAME_MAP.CREEP_SPAWNER.__wave_creep_properties = WAVE_PROPERTIES
	GAME_MAP.CREEP_SPAWNER.__wave_creep_preload = CreepConstants.CreepPreloads[GAME_MAP.CREEP_SPAWNER.__wave_creep_properties[WaveConstants.WaveProperties.CREEP_ID]]
	GAME_MAP.CREEP_SPAWNER.__spawn_cooldown_timer.wait_time = GAME_MAP.CREEP_SPAWNER.__wave_creep_properties[WaveConstants.WaveProperties.SPAWN_COOLDOWN_TIME]
	GAME_MAP.CREEP_SPAWNER.__wave_size = GAME_MAP.CREEP_SPAWNER.__wave_creep_properties[WaveConstants.WaveProperties.WAVE_SIZE]

	GAME_MAP.CREEP_SPAWNER._spawn_wave_creep()


func _process(delta: float) -> void:
	if !FOLLOW_CREEP:
		return
	if !__found_creep:
		for child in GAME_MAP.ENTITY_LAYER.get_children():
			if child is Creep:
				__found_creep = child
				break
	if __found_creep:
		CAMERA.global_position = __found_creep.global_position





func _on_exit_game_pressed():
	get_tree().quit()
