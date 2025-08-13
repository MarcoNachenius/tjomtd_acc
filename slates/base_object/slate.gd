extends Node2D
class_name Slate

# CONSTANTS
const NODE_Z_INDEX: int = 2
const SPRITE_Z_INDEX: int = 0
const SPRITE_Z_AS_RELATIVE: bool = false

# EXPORTS
@export var SLATE_ID: SlateConstants.SlateIDs
@export var SLATE_SPRITE: Sprite2D

# PRIVATE VARS
var __placement_grid_coord: Vector2i

# INHERITED METHODS
# =================
func _ready() -> void:
    # Ensure sprite has been assigned
    assert(SLATE_SPRITE, "SLATE_SPRITE must be assigned in the editor.")

    # Assign z and y ordering for all components
    _handle_ordering()


# PRIVATE METHODS
# ===============
## Handles ordering and y-sorting for base node and all of its components.
func _handle_ordering():
    # Base node
    y_sort_enabled = true
    z_as_relative = false

    # Slate sprite
    SLATE_SPRITE.y_sort_enabled = true
    SLATE_SPRITE.z_as_relative = SPRITE_Z_AS_RELATIVE
    SLATE_SPRITE.z_index = SPRITE_Z_AS_RELATIVE


# GETTERS
# =======
## Returns the tower's placement grid coordinate on the map.
func get_placement_grid_coordinate() -> Vector2i:
    return __placement_grid_coord


# SETTERS
# =======
## Sets the tower's placement grid coordinate on the map.
func set_placement_grid_coordinate(new_placement_grid_coord: Vector2i) -> void:
    __placement_grid_coord = new_placement_grid_coord