extends Projectile
class_name MultiHitSingleDirBullet

@export var __damage: int  # Damage dealt to a creep upon impact
@export var __infinite_hits: bool = true
@export var __max_hits: int
@export var __damage_degradation_enabled: bool
@export var __damage_degradation_rate: int

# PRIVATES
var __total_hits: int = 0

func _process(delta):
    _handle_movement()

## Handles bullet movement in the isometric space
func _handle_movement():
    position += __velocity * __isometric_speed

## Inflicts damage to a target and removes the bullet from the scene
#
# The bullet will apply its damage to the creep and then self-destruct,
# ensuring it only affects a single target upon impact.
func _inflict_damange(creep: Creep):
    # Ensure bullet is not placed at position beyond creep when hit
    creep.take_damage(__damage)

    # Handle AOE damage if enabled
    _handle_aoe_damage_infliction()
    # Handle AOE slow if enabled
    _handle_aoe_slow_infliction()
    # Handle slow infliction
    _handle_slow_infliction(creep)
    
    # Handle damage degradation
    if __damage_degradation_enabled:
        __damage -= __damage_degradation_rate
    # Destroy bullet if damage is 0 or lower because of degradation
    if __damage_degradation_enabled and __damage < 1:
        queue_free()

    # Handle hit amount
    if __infinite_hits:
        return
    __total_hits += 1
    # Destroy bullet once max hit amount has been reached
    if __total_hits >= __max_hits:
        queue_free()
    

## Detects when the bullet's hurtbox enters another area
#
# If the entered area belongs to a detectable Creep, the bullet applies damage.
func _on_hurtbox_entered(area):
    if !area.get_parent() is Creep:
        return
    var entered_creep: Creep = area.get_parent() 
    if !entered_creep.is_detectable():
        return
    
    _inflict_damange(entered_creep)

# *******
# SETTERS
# *******

## Sets the damage value for this bullet
func set_damage(amount: int):
    __damage = amount

func set_infinite_hits(value: bool) -> void:
    __infinite_hits = value

func set_max_hits(value: int) -> void:
    __max_hits = value

func set_damage_degradation_enabled(value: bool) -> void:
    __damage_degradation_enabled = value

func set_damage_degradation_rate(value: int) -> void:
    __damage_degradation_rate = value