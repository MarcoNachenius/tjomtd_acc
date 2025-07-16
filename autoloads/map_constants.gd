extends Node

const MAP_TILE_WIDTH: int = 256
const MAP_TILE_HEIGHT: int = 128

enum MapID {
    LINE_TD = 1,
    GEM_TD = 2,
    BLANK_MAP = 3
}

# BLANK MAP
const BLANK_MAP_MANDATORY_WAYPOINTS: Array[Vector2i] = []
const BLANK_MAP_TILE_IMPEDIMENTS: Array[Vector2i] = []

# LINE TD
const LINE_TD_MANDATORY_WAYPOINTS: Array[Vector2i] = []
const LINE_TD_MAP_TILE_IMPEDIMENTS: Array[Vector2i] = []

## Does not include start or end points
const MandatoryWaypoints = {
    MapID.LINE_TD: LINE_TD_MANDATORY_WAYPOINTS,
    MapID.GEM_TD: GEM_TD_MANDATORY_WAYPOINTS,
    MapID.BLANK_MAP: BLANK_MAP_MANDATORY_WAYPOINTS,
}

const MapTileImpediments = {
    MapID.LINE_TD: LINE_TD_MAP_TILE_IMPEDIMENTS,
    MapID.GEM_TD: GEM_TD_MAP_TILE_IMPEDIMENTS,
    MapID.BLANK_MAP: BLANK_MAP_TILE_IMPEDIMENTS,
}


var PROJECTILE_BOUNDARY_AREA_PRELOAD: PackedScene = load("res://maps/components/projectile_boundary_area/projectile_boundary_area.tscn")

# PLACEMENT SPRITES
const PLACEMENT_TILE_TRANSPARENCY: float = 0.5
var SINGLE_POINT_IMPEDIMENT_RED_SURFACE = load("res://maps/sprites/tiles/red_surface_main_grid.tscn")
var TOWER_PLACEMENT_RED_SURFACE = load("res://maps/sprites/tiles/red_surface_map_grid.tscn")
var TOWER_PLACEMENT_GREEN_SURFACE = load("res://maps/sprites/tiles/green_surface_map_grid.tscn")
var TOWER_PLACEMENT_INSUFFICIENT_BALANCE_SURFACE = load("res://maps/sprites/tiles/insufficient_funds_tower_build.tscn")


# Gem TD Waypoints
# (main grid coordinates)
const GTD_WP_1 = Vector2i(23, 14)
# 1 tile left, 27 tiles down
const GTD_WP_2 = GTD_WP_1 + Vector2i(-1, 27)
# 49 tiles right 
const GTD_WP_3 = GTD_WP_2 + Vector2i(49, 0)
# 27 tiles up
const GTD_WP_4 = GTD_WP_3 + Vector2i(0, -27)
# 25 tiles left
const GTD_WP_5 = GTD_WP_4 + Vector2i(-25, 0)
# 53 tiles up
const GTD_WP_6 = GTD_WP_5 + Vector2i(0, 53)
const GEM_TD_MANDATORY_WAYPOINTS: Array[Vector2i] = [GTD_WP_1, GTD_WP_2, GTD_WP_3, GTD_WP_4, GTD_WP_5, GTD_WP_6]


var GEM_TD_MAP_LOAD = load("res://maps/gem_td/gem_td.tscn")

## Does not include start or end points
const GEM_TD_MAP_TILE_IMPEDIMENTS: Array[Vector2i] = [
    # Waypoint 1
    Vector2i(10, 7),
    Vector2i(11, 7),
    Vector2i(11, 8),
    # Waypoint 2
    Vector2i(11, 19),
    Vector2i(11, 20),
    Vector2i(12, 20),
    # Waypoint 3
    Vector2i(34, 20),
    Vector2i(35, 20),
    Vector2i(35, 19),
    # Waypoint 4
    Vector2i(35, 8),
    Vector2i(35, 7),
    Vector2i(34, 7),
    # Waypoint 5
    Vector2i(24, 7),
    Vector2i(23, 7),
    Vector2i(23, 8),
    # Waypoint 6
    Vector2i(23, 32),
    Vector2i(23, 33),
    Vector2i(24, 33)
]