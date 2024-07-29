extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func draw(radius, center, num_wedges):
	var wedge_angle = 2 * PI / num_wedges

	# Draw the small triangle at the left-most point of the wheel
	var triangle_radius = radius * 0.1  # Radius of the triangle
	var triangle_center_angle = PI  # Left-most point angle

	var triangle_center = center + Vector2(cos(triangle_center_angle), sin(triangle_center_angle)) * radius

	# Define the points for the triangle
	var triangle_points = [
		triangle_center + Vector2(triangle_radius, 0),
		triangle_center + Vector2(-triangle_radius, triangle_radius / 2),
		triangle_center + Vector2(-triangle_radius, -triangle_radius / 2)
	]

	# Draw the triangle
	draw_polygon(triangle_points, [triangle_color])
