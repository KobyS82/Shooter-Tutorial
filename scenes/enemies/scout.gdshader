shader_type canvas_item;

uniform vec3 color: source_color = vec3(1);
uniform float progress: hint_range(0.0, 1.0, 0.1) = 0;

void fragment() {
	// texture().a == opacity
	float current_a = texture(TEXTURE, UV).a;
	// Mixes texture with a pure white color, but keeps the pixels opacity
	vec4 target_color = mix(texture(TEXTURE, UV), vec4(color, current_a), progress);
	COLOR = target_color;
	
}
