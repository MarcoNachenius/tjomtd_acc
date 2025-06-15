extends Node2D
class_name BackgroundMusicAudioStreams

var __curr_track_num: int = 0

@export var TRACK_1: AudioStreamPlayer

@onready var ALL_TRACKS: Array[AudioStreamPlayer] = [
    TRACK_1,
]

func _ready() -> void:
    # Connect finished signals or audio streams
    for track in ALL_TRACKS:
        track.finished.connect(_on_track_finished)
    # Play the first track
    ALL_TRACKS[__curr_track_num].play()

func _on_track_finished() -> void:
    # Increment the current track number
    __curr_track_num = (__curr_track_num + 1) % ALL_TRACKS.size()
    # Play the next track
    ALL_TRACKS[__curr_track_num].play()

## Play the background music sound effect.
func play_background_music():
    # Do nothing if the current track is already playing
    if ALL_TRACKS[__curr_track_num].playing:
        return
    
    ALL_TRACKS[__curr_track_num].play()
    __curr_track_num = (__curr_track_num + 1) % ALL_TRACKS.size()