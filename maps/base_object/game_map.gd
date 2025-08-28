extends TileMapLayer
class_name GameMap

# ENUMS
enum ImpedimentPlacementTypes {
	SINGLE_POINT,
	TOWER
}

enum States {
	INACTIVE,
	BUILD_MODE,
	NAVIGATION_MODE
}

# SIGNALS
signal camera_moved(distance: Vector2)
signal balance_altered(remaining_balance: int)
signal lost_life(remaining_lives: int)
signal completed_wave(total_waves_completed: int)
signal tower_placed(tower: Tower)
signal tower_selected(tower: Tower)
signal maze_length_updated(updated_maze_length: int)
signal lives_depleted
signal final_boss_path_completed(total_damage_taken: int, maze_completion_time: float)
signal slate_placed

# EXPORTS
## Map ID
@export var MAP_ID: MapConstants.MapID
## Number of map tiles
@export var MAP_HEIGHT: int
## Number of map tiles
@export var MAP_WIDTH: int
## Show mob path
@export var __path_line_visible: bool
## Main grid coodrinate.
@export var __path_end_point: Vector2i
## Main grid coodrinate.
@export var __path_start_point: Vector2i

# PRIVATE VARS
# ============
var __astar_grid: AStarGrid2D
var __build_tower_preload: PackedScene
var __build_tower_cost: int
var __barricades_on_map: Array[Tower]
var __curr_balance: int
var __curr_path: Array[Vector2i]
var __curr_state: States
var __impediment_placement_type: ImpedimentPlacementTypes = ImpedimentPlacementTypes.TOWER
var __insufficient_balance_surface_highlight: Sprite2D
var __invalid_build_position_surface_highlight: Sprite2D
var __mandatory_waypoints: Array[Vector2i]
var __main_tileset: TileMapLayer
var __mouse_position: Vector2
var __path_impediments: Array[Vector2i]
var __path_line: Line2D
var __placement_grid: TileMapLayer
var __placement_grid_coords_for_towers: Dictionary[Vector2i, Tower]
var __placement_grid_coords_for_barricades: Dictionary[Vector2i, Tower]
var __remaining_lives: int
var __total_active_creeps: int
var __total_active_wave_creeps: int
var __total_points_earned: int
var __total_waves_completed: int
var __towers_awaiting_selection: Array[Tower]
var __towers_on_map: Array[Tower]
var __valid_build_position_surface_highlight: Sprite2D

# SINGLETONS
# ==========
var CREEP_SPAWNER: CreepSpawner
var RANDOM_TOWER_GENERATOR: RandomTowerGenerator
var SLATE_MANAGER: SlateManager

# -----------------
# INHERITED METHODS
# -----------------
func _ready() -> void:
	__total_points_earned = 0
	__total_waves_completed = 0
	__total_active_creeps = 0
	__total_active_wave_creeps = 0
	__remaining_lives = GameConstants.STARTING_LIVES
	__curr_balance = GameConstants.STARTING_BALANCE
	__curr_state = States.NAVIGATION_MODE

	# CURRENT GAME DATA
	_reset_curr_game_data()

	# RANDOM TOWER GENERATOR
	_create_random_tower_generator()

	# TOWER PLACEMENT TILES
	self._create_tower_placement_validity_tiles()

	# ASTAR GRID
	self._create_astar_grid()

	# DERIVED TileMapLayerS
	self._create_main_tileset()
	self._create_placement_grid()

	# MANDATORY WAYPOINTS
	self._set_mandatory_waypoints()

	# MAP TILE IMPEDIMENTS
	self._set_map_tile_impediments()

	# CURRENT PATH
	self._update_current_path()

	# CREEP SPAWNER
	self._create_creep_spawner()

	# PROJECTILE BOUNDARY AREA
	self._create_projectile_boundary_area()

	# SLATE MANAGER
	_create_slate_manager()


func _unhandled_input(event) -> void:
	# Handle build mode
	if __curr_state == States.BUILD_MODE:
		_handle_build_mode(event)
	if __curr_state == States.NAVIGATION_MODE:
		_handle_navigation_mode()


# --------------
# PUBLIC METHODS
# --------------
## Returns a dictionary of which towers are awaiting selection, and how many of them have been placed.
func awaiting_selection_tower_count_dict() -> Dictionary[TowerConstants.TowerIDs, int]:
	var count_dict: Dictionary[TowerConstants.TowerIDs, int] = {}
	# Increment the count of a tower by 1 if it exists, or add new tower id and set it to 1 if it doesn't.
	for tower in __towers_awaiting_selection:
		count_dict[tower.TOWER_ID] = count_dict.get(tower.TOWER_ID, 0) + 1
	return count_dict

func add_test_single_point_path_impediment_sprite(mainGridTile: Vector2i) -> void:
	var path_tile = MapConstants.SINGLE_POINT_IMPEDIMENT_RED_SURFACE.instantiate()
	__main_tileset.add_child(path_tile)
	path_tile.position = __main_tileset.map_to_local(mainGridTile)

func add_test_tower_sprite(placementGridTile: Vector2i) -> void:
	var path_tile = MapConstants.TOWER_PLACEMENT_RED_SURFACE.instantiate()
	add_child(path_tile)
	path_tile.position = __placement_grid.map_to_local(placementGridTile)
	path_tile.modulate = Color(0.0, 0.0, 0.0, 1.0)  # RGBA for solid blue

## Removes the tower from towers on map or towers awaiting selection.
func convert_tower_to_barricade(tower: Tower) -> void:
	# Ensure that the tower is in a list
	assert(__towers_on_map.has(tower) or __towers_awaiting_selection.has(tower), "Tower not in __towers_on_map list")
	var tower_placement_grid_coord: Vector2i = tower.get_placement_grid_coordinate()

	# EITHER remove tower from __towers_awaiting_selection
	if __towers_awaiting_selection.has(tower):
		__towers_awaiting_selection.erase(tower)
	else: # OR remove tower from __towers_on_map
		__towers_on_map.erase(tower)

	# Remove tower from placement grid coord dict for towers
	_remove_tower_from_placement_grid_coords_dict(tower, __placement_grid_coords_for_towers)

	# Remove tower scene from map
	tower.queue_free()

	place_barricade(tower_placement_grid_coord)

func remove_barricade(barricade: Tower) -> void:
	assert(barricade.TOWER_ID == TowerConstants.TowerIDs.BARRICADE, "Provided tower should be barricade")
	# Remove placement points
	_remove_tower_impediment_points(barricade.get_placement_grid_coordinate())
	# Remove from barricade dict
	_remove_tower_from_placement_grid_coords_dict(barricade, __placement_grid_coords_for_barricades)
	# Remove from barricade list
	assert(__barricades_on_map.has(barricade), "Barricade not found in __barricades_on_map")
	__barricades_on_map.erase(barricade)
	# Remove from scene
	barricade.queue_free()


func tower_count_dict_to_tower_id_array(tower_count_dict: Dictionary[TowerConstants.TowerIDs, int]) -> Array[TowerConstants.TowerIDs]:
	var tower_id_array: Array[TowerConstants.TowerIDs] = []
	# Iterate through the tower count dictionary
	for tower_id in tower_count_dict.keys():
		# Add the tower id to the array the number of times specified in the count
		for i in range(tower_count_dict[tower_id]):
			tower_id_array.append(tower_id)
	return tower_id_array

## Removes all creeps from the map
func remove_remaining_creeps() -> void:
	for child in get_children():
		if child is Creep:
			child.queue_free()

## Removes all projectiles still present on the map
func remove_remaining_projectiles() -> void:
	for tower in __towers_on_map:
		for tower_child in tower.get_children():
			# Ignore children that are not projectile spawners
			if !tower_child is ProjectileSpawner:
				continue
			for projectile_spawner_child in tower_child.get_children():
				if projectile_spawner_child is Projectile:
					projectile_spawner_child.queue_free()

## Updates current save file and writes it to disk.
func save_game() -> void:
	# Game map data
	# Balance
	GameDataStorage.ACTIVE_GAME_DATA.set_remaining_balance(__curr_balance)
	# Remaining lives
	GameDataStorage.ACTIVE_GAME_DATA.set_remaining_lives(__remaining_lives)
	# Barricades
	var barricade_positions: Array[Vector2i] = []
	for barricade in __barricades_on_map:
		barricade_positions.append(barricade.get_placement_grid_coordinate())
	GameDataStorage.ACTIVE_GAME_DATA.set_barricade_positions(barricade_positions)
	# Towers
	var tower_postion_to_tower_id: Dictionary[Vector2i, int] = {}
	for tower in __placement_grid_coords_for_towers.values():
		tower_postion_to_tower_id[tower.get_placement_grid_coordinate()] = tower.TOWER_ID
	GameDataStorage.ACTIVE_GAME_DATA.set_placed_towers(tower_postion_to_tower_id)
	# Creep spawner data
	CREEP_SPAWNER.update_wave_data()
	# Build level
	GameDataStorage.ACTIVE_GAME_DATA.build_level = RANDOM_TOWER_GENERATOR.get_curr_level()
	# Write updated data to disk
	GameDataStorage.save_game_data()

## Loads game data from disk.
func load_game() -> void:
	# Place towers
	var tower_coord_to_id_dict: Dictionary[Vector2i, int] = GameDataStorage.ACTIVE_GAME_DATA.get_placed_towers()
	for placement_coord in tower_coord_to_id_dict.keys():
		var tower_id = tower_coord_to_id_dict[placement_coord]
		place_built_tower(placement_coord, tower_id)
	
	# Place barricades
	for barricade_placement_coord in GameDataStorage.ACTIVE_GAME_DATA.get_barricade_positions():
		place_barricade(barricade_placement_coord, true)
	
	# Build level
	RANDOM_TOWER_GENERATOR.load_level(GameDataStorage.ACTIVE_GAME_DATA.build_level)

	# Remaining lives
	__remaining_lives = GameDataStorage.ACTIVE_GAME_DATA.get_remaining_lives()

	# Balance
	__curr_balance = GameDataStorage.ACTIVE_GAME_DATA.get_remaining_balance()

	# Wave number
	CREEP_SPAWNER.load_wave_data()
	__total_waves_completed = GameDataStorage.ACTIVE_GAME_DATA.wave_number


# ---------------
# PRIVATE METHODS
# ---------------
func _create_slate_manager() -> void:
	var new_slate_manager_instance: SlateManager = SlateManager.new(self)
	add_child(new_slate_manager_instance)
	SLATE_MANAGER = new_slate_manager_instance

## Adds placement grid points as keys with provided tower as value. 
func _add_tower_to_placement_grid_coords_dict(tower: Tower, placementGridCoordDict: Dictionary[Vector2i, Tower]) -> void:
	# Get list of all current impediment points 
	var list_of_curr_impediment_points: Array[Vector2i] = placementGridCoordDict.keys()
	# Get list of tower impediment points
	var tower_impediment_points: Array[Vector2i] = get_tower_impediment_points(tower.get_placement_grid_coordinate())
	
	# Insert new values into grid coords for towers
	for new_placement_coord in tower_impediment_points:
		# Ensure coordinate is not already a key in coord dict
		assert(!list_of_curr_impediment_points.has(new_placement_coord))
		# New value to dict
		placementGridCoordDict[new_placement_coord] = tower


## Replaces the values of placement grid coordinates for a tower in the placement grid coords for towers 
func _replace_tower_in_placement_grid_coords_dict(oldTower: Tower, newTower: Tower, placementGridCoordDict: Dictionary[Vector2i, Tower]) -> void:
	# Verify that the old tower's placement grid coordinate is equal to the new tower's placement grid coordinate
	assert(oldTower.get_placement_grid_coordinate() == newTower.get_placement_grid_coordinate(), "Old and new tower placement grid coordinates do not match")

	# Get list of all current impediment points 
	var list_of_curr_impediment_points: Array[Vector2i] = placementGridCoordDict.keys()
	# Get list of tower impediment points
	var tower_impediment_points: Array[Vector2i] = get_tower_impediment_points(oldTower.get_placement_grid_coordinate())
	
	# Replace values in grid coords dict for towers
	for new_placement_coord in tower_impediment_points:
		# Ensure coordinate is present in dict
		assert(list_of_curr_impediment_points.has(new_placement_coord), "Coordinate not in placement grid coord dict")
		# Replace values such that placement coord refers to new tower
		placementGridCoordDict[new_placement_coord] = newTower


## Adds placement grid points as keys with provided tower as value. 
func _remove_tower_from_placement_grid_coords_dict(tower: Tower, placementGridCoordDict: Dictionary[Vector2i, Tower]) -> void:
	# Get list of all current impediment points 
	var list_of_curr_impediment_points: Array[Vector2i] = placementGridCoordDict.keys()
	# Get list of tower impediment points
	var tower_impediment_points: Array[Vector2i] = get_tower_impediment_points(tower.get_placement_grid_coordinate())
	
	# Remove keys from placement coord dict
	for new_placement_coord in tower_impediment_points:
		# Ensure coordinate is a key in coord dict
		assert(list_of_curr_impediment_points.has(new_placement_coord), "Impediment coordinate not containedd in placement grid dict")
		# Remove coordinate from dict
		placementGridCoordDict.erase(new_placement_coord)

## Check if adding a new solid point blocks the path.
## Do not use in for loop, rather use can_add_multiple_impediments()
func can_add_single_point_impediment(mainGridPoints: Vector2i) -> bool:
	# Temporarily add impediment to astar grid
	__astar_grid.set_point_solid(mainGridPoints)
	# Generate possible alternative path
	var alternative_path = __astar_grid.get_id_path(__path_start_point, __path_end_point)
	# Remove temporary impediment from astar grid
	__astar_grid.set_point_solid(mainGridPoints, false)

	return len(alternative_path) > 0

## Determines if a tower can be placed at the specified placement grid point without blocking the path.
func can_place_tower(placementGridPoint: Vector2i) -> bool:
	var normal_grid_points: Array[Vector2i] = self.get_tower_impediment_points(placementGridPoint)
	# Check for coordinates that fall outside the map boundries
	for point in normal_grid_points:
		# Check if the points are within the valid width range of the map
		if point.x < 0 or point.x > (MAP_WIDTH * 2) - 1:
			return false
		# Check if the points are within the valid height range of the map
		if point.y < 0 or point.y > (MAP_HEIGHT * 2) - 1:
			return false
	# Check if the points are already occupied
		if __path_impediments.has(point):
			return false

	# Temporarily add impediments to astar grid
	for point in normal_grid_points:
		__astar_grid.set_point_solid(point, true)

	# Generate possible alternative path.
	var alternative_path = []
	for i in range(__mandatory_waypoints.size() - 1):
		var from_point: Vector2i = __mandatory_waypoints[i]
		var to_point: Vector2i = __mandatory_waypoints[i + 1]
		var path_segment = __astar_grid.get_id_path(from_point, to_point)
		# When one segment of the creep path is not possible, it can
		# be concluded that there is no viable path. 
		if path_segment.size() == 0:
			alternative_path = []
			break
		if !alternative_path.is_empty():
			alternative_path.resize(alternative_path.size() - 1)
		alternative_path.append_array(path_segment)

	# Remove temporary impediments from astar grid
	for point in normal_grid_points:
		__astar_grid.set_point_solid(point, false)

	return alternative_path.size() != 0

## Clears the build tower values, resetting the preload and cost to their default values.
func clear_build_tower_values():
	__build_tower_preload = null
	__build_tower_cost = 0

## Initializes the AStar grid for pathfinding on the map. 
## The grid dimensions are set to double the map's width and height, allowing 
## finer granularity for placement and movement, such as units that can occupy 
## positions halfway between tiles, similar to Warcraft 3 building placement.
func _create_astar_grid() -> void:
	# Create a new instance of AStarGrid2D for pathfinding.
	__astar_grid = AStarGrid2D.new()
	__astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	# Validate that map dimensions are properly assigned.
	# The map height and width are crucial for defining the grid's size.
	assert(MAP_HEIGHT, "No map height (self.MAP_HEIGHT) has been assigned.")
	assert(MAP_WIDTH, "No map width (self.MAP_WIDTH) has been assigned.")

	# Set the region of the AStar grid.
	# The grid dimensions are doubled to allow more precise positioning
	# for units and buildings that can occupy half-tile spaces.
	__astar_grid.region = Rect2i(0, 0, MAP_WIDTH * 2, MAP_HEIGHT * 2)

	# Enable path jumping for the grid if the feature is configured.
	# This setting allows units to "jump" over specific obstacles as defined
	# by the pathfinding logic, enhancing pathing flexibility.
	__astar_grid.jumping_enabled = true

	# Commit the grid configuration to apply the changes.
	__astar_grid.update()

## Creates the main grid (TileMapLayer) for the map, setting up its properties from scratch 
## and adding it to the scene. This method ensures that the TileMapLayer aligns properly 
## with the map's tile structure and is configured for isometric gameplay.
func _create_main_tileset() -> void:
	# Create a new TileMapLayer instance to represent the map's main grid.
	var new_tile_map = TileMapLayer.new()

	# Position the new TileMapLayer such that its (0, 0) tile's center aligns with 
	# the top-left corner of the (0, 0) tile in the map's grid. This ensures
	# proper alignment between the TileMapLayer and the overall map layout.
	new_tile_map.position = Vector2(self.tile_set.tile_size.x / 4, 0)

	# Create a new TileSet to define the visual and structural properties of the tiles.
	var new_tileset = TileSet.new()
	new_tile_map.tile_set = new_tileset

	# Configure the TileSet for isometric gameplay:
	# - Set the tile shape to isometric to align with the game's design.
	# - Use a diamond-down layout for proper rendering of isometric tiles.
	new_tileset.tile_shape = new_tileset.TILE_SHAPE_ISOMETRIC
	new_tileset.tile_layout = new_tileset.TILE_LAYOUT_DIAMOND_DOWN

	# Set the tile size to half of the original tile size, enabling finer
	# navigation and ensuring that four navigation tiles fit into one map tile.
	new_tileset.tile_size = self.tile_set.tile_size / 2

	# Assign the newly created TileMapLayer to the __main_tileset variable for 
	# easy reference and to signify it as the primary tile map for the map.
	self.__main_tileset = new_tile_map

	# Add the TileMapLayer as a child node of the current scene, integrating it into 
	# the map structure and making it visible in the game world.
	add_child(new_tile_map)

## Constructs map's tower placement grid from scratch and adds it to scene.
func _create_placement_grid() -> void:
	var new_tile_map = TileMapLayer.new()
	# Build tileset
	var new_tileset = TileSet.new()
	new_tile_map.tile_set = new_tileset
	new_tileset.tile_shape = new_tileset.TILE_SHAPE_ISOMETRIC
	new_tileset.tile_layout = new_tileset.TILE_LAYOUT_DIAMOND_DOWN
	# Four navigation tiles must fit into one map tile
	new_tileset.tile_size = self.tile_set.tile_size/2
	# Assign TileMapLayer to __main_tileset
	self.__placement_grid = new_tile_map
	# Instantiate main tile grid as child of Map scene
	add_child(new_tile_map)

## Create a new instance of RandomTowerGenerator for generating random towers.
func _create_random_tower_generator():
	var new_generator = RandomTowerGenerator.new()
	add_child(new_generator)
	RANDOM_TOWER_GENERATOR = new_generator

## Creates red(invalid position) and green(valid position) surface areas
## that follow mouse during build mode.
func _create_tower_placement_validity_tiles() -> void:
	# Valid position tile
	__invalid_build_position_surface_highlight = MapConstants.TOWER_PLACEMENT_RED_SURFACE.instantiate() as Sprite2D
	__invalid_build_position_surface_highlight.visible = false
	# Set transparency
	__invalid_build_position_surface_highlight.modulate.a = MapConstants.PLACEMENT_TILE_TRANSPARENCY
	add_child(__invalid_build_position_surface_highlight)

	# Invalid position tile
	__valid_build_position_surface_highlight = MapConstants.TOWER_PLACEMENT_GREEN_SURFACE.instantiate() as Sprite2D
	__valid_build_position_surface_highlight.visible = false
	# Set transparency
	__valid_build_position_surface_highlight.modulate.a = MapConstants.PLACEMENT_TILE_TRANSPARENCY
	add_child(__valid_build_position_surface_highlight)

	# Insufficient balance tile
	__insufficient_balance_surface_highlight = MapConstants.TOWER_PLACEMENT_INSUFFICIENT_BALANCE_SURFACE.instantiate() as Sprite2D
	__insufficient_balance_surface_highlight.visible = false
	# Set transparency
	__insufficient_balance_surface_highlight.modulate.a = MapConstants.PLACEMENT_TILE_TRANSPARENCY
	add_child(__insufficient_balance_surface_highlight)

func creep_mapped_to_local_path_positions() -> Array[Vector2i]:
	var mapped_positions: Array[Vector2i] = []
	for point in __curr_path:
		mapped_positions.append(Vector2i(__main_tileset.map_to_local(point)) + Vector2i(64, 0))
	return mapped_positions

func switch_states(new_state: States) -> void:
	if __curr_state == new_state:
		return
	if new_state == States.BUILD_MODE:
		# Disable monitoring on selection
		__curr_state = States.BUILD_MODE
	if new_state == States.NAVIGATION_MODE:
		__curr_state = States.NAVIGATION_MODE
		# Hide all build mode tiles
		__valid_build_position_surface_highlight.visible = false
		__invalid_build_position_surface_highlight.visible = false

func update_path_line() -> void:
	# Avoid errors on path line instantiation
	if __path_line:
		__path_line.queue_free()
	# Create new line
	var new_path_line = Line2D.new()
	# Edit presentation
	new_path_line.z_index = 3
	new_path_line.y_sort_enabled = true
	new_path_line.default_color = Color.GREEN
	# Add points
	for point in __curr_path:
		new_path_line.add_point(__main_tileset.map_to_local(point))
	__main_tileset.add_child(new_path_line)
	# Add line
	__path_line = new_path_line
	__path_line.visible = __path_line_visible

## Retrurns coordinates for main tileset as [top_left, top_right, bottom_left, bottom_right].
## TOP RIGHT point of returned impediment points is equal to provided placement grid point
func get_tower_impediment_points(placementGridPoint: Vector2i) -> Array[Vector2i]:
	# Calculate the top-left grid point of the 2x2 area relative to the placement point.
	var top_left: Vector2i = Vector2i(placementGridPoint.x - 1, placementGridPoint.y)
	
	# Calculate the top-right grid point of the 2x2 area.
	var top_right: Vector2i = Vector2i(placementGridPoint.x, placementGridPoint.y)
	
	# Calculate the bottom-left grid point of the 2x2 area.
	var bottom_left: Vector2i = Vector2i(placementGridPoint.x - 1, placementGridPoint.y + 1)
	
	# Calculate the bottom-right grid point of the 2x2 area.
	var bottom_right: Vector2i = Vector2i(placementGridPoint.x, placementGridPoint.y + 1)
	
	# Create an array containing all four points that define the 2x2 area.
	var normal_grid_points: Array[Vector2i] = [top_left, top_right, bottom_left, bottom_right]
	
	# Return the array of grid points to the caller.
	return normal_grid_points

## Returns true if the a tower exists at the provided global position.
func tower_exists_at_global_position(globalPosition: Vector2) -> bool:
	# Convert the global position to the local coordinate space of the placement grid.
	var placement_grid_coord: Vector2i = __placement_grid.local_to_map(to_local(globalPosition))

	# Check if the placement grid coordinate is a key in the placement grid coordinates for towers dictionary.
	if __placement_grid_coords_for_towers.has(placement_grid_coord):
		return true

	# Check if the placement grid coordinate is a key in the placement grid coordinates for barricades dictionary.
	if __placement_grid_coords_for_barricades.has(placement_grid_coord):
		return true

	return false

## Returns tower to which the provided global position belongs.
## This method should be called only when tower_exists_at_global_position() returns true.
func get_tower_from_global_position(globalPosition: Vector2) -> Tower:
	# Convert the global position to the local coordinate space of the placement grid.
	var placement_grid_coord: Vector2i = __placement_grid.local_to_map(to_local(globalPosition))

	# Check if the placement grid coordinate is a key in the placement grid coordinates for towers dictionary.
	if __placement_grid_coords_for_towers.has(placement_grid_coord):
		return __placement_grid_coords_for_towers[placement_grid_coord]

	# Check if the placement grid coordinate is a key in the placement grid coordinates for barricades dictionary.
	if __placement_grid_coords_for_barricades.has(placement_grid_coord):
		return __placement_grid_coords_for_barricades[placement_grid_coord]

	return null


## Governs validity surface hightlights and impediment placements on map
func _handle_build_mode(event: InputEvent = null) -> void:
	match __impediment_placement_type:
		ImpedimentPlacementTypes.SINGLE_POINT:
			self.handle_single_point_impediment_placement()
		
		ImpedimentPlacementTypes.TOWER:
			self._handle_tower_placement(event)

## Handles the placement of a tower impediment by snapping the position to the grid and 
## displaying a placement highlight. The highlight changes color based on whether the 
## placement is valid. This ensures visual feedback for the player when positioning towers.
func _handle_tower_placement(event: InputEvent = null) -> void:
	# Hide surface highlights if touch has been released (Android)
	if event is InputEventScreenTouch and event.is_released():
		__valid_build_position_surface_highlight.visible = false
		__invalid_build_position_surface_highlight.visible = false
		return

	# Hide surface highlights if select button is not pressed down
	if !Input.is_action_pressed("select") and !Input.is_action_just_released("select"):
		__valid_build_position_surface_highlight.visible = false
		__invalid_build_position_surface_highlight.visible = false
		return

	# Get the current mouse position in the local coordinate space of the placement grid.
	var mouse_pos: Vector2 = get_local_mouse_position()
	
	# Convert the mouse position into the corresponding tile position on the grid.
	# This allows snapping the tower placement to the grid structure.
	var placement_tile_position: Vector2i = __placement_grid.local_to_map(mouse_pos)

	# Apply the tower placement offset to the tile position.
	# This offset places the tower slightly away from the cursor or touch position,
	# allowing for easier placement without overlapping the cursor.
	# See GameConstants.TOWER_PLACEMENT_OFFSET for more details.
	placement_tile_position += GameConstants.TOWER_PLACEMENT_OFFSET
	
	# Snap the calculated tile position back into local coordinates.
	# This ensures the tower or highlight aligns with the tile grid.
	var snap_to_grid_position: Vector2 = __placement_grid.map_to_local(placement_tile_position)
	
	# Check if the tower can be placed at the current position.
	var tower_placement_possible: bool = self.can_place_tower(placement_tile_position)

	# Determine the placement validity and update the visual feedback accordingly.
	if !tower_placement_possible:
		__invalid_build_position_surface_highlight.position = snap_to_grid_position
		__invalid_build_position_surface_highlight.visible = true
		__valid_build_position_surface_highlight.visible = false
	else:
		__valid_build_position_surface_highlight.position = snap_to_grid_position
		__valid_build_position_surface_highlight.visible = true
		__invalid_build_position_surface_highlight.visible = false
	
	# Handle placement action
	if Input.is_action_just_released("select") and __build_tower_preload and tower_placement_possible:
		self.place_tower(placement_tile_position)


func place_single_point_path_impediment(mainGridPoint: Vector2i) -> void:
	# Avoid duplicate coodrinates
	if !__path_impediments.has(mainGridPoint):
		__path_impediments.append(mainGridPoint)
	# Update astrar grid
	__astar_grid.set_point_solid(mainGridPoint)
	self._update_current_path()

## I want to make it clear here that I am not actually adding a tower to the scene, 
## rather I am simply adding the solid points to the main grid
func place_tower_impediment_points(placementGridPoint: Vector2i) -> void:
	var new_impediments: Array[Vector2i] = self.get_tower_impediment_points(placementGridPoint)
	for point in new_impediments:
		__astar_grid.set_point_solid(point)
		__path_impediments.append(point)
	# Update path line
	self._update_current_path()

## Resets mandatory path points if it already exists
func _set_mandatory_waypoints() -> void:
	var retrieved_mandatory_points: Array[Vector2i] = MapConstants.MandatoryWaypoints[MAP_ID]
	var new_mandatory_waypoints: Array[Vector2i] = []
	# Add path start point
	new_mandatory_waypoints.append(__path_start_point)

	# Handle additional mandatoy points
	if retrieved_mandatory_points.size() == 0: # No additional points given
		# Add path end point
		new_mandatory_waypoints.append(__path_end_point)
		__mandatory_waypoints = new_mandatory_waypoints
	else:# Assume additional points given
		for point in retrieved_mandatory_points:
			new_mandatory_waypoints.append(point)
		# Add path end point
		new_mandatory_waypoints.append(__path_end_point)
		__mandatory_waypoints = new_mandatory_waypoints
	
	# Add path impediments WITHOUT setting astar grid point solid
	# (Setting start point solid would make astar path generation impossible)
	for impediment in __mandatory_waypoints:
		__path_impediments.append(impediment)
	
	self._update_current_path()

## Updates the current path based on the mandatory waypoints, as
## well as the path line.
func _update_current_path() -> void:
	var updated_path: Array[Vector2i] = []
	for i in range(__mandatory_waypoints.size() - 1):
		# Construct path segment
		var from_point: Vector2i = __mandatory_waypoints[i]
		var to_point: Vector2i = __mandatory_waypoints[i + 1]
		var path_segment = __astar_grid.get_id_path(from_point, to_point)

		# Check for path blockage
		if path_segment.size() == 0:
			__curr_path = []
			# Create empty path line just in case show path line is called
			self.update_path_line()
			return
		
		# Avoid duplication of end point of one path segment with beginning of next segment
		if !updated_path.is_empty():
			# Remove last elemnt in array
			updated_path.resize(updated_path.size() - 1)
		
		# Add path segment to updated path
		updated_path.append_array(path_segment)

	# Perform update
	__curr_path = updated_path

	# Emit maze length updated signal
	maze_length_updated.emit(get_maze_length())

	# Update path line
	self.update_path_line()

## Restets all of the values in the CurrGameData autoload when a new map is loaded
func _reset_curr_game_data() -> void:
	CurrGameData.RESULT_TEXT = ""
	CurrGameData.FINAL_MAZE_LENGTH = 0.0
	CurrGameData.FINAL_MAZE_DAMAGE = 0.0
	CurrGameData.FINAL_MAZE_COMPLETION_TIME = 0.0
	CurrGameData.FINAL_SCORE = 0
	CurrGameData.WAVES_COMPLETED = 0

# -------------------
# GETTERS AND SETTERS
# -------------------
func get_towers_awaiting_selection() -> Array[Tower]:
	return __towers_awaiting_selection

func get_towers_on_map() -> Array[Tower]:
	return __towers_on_map

func get_total_points_earned() -> int:
	return __total_points_earned

# __path_line_visible
func show_path_line():
	self.__path_line_visible = true
	self.__path_line.visible = true
func hide_path_line():
	self.__path_line_visible = false
	self.__path_line.visible = false

# __curr_state
func set_state(new_state: States):
	__curr_state = new_state
func get_state() -> States:
	return __curr_state

# __build_tower_preload
func set_build_tower_preload(new_preload: PackedScene) -> void:
	__build_tower_preload = new_preload

# __build_tower_cost
func set_build_tower_cost(new_cost: int) -> void:
	__build_tower_cost = new_cost

func get_curr_balance() -> int:
	return __curr_balance

func get_total_waves_completed() -> int:
	return __total_waves_completed

func get_maze_length() -> int:
	var total_length := 0
	for i in range(1, __curr_path.size()):
		var from_point: Vector2i = __curr_path[i - 1]
		var to_point: Vector2i = __curr_path[i]
		total_length += round(from_point.distance_to(to_point))
	return total_length

# **************
# SIGNAL METHODS
# **************

func _on_creep_end_of_path_reached(creep: Creep) -> void:
	__remaining_lives -= 1
	
	if creep.FINAL_BOSS_MODE:
		# Time in seconds
		var maze_completion_time: float = creep.get_elapsed_travel_time()
		# When a final boss is spawned, it's health functions as a mechanism for
		# storing the total damage dealt to it.
		# See Creep.take_damage() for more details.
		var total_damage_taken: int = creep.get_curr_health()
		final_boss_path_completed.emit(total_damage_taken, maze_completion_time)
		return

	# Emit lives depleted signal if there are no more remaining lives
	if __remaining_lives < 1:
		lives_depleted.emit()
		return

	lost_life.emit(__remaining_lives)
	__total_active_creeps -= 1
	
	if !creep.get_is_wave_creep():
		return
	__total_active_wave_creeps -= 1
	if __total_active_wave_creeps == 0 and !CREEP_SPAWNER.wave_initiation_in_progress():
		__total_waves_completed += 1
		completed_wave.emit(__total_waves_completed)

func _on_creep_death(creep: Creep) -> void:
	var creep_points: int = creep.get_points_for_death()
	__curr_balance += creep_points
	__total_points_earned += creep_points
	balance_altered.emit(__curr_balance)
	
	if !creep.get_is_wave_creep():
		return
	__total_active_wave_creeps -= 1
	if __total_active_wave_creeps == 0 and !CREEP_SPAWNER.wave_initiation_in_progress():
		__total_waves_completed += 1
		completed_wave.emit(__total_waves_completed)

func _on_creep_spawned(creep: Creep) -> void:
	__total_active_creeps += 1
	if creep.get_is_wave_creep():
		__total_active_wave_creeps += 1



func get_map_tile_impediment_points(mapTileCoordinates: Vector2i) -> Array[Vector2i]:
	var top_left_main_grid_point: Vector2i = mapTileCoordinates * 2
	var top_right_main_grid_point: Vector2i = top_left_main_grid_point + Vector2i(1, 0)
	var bottom_left_main_grid_point: Vector2i = top_left_main_grid_point + Vector2i(0, 1)
	var bottom_right_main_grid_point: Vector2i = top_left_main_grid_point + Vector2i(1, 1)
	var impediment_points: Array[Vector2i] = [
		top_left_main_grid_point,
		top_right_main_grid_point,
		bottom_left_main_grid_point,
		bottom_right_main_grid_point
		]
	return impediment_points

func _set_map_tile_impediments() -> void:
	# Set start point as map tile impediment
	var start_point_map_tile_coord: Vector2i = local_to_map(__main_tileset.map_to_local(__path_start_point))
	var end_point_map_tile_coord: Vector2i = local_to_map(__main_tileset.map_to_local(__path_end_point))
	
	# Add start and end points to path impediments
	# Start point
	for point in get_map_tile_impediment_points(start_point_map_tile_coord):
		__path_impediments.append(point)
	# End point
	for point in get_map_tile_impediment_points(end_point_map_tile_coord + Vector2i(0, -1)):
		__path_impediments.append(point)
	for map_coord in MapConstants.MapTileImpediments[MAP_ID]:
		var impediment_points: Array[Vector2i] = get_map_tile_impediment_points(map_coord)
		for point in impediment_points:
			__path_impediments.append(point)

## Instantiates a barraciade at the specified grid position and updates the lists/dicts accordingly.
## Primarily used for loading game and debugging. 
func place_barricade(placementGridPoint: Vector2i, addImpedimentPoints: bool = false) -> void:
	if addImpedimentPoints:
		place_tower_impediment_points(placementGridPoint)
	# Place barricade
	var new_barricade: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BARRICADE].instantiate()
	add_child(new_barricade)

	# Ensure barricades do not appear as towers awaiting selection
	new_barricade.switch_state(Tower.States.BUILT)

	# Assign same placement grid coordinate and global position as the tower
	new_barricade.set_placement_grid_coordinate(placementGridPoint)
	new_barricade.position = __placement_grid.map_to_local(placementGridPoint)

	# Add barricade to list of those on map
	__barricades_on_map.append(new_barricade)

	# Add barricade placement coords 
	_add_tower_to_placement_grid_coords_dict(new_barricade, __placement_grid_coords_for_barricades)

## Instantiates a new tower at the specified grid position and adds it as a built tower.
## Does NOT handle barricades. Does not emit any signals. Primarily used for loading game and debugging.  
func place_built_tower(placementGridPoint: Vector2i, towerID: int) -> void:
	# Place tower impediment points
	place_tower_impediment_points(placementGridPoint)
	
	__build_tower_preload = TowerConstants.ALL_TOWER_LOADS[towerID]

	# Create new tower instance
	var new_tower: Tower = __build_tower_preload.instantiate()
	new_tower.set_placement_grid_coordinate(placementGridPoint)
	add_child(new_tower)
	new_tower.position = __placement_grid.map_to_local(placementGridPoint)
	

	# Update tower placement grid dict
	_add_tower_to_placement_grid_coords_dict(new_tower, __placement_grid_coords_for_towers)

	# Ensure tower is awaiting selection
	new_tower.switch_state(Tower.States.BUILT)

	# Add to list of towers awaiting selection
	__towers_on_map.append(new_tower)

## Instantiates a new tower at the specified grid position and adds it as a tower awaiting selection.
func place_tower(placementGridPoint: Vector2i) -> void:
	# Place tower impediment points
	place_tower_impediment_points(placementGridPoint)
	
	# Create new tower instance
	var new_tower: Tower = __build_tower_preload.instantiate()
	new_tower.set_placement_grid_coordinate(placementGridPoint)
	add_child(new_tower)
	new_tower.position = __placement_grid.map_to_local(placementGridPoint)
	
	# Ensure tower is awaiting selection
	new_tower.switch_state(Tower.States.AWAITING_SELECTION)

	# Update tower placement grid dict
	_add_tower_to_placement_grid_coords_dict(new_tower, __placement_grid_coords_for_towers)

	# Emit signals
	tower_placed.emit(new_tower)

	# Add to list of towers awaiting selection
	__towers_awaiting_selection.append(new_tower)

## Creates a new instance of CreepSpawner and adds it as a child to the current node.
## The CreepSpawner does not require positional information, as it will handled by the creep when spawned.
func _create_creep_spawner() -> void:
	var new_creep_spawner: CreepSpawner = CreepSpawner.new()
	add_child(new_creep_spawner)
	CREEP_SPAWNER = new_creep_spawner
	CREEP_SPAWNER.set_game_map(self)
	# Connect signal
	CREEP_SPAWNER.creep_spawned.connect(_on_creep_spawned)

func _create_projectile_boundary_area() -> void:
	var new_area = MapConstants.PROJECTILE_BOUNDARY_AREA_PRELOAD.instantiate() as ProjectileBoundaryArea
	var new_coll_shape = CollisionShape2D.new()
	var new_shape = ConvexPolygonShape2D.new()
	new_area.add_child(new_coll_shape)
	new_coll_shape.shape = new_shape

	var corner_offset: Vector2 = Vector2(0, MapConstants.MAP_TILE_HEIGHT/2)

	# Generate coordiantes of corners of the area
	var top_left_corner: Vector2 = map_to_local(Vector2i(0, 0)) - corner_offset
	var top_right_corner: Vector2 = map_to_local(Vector2i(MAP_WIDTH, 0)) - corner_offset
	var bottom_left_corner: Vector2 = map_to_local(Vector2i(0, MAP_HEIGHT)) - corner_offset
	var bottom_right_corner: Vector2 = map_to_local(Vector2i(MAP_WIDTH, MAP_HEIGHT)) - corner_offset
	add_child(new_area)

	# Set the shape points
	new_shape.points = [top_left_corner, top_right_corner, bottom_right_corner, bottom_left_corner]

## Removes the tower from the list of towers awaiting selection and adds it to the list of towers on the map.
## This method then moves the converts remaining towers awaiting selection (if any exist) to barricades.
func keep_built_tower_awaiting_selection(towerAwaitingSelection: Tower) -> void:
	# Ensure the tower is in the list of towers awaiting selection
	assert(__towers_awaiting_selection.has(towerAwaitingSelection), "Tower not found in list of towers awaiting selection")
	# Remove the tower from the list of towers awaiting selection
	__towers_awaiting_selection.erase(towerAwaitingSelection)
	# Add the tower to the list of towers on the map
	__towers_on_map.append(towerAwaitingSelection)
	# Set the tower's state to built
	towerAwaitingSelection.switch_state(Tower.States.BUILT)
	
	# Reselect tower to update hud containers
	tower_selected.emit(towerAwaitingSelection)

	# Convert remaining towers awaiting selection to barricades
	for tower in __towers_awaiting_selection.duplicate():
		# Convert the tower to a barricade
		self.convert_tower_to_barricade(tower)
	# Clear the list of towers awaiting selection
	__towers_awaiting_selection.clear()

## Called when a tower is selected for upgrade.
## This method removes the selected tower from the list of towers on the map and prepares it for upgrade.
## It also creates a new tower based on the provided upgrade tower ID and sets its position.
func upgrade_from_towers_on_map(selectedTower: Tower, upgradeTowerID: TowerConstants.UpgradeTowerIDs) -> void:
	# Ensure the upgrade tower ID is valid
	assert(TowerConstants.UpgradeTowerIDs.values().has(upgradeTowerID), "Invalid upgrade tower ID")
	# Ensure the tower is in the list of towers on map
	assert(__towers_on_map.has(selectedTower), "Tower not found in list of towers awaiting selection")
	
	# Capture the selected tower's placement grid coordinate and global position
	var tower_placement_grid_coord: Vector2i = selectedTower.get_placement_grid_coordinate()
	var tower_global_position: Vector2 = selectedTower.global_position

	# Construct array of required tower IDs
	var required_tower_ids: Array[TowerConstants.TowerIDs] = tower_count_dict_to_tower_id_array(TowerConstants.REQUIRES_TOWERS[upgradeTowerID])
	# Create list that will hold the towers that will be removed from the towers on map list
	var towers_to_remove: Array[Tower] = []

	# Remove tower id from the towers on map list
	required_tower_ids.erase(selectedTower.TOWER_ID)
	# Remove the selected tower from the list of towers on the map
	__towers_on_map.erase(selectedTower)
	# Remove tower scene from map
	selectedTower.queue_free()

	# Iterate through the remaining required tower IDs
	for tower_id in required_tower_ids.duplicate():
		# End loop once all required tower IDs have been found
		if required_tower_ids.is_empty():
			break
		for tower in __towers_on_map.duplicate():
			# Check if the tower ID matches the required tower ID
			if tower.TOWER_ID == tower_id:
				# Add the tower to the list of towers to remove
				towers_to_remove.append(tower)
				# Remove the tower id from the required tower ids array
				required_tower_ids.erase(tower_id)
				# Ensure only one tower can removed from the list of towers on map on each iteration
				break
	
	# Convert additional required towers to barricades
	for tower in towers_to_remove:
		convert_tower_to_barricade(tower)
	
	# Place the new upgrade tower
	var new_upgrade_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[upgradeTowerID].instantiate()
	add_child(new_upgrade_tower)
	
	# Set the upgrade tower's placement grid coordinate and global position
	new_upgrade_tower.set_placement_grid_coordinate(tower_placement_grid_coord)
	new_upgrade_tower.global_position = tower_global_position
	
	# Add tower to the list of towers on the map
	__towers_on_map.append(new_upgrade_tower)

	# Update the placement grid coordinates reference for the new tower
	_replace_tower_in_placement_grid_coords_dict(selectedTower, new_upgrade_tower, __placement_grid_coords_for_towers)

	# Ensure upgraded tower is not awaiting selection
	new_upgrade_tower.switch_state(Tower.States.BUILT)

	# Reselect tower to update hud containers
	tower_selected.emit(new_upgrade_tower)

## Called when an upgrade tower exists on the towers awaiting selection list.
func keep_upgrade_tower_from_towers_awaiting_selection(selectedTower: Tower, upgradeTowerID: TowerConstants.UpgradeTowerIDs) -> void:
	# Ensure the upgrade tower ID is valid
	assert(TowerConstants.UpgradeTowerIDs.values().has(upgradeTowerID), "Invalid upgrade tower ID")
	# Ensure the tower is in the list of towers awaiting selection
	assert(__towers_awaiting_selection.has(selectedTower), "Tower not found in list of towers awaiting selection")
	# Remove the tower from the list of towers awaiting selection
	__towers_awaiting_selection.erase(selectedTower)

	# Capture the tower's placement grid coordinate
	var tower_placement_grid_coord: Vector2i = selectedTower.get_placement_grid_coordinate()
	# Capture the tower's global position
	var tower_global_position: Vector2 = selectedTower.global_position

	# Remove towers from map scene
	selectedTower.queue_free()
	
	# Create new tower based on provided tower ID
	var new_upgrade_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[upgradeTowerID].instantiate()
	add_child(new_upgrade_tower)

	# Set upgrade tower placement grid coordinate and global position
	new_upgrade_tower.set_placement_grid_coordinate(tower_placement_grid_coord)
	new_upgrade_tower.global_position = tower_global_position
	
	# Set the tower's state to built
	new_upgrade_tower.switch_state(Tower.States.BUILT)
	
	# Add the tower to the list of towers on the map
	__towers_on_map.append(new_upgrade_tower)

	# Convert all towers awaiting selection to barricades
	for tower in __towers_awaiting_selection.duplicate():
		# Convert the tower to a barricade
		convert_tower_to_barricade(tower)
	# Clear the list of towers awaiting selection
	__towers_awaiting_selection.clear()

	# Update the placement grid coordinates reference for the new tower
	_replace_tower_in_placement_grid_coords_dict(selectedTower, new_upgrade_tower, __placement_grid_coords_for_towers)

	# Reselect tower to update hud containers
	tower_selected.emit(new_upgrade_tower)


## Called when a slate upgrade is triggered from towers awaiting selection
func keep_slate_from_towers_awaiting_selection(selectedTower: Tower, slateID: SlateConstants.SlateIDs) -> void:
	# Ensure the tower is in the list of towers awaiting selection
	assert(__towers_awaiting_selection.has(selectedTower), "Tower not found in list of towers awaiting selection")

	# Capture the tower's placement grid coordinate
	var selected_tower_placement_grid_coord: Vector2i = selectedTower.get_placement_grid_coordinate()

	# Remove selected tower from towers awaiting selection
	_remove_tower_awaiting_selection(selectedTower)

	# Convert remaining towers awaiting selection to barricades
	for tower in __towers_awaiting_selection.duplicate():
		# Convert the tower to a barricade
		convert_tower_to_barricade(tower)
	# Clear the list of towers awaiting selection
	__towers_awaiting_selection.clear()

	# Place slate in selected tower's placement grid position
	place_slate(slateID, selected_tower_placement_grid_coord)

	# Emit slate placed signal
	slate_placed.emit() 

## Called when an upgrade tower exists on the towers on map list.
func keep_extended_upgrade_tower(selectedTower: Tower, upgradeTowerID: TowerConstants.UpgradeTowerIDs) -> void:
	# Ensure the upgrade tower ID is valid
	assert(TowerConstants.UpgradeTowerIDs.values().has(upgradeTowerID), "Invalid upgrade tower ID")
	# Ensure the tower is in the list of towers on map
	assert(__towers_on_map.has(selectedTower), "Tower not found in list of towers on map")
	# Remove the tower from the list of towers on map
	__towers_on_map.erase(selectedTower)

	# Capture the tower's placement grid coordinate
	var tower_placement_grid_coord: Vector2i = selectedTower.get_placement_grid_coordinate()
	# Capture the tower's global position
	var tower_global_position: Vector2 = selectedTower.global_position

	# Remove towers from map scene
	selectedTower.queue_free()
	
	# Create new tower based on provided tower ID
	var new_upgrade_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[upgradeTowerID].instantiate()
	add_child(new_upgrade_tower)

	# Set upgrade tower placement grid coordinate and global position
	new_upgrade_tower.set_placement_grid_coordinate(tower_placement_grid_coord)
	new_upgrade_tower.global_position = tower_global_position
	
	# Set the tower's state to built
	new_upgrade_tower.switch_state(Tower.States.BUILT)
	
	# Add the tower to the list of towers on the map
	__towers_on_map.append(new_upgrade_tower)

	# Update the placement grid coordinates reference for the new tower
	_replace_tower_in_placement_grid_coords_dict(selectedTower, new_upgrade_tower, __placement_grid_coords_for_towers)

	# Reselect tower to update hud containers
	tower_selected.emit(new_upgrade_tower)

## Called when a copound upgrade tower exists on the towers awaiting selection list.
func keep_compound_upgrade_tower_from_towers_awaiting_selection(selectedTower: Tower, compoundUpgradeTowerID: TowerConstants.TowerIDs) -> void:
	# Ensure the tower is in the list of towers awaiting selection
	assert(__towers_awaiting_selection.has(selectedTower), "Tower not found in list of towers awaiting selection")
	# Remove the tower from the list of towers awaiting selection
	__towers_awaiting_selection.erase(selectedTower)

	# Capture the tower's placement grid coordinate
	var tower_placement_grid_coord: Vector2i = selectedTower.get_placement_grid_coordinate()
	# Capture the tower's global position
	var tower_global_position: Vector2 = selectedTower.global_position

	# Remove towers from map scene
	selectedTower.queue_free()
	
	# Create new tower based on provided tower ID
	var new_upgrade_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[compoundUpgradeTowerID].instantiate()
	add_child(new_upgrade_tower)

	# Set upgrade tower placement grid coordinate and global position
	new_upgrade_tower.set_placement_grid_coordinate(tower_placement_grid_coord)
	new_upgrade_tower.global_position = tower_global_position
	
	# Set the tower's state to built
	new_upgrade_tower.switch_state(Tower.States.BUILT)
	
	# Add the tower to the list of towers on the map
	__towers_on_map.append(new_upgrade_tower)

	# Convert all towers awaiting selection to barricades
	for tower in __towers_awaiting_selection.duplicate():
		# Convert the tower to a barricade
		convert_tower_to_barricade(tower)
	# Clear the list of towers awaiting selection
	__towers_awaiting_selection.clear()

	# Update the placement grid coordinates reference for the new tower
	_replace_tower_in_placement_grid_coords_dict(selectedTower, new_upgrade_tower, __placement_grid_coords_for_towers)
	
	# Reselect tower to update hud containers
	tower_selected.emit(new_upgrade_tower)

func _handle_navigation_mode() -> void:
	if Input.is_action_just_pressed("select"):
		# Start tracking mouse position
		__mouse_position = get_global_mouse_position()
		# Signal tower being selected if mouse points to a tower
		if tower_exists_at_global_position(__mouse_position):
			tower_selected.emit(get_tower_from_global_position(__mouse_position))
		return
	# Handle camera movement
	if !Input.is_action_just_pressed("select") and Input.is_action_pressed("select"):
		# Calculate mouse movement
		var new_mouse_position = get_global_mouse_position()
		var mouse_movement_distance = new_mouse_position - __mouse_position
		# Move camera
		camera_moved.emit(mouse_movement_distance)
		# Update mouse position
		__mouse_position = new_mouse_position

func remove_tower(tower: Tower) -> void:
	# Remove tower from list
	assert(__towers_on_map.has(tower), "Tower not found in map")
	__towers_on_map.erase(tower)
	# Remove path impediments
	_remove_tower_impediment_points(tower.get_placement_grid_coordinate())
	# Remove tower
	tower.queue_free()

func _remove_tower_awaiting_selection(tower: Tower) -> void:
	# Remove tower from list
	assert(__towers_awaiting_selection.has(tower), "Tower not found in map")
	__towers_awaiting_selection.erase(tower)
	# Remove path impediments
	_remove_tower_impediment_points(tower.get_placement_grid_coordinate())
	# Remove tower
	tower.queue_free()

## Removes the tower impediment points from the map and updates the path accordingly.
## Helper method for self.remove_tower().
func _remove_tower_impediment_points(placementGridPoint: Vector2i) -> void:
	for point in get_tower_impediment_points(placementGridPoint):
		__astar_grid.set_point_solid(point, false)
		__path_impediments.remove_at(__path_impediments.find(point))
	# Update path 
	self._update_current_path()

## Handles awaiting selection towers AND upgrade towers
func upgrade_tower(selectedTower: Tower, upgradeTowerID: TowerConstants.UpgradeTowerIDs) -> void:
	assert(TowerConstants.UpgradeTowerIDs.values().has(upgradeTowerID), "Invalid upgrade tower ID")

	# Handle upgrade tower
	if TowerConstants.UpgradeTowerIDs.values().has(selectedTower.TOWER_ID):
		keep_extended_upgrade_tower(selectedTower, upgradeTowerID)
		return

	# Handle tower awaiting selection
	if selectedTower.get_state() == Tower.States.AWAITING_SELECTION:
		keep_upgrade_tower_from_towers_awaiting_selection(selectedTower, upgradeTowerID)
		return
	

func subtract_funds(amount: int) -> void:
	__curr_balance -= amount
	balance_altered.emit(__curr_balance)

# TODO
func handle_single_point_impediment_placement(event: InputEvent = null) -> void:
	pass

func place_slate(slateID: SlateConstants.SlateIDs, placementGridCoord: Vector2i) -> void:
	# Ensure SlateConstants.SLATE_LOADS has the provided slate ID
	assert(SlateConstants.SLATE_LOADS.has(slateID), "Invalid slate ID")
	# Instantiate the slate from the preload
	var new_slate: Slate = SlateConstants.SLATE_LOADS[slateID].instantiate()
	# Add the slate to 
	add_child(new_slate)
	# Set the slate's placement grid coordinate
	new_slate.set_placement_grid_coordinate(placementGridCoord)
	# Set the slate's global position based on the placement grid coordinate
	new_slate.position = __placement_grid.map_to_local(placementGridCoord)
	# Add the slate to the list of slates on the map
	SLATE_MANAGER.add_slate_to_map(new_slate)
