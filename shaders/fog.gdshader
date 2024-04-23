shader_type spatial;
render_mode cull_disabled;

uniform sampler2D noise;
uniform vec2 scale = vec2(1.0);
uniform vec2 offset = vec2(0.0);
uniform float speed = 1.0;
uniform float lower_strength = 0.0;


void vertex() {
	VERTEX += vec3(sin(TIME*3.0+UV.y), 0.0, cos(TIME*3.0+VERTEX.x));
}

void fragment() {
	vec3 c = texture(noise, UV * scale + offset + vec2(TIME*speed/6.0, 0.0)).rgb;
	ALBEDO = clamp(c-0.5, 0.0, 1.0);
	ALPHA = c.r + 0.2;
	ALPHA += UV.y * lower_strength;
	ALBEDO.rgb -= UV.y * lower_strength;
	// -> -->  >= <=
}
