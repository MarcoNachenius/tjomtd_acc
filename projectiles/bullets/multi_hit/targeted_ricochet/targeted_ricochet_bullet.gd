extends Projectile
class_name TargetedRicochetBullet

## TODO: Hide ricochet detection hurtbox whenever the bullet is
## traveling towards the target. It should only be monitoring when
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

## Alters the direction of the bullet to new target in range of richochet hurtbox,
## if one exists. 
## This method also avoids ping-ponging between the same two targets when there is 
## more than one viable ricochet target in range that is not the last hit creep.
func _handle_ricochet(damanged_creep: Creep):
	var detectable_creeps = __ricochet_detection_hurtbox.get_detectable_creeps_in_range()
	# Keep moving at the same velocity if there are no creeps in range.
	if detectable_creeps.is_empty():
		__last_damaged_creep = null
		return
	
	# Evaluate detecaable creeps in range
	# Handle case where there are multiple viable targets in ricochet range.
	var found_last_damaged_creep: bool = false
	var remaining_viable_targets: Array[Creep] = []
	# Populate extract values
	for creep_instance in detectable_creeps:
		# Elimitate the damaged creep from the list of viable targets
		if creep_instance == damanged_creep:
			continue
		# Check for last damaged creep
		if __last_damaged_creep and creep_instance == __last_damaged_creep:
			found_last_damaged_creep = true
			continue
		# Add to remaining viable targets list
		remaining_viable_targets.append(creep_instance)

	# Handle case where there are no other viable targets except for the last damaged creep.
	if remaining_viable_targets.is_empty() and found_last_damaged_creep:
		# Set target to last damaged creep
		__target = __last_damaged_creep
		# Replace the last damaged creep with the damaged creep.
		__last_damaged_creep = damanged_creep
		update_velocity_towards_target()
		update_isometric_speed()
		return

	# Handle case where there are more than one viable ricochet target in range that is not the last hit creep.
	# Select a random target from the remaining viable targets.
	var random_ricochet_target: Creep = remaining_viable_targets[randi() % remaining_viable_targets.size()]
	# Replace the last damaged creep with the damaged creep.
	__last_damaged_creep = damanged_creep
	__target = random_ricochet_target
	update_velocity_towards_target()
	update_isometric_speed()

# Executes additional logic during the _ready() method
func _extended_onready():
	__curr_ricochets = 0
	# Create the ricochet detection hurtbox
	__ricochet_detection_hurtbox = ProjectileConstants.HURTBOX_PRELOAD.instantiate()
	add_child(__ricochet_detection_hurtbox)
	__ricochet_detection_hurtbox.set_base_radius(__ricochet_detection_radius)
	# Conneec the ricochet detection hurtbox's area exited signal
	__ricochet_detection_hurtbox.area_exited.connect(_on_ricochet_detection_hurtbox_exited)

## Inflicts damage to the specified creep and handles ricochet logic.
func _inflict_damange(creep: Creep):
	creep.take_damage(__damage)
	__curr_ricochets += 1
	# Destroy the bullet if it has reached the maximum ricochets
	# If infinite ricochets are enabled, the bullet will not be destroyed
	if !__infinite_ricochets and __curr_ricochets == __total_ricochets:
		queue_free()
		return

	# Handle ricochet
	_handle_ricochet(creep)


func _on_hurtbox_entered(area):
	if !area.get_parent() is Creep:
		return
	var entered_creep: Creep = area.get_parent()
	if !entered_creep.is_detectable():
		return
	# Inflict damage on the creep
	_inflict_damange(entered_creep)

func _on_ricochet_detection_hurtbox_exited(area):
	if !area.get_parent() is Creep:
		return
	var exited_creep: Creep = area.get_parent()
	if exited_creep == __last_damaged_creep:
		__last_damaged_creep = null

# *******
# SETTERS
# *******

func set_damage(amount: int):
	__damage = amount
