extends Node

# HURTBOX/HITBOX COLLISION SHAPE
# ==============================
# More points = Smoother oval collision shape
const COLLISION_SHAPE_PRECISION: int = 16


# START NEW GAME
# ==============
const STARTING_LIVES: int = 20
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