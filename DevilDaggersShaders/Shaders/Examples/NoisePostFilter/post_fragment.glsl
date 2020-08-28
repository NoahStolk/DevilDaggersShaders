// post
#version 330
uniform float seed;
uniform float vhs_scale;
uniform float lut_scale;
uniform float lut2_scale;
uniform float exposure;
uniform sampler2D tex_diffuse;
uniform sampler2D tex_lut;
uniform sampler2D tex_lut2;
in      vec2 vert_uv0;
out     vec4 out_colour0;

void main()
{
	vec2 vuv = (gl_FragCoord.xy / textureSize(tex_diffuse, 0)) + vhs_scale * 0.003 * vec2(pow(1.0 - (abs(seed - vert_uv0.y)), seed * 144.0), 0.0);
	
	vec4 result0 = texture(tex_diffuse, vuv) * vec4(1.0, 0.0, 0.0, 1.0);
	result0 += texture(tex_diffuse, vuv + vhs_scale * vec2(0.002, 0.0)) * vec4(0.0, 1.0, 0.0, 1.0);
	result0 += texture(tex_diffuse, vuv + vhs_scale * vec2(-0.002, 0.0)) * vec4(0.0, 0.0, 1.0, 1.0);

	float r = sin(seed * 63.3 + dot(vert_uv0.xy, vec2(12.9898, 78.233))) * 43758.5453;
	vec3 noise = vec3(fract(r * 0.111), fract(r * 12.0), fract(r * 0.01));

	result0.rgb += noise / 3.0;

	result0 *= 2.0;
	result0.a = 1.0;
	
	float quantpow = 1.1;
	float sat = 1.0 - min(result0.r, min(result0.g, result0.b)) / max(0.001, max(result0.r, max(result0.g, result0.b)));
	quantpow -= sat * 0.9;
	result0.rgb = pow(result0.rgb, vec3(quantpow));
	vec3 quant = vec3(19.0);
	result0.rgb = floor(result0.rgb * quant) / quant;
	result0.rgb = pow(result0.rgb, vec3(1.0 / quantpow));

	// LUT TEST
	vec3 lut_in = clamp(result0.rgb, vec3(0.0), vec3(1.0));
	float lut_tex_size = textureSize(tex_lut, 0).x;
	float lut_b = lut_in.b * 15.0;
	float lut_b_sub = fract(lut_b);
	lut_b -= lut_b_sub;
	vec2 lut_rg = lut_in.rg * 15.0 / vec2(lut_tex_size, 256.0);
	lut_rg.g += lut_b * 16.0 / 256.0;
	lut_rg += vec2(0.5 / lut_tex_size, 0.5 / 256.0);
	lut_rg.g = 1.0 - lut_rg.g;
	vec3 lut_rgb = mix(textureLod(tex_lut, lut_rg, 0), textureLod(tex_lut, lut_rg - vec2(0.0, 16.0 / 256.0), 0), lut_b_sub).rgb;
	vec3 lut2_rgb = mix(textureLod(tex_lut2, lut_rg, 0), textureLod(tex_lut2, lut_rg - vec2(0.0, 16.0 / 256.0), 0), lut_b_sub).rgb;
	result0.rgb = mix(mix(result0.rgb, lut_rgb, lut_scale), lut2_rgb, lut2_scale);

	result0.a = 1.0;

	out_colour0 = result0 * exposure;
}