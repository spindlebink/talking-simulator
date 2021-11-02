tool
extends Node2D

export(Color) var zone_1_color
export(Color) var zone_2_color

var zone_1 = Rect2()
var zone_2 = Rect2()

func _draw():
	draw_rect(zone_1, zone_1_color)
	draw_rect(zone_2, zone_2_color)
