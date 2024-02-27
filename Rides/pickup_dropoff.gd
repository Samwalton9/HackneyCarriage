extends Node2D

enum {
	PICKUP,
	DROPOFF
}

var mode := PICKUP

func move_for_dropoff() -> void:
	position.x += 100
	mode = DROPOFF


func _on_area_2d_area_entered(area):
	if mode == PICKUP:
		move_for_dropoff()
	elif mode == DROPOFF:
		queue_free()
