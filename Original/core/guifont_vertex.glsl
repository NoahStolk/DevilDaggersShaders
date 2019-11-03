// guifont
#version 330
in        vec3 in_position;
in        vec3 in_normal;
in        vec2 in_uv0;
in        vec2 in_uv1;
uniform vec4 uv_scale_offset;
uniform sampler2D tex_diffuse;
uniform sampler2D tex_diffuse2;
out     vec2 vert_uv0;
out     vec2 vert_uv1;
out     vec4 vert_colour;
void main( )
{
	vert_uv0 = in_uv0;
	vert_uv1 = in_uv1;
	vert_colour = vec4( in_normal.bgr, in_position.z );
	vec2 sc_pos = vec2( in_position.x, in_position.y ) * uv_scale_offset.xy + uv_scale_offset.zw;
	gl_Position = vec4( sc_pos.x, -sc_pos.y, 0.0, 1.0 );
}