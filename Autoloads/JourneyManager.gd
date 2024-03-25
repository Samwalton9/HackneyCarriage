extends Node

var possible_pickups_and_dropoffs : Array[Vector2]
var active_pickups_or_dropoffs : Array[Vector2]

var num_active_journeys : int = 0
const MAX_ACTIVE_JOURNEYS : int = 3

signal new_journey(journey_node : Node)


func _ready() -> void:
	Events.dropped_off.connect(_on_dropped_off)


func car_is_full() -> bool:
	if num_active_journeys >= MAX_ACTIVE_JOURNEYS:
		return true
	else:
		return false


func start_new_journey(pickup_location : Vector2) -> Node:
	active_pickups_or_dropoffs.erase(pickup_location)

	var journey_node := load("res://Rides/Journey.tscn")
	var new_journey_node : Node = journey_node.instantiate()
	call_deferred("add_child", new_journey_node)

	new_journey_node.pickup_loc = pickup_location
	var dropoff_location : Vector2 = get_new_available_location()
	new_journey_node.dropoff_loc = dropoff_location

	num_active_journeys += 1

	possible_pickups_and_dropoffs.append(pickup_location)

	new_journey_node.destination_road_name = find_street_name(dropoff_location)

	new_journey.emit(new_journey_node)

	return new_journey_node


func _on_dropped_off(dropoff_location : Vector2) -> void:
	active_pickups_or_dropoffs.erase(dropoff_location)
	num_active_journeys -= 1

	possible_pickups_and_dropoffs.append(dropoff_location)


func get_new_available_location() -> Vector2:
	var new_loc : Vector2 = possible_pickups_and_dropoffs.pick_random()
	active_pickups_or_dropoffs.append(new_loc)
	possible_pickups_and_dropoffs.erase(new_loc)
	return new_loc


func find_street_name(dropoff_location : Vector2) -> String:
	var raycast := RayCast2D.new()
	raycast.position = Globals.map_global_position + dropoff_location
	add_child(raycast)

	raycast.target_position = Vector2.ZERO
	raycast.collide_with_areas = true
	raycast.set_collision_mask_value(5, true)
	raycast.hit_from_inside = true
	raycast.force_raycast_update()

	var colliding_street := raycast.get_collider()

	return colliding_street.road_name
