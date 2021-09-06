shader_type spatial;
render_mode cull_disabled, depth_draw_always;

uniform vec4 albedo: hint_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float roughness = 0.98;
uniform float metallic = 0.0;

// normal vector (x, y, z) and distance from origin (w)

uniform vec4 plane = vec4(0.0, -1.0, 0.0, 1000.0);

float intersection (vec3 vertex, mat4 cam) {
	vec3 pos = (cam * vec4(vertex, 1.0)).xyz;
	return plane.x * pos.x 
		+ plane.y * pos.y
		+ plane.z * pos.z
		+ plane.w;
}

void fragment() {
	float cross_section = intersection(VERTEX, CAMERA_MATRIX);
	vec3 color = cross_section >= 0.0 ? albedo.rgb : vec3(0, 0, 0);
		
	if (cross_section <= 0.0) {
		discard;
	}
	
	ALBEDO = color;
	ROUGHNESS = roughness;
	METALLIC = metallic;

	// float alpha = smoothstep(0.0, albedo.a * 0.1, clamp(cross_section * 2.0, 0.0, 1.0));
	// ALPHA = clamp(alpha, 0.1, 1.0);
	//ALPHA = albedo.a;
}