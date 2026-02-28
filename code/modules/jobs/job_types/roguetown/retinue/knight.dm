/datum/job/roguetown/knight
	title = "Cataphract" //The main guy. The main character.
	flag = KNIGHT
	department_flag = RETINUE
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_TOLERATED_UP
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	allowed_patrons = ALL_NICE_PATRONS
	tutorial = "Having served as one of the most faithful members of the Retinue serving from humble beginnings as a squire, you were rewarded most gloriously by the Viscount with a proper noble title and knighthood, serving as the Cataphract to the House of Lyndvhar. Lead your men to victory--and keep them in line--and you will see this city prosper under a thousand suns and be returned to its former glory."
	display_order = JDO_KNIGHT
	whitelist_req = FALSE
	outfit = /datum/outfit/job/roguetown/knight
	advclass_cat_rolls = list(CTAG_ROYALGUARD = 20)
	job_traits = list(TRAIT_NOBLE, TRAIT_STEELHEARTED, TRAIT_GUARDSMAN)
	give_bank_account = TRUE
	noble_income = 10
	min_pq = 0
	max_pq = null
	round_contrib_points = 3

	cmode_music = 'sound/music/combat_knight.ogg'

	job_subclasses = list(
		/datum/advclass/knight/heavy,
		/datum/advclass/knight/footknight,
		/datum/advclass/knight/mountedknight,
		)

/datum/outfit/job/roguetown/knight
	job_bitflag = BITFLAG_GARRISON

/datum/job/roguetown/knight/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak/banneret))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "cataphract's cloak ([index])"
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Ser"
		if(should_wear_femme_clothes(H))
			honorary = "Dame"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"

/datum/outfit/job/roguetown/knight
	cloak = /obj/item/clothing/cloak/banneret
	neck = /obj/item/clothing/neck/roguetown/bevor
	gloves = /obj/item/clothing/gloves/roguetown/plate
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	head = /obj/item/clothing/head/roguetown/helmet/heavy/banneret
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine/banneret
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	pants = /obj/item/clothing/under/roguetown/chainlegs/banneret
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	belt = /obj/item/storage/belt/rogue/leather/plaquegold
	backr = /obj/item/storage/backpack/rogue/satchel/short/black
	id = /obj/item/scomstone/garrison
	backpack_contents = list(
		/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 1,
		/obj/item/storage/keyring/marshal = 1,
	)

/datum/advclass/knight/heavy
	name = "Heavy Knight"
	tutorial = "You've trained thoroughly and hit far harder than most - adept with massive swords, axes, maces, and polearms. People may fear the mounted knights, but they should truly fear those who come off their mount..."
	outfit = /datum/outfit/job/roguetown/knight/heavy

	category_tags = list(CTAG_ROYALGUARD)
	traits_applied = list(TRAIT_HEAVYARMOR, TRAIT_GOODTRAINER)
	subclass_stats = list(
		STATKEY_STR = 3,//Heavy hitters. Less con/end, high strength.
		STATKEY_INT = 2,
		STATKEY_CON = 1,
		STATKEY_WIL = 2,
		STATKEY_SPD = -2,
	)
	age_mod = /datum/class_age_mod/knight/heavy
	subclass_skills = list(
		/datum/skill/combat/polearms = SKILL_LEVEL_EXPERT, //Polearms are pretty much explicitly a two-handed weapon, so I gave them a polearm option.
		/datum/skill/combat/swords = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/axes = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/maces = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/riding = SKILL_LEVEL_NOVICE,	//Too heavy for horses.
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE, //This is not saving them considering plate but funny either way.
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/tracking = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/knight/heavy/pre_equip(mob/living/carbon/human/H)
	..()
	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	H.verbs |= /mob/proc/haltyell

	H.adjust_blindness(-3)
	if(H.mind)
		var/weapons = list("Claymore","Great Mace","Battle Axe","Poleaxe","Estoc","Lucerne", "Partizan")
		var/weapon_choice = input(H, "Choose your weapon.", "TAKE UP ARMS") as anything in weapons
		H.set_blindness(0)
		switch(weapon_choice)
			if("Claymore")
				r_hand = /obj/item/rogueweapon/greatsword/zwei
				backl = /obj/item/rogueweapon/scabbard/gwstrap
				H.adjust_skillrank_up_to(/datum/skill/combat/swords, 5, TRUE)
			if("Great Mace")
				r_hand = /obj/item/rogueweapon/mace/goden/steel
				H.adjust_skillrank_up_to(/datum/skill/combat/maces, 5, TRUE)
			if("Battle Axe")
				r_hand = /obj/item/rogueweapon/stoneaxe/battle
				H.adjust_skillrank_up_to(/datum/skill/combat/axes, 5, TRUE)
			if("Poleaxe")
				r_hand = /obj/item/rogueweapon/greataxe/steel/knight
				backl = /obj/item/rogueweapon/scabbard/gwstrap
				H.adjust_skillrank_up_to(/datum/skill/combat/polearms, 5, TRUE)
			if("Estoc")
				r_hand = /obj/item/rogueweapon/estoc
				backl = /obj/item/rogueweapon/scabbard/gwstrap
				H.adjust_skillrank_up_to(/datum/skill/combat/swords, 5, TRUE)
			if("Lucerne")
				r_hand = /obj/item/rogueweapon/eaglebeak/lucerne
				backl = /obj/item/rogueweapon/scabbard/gwstrap
				H.adjust_skillrank_up_to(/datum/skill/combat/polearms, 5, TRUE)
			if("Partizan")
				r_hand = /obj/item/rogueweapon/spear/partizan
				backl = /obj/item/rogueweapon/scabbard/gwstrap
				H.adjust_skillrank_up_to(/datum/skill/combat/polearms, 5, TRUE)

	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1,
		/obj/item/rope/chain = 1,
		/obj/item/rogueweapon/scabbard/sheath/royal = 1
	)
	if(H.mind)
		SStreasury.give_money_account(ECONOMIC_UPPER_CLASS, H, "Savings.")

/datum/advclass/knight/footknight
	name = "Foot Knight"
	tutorial = "You are accustomed to traditional foot-soldier training in one-handed weapons such as flails, swords, and maces. Your fortitude and mastery with the versatile combination of a shield and weapon makes you a fearsome opponent to take down!"
	outfit = /datum/outfit/job/roguetown/knight/footknight

	category_tags = list(CTAG_ROYALGUARD)
	traits_applied = list(TRAIT_HEAVYARMOR, TRAIT_GOODTRAINER)
	subclass_stats = list(
		STATKEY_STR = 2,//Tanky, less strength, but high con/end.
		STATKEY_INT = 1,
		STATKEY_CON = 3,//If mercenaries can have this...
		STATKEY_WIL = 3,
		STATKEY_PER = 1,
		STATKEY_SPD = -2,
	)
	age_mod = /datum/class_age_mod/knight/footknight
	subclass_skills = list(
		/datum/skill/combat/swords = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/whipsflails = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/maces = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/shields = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/riding = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/tracking = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/knight/footknight/pre_equip(mob/living/carbon/human/H)
	..()
	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	H.verbs |= /mob/proc/haltyell

	H.adjust_blindness(-3)
	if(H.mind)
		var/weapons = list("Longsword","Flail","Warhammer","Edict and Aegis")
		var/weapon_choice = input(H, "Choose your weapon.", "TAKE UP ARMS") as anything in weapons
		H.set_blindness(0)
		switch(weapon_choice)
			if("Longsword")
				beltl = /obj/item/rogueweapon/scabbard/sword/noble
				l_hand = /obj/item/rogueweapon/sword/long/dec
				backl = /obj/item/rogueweapon/shield/buckler/banneret
				H.adjust_skillrank_up_to(/datum/skill/combat/swords, 5, TRUE)
			if("Flail")
				beltr = /obj/item/rogueweapon/flail/sflail
				backl = /obj/item/rogueweapon/shield/buckler/banneret
				H.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 5, TRUE)
			if ("Warhammer")
				beltr = /obj/item/rogueweapon/mace/warhammer/steel //Steel warhammer. This is one-handed and pairs well with shields.
				backl = /obj/item/rogueweapon/shield/buckler/banneret
				H.adjust_skillrank_up_to(/datum/skill/combat/maces, 5, TRUE)
			if("Edict and Aegis")
				beltl = /obj/item/rogueweapon/scabbard/sword/royal
				l_hand = /obj/item/rogueweapon/sword/sabre/banneret
				backl = /obj/item/rogueweapon/shield/buckler/banneret
				H.adjust_skillrank_up_to(/datum/skill/combat/swords, 5, TRUE)

	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1,
		/obj/item/rope/chain = 1,
		/obj/item/rogueweapon/scabbard/sheath/royal = 1
	)
	if(H.mind)
		SStreasury.give_money_account(ECONOMIC_UPPER_CLASS, H, "Savings.")

/datum/advclass/knight/mountedknight
	name = "Mounted Knight"
	tutorial = "You are the picture-perfect knight from a high tale, knowledgeable in riding steeds into battle. You specialize in weapons most useful on a saiga including spears, swords, maces, and a variety of ranged weaponry."
	outfit = /datum/outfit/job/roguetown/knight/mountedknight
	subclass_stashed_items = list("Ducal Caparison" = /obj/item/caparison/lyndvhar)
	extra_context = "This subclass recieves Lyndvhar Caparison in it's stash."

	category_tags = list(CTAG_ROYALGUARD)

	traits_applied = list(TRAIT_HEAVYARMOR, TRAIT_GOODTRAINER)
	//Decent all-around stats. Nothing spectacular. Ranged/melee hybrid class on horseback.
	subclass_stats = list(
		STATKEY_STR = 2,
		STATKEY_INT = 2,
		STATKEY_CON = 1,
		STATKEY_WIL = 2,
		STATKEY_PER = 2,
		STATKEY_SPD = -1,
	)
	age_mod = /datum/class_age_mod/knight/mountedknight
	subclass_skills = list(
		/datum/skill/combat/polearms = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/swords = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/maces = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/riding = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/crossbows = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/bows = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/wrestling = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/tracking = SKILL_LEVEL_JOURNEYMAN,
	)
	subclass_virtues = list(
		/datum/virtue/utility/riding
	)

/datum/outfit/job/roguetown/knight/mountedknight/pre_equip(mob/living/carbon/human/H)
	..()
	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	H.verbs |= /mob/proc/haltyell

	if(H.mind)
		H.adjust_blindness(-3)
		var/weapons = list(
			"Longsword + Crossbow",
			"Billhook + Recurve Bow",
			"Grand Mace + Longbow",
			"Sabre + Recurve Bow",
			"Lance + Aegis"
		)
		var/weapon_choice = input(H, "Choose your weapon.", "TAKE UP ARMS") as anything in weapons
		H.set_blindness(0)
		switch(weapon_choice)
			if("Longsword + Crossbow")
				beltl = /obj/item/rogueweapon/scabbard/sword/noble
				r_hand = /obj/item/rogueweapon/sword/long/dec
				beltr = /obj/item/quiver/bolts
				backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
				H.adjust_skillrank_up_to(/datum/skill/combat/swords, 5, TRUE)
				H.adjust_skillrank_up_to(/datum/skill/combat/crossbows, 5, TRUE)
			if("Billhook + Recurve Bow")
				r_hand = /obj/item/rogueweapon/spear/billhook
				backl = /obj/item/rogueweapon/scabbard/gwstrap
				beltr = /obj/item/quiver/arrows
				beltl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
				H.adjust_skillrank_up_to(/datum/skill/combat/polearms, 5, TRUE)
				H.adjust_skillrank_up_to(/datum/skill/combat/bows, 5, TRUE)
			if("Grand Mace + Longbow")
				backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/longbow
				beltr = /obj/item/quiver/arrows
				beltl = /obj/item/rogueweapon/mace/goden/steel
				H.adjust_skillrank_up_to(/datum/skill/combat/maces, 5, TRUE)
				H.adjust_skillrank_up_to(/datum/skill/combat/bows, 5, TRUE)
			if("Sabre + Recurve Bow")
				l_hand = /obj/item/rogueweapon/scabbard/sword/noble
				r_hand = /obj/item/rogueweapon/sword/sabre/dec
				beltr = /obj/item/quiver/arrows
				beltl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
				H.adjust_skillrank_up_to(/datum/skill/combat/swords, 5, TRUE)
				H.adjust_skillrank_up_to(/datum/skill/combat/bows, 5, TRUE)
			if("Lance + Aegis")
				r_hand = /obj/item/rogueweapon/spear/lance
				backl = /obj/item/rogueweapon/shield/buckler/banneret
				H.adjust_skillrank_up_to(/datum/skill/combat/shields, 3, TRUE) // Let them skip dummy hitting
				H.adjust_skillrank_up_to(/datum/skill/combat/polearms, 5, TRUE)

	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1,
		/obj/item/rope/chain = 1,
		/obj/item/rogueweapon/scabbard/sheath/royal = 1
	)
	if(H.mind)
		SStreasury.give_money_account(ECONOMIC_UPPER_CLASS, H, "Savings.")
