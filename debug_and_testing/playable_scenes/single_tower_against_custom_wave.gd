extends Node2D

@export var GAME_MAP: GameMap
@export var TOWER_ID: TowerConstants.TowerIDs
@export var TOWER_PLACEMENT_COORD: Vector2i

func _ready():
	_place_single_tower()
	GAME_MAP.CREEP_SPAWNER.initiate_final_boss_wave()

func _place_single_tower():
	# Place tower impediment points
	GAME_MAP.place_tower_impediment_points(TOWER_PLACEMENT_COORD)
	
	# Create new tower instance
	var new_tower: Tower = TowerConstants.ALL_TOWER_LOADS[TOWER_ID].instantiate()
	new_tower.set_placement_grid_coordinate(TOWER_PLACEMENT_COORD)
	GAME_MAP.add_child(new_tower)
	new_tower.position = GAME_MAP.__placement_grid.map_to_local(TOWER_PLACEMENT_COORD)

	# Update tower placement grid dict
	GAME_MAP._add_tower_to_placement_grid_coords_dict(new_tower, GAME_MAP.__placement_grid_coords_for_towers)

	# Create tower selection area
	var new_tower_selection_area: TowerSelectionArea = TowerConstants.TOWER_SELECTION_AREA_PRELOAD.instantiate()
	new_tower_selection_area.set_referenced_tower(new_tower)
	new_tower.add_child(new_tower_selection_area)
	new_tower.set_selection_area(new_tower_selection_area)

	# Emit signals
	GAME_MAP.tower_placed.emit(new_tower)
	# Add to appropriate barricade list
	if new_tower.TOWER_ID == TowerConstants.TowerIDs.BARRICADE:
		GAME_MAP.__barricades_on_map.append(new_tower)
	else: # OR ddd to appropriate towers awaiting slection list
		GAME_MAP.__towers_awaiting_selection.append(new_tower)
	
	# Switch state 
	new_tower.switch_state(Tower.States.BUILT)
	
	new_tower.RANGE_DISPLAY_SHAPE.visible = true


func _on_exit_game_pressed() -> void:
	get_tree().quit()
