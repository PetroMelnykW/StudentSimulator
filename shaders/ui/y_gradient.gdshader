shader_type canvas_item;

uniform vec4 color1: source_color;
uniform vec4 color2: source_color;

void fragment() {
	COLOR.rgb = mix(color1, color2, UV.y).rgb;
}
