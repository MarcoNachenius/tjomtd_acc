extends Node2D

@export var GAME_MAP: GameMap
@export var TOWER_ID: TowerConstants.TowerIDs
@export var TOWER_PLACEMENT_COORD: Vector2i

func _ready():
	GAME_MAP.CREEP_SPAWNER.initiate_new_wave()
	GAME_MAP.place_barricade(TOWER_PLACEMENT_COORD)
	GAME_MAP._update_current_path()


func _on_exit_game_pressed():
	get_tree().quit()