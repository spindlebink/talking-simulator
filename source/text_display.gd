extends Control

onready var text_left = $TextLeft
onready var text_right = $TextRight
onready var flash_timer = $Timer

var alt_script = false

func flash_text():
	for i in range(0, 6):
		text_left.visible = not text_left.visible
		text_right.visible = not text_right.visible
		flash_timer.start()
		yield(flash_timer, "timeout")

# Sets the text to display a line of script
func display_script_line(line):
	var text_1 = text_left if !alt_script else text_right
	var text_2 = text_right if !alt_script else text_left

	if line[0] == 1:
		text_1.bbcode_text = line[1] if text_1 == text_left else "[right]" + line[1] + "[/right]"
		text_2.bbcode_text = ""
	elif line[0] == 2:
		text_1.bbcode_text = ""
		text_2.bbcode_text = line[1] if text_2 == text_left else "[right]" + line[1] + "[/right]"
	
	flash_text()

func display_nothing():
	text_left.bbcode_text = ""
	text_right.bbcode_text = ""
