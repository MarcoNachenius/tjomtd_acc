extends Node2D

# EXPORT VARS
@export var MAIN_MENU_TRACK: AudioStreamPlayer
@export var END_MENU_TRACK: AudioStreamPlayer
@export var LEVEL_TRACK_1: AudioStreamPlayer
@export var FINAL_BOSS_TRACK: AudioStreamPlayer

# ONREADY VARS
@onready var ALL_LEVEL_TRACKS: Array[AudioStreamPlayer] = [
	LEVEL_TRACK_1,
]

# PRIVATE VARS
var __curr_track_num: int = 0
var __curr_audio_player: AudioStreamPlayer = null


func _ready() -> void:
	_verify_all_tracks_assigned()
	_connect_level_tracks_finished_signals()

# ===============
# PRIVATE METHODS
# ===============
## Verify that all tracks have been assigned.
func _verify_all_tracks_assigned() -> void:
	assert(MAIN_MENU_TRACK, "MAIN_MENU_TRACK is not assigned.")
	#assert(END_MENU_TRACK, "END_MENU_TRACK is not assigned.")
	assert(LEVEL_TRACK_1, "LEVEL_TRACK_1 is not assigned.")
	#assert(FINAL_BOSS_TRACK, "FINAL_BOSS_TRACK is not assigned.")

# ==============
# SIGNAL METHODS
# ==============
## Handle track finished signal. When triggered, the next track will play.
func _on_level_track_finished() -> void:
	# Increment the current track number
	__curr_track_num = (__curr_track_num + 1) % ALL_LEVEL_TRACKS.size()
	# Play the next track
	ALL_LEVEL_TRACKS[__curr_track_num].play()


func _connect_level_tracks_finished_signals() -> void:
	for track in ALL_LEVEL_TRACKS:
		track.finished.connect(_on_level_track_finished)

# ==============
# PUBLIC METHODS
# ==============
## Initiate playing of level background music.
func play_level_track() -> void:
	# Do nothing if the current level track is already playing
	if ALL_LEVEL_TRACKS[__curr_track_num].playing:
		return
	# Stop the current track if one is playing
	if __curr_audio_player and __curr_audio_player.playing:
		__curr_audio_player.stop()   
	__curr_audio_player = MAIN_MENU_TRACK
	
	ALL_LEVEL_TRACKS[__curr_track_num].play()
	# Ensure the next track will play after this one finishes
	__curr_track_num = (__curr_track_num + 1) % ALL_LEVEL_TRACKS.size()


## Initiate playing of main menu background music.
func play_main_menu_track() -> void:
	# Do nothing if the main menu track is already playing
	if __curr_audio_player == MAIN_MENU_TRACK:
		return
	# Stop the current track if one is playing
	if __curr_audio_player and __curr_audio_player.playing:
		__curr_audio_player.stop()   
	__curr_audio_player = MAIN_MENU_TRACK
	MAIN_MENU_TRACK.play()


## Initiate playing of end menu background music.
func play_end_menu_track() -> void:
	# Do nothing if the end menu track is already playing
	if __curr_audio_player == END_MENU_TRACK:
		return
	# Stop the current track if one is playing
	if __curr_audio_player and __curr_audio_player.playing:
		__curr_audio_player.stop()   
	__curr_audio_player = END_MENU_TRACK
	END_MENU_TRACK.play()


## Initiate playing of final boss background music.
func play_final_boss_track() -> void:
	FINAL_BOSS_TRACK.play()
