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
	
	for point in points:
		var calculated_angle = Vector2.ZERO.angle_to_point(point)
		# Handle (2PI, 3/2PI)
		if calculated_angle >= -PI and calculated_angle < 0:
			calculated_angle += 2 * PI
		#if calculated_angle >= -PI/2 and calculated_angle < 0:
		#	calculated_angle =+ 
		print("Point: ", point)
		print("Angle to point: ", rad_to_deg(calculated_angle))
	
