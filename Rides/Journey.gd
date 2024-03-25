extends Node


var journey_distance : float:
	get:
		return journey_distance
	set(value):
		journey_distance = value
		set_journey_max_cost(value)

var pickup_loc : Vector2

var dropoff_loc := Vector2.ZERO:
	get:
		return dropoff_loc
	set(value):
		dropoff_loc = value
		journey_distance = pickup_loc.distance_to(dropoff_loc)

var journey_cost : int

var destination_road_name : String


func set_journey_max_cost(distance : float) -> void:
	journey_cost = round(distance * 5)


func dropped_off() -> void:
	Globals.money += journey_cost
