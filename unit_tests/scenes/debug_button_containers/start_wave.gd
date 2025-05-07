extends HBoxContainer

@export var START_NEW_WAVE_BUTTON: Button
@export var GAME_MAP: GameMap


func _ready():
    START_NEW_WAVE_BUTTON.pressed.connect(_on_start_new_wave_button_pressed)

func _on_start_new_wave_button_pressed():
    GAME_MAP.creep_spawner.initiate_new_wave()