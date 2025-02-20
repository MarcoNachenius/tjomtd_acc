extends Projectile
class_name TargetedRicochetBullet

## TODO: Hide ricochet detection hurtbox whenever the bullet is
## traveling towards the target. It should only be visible when
## the bullet is looking for a new target to ricochet to.


@export var __damage: int
@export var __infinite_ricochets: bool = false
@export var __ricochet_detection_radius: int = 100
@export var __total_ricochets: int = 3


var __curr_ricochets: int
var __last_damaged_creep: Creep
var __ricochet_detection_hurtbox: ProjectileHurtbox


func _process(delta):
	_handle_movement()


func _handle_movement():
	assert(__velocity, "No velocity provided")
	assert(__speed, "No speed provided")
	position += __velocity * __isometric_speed

# Executes additional logic during the _ready() method
func _extended_onready():
	__curr_ricochets = 0
	# Create the ricochet detection hurtbox
	__ricochet_detection_hurtbox = ProjectileConstants.HURTBOX_PRELOAD.instantiate()
	add_child(__ricochet_detection_hurtbox)
	__ricochet_detection_hurtbox.set_base_radius(__ricochet_detection_radius)


func _inflict_damange(creep: Creep):
	creep.take_damage(__damage)
	__last_damaged_creep = creep
	__curr_ricochets += 1
	# Destroy the bullet if it has reached the maximum ricochets
	# If infinite ricochets are enabled, the bullet will not be destroyed
	if !__infinite_ricochets and __curr_ricochets == __total_ricochets:
		queue_free()
	
	# HANDLE RICOCHET
	# ---------------
	# Keep moving at the same velocity if there are no creeps in range
	if __ricochet_detection_hurtbox.get_creeps_in_range().size() == 0:
			return
	# Change the target to first creep detected that is not the last damaged creep
	for creep_instance in __ricochet_detection_hurtbox.get_creeps_in_range():
		if !is_instance_valid(creep_instance):
			continue
		if creep_instance == __last_damaged_creep:
			continue
		if !creep_instance.is_detectable():
			continue
		__target = creep_instance
		update_velocity_towards_target()
		update_isometric_speed()
		break


func _on_hurtbox_entered(area):
	if !area.get_parent() is Creep:
		return
	var entered_creep: Creep = area.get_parent()
	if !entered_creep.is_detectable():
		return
	# Inflict damage on the creep
	_inflict_damange(entered_creep)


# *******
# SETTERS
# *******

func set_damage(amount: int):
	__damage = amount
