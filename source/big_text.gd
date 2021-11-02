extends Label

signal flashed

var failure_messages = [
	"OH NO",
	"THAT WON'T CUT IT",
	"TRY AGAIN\nMAYBE",
	"NEVER MIND,\nGIVE IT UP",
	"READ THE DAMN\nINSTRUCTIONS",
	"GOOD LORD, NO",
	"PUH-LEASE",
	"IT HURTS\nTO WATCH",
	"NOPE",
	"ARE YOU EVEN\nTRYING",
	"COME ON\nDUDE",
	"BUTTERFINGERS",
	"WHOOPSIE\nDOODLE",
	"YIKES",
	"HELL NO",
	"IT'S NOT THAT HARD",
	"OH MY GOD, NO",
	"BAD JOB"
]

var success_messages = [
	"OH YEAH",
	"NICE JOB",
	"GOOD TALKING",
	"EXCELLENTÉ",
	"WHOAH, THOSE'RE SOME\nBOMB-ASS WORDS",
	"TALKING SKILLS\nON POINT",
	"SWEET",
	"YOU'RE THE\nBEE'S KNUCKLES",
	"WONDERFUL",
	"BETTER THAN TOAST",
	"A STROKE OF GENIUS,\nWHAT YOU JUST SAID",
	"GODDAMN YOU'RE ON FIRE",
	"WONDROUS, YOU",
	"SHIT, BABY\nYOU'RE THE COOLEST",
	"AWESOME",
	"HECK YEAH"
]

var failure_index = 0
var success_index = 0

onready var flash_timer = $Timer

func flash_message(message):
	text = message
	visible = true
	flash_timer.wait_time = clamp(text.length() * 0.05, 0.5, INF)
	flash_timer.start()
	yield(flash_timer, "timeout")
	visible = false
	emit_signal("flashed")

func flash_success():
	flash_message(success_messages[success_index])
	success_index = (success_index + 1) % success_messages.size()

func flash_failure():
	flash_message(failure_messages[failure_index])
	failure_index = (failure_index + 1) % failure_messages.size()

func _ready():
	failure_index = randi() % failure_messages.size()
	success_index = randi() % success_messages.size()
