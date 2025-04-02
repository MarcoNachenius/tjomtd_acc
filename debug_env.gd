extends Node2D

@export var __game_map: GameMap

func _on_button_pressed():
	__game_map.__creep_spawner.__total_wave_creeps_spawned = 0
	__game_map.__creep_spawner.__creep_preload = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER]
	__game_map.__creep_spawner._spawn_wave_creep()


func _on_show_path_pressed():
	if __game_map.__path_line_visible:
		__game_map.hide_path_line()
	else:
		__game_map.show_path_line()

