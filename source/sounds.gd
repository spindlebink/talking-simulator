extends Node

signal finish_finished

func play_good():
	$GoodFeedback.play()

func play_bad():
	$BadFeedback.play()

func play_finish():
	$FinishFeedback.play()
	yield($FinishFeedback, "finished")
	emit_signal("finish_finished")
