extends TowerAuraArea
class_name TowerRangeAura

@export var RANGE_INCREASE_FACTOR: float

func _extended_ready() -> void:
    # Ensure range increase factor is set
    assert(RANGE_INCREASE_FACTOR > 0, "RANGE_INCREASE_FACTOR must be greater than 0.")