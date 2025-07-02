extends ProjectileSpawner
class_name HealthDrainer

## If true, any and all detectable creeps in range will be damaged.
@export var DAMAGE_ALL_CREEPS_IN_RANGE: bool = true
## Sets max number of creeps in range that may be damaged at a time.
## Note: DAMAGE_ALL_CREEPS_IN_RANGE must be set to false in order for this to take effect.
@export var MAX_SIMULTANEOUS_TARGETS: int
@export var __damage: int


func _launch_projectiles():
	# Fetch list of available targets
	var available_targets: Array[Creep] = __hurtbox.get_detectable_creeps_in_range()

	# Handle damage to all creeps in range
	if DAMAGE_ALL_CREEPS_IN_RANGE:
		for viable_creep in available_targets:
			# Damage creep without playing sound effect
			viable_creep.take_damage(__damage, false)
		return
	
	# Handle damage to specified number of creeps
	if !DAMAGE_ALL_CREEPS_IN_RANGE:
		var num_of_creeps_damaged: int = 0
		for viable_creep in available_targets:
			# Damage creep without playing sound effect
			viable_creep.take_damage(__damage, false)
			num_of_creeps_damaged += 1
			if num_of_creeps_damaged >= MAX_SIMULTANEOUS_TARGETS:
				break
		return


func _execute_extended_onready_commands():
	if !DAMAGE_ALL_CREEPS_IN_RANGE:
		assert(MAX_SIMULTANEOUS_TARGETS > 0, "MAX_SIMULTANEOUS_TARGETS set to 0 when DAMAGE_ALL_CREEPS_IN_RANGE is false")
