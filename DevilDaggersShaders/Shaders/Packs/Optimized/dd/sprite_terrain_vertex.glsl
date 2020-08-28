// sprite_terrain
#version 330
in      vec3 in_position;
in      vec3 in_normal;
in      vec2 in_uv0;
out     vec2 vert_uv0;
out     mat2 vert_rotation_inv;

void main()
{
	vert_uv0 = in_uv0;
	vert_rotation_inv[0] = in_normal.xy * vec2(1.0, -1.0);
	vert_rotation_inv[1] = in_normal.yx * vec2(1.0,  1.0);
	vert_rotation_inv = inverse(vert_rotation_inv);
	gl_Position = vec4(in_position, 1.0);
}