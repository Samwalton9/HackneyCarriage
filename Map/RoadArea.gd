extends Area2D

@export var road_name : String


func _on_area_entered(_area : Area2D) -> void:
	Events.road_entered.emit(road_name)
