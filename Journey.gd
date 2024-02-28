extends Node

var journey_distance : float:
	get:
		return journey_distance
	set(value):
		journey_distance = value
		set_journey_max_cost(value)

var journey_cost : int

func _ready():
	Events.dropped_off.connect(_on_dropped_off)


func set_journey_max_cost(distance) -> void:
	journey_cost = round(distance * 5)


func _on_dropped_off():
	Globals.money += Journey.journey_cost
