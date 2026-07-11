extends Node2D

@export var GAME_MAP: GameMap
@export var TOWER_ID: TowerConstants.TowerIDs
@export var TOWER_PLACEMENT_COORD: Vector2i

const TST_CREEP_WAVE_PROPERTIES: Dictionary = {
		WaveConstants.WaveProperties.CREEP_ID: CreepConstants.CreepIDs.MUMMY,
		WaveConstants.WaveProperties.CREEP_SPEED: 5,
		WaveConstants.WaveProperties.CREEP_HEALTH: 10,
		WaveConstants.WaveProperties.WAVE_SIZE: 1,
		WaveConstants.WaveProperties.SPAWN_COOLDOWN_TIME: 100.0,
		WaveConstants.WaveProperties.POINTS_FOR_DEATH: 4
	}

func _ready():
	GAME_MAP.place_barricade(TOWER_PLACEMENT_COORD, true)

	GAME_MAP.CREEP_SPAWNER.__wave_creep_properties = TST_CREEP_WAVE_PROPERTIES
	GAME_MAP.CREEP_SPAWNER.set_creep_preload(CreepConstants.CreepPreloads[TST_CREEP_WAVE_PROPERTIES[WaveConstants.WaveProperties.CREEP_ID]])
	GAME_MAP.CREEP_SPAWNER.__wave_size = TST_CREEP_WAVE_PROPERTIES[WaveConstants.WaveProperties.WAVE_SIZE]
	GAME_MAP.CREEP_SPAWNER._spawn_wave_creep()


func _on_exit_game_pressed():
	get_tree().quit()