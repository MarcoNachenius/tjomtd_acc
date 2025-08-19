extends ProjectileSpawner
class_name SlowAura
## If true, any and all detectable creeps in range will be slowed.
@export var SLOW_ALL_CREEPS_IN_RANGE: bool = true
## Sets max number of creeps in range that may be slowed at a time.
@export var MAX_SIMULTANEOUS_TARGETS: int
@export var SLOW_PERCENTAGE: int


var __slow_duration: float

func _execute_extended_onready_commands():
    # Slow auras do not have damage by default, so damage buffs are not applicable.
    ALLOW_DAMAGE_BUFFS = false

    if !SLOW_ALL_CREEPS_IN_RANGE:
        assert(MAX_SIMULTANEOUS_TARGETS > 0, "MAX_SIMULTANEOUS_TARGETS set to 0 when SLOW_ALL_CREEPS_IN_RANGE is false")
    if SLOW_PERCENTAGE <= 0 or SLOW_PERCENTAGE > 100:
        assert(false, "SLOW_PERCENTAGE must be between 1 and 100")
    
    # Ensure the slow duration is slightly less than the cooldown duration to prevent immediate reapplication
    assert(__cooldown_duration > 0, "Cooldown duration must be greater than 0")
    __slow_duration = __cooldown_duration - 0.1

func _launch_projectiles():
    # Fetch list of available targets
    var available_targets: Array[Creep] = __hurtbox.get_detectable_creeps_in_range()

    # Handle slowing of all creeps in range
    if SLOW_ALL_CREEPS_IN_RANGE:
        for viable_creep in available_targets:
            viable_creep.slow(SLOW_PERCENTAGE, __slow_duration)
        return

    # Handle slowing of specified number of creeps
    if !SLOW_ALL_CREEPS_IN_RANGE:
        var num_of_creeps_slowed: int = 0
        for viable_creep in available_targets:
            viable_creep.slow(SLOW_PERCENTAGE, __slow_duration)
            num_of_creeps_slowed += 1
            if num_of_creeps_slowed >= MAX_SIMULTANEOUS_TARGETS:
                break
        return