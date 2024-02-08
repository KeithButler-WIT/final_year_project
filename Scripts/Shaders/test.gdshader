shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX.y += 0.5;
	VERTEX.y += cos(TIME) * 0.2;
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = vec3(0.1,0.1,0.1);
	ROUGHNESS = 1.0;
	RIM = 0.1;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
