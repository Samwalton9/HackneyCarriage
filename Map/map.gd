extends Node2D

var spawn_locations : Array[Vector2]


func _ready():
	Events.dropped_off.connect(_on_dropped_off)
	spawn_locations = $TileMap.get_possible_pickup_dropoff_locations()
	JourneyManager.possible_pickups_and_dropoffs = spawn_locations

	if OS.is_debug_build():
		for spawn_loc in spawn_locations:
			var debug_pickup = load("res://Rides/debug_pickup.tscn")
			var instance = debug_pickup.instantiate()
			call_deferred("add_child", instance)
			instance.position = spawn_loc


func _on_dropped_off(_dropoff_loc):
	var pickup_dropoff = load("res://Rides/pickup_dropoff.tscn")
	var instance = pickup_dropoff.instantiate()

	call_deferred("add_child", instance)
	instance.position = JourneyManager.get_new_available_location()
