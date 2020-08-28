// particle_decal
#version 330
uniform mat4 user_matrix;
uniform sampler2D tex_diffuse;
in      vec2 vert_uv0;
in      vec3 vert_normal;
in      vec3 vert_colour;
in      vec3 vert_rim;
in      vec3 vert_view_vec;
out     vec4 out_colour0;

void main()
{
	vec3 result0 = vec3(0.7, 0.02, 0.01);
	result0 = vert_colour * vert_colour * 0.5;

	float fresnel = 0.5 + 0.5 * dot(normalize(vert_view_vec), normalize(vert_normal));
	fresnel *= min(1.0, user_matrix[3].y);
	fresnel += max(0.0, user_matrix[3].y - 1.0);

	result0 = mix(result0, vert_rim * vert_rim * 0.5, fresnel);

	result0 = clamp(result0 * (texture(tex_diffuse, vert_uv0).rgb + 0.5), 0.0, 1.0);

	out_colour0 = vec4(pow(result0 * 2.0, vec3(1.0 / 2.0)), 1.0);
}