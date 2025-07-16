extends Node

const PATH: String = "user://"
const SAVE_FILE_NAME: String = "save_file.res"

var ACTIVE_GAME_DATA: ActiveGameData

## Creates and initializes a new ActiveGameData instance.
##
## Parameters:
##     mapID (int) – MapConstants.MapID enum value to associate with the new game data.
##
## Behavior:
##     • Instantiates a new ActiveGameData.
##     • Sets its map_id property to the provided mapID.
func create_new_game_data(mapID: int) -> void:
	# Ensure old save file no longer exists
	delete_save_file()
	# Create/reset curr game data
	ACTIVE_GAME_DATA = ActiveGameData.new()
	ACTIVE_GAME_DATA.set_map_id(mapID)

## Loads game data from disk if a save file exists.
##
## Behavior:
##     • Checks if a file exists at the combined path (PATH + SAVE_FILE_NAME).
##     • If the save file exists, loads it into ACTIVE_GAME_DATA.
##     • If no save file is found, ACTIVE_GAME_DATA remains unchanged.
func load_game_data() -> void:
	if ResourceLoader.exists(PATH + SAVE_FILE_NAME):
		ACTIVE_GAME_DATA = ResourceLoader.load(PATH + SAVE_FILE_NAME)

## Saves the current ACTIVE_GAME_DATA to disk.
##
## Behavior:
##     • Serializes and writes ACTIVE_GAME_DATA to a file at PATH + SAVE_FILE_NAME.
##     • Overwrites any existing save file without prompting.
func save_game_data() -> void:
	ResourceSaver.save(ACTIVE_GAME_DATA, PATH + SAVE_FILE_NAME)

## Deletes the save file from disk.
##
## Behavior:
##     • Opens the user://save_files/ directory.
##     • Checks if the file SAVE_FILE_NAME exists within that directory.
##     • If it exists, attempts to remove it via DirAccess.remove_file().
##     • Logs an error if directory access or deletion fails.
##     • Clears ACTIVE_GAME_DATA after a successful deletion.
##     • Logs a warning if no save file was found.
func delete_save_file() -> void:
	var dir = DirAccess.open(PATH)
	if dir == null:
		push_error("delete_save_file: Unable to open directory '%s'" % PATH)
		return
	if dir.file_exists(PATH + SAVE_FILE_NAME):
		var err = DirAccess.remove_absolute(PATH + SAVE_FILE_NAME)
		if err != OK:
			push_error("delete_save_file: Failed to delete '%s': error %d" % [SAVE_FILE_NAME, err])
		else:
			ACTIVE_GAME_DATA = null
	else:
		push_warning("delete_save_file: No save file found at '%s'" % (PATH + SAVE_FILE_NAME))

## Checks whether the save file exists on disk.
##
## Returns:
##     bool – True if a save file is present at PATH + SAVE_FILE_NAME; false otherwise.
func save_file_exists() -> bool:
	return ResourceLoader.exists(PATH + SAVE_FILE_NAME)
