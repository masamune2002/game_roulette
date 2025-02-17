extends Control

@export var starting_speed: float = 800.0  # Starting speed in degrees per second

var elapsed_time: float = 0.0
var previous_elapsed_time : float = 0.0
var spin_seconds : float = 0.0

var current_speed : float = 0.0
var deceleration_rate: float
var wedge_labels: Array[String]
var triangle_color = Color(1, 1, 0)
const colors: Array[Color] = [Color.BLACK, Color.ORANGE]

var spinning : bool = false

signal show_result(result)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)  # Ensure _process is called
	set_process_input(true)  # Ensure _input is called
	queue_redraw()  # Request a redraw to draw the circle

func update(wedge_labels):
	self.wedge_labels = wedge_labels
	queue_redraw()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Set the pivot point to the center
	self.pivot_offset = Vector2(size.x / 2, size.y / 2)

	if spin_seconds > 0.0:
		deceleration_rate = starting_speed / spin_seconds

	if elapsed_time < spin_seconds:
		# The wheel is rotating
		rotation_degrees += current_speed * delta
		previous_elapsed_time = elapsed_time
		elapsed_time += delta
		current_speed -= deceleration_rate * delta
		current_speed = max(0, current_speed)  # Ensure speed does not go negative
	elif previous_elapsed_time < spin_seconds:
		# The first time the timer runs outt, stop the wheel
		stop_spin()
		previous_elapsed_time = elapsed_time

func _draw():
	var radius = min(size.x, size.y) / 2
	var center = Vector2(size.x / 2, size.y / 2)
	var num_wedges = wedge_labels.size()
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
		var wedge_color = colors[i % colors.size()]

		# Draw the wedge
		draw_polygon(points, [wedge_color])
		add_labels_to_wedges(wedge_labels)

func start_spin(spin_seconds : float):
	self.spin_seconds = spin_seconds
	current_speed = starting_speed
	elapsed_time = 0.0
	queue_redraw()

func stop_spin():
	current_speed = 0
	show_result.emit("result")
	queue_redraw()

# Function to add labels to the wedges
func add_labels_to_wedges(wedge_labels):

	for child in get_children():
		if child is Label:
			remove_child(child)
			child.free()

	var radius = min(size.x, size.y) / 2
	var center = Vector2(size.x / 2, size.y / 2)
	var num_wedges = wedge_labels.size()
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

