draw_set_colour(c_red)

if(timer > 0) {
	draw_text(20, 20, $"TIME UNTIL LAVA RISING {floor(timer / 0.6)/100}")
} else {
	draw_text(20, 20, $"WARNING, RISING LAVA")
}