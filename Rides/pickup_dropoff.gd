extends Node2D

signal dropped_off

enum {
	PICKUP,
	DROPOFF
}

var mode := PICKUP

func _ready():
	Events.new_pickup.emit(self)


func move_for_dropoff() -> void:
	position.x += 50
	mode = DROPOFF


func _on_area_2d_area_entered(area):
	if mode == PICKUP:
		move_for_dropoff()
	elif mode == DROPOFF:
		queue_free()
		dropped_off.emit()
