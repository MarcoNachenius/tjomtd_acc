extends Node2D

@export var GAME_MAP: GameMap
@export var TOWER_ID: TowerConstants.TowerIDs
@export var TOWER_PLACEMENT_COORD: Vector2i

func _ready():
	GAME_MAP.CREEP_SPAWNER.initiate_new_wave()
	GAME_MAP.place_built_tower(TOWER_PLACEMENT_COORD, TOWER_ID)
	var tower_aura: TowerDamageAura = TowerAuraConstants.TOWER_DAMAGE_AURA_PRELOAD.instantiate()
	tower_aura.DAMAGE_INCREASE_FACTOR = 0.8
	add_child(tower_aura)
	tower_aura.global_position = GAME_MAP.__towers_on_map[0].global_position


func _on_exit_game_pressed():
	get_tree().quit()