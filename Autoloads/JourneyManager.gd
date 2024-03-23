extends Node

var possible_pickups_and_dropoffs : Array[Vector2]
var active_pickups_or_dropoffs : Array[Vector2]

var num_active_journeys : int = 0
const MAX_ACTIVE_JOURNEYS : int = 3

signal new_pickup_location_set(pickup_location)


func _ready():
	Events.dropped_off.connect(_on_dropped_off)


func car_is_full() -> bool:
	if num_active_journeys >= MAX_ACTIVE_JOURNEYS:
		return true
	else:
		return false


func start_new_journey(pickup_location):
	active_pickups_or_dropoffs.erase(pickup_location)

	var journey_node = load("res://Rides/Journey.tscn")
	var new_journey = journey_node.instantiate()
	call_deferred("add_child", new_journey)

	new_journey.pickup_loc = pickup_location
	new_journey.dropoff_loc = get_new_available_location()

	num_active_journeys += 1

	possible_pickups_and_dropoffs.append(pickup_location)

	return new_journey


func _on_dropped_off(dropoff_location):
	active_pickups_or_dropoffs.erase(dropoff_location)
	num_active_journeys -= 1

	possible_pickups_and_dropoffs.append(dropoff_location)


func get_new_available_location() -> Vector2:
	var new_loc = possible_pickups_and_dropoffs.pick_random()
	active_pickups_or_dropoffs.append(new_loc)
	possible_pickups_and_dropoffs.erase(new_loc)
	return new_loc
