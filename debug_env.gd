extends Node2D

@export var __game_map: GameMap


func _ready() -> void:
	print(__game_map.__mandatory_waypoints)
