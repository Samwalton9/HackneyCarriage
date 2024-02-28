extends Label

@onready var timer = %JourneyTimer

func _process(_delta):
	text = str(snapped(timer.time_left, 0.1))
