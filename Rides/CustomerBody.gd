extends CharacterBody2D

enum {
	WAITING,
	PICKING_UP
}

var state := WAITING
var destination
var speed = 5.0

signal reached_taxi


func _physics_process(_delta):
	if state == PICKING_UP:
		var dir = global_position.direction_to(destination.global_position)
		
		velocity = dir * speed
		move_and_slide()


func move_to_taxi(taxi_position : Area2D) -> void:
	state = PICKING_UP
	destination = taxi_position


func _on_taxi_enter_area_area_entered(_area):
	reached_taxi.emit()
	visible = false
	state = WAITING
