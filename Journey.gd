extends Node

var journey_distance : float:
	get:
		return journey_distance
	set(value):
		journey_distance = value
		set_journey_max_cost(value)

var journey_cost : int

var possible_pickups_and_dropoffs : Array[Vector2]
var active_pickups_or_dropoffs : Array[Vector2]
var pickup_loc : Vector2
var dropoff_loc := Vector2.ZERO

signal new_pickup_location_set(pickup_location)
signal new_dropoff_location_set(dropoff_location)

func _ready():
	Events.dropped_off.connect(_on_dropped_off)
	Events.picked_up.connect(_on_picked_up)


func set_journey_max_cost(distance) -> void:
	journey_cost = round(distance * 5)


func _on_picked_up(pickup_location):
	active_pickups_or_dropoffs.erase(pickup_location)
	dropoff_loc = get_new_dropoff_location()
	new_dropoff_location_set.emit(dropoff_loc)

	Journey.journey_distance = pickup_location.distance_to(dropoff_loc)

func _on_dropped_off(dropoff_location):
	Globals.money += Journey.journey_cost

	active_pickups_or_dropoffs.erase(dropoff_location)


func get_new_pickup_location() -> Vector2:
	var new_pickup = get_new_location_without_duplicate(dropoff_loc)
	pickup_loc = new_pickup
	active_pickups_or_dropoffs.append(pickup_loc)
	return new_pickup


func get_new_dropoff_location() -> Vector2:
	var new_dropoff = get_new_location_without_duplicate(pickup_loc)
	dropoff_loc = new_dropoff
	active_pickups_or_dropoffs.append(dropoff_loc)
	return new_dropoff


func get_new_location_without_duplicate(old_loc : Vector2) -> Vector2:
	var new_loc = old_loc
	while new_loc == old_loc:
		new_loc = possible_pickups_and_dropoffs.pick_random()

	return new_loc
