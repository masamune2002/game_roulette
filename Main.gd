extends Control

@onready var wheel = $Wheel
@onready var results_screen = $Results_Screen
@onready var audio_player = $AudioStreamPlayer

var songs : Array[Dictionary] = [{
	'stream': preload("res://Assets/Sounds/ThisIsHalloween.wav"),
	'stop_at': 10.5
}]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Handle input events
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos = event.position
		var circle_center = Vector2(wheel.size.x / 2, wheel.size.y / 2)
		var radius = min(wheel.size.x, wheel.size.y) / 2
		if circle_center.distance_to(mouse_pos) <= radius:
			var song = songs.pick_random()
			wheel.start_spin(song.stop_at)
			audio_player.stream = song.stream
			audio_player.play()
		else:
			wheel.stop_spin()

func _on_settings_button_pressed():
	$Foreground/Settings_Screen.visible = !$Foreground/Settings_Screen.visible

func _on_wheel_show_result(result):
	results_screen.visible = true
