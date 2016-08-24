/mob/living/carbon/human/monkey/create_mob_hud()
	if(client && !hud_used)
		hud_used = new /datum/hud/monkey(src, ui_style2icon(client.prefs.UI_style), client.prefs.UI_style_color, client.prefs.UI_style_alpha)

/datum/hud/monkey/New(mob/living/carbon/human/owner, var/ui_style = 'icons/mob/screen_white.dmi', var/ui_color = "#ffffff", var/ui_alpha = 255)
	..()

	var/obj/screen/using
	var/obj/screen/inventory/inv_box

	using = new /obj/screen/act_intent()
	using.icon_state = mymob.a_intent
	using.color = ui_color
	using.alpha = ui_alpha
	static_inventory += using
	action_intent = using

	using = new /obj/screen/mov_intent()
	using.icon = ui_style
	using.icon_state = (mymob.m_intent == "run" ? "running" : "walking")
	using.screen_loc = ui_movi
	using.color = ui_color
	using.alpha = ui_alpha
	static_inventory += using
	move_intent = using

	using = new /obj/screen/drop()
	using.icon = ui_style
	using.screen_loc = ui_drop_throw
	using.color = ui_color
	using.alpha = ui_alpha
	static_inventory += using

	inv_box = new /obj/screen/inventory/hand()
	inv_box.name = "r_hand"
	inv_box.icon = ui_style
	inv_box.icon_state = "hand_r"
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	inv_box.screen_loc = ui_rhand
	inv_box.slot_id = slot_r_hand
	static_inventory += inv_box

	inv_box = new /obj/screen/inventory/hand()
	inv_box.name = "l_hand"
	inv_box.icon = ui_style
	inv_box.icon_state = "hand_l"
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	inv_box.screen_loc = ui_lhand
	inv_box.slot_id = slot_l_hand
	static_inventory += inv_box

	using = new /obj/screen/swap_hand()
	using.name = "hand"
	using.icon = ui_style
	using.icon_state = "swap_1_m"
	using.screen_loc = ui_swaphand1
	using.color = ui_color
	using.alpha = ui_alpha
	static_inventory += using

	using = new /obj/screen/swap_hand()
	using.name = "hand"
	using.icon = ui_style
	using.icon_state = "swap_2"
	using.screen_loc = ui_swaphand2
	using.color = ui_color
	using.alpha = ui_alpha
	static_inventory += using

	inv_box = new /obj/screen/inventory()
	inv_box.name = "mask"
	inv_box.icon = ui_style
	inv_box.icon_state = "mask"
	inv_box.screen_loc = ui_mask
	inv_box.slot_id = slot_wear_mask
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	toggleable_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "back"
	inv_box.icon = ui_style
	inv_box.icon_state = "back"
	inv_box.screen_loc = ui_back
	inv_box.slot_id = slot_back
	inv_box.color = ui_color
	inv_box.alpha = ui_alpha
	static_inventory += inv_box

	throw_icon = new /obj/screen/throw_catch()
	throw_icon.icon = ui_style
	throw_icon.screen_loc = ui_drop_throw
	throw_icon.color = ui_color
	throw_icon.alpha = ui_alpha
	hotkeybuttons += throw_icon

	internals = new /obj/screen/internals()
	infodisplay += internals

	healths = new /obj/screen/healths()
	infodisplay += healths

	healthdoll = new()
	infodisplay += healthdoll

	pull_icon = new /obj/screen/pull()
	pull_icon.icon = ui_style
	pull_icon.update_icon(mymob)
	pull_icon.screen_loc = ui_pull_resist
	static_inventory += pull_icon

	lingchemdisplay = new /obj/screen/ling/chems()
	infodisplay += lingchemdisplay

	lingstingdisplay = new /obj/screen/ling/sting()
	infodisplay += lingstingdisplay

	zone_select = new /obj/screen/zone_sel()
	zone_select.icon = ui_style
	zone_select.update_icon(mymob)
	static_inventory += zone_select

	inventory_shown = 0

	for(var/obj/screen/inventory/inv in (static_inventory + toggleable_inventory))
		if(inv.slot_id)
			inv.hud = src
			inv_slots[inv.slot_id] = inv
			inv.update_icon()
