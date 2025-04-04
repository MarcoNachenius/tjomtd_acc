extends Node2D

@export var __game_map: GameMap


func _ready() -> void:
	var points = [
		Vector2(1, 0),
		Vector2(1, 1),
		Vector2(0, 1),
		Vector2(-1, 1),
		Vector2(-1, 0),
		Vector2(-1, -1),
		Vector2(0, -1),
		Vector2(1, -1),
		]
