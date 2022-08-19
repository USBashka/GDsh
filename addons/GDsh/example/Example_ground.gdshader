shader_type spatial;

uniform sampler2D heightmap;

void vertex() {
	VERTEX.y += texture(heightmap, UV).r;
}
void fragment() {
	ALBEDO = vec3(0.01, texture(heightmap, UV).r/4.0, 0.01);
}
