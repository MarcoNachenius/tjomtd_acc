extends ProjectileSpawner
class_name StunAura

@export var STUN_ALL_TARGETS_IN_RAGE: bool = false
@export var MAX_CREEPS_PER_STUN: int = 1
@export var STUN_DURATION: float = 1.5

func _ready() -> void:
    assert(STUN_DURATION > 0, "Stun duration must be greater than 0")
    assert(MAX_CREEPS_PER_STUN > 0, "Max creeps per stun must be greater than 0")
    assert(STUN_ALL_TARGETS_IN_RAGE or MAX_CREEPS_PER_STUN > 0, "Either STUN_ALL_TARGETS_IN_RAGE must be true or MAX_CREEPS_PER_STUN must be greater than 0")

func _launch_projectiles():
    # Fetch list of available targets
    var available_targets: Array[Creep] = __hurtbox.get_detectable_creeps_in_range()

    # Handle stunning of all creeps in range
    if STUN_ALL_TARGETS_IN_RAGE:
        for viable_creep in available_targets:
            viable_creep.stun(STUN_DURATION)
        return
    
    # Handle stunning of specified number of creeps
    if !STUN_ALL_TARGETS_IN_RAGE:
        var num_of_creeps_stunned: int = 0
        for viable_creep in available_targets:
            viable_creep.stun(STUN_DURATION)
            num_of_creeps_stunned += 1
            if num_of_creeps_stunned >= MAX_CREEPS_PER_STUN:
                break
        return