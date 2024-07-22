extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_settings_button_pressed():
	$Foreground/Settings_Screen.visible = !$Foreground/Settings_Screen.visible


func _on_wheel_show_result(result):
	print(result)
	$Foreground.visible = !$Foreground.visible
