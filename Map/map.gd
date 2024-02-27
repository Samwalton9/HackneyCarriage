extends Node2D


func _ready():
	Events.new_pickup.connect(_on_new_pickup)


func _on_pickup_dropoff_dropped_off():
	var pickup_dropoff = load("res://Rides/pickup_dropoff.tscn")
	var instance = pickup_dropoff.instantiate()

	call_deferred("add_child", instance)
	instance.position = Vector2(50,50)


func _on_new_pickup(node):
	node.dropped_off.connect(_on_pickup_dropoff_dropped_off)
