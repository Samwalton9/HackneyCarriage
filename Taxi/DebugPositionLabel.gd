extends Label

var taxi_position := Vector2.ZERO

func _process(_delta : float) -> void:
	text = str(snapped(taxi_position.x,1)) + ", " + str(snapped(taxi_position.y,1))
