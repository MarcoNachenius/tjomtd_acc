extends Projectile
class_name SingleHitMissile

@export var __damage: int
@export var MISSILE_SPRITE: Sprite2D

func _process(delta):
	_handle_movement()

func _handle_movement():
	assert(__velocity, "No velocity provided")
	assert(__speed, "No speed provided")
	if is_instance_valid(__target) and __target.is_detectable():
		update_velocity_towards_target()
		update_isometric_speed()
		MISSILE_SPRITE.look_at(__target.global_position)
	position += __velocity * __isometric_speed

## Self destructs after dealing damage
func _inflict_damange(creep: Creep):
	creep.take_damage(__damage)
	# Signal that creep has been hit
	creep_hit.emit(creep)
	# Handle AOE damage if enabled
	_handle_aoe_damage_infliction()
	# Handle slow infliction
	_handle_slow_infliction(creep)
	queue_free()

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

func set_damage(amount: int):
	__damage = amount

# *******
# GETTERS
# *******

