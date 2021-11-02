tool
extends Node2D

onready var line2d = $Line2D
onready var color_zones = $ColorZones

onready var stroke_size = line2d.width

var corner_position = Vector2(0.55, 0.7)
var arc_radius_base = 0.05
var arc_resolution = 30

func _draw():
	var viewport = get_viewport_rect().size
	var arc_radius = arc_radius_base * viewport.x

	# First, polyline - Z on left, thin upward rectangle (minus arc at end)
	line2d.clear_points()
	for point in [Vector2(0.2, 0.35), Vector2(0.4, 0.35), Vector2(0.3, 0.7), Vector2(0.55, 0.7), Vector2(0.55, 0.1), Vector2(0.6, 0.1), Vector2(0.6, 0.7)]:
		line2d.add_point(point * viewport)

	# Three stripes at top of Z
	for x in range(0, 3):
		var x_offset = stroke_size * 2 * x + stroke_size * 3
		draw_line(Vector2(0.2, 0.35) * viewport + Vector2.RIGHT * x_offset, Vector2(0.2, 0.35) * viewport + Vector2(x_offset, -arc_radius), Color.black, stroke_size)

	# Dot & arc at corner of rectangle
	draw_circle(corner_position * viewport, arc_radius * 0.25, Color.black)
	draw_arc(corner_position * viewport, arc_radius, 0, PI / 2, arc_resolution, Color.black, stroke_size)

	# Bigger arc stretching from rect left side
	draw_arc(corner_position * viewport, arc_radius * 3, -PI / 2, PI / 16, arc_resolution, Color.black, stroke_size)
	
	# Circle between Z and rectangle & its accompanying arc
	var circle_1_position = corner_position * viewport + (Vector2.RIGHT * arc_radius * 3).rotated(PI * 1.25)
	draw_circle(circle_1_position, arc_radius * 0.25, Color.black)
	draw_arc(circle_1_position, arc_radius, PI, PI / 3, arc_resolution, Color.black, stroke_size)

	# Circle on the other side of Z
	draw_circle(circle_1_position + Vector2.LEFT * arc_radius * 3, arc_radius * 0.25, Color.black)

	color_zones.zone_1.position = Vector2(0.2, 0.35) * viewport + Vector2.UP * arc_radius * 1.25 + Vector2.LEFT * arc_radius * 0.25
	color_zones.zone_1.size = circle_1_position - color_zones.zone_1.position
	color_zones.zone_2.position = circle_1_position + Vector2.LEFT * arc_radius * 3
	color_zones.zone_2.size = Vector2(arc_radius * 9, arc_radius * 3.25)
	color_zones.update()
