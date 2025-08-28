extends Node2D

@export var GAME_MAP: GameMap

func _ready() -> void:
    # LARIMAR_LVL_2
    # Simulate autoload being assigned to required tower
    GAME_MAP.__build_tower_preload = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.LARIMAR_LVL_2]
    # Simulate tower being placed on map (placement grid coord is arbitrary)
    GAME_MAP.place_tower(Vector2i(5, 5))
    # LARIMAR_LVL_3
    # Simulate autoload being assigned to required tower
    GAME_MAP.__build_tower_preload = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.LARIMAR_LVL_3]
    # Simulate tower being placed on map (placement grid coord is arbitrary)
    GAME_MAP.place_tower(Vector2i(5, 7))
    # SUNSTONE_LVL_4
    # Simulate autoload being assigned to required tower
    GAME_MAP.__build_tower_preload = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.BuildTowerIDs.SUNSTONE_LVL_4]
    # Simulate tower being placed on map (placement grid coord is arbitrary)
    GAME_MAP.place_tower(Vector2i(5, 9))