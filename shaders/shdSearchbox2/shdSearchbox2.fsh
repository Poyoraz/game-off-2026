//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

float sdf_rect(vec2 topleft, vec2 size, vec4 radii, vec2 pos) {
    pos -= topleft; // normalize as if rect starts at 0,0
    pos -= size;    // not sure why but it's needed ..
    // from https://iquilezles.org/articles/distfunctions2d/
    radii.xy = (pos.x>0.0)?radii.xy : radii.zw;
    radii.x  = (pos.y>0.0)?radii.x  : radii.y;
    vec2 q = abs(pos)-size+radii.x;
    return min(max(q.x,q.y),0.0) + length(max(q,0.0)) - radii.x;
}

float sdf_border(in float d, in float thickness) {
    return d <= 0.0 ? 1.0 - smoothstep(thickness - 0.4, thickness + 0.4, abs(d)) : 0.0;
}

float sdf_fill(float d, float softness) {
    d = 1.0 - d;
    return smoothstep(1.0 - softness, 1.0 + softness, d);
}

void main()
{
	vec2 res = vec2(400.0, 50.0);
	vec2 coord = v_vTexcoord * res;
	//coord.y = res.y - coord.y;
	
	float innerGap = 8.0;
	vec2 origin = vec2(innerGap);
    vec4 radii = vec4(10.0);
    vec2 size = vec2(400.0 / 2.625 + 4.0 - innerGap, 50.0 / 2.0 - 3.0 - innerGap);
    
    float dist = sdf_rect(origin, size, radii, coord);
	float f_fill   = sdf_fill(dist, 0.5);
    
    float f_border = sdf_border(dist, 4.0);
	
    gl_FragColor = vec4(85.0 / 255.0, 87.0 / 255.0, 117.0 / 255.0, 1.0) * vec4(f_fill);
}
