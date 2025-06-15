extends Node2D
class_name  InsufficientFundsAudioStreams

@export var STREAM_1: AudioStreamPlayer
@export var STREAM_2: AudioStreamPlayer
@export var STREAM_3: AudioStreamPlayer

@onready var ALL_AUDIO_STREAMS: Array[AudioStreamPlayer] = [
    STREAM_1,
    STREAM_2,
    STREAM_3,
]

var __is_playing_audio: bool = false

func _ready() -> void:
    # Connect finished signals or audio streams
    for stream in ALL_AUDIO_STREAMS:
        stream.finished.connect(_on_audio_finished)

## Play the insufficient funds sound effect.
## This function plays selects a random audio stream from the ALL_AUDIO_STREAMS array
## and plays it.
func play_insufficient_funds_sound():
    # Do nothing if audio stream is already playing
    if __is_playing_audio:
        return
    
    var randomly_selected_stream: AudioStreamPlayer = ALL_AUDIO_STREAMS.pick_random()
    randomly_selected_stream.play()
    __is_playing_audio = true

func _on_audio_finished():
    __is_playing_audio = false
