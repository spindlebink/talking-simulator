extends Control

onready var sounds = $Sounds
onready var script_data = $ScriptData
onready var text_display = $TextDisplay
onready var inverter = $Inverter
onready var the_zone = $TheZone
onready var big_text = $BigText
onready var score_panel = $Inverter/ScorePanel

var input_enabled = true
var score = 0

var zone = 0.5
var zone_size = 0.05
var max_zone_size = 0.1
var min_zone_size = 0.025

var selector_speed = 0.1
var max_selector_speed = 0.5
var min_selector_speed = 0.1

var selector = 0.5
var selector_size = 4
var selector_visible = true

# Carries out the necessary success or failure states when you press a button
func success_or_failure():
	# valid hit test area is technically slightly larger than the displayed zone
	if selector >= zone - zone_size * 1.25 && selector <= zone + zone_size * 1.25:
		sounds.play_good()
		score_panel.set_score(score_panel.score + 1)
		var next_line = script_data.move_to_next()
		if next_line != null:
			text_display.display_script_line(next_line)
			big_text.flash_success()
		else:
			sounds.play_finish()
			input_enabled = false
			selector_visible = false
			the_zone.visible = false
			big_text.flash_message("NICE JOB\nYOU KNOCKED THAT CONVO\nOUT OF THE PARK")
			text_display.display_nothing()
			text_display.alt_script = not text_display.alt_script
			script_data.restart()
			yield(big_text, "flashed")
			big_text.flash_message("LET'S TRY\nAN ALL-NEW\nEXPERIENCE")
			inverter.flash(11)
			yield(big_text, "flashed")
			yield(sounds, "finish_finished")
			score_panel.set_score(0)
			input_enabled = true
			selector_visible = true
			the_zone.visible = true
	else:
		sounds.play_bad()
		score_panel.set_score(score_panel.score - 1 if score_panel.score > 0 else 0)
		var prev_line = script_data.move_to_prev()
		big_text.flash_failure()
		if prev_line != null:
			text_display.display_script_line(prev_line)
		else:
			text_display.display_nothing()

# Triggers a new round to begin, irrespective of whether you succeeded in the
# previous round
func new_round():
	zone = randf()
	zone_size = randf() * (max_zone_size - min_zone_size) + min_zone_size
	the_zone.material.set_shader_param("angle", randi() % 360)

	selector_speed = randf() * (max_selector_speed - min_selector_speed) + min_selector_speed
	if selector > zone:
		selector_speed = -abs(selector_speed)
	elif selector < zone:
		selector_speed = abs(selector_speed)

	the_zone.rect_size.x = zone_size * inverter.rect_size.x
	the_zone.rect_position.x = inverter.rect_position.x + (inverter.rect_size.x - the_zone.rect_size.x) * zone

# Draws the selector
func _draw():
	if selector_visible:
		draw_rect(Rect2(Vector2(selector * (inverter.rect_size.x - selector_size) + inverter.rect_position.x, 0), Vector2(selector_size, inverter.rect_size.y)), Color.white)

# Called each frame
func _process(delta):
	selector += selector_speed * delta
	if selector >= 1:
		selector_speed = -abs(selector_speed)
		selector = 1
	elif selector <= 0:
		selector_speed = abs(selector_speed)
		selector = 0

	update()

# Called on input
func _input(event):
	if input_enabled:
		if event is InputEventKey && event.is_pressed():
			inverter.flash(3)
			success_or_failure()
			new_round()

# Called when the game begins
func _ready():
	script_data.load_script("res://resources/script.txt")
	new_round()
	score_panel.set_score(0)
