extends Node

var journey_distance : float:
	get:
		return journey_distance
	set(value):
		journey_distance = value
		set_journey_max_cost(value)

var journey_cost : int

var possible_pickups_and_dropoffs : Array[Vector2]
var pickup_loc : Vector2
var dropoff_loc := Vector2.ZERO

func _ready():
	Events.dropped_off.connect(_on_dropped_off)


func set_journey_max_cost(distance) -> void:
	journey_cost = round(distance * 5)


func _on_dropped_off():
	Globals.money += Journey.journey_cost


func get_new_pickup_location() -> Vector2:
	var new_pickup = get_new_location_without_duplicate(dropoff_loc)
	pickup_loc = new_pickup
	return new_pickup


func get_new_dropoff_location() -> Vector2:
	var new_dropoff = get_new_location_without_duplicate(pickup_loc)
	dropoff_loc = new_dropoff
	return new_dropoff


func get_new_location_without_duplicate(old_loc : Vector2) -> Vector2:
	var new_loc = old_loc
	while new_loc == old_loc:
		new_loc = possible_pickups_and_dropoffs.pick_random()

	return new_loc
