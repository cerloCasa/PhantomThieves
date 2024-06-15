--- STEAMODDED HEADER
--- MOD_NAME: Phantom Thieves 0.1
--- MOD_ID: PhantomThieves
--- MOD_AUTHOR: [Cerlo]
--- MOD_DESCRIPTION: A Persona Mod
--- BADGE_COLOR: DB2109
--- PREFIX: PT
--- PRIORITY: -1000000
--- LOADER_VERSION_GEQ: 1.0.0
_RELEASE_MODE = false

-- FUNZIONI DI SUPPORTO / SUPPORT FUNCTIONS

pt_util = require(SMODS.current_mod.path.."/PT_util")
--pt_TheContract = require(SMODS.current_mod.path.."/PT_TheContract")
--pt_Zorro = require(SMODS.current_mod.path.."/PT_Zorro")
--pt_Johanna = require(SMODS.current_mod.path.."/PT_Johanna")
--pt_Milady = require(SMODS.current_mod.path.."/PT_Milady")
--pt_Goemon = require(SMODS.current_mod.path.."/PT_Goemon")
--pt_Chief = require(SMODS.current_mod.path.."/PT_Chief")
--pt_Carmen = require(SMODS.current_mod.path.."/PT_Carmen")
--pt_CaptainKidd = require(SMODS.current_mod.path.."/PT_CaptainKidd")
pt_RobinHood = require(SMODS.current_mod.path.."/PT_RobinHood")
--pt_Necronomicon = require(SMODS.current_mod.path.."/PT_Necronomicon")
--pt_FortuneTeller = require(SMODS.current_mod.path.."/PT_FortuneTeller")
--pt_Twins = require(SMODS.current_mod.path.."/PT_Twins")
--pt_WeaponsDealer = require(SMODS.current_mod.path.."/PT_WeaponsDealer")
--pt_BackAlleyDoctor = require(SMODS.current_mod.path.."/PT_BackAlleyDoctor")
--pt_Teacher = require(SMODS.current_mod.path.."/PT_Teacher")
--pt_Paparazza = require(SMODS.current_mod.path.."/PT_Paparazza")
--pt_SkilledGamer = require(SMODS.current_mod.path.."/PT_SkilledGamer")
--pt_ShogiPlayer = require(SMODS.current_mod.path.."/PT_ShogiPlayer")
--pt_Admin = require(SMODS.current_mod.path.."/PT_Admin")
--pt_ManOfThePeople = require(SMODS.current_mod.path.."/PT_ManOfThePeople")
--pt_Prosecutor = require(SMODS.current_mod.path.."/PT_Prosecutor")
--pt_Arsene = require(SMODS.current_mod.path.."/PT_Arsene")

-- VARIABILI GLOBALI / GLOBAL VARIABLES

G.PhantomThieves = {
}

-- INIZIO DELLA PARTITA / START OF THE RUN

local BackApply_to_run_ref = Back.apply_to_run
function Back.apply_to_run(self)
	BackApply_to_run_ref(self)
	pt_util.resetGlobalVars()
	return true
end

-- JOLLY

SMODS.Joker { -- Robin Hood
	key = 'RobinHood',
	loc_txt = {
		['it'] = {
			name = 'Robin Hood',
			text = {''},
		},
		['default'] = {
			name = 'Robin Hood',
			text = {'Create your most','used {C:purple}Tarot{} at the end','of the round'},
		},
	},
	config = {extra = {Rank = 1}},
	rarity = 2,
	pos = { x = 0 , y = 0 },
	atlas = 'RobinHood',
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	linked_tarot = 'c_justice',
	calculate = function(self,card,context)
		if context.setting_blind then
			pt_RobinHood.RoundStart(card,card.ability.extra.Rank)
		end
		if context.end_of_round and context.game_over == false then
			pt_RobinHood.RoundWon(card,card.ability.extra.Rank)
		end
		if context.selling_self then
			pt_RobinHood.SellingSelf(card,card.ability.extra.Rank)
		end
		if context.using_consumeable then
			-- Calcola Rank Up e Evoluzione
			if context.consumeable.ability.name == 'Justice' and card.ability.extra.Rank < 10 then
				pt_util.rankUp(card)
			end
			if card.ability.extra.Rank == 9 then
				pt_util.evolve(card,'j_PT_Loki')
			end
		end
	end
}

SMODS.Joker { -- Loki
	key = 'Loki',
	loc_txt = {
		['it'] = {
			name = 'Loki',
			text = {''},
		},
		['default'] = {
			name = 'Loki',
			text = {'Create a {C:dark_edition}negative{} copy','of your most','used {C:purple}Tarot{} at the end','of the round','{C:red}(WATCH OUT!)'},
		},
	},
	config = {extra = {Rank = 9}},
	rarity = 2,
	pos = { x = 0 , y = 0 },
	atlas = 'Loki',
	cost = 5,
	unlocked = false,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	linked_tarot = 'c_justice',
	calculate = function(self,card,context)
		if context.setting_blind then
			pt_RobinHood.RoundStart(card,card.ability.extra.Rank)
		end
		if context.end_of_round and context.game_over == false then
			pt_RobinHood.RoundWon(card,card.ability.extra.Rank)
		end
		if context.selling_self then
			pt_util.removeFromUseful('Justice')
		end
		if context.using_consumeable then
			-- Calcola Rank Up e Evoluzione
			if context.consumeable.ability.name == 'Justice' then
				pt_util.rankUp(card)
			end
			if card.ability.extra.Rank == 10 then
				pt_util.evolve(card,'j_PT_Hereward')
			end
		end
	end
}

SMODS.Joker { -- Hereward
	key = 'Hereward',
	loc_txt = {
		['it'] = {
			name = '{C:red}Hereward',
			text = {''},
		},
		['default'] = {
			name = '{C:red}Hereward',
			text = {'Create a {C:dark_edition}negative{} copy','of your most','used {C:purple}Tarot{} at the end','of the round'},
		},
	},
	config = {extra = {Rank = 10}},
	rarity = 2,
	pos = { x = 0 , y = 0 },
	atlas = 'Hereward',
	cost = 7,
	unlocked = false,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	linked_tarot = 'c_justice',
	calculate = function(self,card,context)
		if context.setting_blind then
			pt_RobinHood.RoundStart(card,card.ability.extra.Rank)
		end
		if context.end_of_round and context.game_over == false then
			pt_RobinHood.RoundWon(card,card.ability.extra.Rank)
		end
		if context.selling_self then
			pt_util.removeFromUseful('Justice')
		end
	end
}

-- CONSUMABILI / CONSUMEABLES

-- ASSETS

SMODS.Atlas {
	key = 'modicon',
	px = 34,
	py = 34,
	path = 'modicon.png'
}

SMODS.Atlas {
	key = 'RobinHood',
	px = 71,
	py = 95,
	path = '07 - Robin Hood.png'
}

SMODS.Atlas {
	key = 'Loki',
	px = 71,
	py = 95,
	path = '07.1 - Loki.png'
}

SMODS.Atlas {
	key = 'Hereward',
	px = 71,
	py = 95,
	path = '07.2 - Hereward.png'
}