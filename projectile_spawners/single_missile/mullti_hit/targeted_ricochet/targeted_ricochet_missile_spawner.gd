extends ProjectileSpawner
class_name TargetedRicochetMissileSpawner

@export var __missile_damage: int
@export var __missile_speed: int
@export var MISSILE_LOAD: ProjectileConstants.TargetedRicochetMissiles
## If set to true, the missile will lose damage every time it hits a creep.
@export var __damage_degredation_enabled: bool = false
## The rate at which the missile loses damage after hitting a creep.
@export var __damage_degredation_rate: int
@export var __infinite_ricochets: bool = false
@export var __ricochet_detection_radius: int = 100
@export var __total_ricochets: int = 3

func _launch_projectiles():
	# Create missile
	var new_missile: TargetedRicochetMissile = ProjectileConstants.TARGETED_RICOCHET_MISSILE_LOADS[MISSILE_LOAD].instantiate()
	add_child(new_missile)
	# set Target
	assert(__target, "No target provided")
    # Set Target
	new_missile.set_target(__target)
	# set Damage
	new_missile.set_damage(__missile_damage)
	# set Speed
	new_missile.set_speed(__missile_speed)
	# set Damage Degradation
	new_missile.set_damage_degredation_enabled(__damage_degredation_enabled)
	# set Damage Degradation Rate
	new_missile.set_damage_degredation_rate(__damage_degredation_rate)
	# set Infinite Ricochets
	new_missile.set_infinite_ricochets(__infinite_ricochets)
	# set Ricochet Detection Radius
	new_missile.set_ricochet_detection_radius(__ricochet_detection_radius)
	# set Total Ricochets
	new_missile.set_total_ricochets(__total_ricochets)