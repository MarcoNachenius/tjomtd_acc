## SingleHitBullet: A lightweight projectile for direct hits
# Unlike TargetedRicochetBullet, this class does not include additional ricochet detection, 
# making it a more lightweight and efficient option for straightforward projectile behavior.

extends Projectile
class_name SingleHitBullet

@export var __damage: int  # Damage dealt to a creep upon impact

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
	creep.take_damage(__damage)
	# Signal that creep has been hit
	creep_hit.emit(creep)
	# Handle AOE damage if enabled
	_handle_aoe_damage_infliction()
	# Handle slow infliction
	_handle_slow_infliction(creep)
	queue_free()  # Destroy the bullet after dealing damage

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
