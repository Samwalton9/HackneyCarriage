extends Node2D

enum {
	PICKUP,
	DROPOFF
}

var mode := PICKUP
var distance_to_travel : float


func move_for_dropoff() -> void:
	mode = DROPOFF
	var new_location = new_dropoff_location()

	distance_to_travel = position.distance_to(new_location)

	position = new_location


func new_dropoff_location() -> Vector2:
	var rand_x = randi_range(0, 100)
	var rand_y = randi_range(0, 100)

	return Vector2(rand_x, rand_y)


func _on_area_2d_area_entered(_area):
	if mode == PICKUP:
		move_for_dropoff()
		Events.picked_up.emit(self)
	elif mode == DROPOFF:
		queue_free()
		Events.dropped_off.emit()
