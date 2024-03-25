extends Label

var velocity := Vector2.ZERO

func _process(_delta : float) -> void:
	text = str(snapped(velocity.length(),1))
