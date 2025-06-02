extends Node

# HURTBOX/HITBOX COLLISION SHAPE
# ==============================
# More points = Smoother oval collision shape
const COLLISION_SHAPE_PRECISION: int = 16


# COMPLETE PACKED SCENE LOADS
# ============================
var GEM_TD_COMPLETE_BUILD: PackedScene = load("res://ui/complete_hud_builds_with_maps/completed_gem_td_hud.tscn")
var LINE_TD_COMPLETE_BUILD: PackedScene = load("res://ui/complete_hud_builds_with_maps/completed_line_td_hud.tscn")

# START NEW GAME
# ==============
const STARTING_LIVES: int = 3
const STARTING_BALANCE: int = 0
const MAX_PLACEABLE_TOWERS_PER_TURN = 5

# CAMERA
# ======
# Zoom Constants
const MAX_ZOOM = 2.0
const MIN_ZOOM = 0.1
const ZOOM_SPEED = 0.05


# HUD LOADS
# =========
enum HudTypes {
    RANDOM_TOWER_BUILD
}

var HUD_LOADS: Dictionary = {
    HudTypes.RANDOM_TOWER_BUILD: load("res://ui/hud/gameplay_huds/random_tower_build_hud/random_tower_build_hud.tscn")
}

# GAMEPLAY SETTINGS
# =================
## Controlls the max number of slow effects that can be active at the same time
## at any time on a creep. 
const MAX_SIMULTANEOUS_SLOW_EFFECTS = 2
## Controlls the max number of stun effects that can be active at the same time
## at any time on a creep. 
const MAX_SIMULTANEOUS_STUN_EFFECTS = 2