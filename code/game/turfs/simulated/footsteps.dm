/turf/simulated/Entered(var/mob/living/carbon/human/H)
	..()
	if(istype(H))
		H.handle_footstep(src)
		H.step_count++



/mob/living/carbon/human/proc/handle_footstep(var/turf/simulated/T)
	var/turf/simulated/T = get_turf(src)
	if(!istype(T))
		return

	if(buckled || lying || throwing)
		return //people flying, lying down or sitting do not step

	if(MOVING_QUICKLY(src))
		if(step_count % 2) //every other turf makes a sound
			return


	if(shoes && (shoes.item_flags & SILENT))
		return // quiet shoes

	if(!has_gravity(src))
		if(step_count % 3) // don't need to step as often when you hop around
			return

	//if(!has_organ(BP_L_FOOT) && !has_organ(BP_R_FOOT))
		//return //no feet no footsteps

	var/footsound = T.get_footstep_sound()
	if(footsound)
		var/range = -(world.view - 2)
		var/volume = 70
		if(MOVING_DELIBERATELY(src))
			volume -= 45
			range -= 0.333
		if(!shoes)
			volume -= 60
			range -= 0.333

		playsound(T, footsound, volume, 1, range)