// warp
#version 330
uniform sampler2D tex_diffuse;
in      vec3 vert_view_dir;
in      vec3 vert_world_normal;
out     vec4 out_colour0;

void main()
{
	vec2 hackuv = normalize(vert_view_dir + vert_world_normal * 0.1).xz;
	vec3 diffuse = texture(tex_diffuse, hackuv, -1.0).rgb * 1.0;

	out_colour0 = vec4(pow(diffuse * diffuse, vec3(1.0 / 2.0)), 0.5);
}