// Inherit the parent event
event_inherited();

brain.tick(self)
weapon.tick(self)

if(mouse_on_enemy) {
	ui_transparency = scr_ease_value(ui_transparency, 100, 7)
} else {
	ui_transparency = scr_ease_value(ui_transparency, 0, 7)
}

visual_health_perc = scr_ease_value(
	visual_health_perc,
	hp / max_hp * 100,
	10,
	true
)