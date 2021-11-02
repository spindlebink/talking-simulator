# *Very* basic parser to simplify writing the script
#
# Using JSON leads to a marginally more verbose format so I figured why not

extends Node

var index = -1
var lines = []

# Reads a script file from a filepath and parses it into `lines`
func load_script(filepath):
	var file = File.new()
	file.open(filepath, File.READ)
	var contents = file.get_as_text()
	file.close()

	lines.clear()
	index = -1
	var current_speaker = 0
	
	for line in contents.split("\n", false):
		var speaker = 1 if line.begins_with("1: ") else 2 if line.begins_with("2: ") else current_speaker
		current_speaker = speaker
		line = line.trim_prefix("1: ").trim_prefix("2: ")
		for segment in line.split(" / "):
			lines.push_back([current_speaker, segment])
	
# Restarts script index marker
func restart():
	index = -1

# Moves the index marker along by one and returns the new script line
func move_to_next():
	index += 1
	if index < lines.size() && index >= 0:
		return lines[index]
	else:
		return null

# Moves the index marker back by one and returns the new script line
func move_to_prev():
	index -= 1
	if index < -1: index = -1
	if index < lines.size() && index >= 0:
		return lines[index]
	else:
		return null
