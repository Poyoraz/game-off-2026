if(shock_enabled) {
	disable_shock()
	
	alarm[0] = passive_time
} else {
	enable_shock()
	
	alarm[0] = shock_time
}