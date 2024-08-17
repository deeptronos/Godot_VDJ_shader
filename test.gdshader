shader_type canvas_item;

global uniform vec2 term1;

void vertex() {
	// Called for every vertex the material is visible on.
}

// Reactive VDJ shader:
	// Restrict 
	// - Figure out TIME value where 

// Credit to Danilo Guanabara
// https://www.shadertoy.com/view/XsXXDn

//const float demotime = 1.4;

uniform float arb : hint_range(0, 3.5) = 0.5;
uniform float arb2 : hint_range(0.,1.) = 1.;

void fragment(){
	//float demotime = TIME;
	float demotime = arb;
	vec2 r = 1./SCREEN_PIXEL_SIZE;
	//r = r * term1;
	vec3 c;
	//float l,z = TIME;

	float l, z = demotime;
	
	for (int i=0; i<3; i++){
		vec2 uv,p = FRAGCOORD.xy/r;
		uv = p;
		p -= 0.5;
		p.x *= r.x/r.y;
		z += 0.07;
		l = length(p) / arb2;
		uv += ((p*1.)/l *(sin((z))+1.) * abs(sin(l*10.-z-z)));
		//uv += p/l * tan(l + TIME) * 2.;
		c[i] = clamp( 0.01 / length(mod(uv, 1.)-.5), 0.0, 1) * arb2;
		//c[i] /= tan(TIME + float(i) * 0.1) * 1.;
		//c[i] /= tan(demotime + float(i) * 0.1) * 0.01;
	}
  //COLOR = vec4(r, 0.5, 1.0);
	COLOR = vec4(c/(l)*1., TIME);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
