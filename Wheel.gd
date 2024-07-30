extends Control

var num_wedges: int
@export var starting_speed: float = 800.0  # Starting speed in degrees per second

var elapsed_time: float = 0.0
var previous_elapsed_time : float = 0.0

var current_speed : float = 0.0
const wedge_labels: Array[String] = ["Alex", "Allison", "Thad", "Ravi", "Liz", "Anuja", "Matthew", "Tyler"]
var triangle_color = Color(1, 1, 0)
const colors: Array[Color] = [Color.BLACK, Color.ORANGE]

var spinning : bool = false

signal show_result(result)

func _draw():
	$Spinner.update(wedge_labels)

func start_spin(spin_seconds : float):
	$Spinner.start_spin(spin_seconds)

func stop_spin():
	$Spinner.stop_spin()

func _on_resized():
	queue_redraw()
	$Spinner.update(wedge_labels)

