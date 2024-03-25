extends Node2D

var spawn_locations : Array[Vector2]
var active_pickups : int = 0

const MAX_PICKUPS : int = 3

@onready var timer = $NewPickupTimer


func _ready():
	Events.picked_up.connect(_on_picked_up)
	spawn_locations = $TileMap.get_possible_pickup_dropoff_locations()

	JourneyManager.possible_pickups_and_dropoffs = spawn_locations
	Globals.map_global_position = global_position

	if OS.is_debug_build():
		for spawn_loc in spawn_locations:
			var debug_pickup = load("res://Rides/debug_pickup.tscn")
			var instance = debug_pickup.instantiate()
			call_deferred("add_child", instance)
			instance.position = spawn_loc


func _on_new_pickup_timer_timeout() -> void:
	if active_pickups < MAX_PICKUPS:
		var pickup_dropoff = load("res://Rides/pickup_dropoff.tscn")
		var instance = pickup_dropoff.instantiate()

		call_deferred("add_child", instance)
		instance.position = JourneyManager.get_new_available_location()

		active_pickups += 1


func _on_picked_up(_loc) -> void:
	active_pickups -= 1
