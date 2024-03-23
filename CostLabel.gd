extends Label

func _ready():
	Events.picked_up.connect(_on_picked_up)
	Events.dropped_off.connect(_on_dropped_off)

	visible = false

func _on_picked_up(_pickup_loc):
	visible = true
	text = str(Journey.journey_cost)


func _on_dropped_off(_dropoff_loc):
	visible = false
