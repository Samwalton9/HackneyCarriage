extends Label

var velocity = 0.0

func _process(delta):
	text = str(snapped(velocity.length(),0.01))
