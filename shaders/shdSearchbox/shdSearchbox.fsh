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

void main()
{
	vec2 res = vec2(400.0, 50.0);
	vec2 coord = v_vTexcoord * res;
	//coord.y = res.y - coord.y;
	
	vec2 origin = vec2(0.0);
    vec4 radii = vec4(16.0);
    vec2 size = vec2(400.0 / 2.625 + 4.0, 50.0 / 2.0 - 3.25);
    
    float dist = sdf_rect(origin, size, radii, coord);
    
    float f_border = sdf_border(dist, 2.0);
	
    gl_FragColor = vec4(f_border);
}
