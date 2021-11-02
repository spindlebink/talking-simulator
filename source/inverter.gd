extends Control

onready var inverter_panel = $InverterPanel
onready var flash_timer = $FlashTimer

func flash(times = 1):
	for _i in range(0, times):
		inverter_panel.visible = not inverter_panel.visible
		flash_timer.start()	
		yield(flash_timer, "timeout")
