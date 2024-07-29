extends Node

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@export var randomizer: AudioStreamRandomizer

var audio_map = [{
	'filename': preload("res://Assets/Sounds/ThisIsHalloween.wav"),
	'stopAt': 10.5
}]

func play_audio_by_int(audio_id: int):
	if audio_id in audio_map:
		audio_player.stream = audio_map[audio_id]
		audio_player.play()
	else:
		print("Audio ID not found")
