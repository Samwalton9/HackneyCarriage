extends CharacterBody2D

@export var max_speed : float = 80
@export var max_reverse_speed : float  = 20
@export var acceleration : float  = 1.5
@export var turn_rate : float  = 0.01
@export var deceleration : float  = 0.5

var current_speed : float = 0.0
var current_reverse_speed : float  = 0.0

func _physics_process(_delta):
	var up_down = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	var left_right = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	if left_right > 0:
		# Wheels right
		if current_speed >= 0.0:
			turn_right()
		else:
			turn_left()
	elif left_right < 0:
		# Wheels left
		if current_speed >= 0.0:
			turn_left()
		else:
			turn_right()

	if up_down > 0:
		# Forwards
		current_speed += acceleration
	elif up_down < 0:
		# Reverse
		current_reverse_speed = max_reverse_speed
		current_speed -= acceleration
	else:
		current_reverse_speed = 0
		current_speed -= deceleration

	current_speed = clamp(current_speed, -current_reverse_speed, max_speed)

	velocity = Vector2(1,0).rotated(rotation) * current_speed

	# Debug
	$DebugSpeedLabel.velocity = velocity

	move_and_slide()


func turn_left() -> void:
	rotation -= turn_rate

func turn_right() -> void:
	rotation += turn_rate
