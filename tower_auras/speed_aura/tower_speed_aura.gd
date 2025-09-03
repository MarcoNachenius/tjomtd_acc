extends TowerAuraArea
class_name TowerSpeedAura

@export var SPEED_INCREASE_FACTOR: float

func _extended_ready() -> void:
    # Ensure damage increase factor is set
    assert(SPEED_INCREASE_FACTOR > 0, "SPEED_INCREASE_FACTOR must be greater than 0.")