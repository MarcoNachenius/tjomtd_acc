extends Node

# INSTANCES
# =========
enum CreepIDs {
    RED_SPIDER,
    DEMON,
    CENTIPEDE
}

var CreepPreloads: Dictionary[CreepIDs, PackedScene] = {
    CreepIDs.RED_SPIDER: load("res://creeps/red_spider/red_spider.tscn"),
    CreepIDs.DEMON: load("res://creeps/demon/demon.tscn"),
    CreepIDs.CENTIPEDE: load("res://creeps/centipede/centipede.tscn")
}


# MOVEMENT
# ========
enum CompassDirections {
    EAST,
    WEST,
    NORTH,
    NORTH_WEST,
    NORTH_EAST,
    SOUTH,
    SOUTH_WEST,
    SOUTH_EAST
}

const CompassDirToVelocities: Dictionary = {
    CompassDirections.EAST: Vector2(0.707, 0.354),
    CompassDirections.WEST: Vector2(-0.707, -0.354),
    CompassDirections.NORTH: Vector2(0.707, -0.354),
    CompassDirections.NORTH_WEST: Vector2(0, -0.5),
    CompassDirections.NORTH_EAST: Vector2(1 , 0),
    CompassDirections.SOUTH: Vector2(-0.707, 0.354),
    CompassDirections.SOUTH_WEST: Vector2(-1 , 0),
    CompassDirections.SOUTH_EAST: Vector2(0, 0.5)
}


const CompassDirToMovementAnimations: Dictionary = {
    CompassDirections.EAST: "move_e",
    CompassDirections.WEST: "move_w",
    CompassDirections.NORTH: "move_n",
    CompassDirections.NORTH_WEST: "move_nw",
    CompassDirections.NORTH_EAST: "move_ne",
    CompassDirections.SOUTH: "move_s",
    CompassDirections.SOUTH_WEST: "move_sw",
    CompassDirections.SOUTH_EAST:  "move_se"
}

const CompassDirToDeathAnimations: Dictionary = {
    CompassDirections.EAST: "death_e",
    CompassDirections.WEST: "death_w",
    CompassDirections.NORTH: "death_n",
    CompassDirections.NORTH_WEST: "death_nw",
    CompassDirections.NORTH_EAST: "death_ne",
    CompassDirections.SOUTH: "death_s",
    CompassDirections.SOUTH_WEST: "death_sw",
    CompassDirections.SOUTH_EAST:  "death_se"
}

const CompassDirToIdleAnimations: Dictionary = {
    CompassDirections.EAST: "idle_e",
    CompassDirections.WEST: "idle_w",
    CompassDirections.NORTH: "idle_n",
    CompassDirections.NORTH_WEST: "idle_nw",
    CompassDirections.NORTH_EAST: "idle_ne",
    CompassDirections.SOUTH: "idle_s",
    CompassDirections.SOUTH_WEST: "idle_sw",
    CompassDirections.SOUTH_EAST:  "idle_se"
}

const CompassDirToStr: Dictionary = {
    CompassDirections.EAST: "e",
    CompassDirections.WEST: "w",
    CompassDirections.NORTH: "n",
    CompassDirections.NORTH_WEST: "nw",
    CompassDirections.NORTH_EAST: "ne",
    CompassDirections.SOUTH: "s",
    CompassDirections.SOUTH_WEST: "sw",
    CompassDirections.SOUTH_EAST:  "se"
}


# COMPONENTS
# ==========
var HITBOX_PRELOAD: PackedScene = load("res://creeps/components/hitbox/creep_hitbox.tscn")