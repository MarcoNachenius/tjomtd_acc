extends Node2D
class_name RangeDisplayShape

var __base_radius: float
var __transparency: float = 0.5
var range_color: Color

func _init(base_radius: float = 10.0):
    __base_radius = base_radius
    __transparency = clamp(0.25, 0.0, 1.0)
    range_color = Color(0.3, 0.6, 1.0, __transparency)

func _ready():
    scale = Vector2(1, 0.5)  # make it oval
    #update()

func _draw():
    draw_circle(Vector2.ZERO, __base_radius * 2, range_color)
