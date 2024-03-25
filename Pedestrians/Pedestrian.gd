extends CharacterBody2D

@export var patrol_points : Array[Vector2]
@export var speed : float = 25

@onready var nav_agent := $NavigationAgent2D

var point_counter : int = 0
var destination : Vector2

func _ready() -> void:
	call_deferred("actor_setup")


func _physics_process(_delta : float) -> void:
	var next_pos : Vector2 = nav_agent.get_next_path_position()
	var dir := global_position.direction_to(next_pos)

	velocity = dir * speed
	move_and_slide()

	var distance_left : Vector2 = destination - global_position
	if distance_left.length() < 1:
		point_counter += 1
		if point_counter == len(patrol_points):
			point_counter = 0

		get_next_destination()

	# TODO: Replace with visible rotation rather than snapping
	look_at(destination)


func actor_setup() -> void:
	await get_tree().physics_frame
	get_next_destination()


func get_next_destination() -> void:
	destination = patrol_points[point_counter]
	nav_agent.target_position = destination
