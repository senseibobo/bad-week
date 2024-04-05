shader_type canvas_item;

uniform float strength: hint_range(0.0, 1.0) = 0.5;

void fragment() {
	COLOR.rgb = vec3(1.0,0.0,0.0);
	COLOR.a = clamp(distance(UV,vec2(0.5,0.5))*strength,0.0,1.0);
}
