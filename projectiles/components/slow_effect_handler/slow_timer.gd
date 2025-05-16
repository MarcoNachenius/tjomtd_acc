extends Timer
class_name SlowTimer

signal slow_timer_stopped(tiemr: SlowTimer)

var __speed_points_claimed: int

func _ready():
    timeout.connect(_on_timeout)

func _on_timeout():
    slow_timer_stopped.emit(self)

func set_speed_points_claimed(amount: int):
    __speed_points_claimed = amount

func get_speed_points_claimed() -> int:
    return __speed_points_claimed