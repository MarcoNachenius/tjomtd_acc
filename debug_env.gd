extends Node2D

@export var __game_map: GameMap


func _ready() -> void:
	var starting_point = Vector2(1, 0)
	var degrees: int = 0
	for i in range(16):
		print("Rotate by ", 45*i, " degrees:")
		print("Coordiante: ", starting_point.rotated((PI/4)*i))
		print("")
