extends Node2D
class_name ProjectileSlowEffectHandler

var CONNECTED_CREEP: Creep
var CONNECTED_PROJECTILE: Projectile
var SLOW_TIME: float
var SLOW_PERCENTAGE: int

func set_connected_creep(creep: Creep):
    assert(creep, "Null type creep provided.")
    CONNECTED_CREEP = creep

func set_connected_projectile(projectile: Projectile):
    assert(projectile, "Invalid null instance of projectile provided")
    CONNECTED_PROJECTILE = projectile
    CONNECTED_PROJECTILE.creep_hit.connect(_on_damage_inflicted)


func _on_damage_inflicted(creep):
    pass
