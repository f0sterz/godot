shader_type spatial;
uniform sampler2D wave_pattern; 
uniform vec4 color:source_color = vec4(0.19, 0.71, 0.82, 0.5); 
uniform float height_factor:hint_range(0,1.0) = 0.03;

void vertex() {
	vec4 wave = texture(wave_pattern, UV); 
	float displacement = sin(VERTEX.x * wave.x * TIME) + cos(VERTEX.z * wave.z * TIME); 
	VERTEX.y += displacement * height_factor;
	// Called for every vertex the material is visible on.
}

void fragment() {
	ALBEDO = color.rgb; ALPHA = color.a;
	
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
