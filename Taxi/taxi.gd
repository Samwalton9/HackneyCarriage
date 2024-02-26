extends CharacterBody2D

@export var max_speed = 80
@export var max_reverse_speed = 10
@export var acceleration = 1.5
@export var turn_rate = 0.01

var current_speed : float = 0.0

func _physics_process(delta):
	var up_down = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	var left_right = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	if left_right > 0:
		# Right
		rotation += turn_rate
	elif left_right < 0:
		# Left
		rotation -= turn_rate

	if up_down > 0:
		# Forwards
		current_speed += acceleration
	elif up_down < 0:
		# Reverse
		current_speed -= acceleration

	current_speed = clamp(current_speed, -max_reverse_speed, max_speed)

	velocity = Vector2(1,0).rotated(rotation) * current_speed

	move_and_slide()
