// warp
#version 330
uniform vec3 cam_position;
uniform float light_scale;
uniform sampler2D tex_diffuse;
in      vec4 vert_world_position;
in      vec3 vert_view_dir;
in      vec3 vert_world_normal;
out     vec4 out_colour0;

vec3 get_lighting(const in vec4 pos, const in vec3 cam_p, float ls);

vec3 get_lighting(const in vec4 pos, const in vec3 cam_p, float ls)
{
	vec3 pos2 = pos.xyz / ls;
	float fade = length(pos2.xyz);
	fade = 2.0 * clamp((60.0 - fade) / 60.0, 0.0, 1.0);
	vec3 light = vec3(fade);
	light += pow(fade, 0.3) * pow(clamp((1.0 - length(pos.xyz - cam_p) / 6.0), 0.0, 0.5), 1.2) * 22.6 * vec3(1.0, 0.5, 0.1);
	return light * 0.5;
}

void main()
{
	vec2 hackuv = normalize(vert_view_dir + vert_world_normal * 0.1).xz;
	vec3 diffuse = texture(tex_diffuse, hackuv, -1.0).rgb * 1.0;

	diffuse = diffuse * diffuse;
 
	vec3 result0 = diffuse;
	vec3 fade = get_lighting(vert_world_position, cam_position, light_scale);

	out_colour0 = vec4(pow(result0, vec3(1.0 / 2.0)), 0.5);
}