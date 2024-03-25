extends AnimatedSprite2D

@export var walking := false

func _ready() -> void:
	if walking:
		start_walking()


func start_walking() -> void:
	play()


func stop_walking() -> void:
	stop()
