extends Timer

func _ready():
	Events.picked_up.connect(_on_picked_up)
	Events.dropped_off.connect(_on_dropped_off)


func _on_picked_up():
	start()


func _on_dropped_off():
	stop()