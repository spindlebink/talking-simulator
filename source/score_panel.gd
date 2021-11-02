extends ColorRect

onready var score_text = $ScoreText

var score_prefix = ""
var score_suffix = ""

var max_movement_speed = 40
var min_movement_speed = 2

var movement_speed = Vector2(2.0, 2.0)
var score = 0

func set_score(new_score):
	if new_score > score:
		movement_speed = movement_speed.normalized() * move_toward(movement_speed.length(), max_movement_speed, 1.0)
	else:
		movement_speed = movement_speed.normalized() * move_toward(movement_speed.length(), min_movement_speed, 1.0)
	score = new_score

	if score >= 100:
		score_prefix = "[rainbow][tornado radius=" + String(score / 10) + " freq=" + String(score / 15) + "]"
		score_suffix = "[/tornado][/rainbow]"
	elif score >= 75:
		score_prefix = "[rainbow][wave amp=" + String(score / 5) + " freq=" + String(score / 5) + "]"
		score_suffix = "[/wave][/rainbow]"
	elif score >= 50:
		score_prefix = "[rainbow][shake level=7]"
		score_suffix = "[/shake][/rainbow]"
	elif score >= 25:
		score_prefix = "[rainbow]"
		score_suffix = "[/rainbow]"
	else:
		score_prefix = ""
		score_suffix = ""

	score_text.bbcode_text = "[center]" + score_prefix + "SCORE: " + String(score) + score_suffix + "[/center]"

# Called each frame
func _process(delta):
	rect_position += movement_speed * delta
	if rect_position.x + rect_size.x >= get_parent().rect_size.x:
		movement_speed.x = -abs(movement_speed.x)
	elif rect_position.x <= 0:
		movement_speed.x = abs(movement_speed.x)
	if rect_position.y + rect_size.y >= get_parent().rect_size.y:
		movement_speed.y = -abs(movement_speed.y)
	elif rect_position.y <= 0:
		movement_speed.y = abs(movement_speed.y)
