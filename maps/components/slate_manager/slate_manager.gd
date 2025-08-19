extends Node
class_name SlateManager

# CONSTANTS

# PRIVATE VARS
@onready var __slates_on_map: Array[Slate] = []

# PRIVATE METHODS
# ===============

# PUBLIC METHODS
# ==============

## Adds a Slate instance to the map's Slate list.
## Ensures that no duplicates are added.
func add_slate_to_map(slate: Slate) -> void:
    # Ensure the Slate does not already exist in the array.
    assert(not __slates_on_map.has(slate), "Attempted to add a duplicate slate to __slates_on_map")
    
    # Append the Slate to the array.
    __slates_on_map.append(slate)

## Removes a Slate instance from the map's Slate list.
func remove_slate_from_map(slate: Slate) -> void:
    # Does nothing if slate is not in array by design
    __slates_on_map.erase(slate)


# GETTERS
# =======
## Returns a read-only copy of the array of Slates currently on the map.
## This prevents external code from directly modifying the internal array.
func get_slates_on_map() -> Array[Slate]:
    # Return a duplicate so that outside code can't alter the original array directly.
    return __slates_on_map


# SETTERS
# =======
