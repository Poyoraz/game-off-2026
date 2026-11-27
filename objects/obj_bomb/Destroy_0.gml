var shape = particle_get_info(prs_explosion).emitters[0].parttype.ind
		
part_particles_create(
	obj_boss_head.part_sys,
	x,
	y,
	shape,
	30
)