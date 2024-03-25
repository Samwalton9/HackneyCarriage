shader_type canvas_item;

uniform vec4 hair_color : source_color;
uniform vec4 new_hair_color : source_color;

uniform vec4 shirt_color : source_color;
uniform vec4 new_shirt_color : source_color;

uniform vec4 skin_color : source_color;
uniform vec4 new_skin_color : source_color;

uniform vec4 trousers_color : source_color;
uniform vec4 new_trousers_color : source_color;

// Avoid floating point errors
bool colorMatch(vec4 c1, vec4 c2, float maxDiff) {
    return (
        abs(c1.r - c2.r) < maxDiff
        && abs(c1.g - c2.g) < maxDiff
        && abs(c1.b - c2.b) < maxDiff
		&& abs(c1.a - c2.a) < maxDiff
    );
}

void fragment() {
	vec4 current_colour = texture(TEXTURE, UV); // Current pixel colour
	
	if (colorMatch(current_colour, hair_color, 0.01))
	{
		COLOR = new_hair_color;
	}
	else if (colorMatch(current_colour, shirt_color, 0.01))
	{
		COLOR = new_shirt_color;
	}
	else if (colorMatch(current_colour, skin_color, 0.01))
	{
		COLOR = new_skin_color;
	}
	else if (colorMatch(current_colour, trousers_color, 0.01))
	{
		COLOR = new_trousers_color;
	}
	else
	{
		COLOR = current_colour;
	}
}