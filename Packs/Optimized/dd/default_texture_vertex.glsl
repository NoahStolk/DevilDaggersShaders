// default_texture
#version 330
in      vec3 in_position;
in      vec2 in_uv0;
uniform vec4 uv_scale_offset;
out     vec2 vert_uv0;

void main()
{
	vert_uv0 = in_uv0 * uv_scale_offset.xy + uv_scale_offset.zw;
	gl_Position = vec4(in_position, 1.0);
}