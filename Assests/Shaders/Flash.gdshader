shader_type canvas_item;

uniform vec4 flash_colr : hint_color = vec4(1.0);
uniform float flash_modifier : hint_range(0.0, 1.0) = 0.8;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	color.rgb = mix(color.rgb, flash_colr.rgb, flash_modifier);
	COLOR = color;
}