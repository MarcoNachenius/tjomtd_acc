extends Node2D

@export var __game_map: GameMap

func _ready() -> void:
    # Make scene appear in fullscreen
	get_viewport().size = DisplayServer.screen_get_size()