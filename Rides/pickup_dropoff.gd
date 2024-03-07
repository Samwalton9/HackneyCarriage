extends Node2D

enum {
	PICKUP,
	DROPOFF
}

var mode := PICKUP
var distance_to_travel : float
var taxi_in_pickup_zone : bool = false
var taxi_pickup_area : Area2D


func _physics_process(_delta):
	if taxi_in_pickup_zone and mode == PICKUP and Globals.taxi_speed < 10:
		$CustomerBody.move_to_taxi(taxi_pickup_area)
		mode = DROPOFF


func move_for_dropoff() -> void:
	mode = DROPOFF
	var new_location = new_dropoff_location()

	distance_to_travel = position.distance_to(new_location)
	Journey.journey_distance = distance_to_travel

	position = new_location


func new_dropoff_location() -> Vector2:
	var rand_x = randi_range(0, 100)
	var rand_y = randi_range(0, 100)

	return Vector2(rand_x, rand_y)


func _on_area_2d_area_entered(area):
	taxi_in_pickup_zone = true
	taxi_pickup_area = area

	# TODO - replace with a similar speed check as for picking up.
	if mode == DROPOFF:
		queue_free()
		Events.dropped_off.emit()


func _on_customer_body_reached_taxi():
		move_for_dropoff()
		Events.picked_up.emit()


func _on_area_2d_area_exited(_area):
	taxi_in_pickup_zone = false
