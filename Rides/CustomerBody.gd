extends CharacterBody2D

enum {
	WAITING,
	PICKING_UP
}

var state := WAITING
var destination : Vector2
var original_position : Vector2
var distance_to_original_position : float = 0.0
var speed = 5.0

signal reached_taxi


func _ready():
	original_position = global_position
	destination = original_position


func _physics_process(_delta):
	distance_to_original_position = global_position.distance_to(original_position)
	if state == PICKING_UP or distance_to_original_position > 1:
		var dir = global_position.direction_to(destination)

		# TODO: Replace with visible rotation rather than snapping
		$CustomerSprite.look_at(destination)
		$CustomerSprite.rotation_degrees -= 90

		velocity = dir * speed
		move_and_slide()


func move_to_taxi(taxi_position : Vector2) -> void:
	state = PICKING_UP
	destination = taxi_position


func return_to_position() -> void:
	state = WAITING
	destination = original_position


func _on_taxi_enter_area_area_entered(_area):
	reached_taxi.emit()
	visible = false
	state = WAITING
