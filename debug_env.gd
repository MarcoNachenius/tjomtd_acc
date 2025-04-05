extends Node2D

@export var __game_map: GameMap


func _ready() -> void:
	var points = [0.0, 0.0, 0.0]
	for i in range(points.size()):
		points[i] += 1.0
	print(points) 
