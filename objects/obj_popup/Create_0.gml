scrib = scribble(message).blend(text_color, 1).align(fa_center, fa_middle).wrap(400)

padding = 10

wid = scrib.get_width() + padding * 2
ht = scrib.get_height() + padding * 2

x = room_width + (wid / 2)
y = padding + ( ht / 2)

xtarget = x - wid - 20
ytarget = y

alarm[0] = 300