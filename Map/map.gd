extends Node2D


func _ready():
	Events.dropped_off.connect(_on_dropped_off)


func _on_dropped_off():
	var pickup_dropoff = load("res://Rides/pickup_dropoff.tscn")
	var instance = pickup_dropoff.instantiate()

	call_deferred("add_child", instance)
	instance.position = Vector2(50,50)
