extends AnimatedSprite2D

@export var walking := false

# TODO: Change these, mostly basic Aseprite palette hexes
var possible_shirt_colours := [
	Color.html("#639bff"),
	Color.html("#5fcde4"),
	Color.html("#ac3232"),
	Color.html("#8a6f30")
]

var possible_skin_colours := [
	Color.html("#eec39a"),
	Color.html("#e0ad7e"),
	Color.html("#9d7045"),
	Color.html("#623e2d")
]

var possible_hair_colours := [
	Color.html("#663931"),
	Color.html("#282423"),
	Color.html("#797575"),
	Color.html("#e46814")
]

var possible_trousers_colours := [
	Color.html("#3f3f74"),
	Color.html("#555454"),
]

func _ready() -> void:
	if walking:
		start_walking()

	randomise_colors()


func start_walking() -> void:
	play()


func stop_walking() -> void:
	stop()


func randomise_colors() -> void:
	select_and_set_random_color("new_shirt_color", possible_shirt_colours)

	select_and_set_random_color("new_skin_color", possible_skin_colours)

	select_and_set_random_color("new_hair_color", possible_hair_colours)

	select_and_set_random_color("new_trousers_color", possible_trousers_colours)


func select_and_set_random_color(
		shader_parameter : String,
		color_selection : Array
		) -> void:
	var random_color : Color  = color_selection.pick_random()
	material.set("shader_parameter/" + shader_parameter, random_color)
