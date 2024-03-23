extends Node2D

enum {
	PICKUP,
	DROPOFF
}

var mode := PICKUP
var distance_to_travel : float
var taxi_in_pickup_zone : bool = false
var taxi_pickup_area : Area2D

@export var max_pickup_speed = 10

@onready var Customer := $CustomerBody


func _physics_process(_delta):
	if taxi_in_pickup_zone and Globals.taxi_speed < max_pickup_speed:
		if mode == PICKUP:
			Customer.move_to_taxi(taxi_pickup_area.global_position)

		elif mode == DROPOFF:
			queue_free()
			Events.dropped_off.emit()

	if Customer.state == Customer.PICKING_UP and not taxi_in_pickup_zone:
		Customer.return_to_position()
		mode = PICKUP



func move_for_dropoff() -> void:
	var new_location = Journey.get_new_dropoff_location()

	distance_to_travel = position.distance_to(new_location)
	Journey.journey_distance = distance_to_travel

	position = new_location

	mode = DROPOFF
	taxi_in_pickup_zone = false


func _on_area_2d_area_entered(area):
	taxi_in_pickup_zone = true
	taxi_pickup_area = area


func _on_customer_body_reached_taxi():
	move_for_dropoff()
	Events.picked_up.emit()


func _on_area_2d_area_exited(_area):
	taxi_in_pickup_zone = false
