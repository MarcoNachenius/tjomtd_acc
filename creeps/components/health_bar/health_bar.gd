extends ProgressBar
class_name HealthBar


func _ready() -> void:
    # Health bar is hidden by default to ensure it only becomes visible
    # when its values have been set.
    visible = false

    # Center the health bar along the x-axis of the creep.
    position.x = -size.x / 2

func update_health_value(newHealth: int) -> void:
    # Hide health bar if health is zero
    if newHealth < 1:
        visible = false
        return

    # Update the fill value of the health bar
    value = newHealth