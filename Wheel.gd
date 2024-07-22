extends Control

var num_wedges: int = 1
@export var total_time: float = 10.0  # Total time in seconds for deceleration
@export var starting_speed: float = 800.0  # Starting speed in degrees per second

var elapsed_time: float = 0.0

var current_speed : float = 0.0
var deceleration_rate: float
var wedge_labels: Array[String] = ["Alex", "Allison", "Thad", "Ravi", "Liz", "Anuja", "Matthew", "Tyler"]

var spinning : bool = false

signal show_result(result)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)  # Ensure _process is called
	set_process_input(true)  # Ensure _input is called
	queue_redraw()  # Request a redraw to draw the circle
	num_wedges = wedge_labels.size()
	deceleration_rate = starting_speed / total_time

	add_labels_to_wedges()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Set the pivot point to the center
	self.pivot_offset = Vector2(size.x / 2, size.y / 2)

	if elapsed_time < total_time:
		# Update rotation
		self.rotation_degrees += current_speed * delta

		# Update elapsed time
		elapsed_time += delta

		# Decelerate the rotation speed
		current_speed -= deceleration_rate * delta
		current_speed = max(0, current_speed)  # Ensure speed does not go negative
	else:
		_stop_spin()

# Function to draw the circle with wedges
func _draw():
	var radius = min(size.x, size.y) / 2
	var center = Vector2(size.x / 2, size.y / 2)
	var wedge_angle = 2 * PI / num_wedges

	for i in range(num_wedges):
		var start_angle = i * wedge_angle
		var end_angle = (i + 1) * wedge_angle

		# Create the points for the wedge
		var points = [center]
		var segments = 10  # Number of segments to approximate the arc
		for j in range(segments + 1):
			var angle = start_angle + j * (end_angle - start_angle) / segments
			points.append(center + Vector2(cos(angle), sin(angle)) * radius)

		# Define a color for the wedge (alternating colors as an example)
		var wedge_color = Color(1, 0, 0) if i % 2 == 0 else Color(0, 1, 0)

		# Draw the wedge
		draw_polygon(points, [wedge_color])

# Handle input events
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos = event.position
		var circle_center = Vector2(size.x / 2, size.y / 2)
		var radius = min(size.x, size.y) / 2
		if circle_center.distance_to(mouse_pos) <= radius:
			_start_spin()
		else:
			_stop_spin()
			show_result.emit("Result!")

func _start_spin():
	current_speed = starting_speed
	elapsed_time = 0.0
	queue_redraw()

func _stop_spin():
	current_speed = 0
	queue_redraw()

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

		# Set the size of the label
		label.set_size(Vector2(100, 30))

		# Position the label
		label.set_position(label_pos)

		# Rotate the label to align with the wedge
		label.set_rotation_degrees(rad_to_deg(angle))

		label.add_theme_color_override("font_color", Color(1, 1, 1))  # Set text color
		add_child(label)

func _on_resized():
	queue_redraw()
	add_labels_to_wedges()

