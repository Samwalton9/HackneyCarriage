extends CharacterBody2D

enum {
	WAITING,
	PICKING_UP
}

var state := WAITING
var destination : Vector2
var original_position : Vector2
var distance_to_original_position : float = 0.0
var speed : float = 10.0

signal reached_taxi


func _ready() -> void:
	original_position = global_position
	destination = original_position


func _physics_process(_delta : float) -> void:
	distance_to_original_position = global_position.distance_to(original_position)
	if state == PICKING_UP or distance_to_original_position > 1:
		var dir := global_position.direction_to(destination)

		# TODO: Replace with visible rotation rather than snapping
		$Person.look_at(destination)
		$Person.rotation_degrees -= 90

		velocity = dir * speed
		move_and_slide()

	elif distance_to_original_position < 1:
		$Person.stop_walking()


func move_to_taxi(taxi_position : Vector2) -> void:
	state = PICKING_UP
	destination = taxi_position
	$Person.start_walking()


func return_to_position() -> void:
	state = WAITING
	destination = original_position


func _on_taxi_enter_area_area_entered(_area : Area2D) -> void:
	# TODO: This is checked too many times, and passengers can be picked
	# up by ramming the car into them at speed.
	if not JourneyManager.car_is_full():
		reached_taxi.emit()
		# TODO: Passenger shouldn't invisibly walk towards old position
		# To reproduce bug with auto-completing rides make visible true.
		visible = false
		state = WAITING
