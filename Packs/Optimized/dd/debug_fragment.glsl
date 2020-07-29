// debug
#version 330
uniform sampler2D tex_diffuse;
uniform sampler2D tex_normal;
uniform vec3 light_dir;
uniform float texel_density;
in      vec2 vert_uv0;
in      vec4 vert_position;
in      mat3 tbn;
out     vec4 out_colour0;

void main()
{
	vec2 scaled_uv = vert_uv0 * texel_density / textureSize(tex_diffuse, 0);
	vec3 result0;
	vec4 normal_height = texture(tex_normal, scaled_uv.xy).gaab;
	normal_height.xy = normal_height.xy * 2.0 - 1.0;
	normal_height.b  = 1.0 - sqrt(dot(normal_height.xy, normal_height.xy));

	vec3 normal = normalize(tbn * normal_height.rgb);
	vec3 diffuse = texture(tex_diffuse, scaled_uv.xy).rgb;
	diffuse = diffuse * diffuse;

	result0 = diffuse * (dot(normal, light_dir) * 0.5 + 0.5);
	result0.rgb = tbn[2];
	result0.g = fract(vert_position.y / 5.0);
	result0.rb = vert_position.xz / 1000.0 + vec2(0.5);
	result0.rgb = tbn[0] * 0.5 + 0.5;

	out_colour0 = vec4(pow(result0, vec3(0.5)), 1.0);
}