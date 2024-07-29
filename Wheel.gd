extends Control

var num_wedges: int
var spin_seconds: float = 10.0  # Total time in seconds for deceleration
@export var starting_speed: float = 800.0  # Starting speed in degrees per second

var elapsed_time: float = 0.0
var previous_elapsed_time : float = 0.0

var current_speed : float = 0.0
var deceleration_rate: float
const wedge_labels: Array[String] = ["Alex", "Allison", "Thad", "Ravi", "Liz", "Anuja", "Matthew", "Tyler"]
var triangle_color = Color(1, 1, 0)
const colors: Array[Color] = [Color.BLACK, Color.ORANGE]

var spinning : bool = false

signal show_result(result)

func _draw():
	var radius = min(size.x, size.y) / 2
	var center = Vector2(size.x / 2, size.y / 2)
	$Spinner.draw(radius, center, num_wedges)
	$Indicator.draw(radius, center, num_wedges)

func start_spin(spin_seconds : float):
	$Spinner.start_spin(spin_seconds)

func stop_spin():
	$Spinner.stop_spin()

# Function to add labels to the wedges
func add_labels_to_wedges():

	for child in get_children():
		if child is Label:
			remove_child(child)
			child.free()

	var radius = min(size.x, size.y) / 2
	var center = Vector2(size.x / 2, size.y / 2)
	var wedge_angle = 2 * PI / num_wedges

	for i in range(num_wedges):
		var angle = i * wedge_angle + wedge_angle / 2
		var label_pos = center + Vector2(cos(angle), sin(angle)) * radius * 0.5

		var label = Label.new()
		label.text = wedge_labels[i % wedge_labels.size()]

		# Position the label
		label.set_position(label_pos)

		# Rotate the label to align with the wedge
		label.set_rotation_degrees(rad_to_deg(angle))

		add_child(label)

func _on_resized():
	queue_redraw()
	add_labels_to_wedges()

