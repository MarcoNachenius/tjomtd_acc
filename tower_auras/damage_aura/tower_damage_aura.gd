extends TowerAuraArea
class_name TowerDamageAura

@export var DAMAGE_INCREASE_FACTOR: float

func _extended_ready() -> void:
    # Ensure damage increase factor is set
    assert(DAMAGE_INCREASE_FACTOR > 0, "DAMAGE_INCREASE_FACTOR must be greater than 0.")