SMODS.Joker { -- 03 Milady
	key = 'Milady',
	loc_txt = {
		['it'] = {
			name = 'Milady',
			text = {''},
		},
		['default'] = {
			name = 'Milady',
			text = {'Earn {C:money}$#1#{} at the end','of the round'},
		},
	},
	config = {extra = {Rank = 1}},
	loc_vars = function(self,info_queue,card)
		info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Empress', set = 'Other'}
		if G.GAME.PTvar_Milady then
			return {vars = {G.GAME.PTvar_Milady[card.ability.extra.Rank]}}
		else
			PT_Milady_resetGlobalVars()
			return {vars = {G.GAME.PTvar_Milady[card.ability.extra.Rank]}}
		end
	end,
	rarity = 2,
	pos = {x = 8, y = 0},
	soul_pos = {x = 3, y = 3},
	set_ability = function(self, card)
		PT_soulPos(card)
	end,
	atlas = 'Jokers',
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	linked_tarot = 'c_empress',
	calculate = function(self,card,context)
		if context.joker_main then
			PT_Milady_HandCalc(card,card.ability.extra.Rank)
		end
		if context.end_of_round and context.game_over == false then
			PT_Milady_RoundWon(card,card.ability.extra.Rank)
		end
		if context.using_consumeable then
			-- Calcola Rank Up e Evoluzione
			if context.consumeable.ability.name == 'The Empress' and card.ability.extra.Rank < 10 then
				PT_rankUp(card)
			end
			if card.ability.extra.Rank == 9 then
				PT_evolve(card,'j_PT_Astarte')
			end
            if not context.blueprint and card.ability.extra.Rank >= 10 then
				PT_evolve(card,'j_PT_Lucy')
			end
		end
	end
}

SMODS.Joker { -- 03.1 Astarte
	key = 'Astarte',
	loc_txt = {
		['it'] = {
			name = '{C:blue}Astarte',
			text = {''},
			unlock = {'{C:red}Evolve{} the previous','Joker to unlock','this one'},
		},
		['default'] = {
			name = '{C:blue}Astarte',
			text = {'Earn {C:money}$#1#{} after each','hand played'},
			unlock = {'{C:red}Evolve{} the previous','Joker to unlock','this one'},
		},
	},
	config = {extra = {Rank = 9}},
	loc_vars = function(self,info_queue,card)
		info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Empress', set = 'Other'}
		if G.GAME.PTvar_Milady then
			return {vars = {G.GAME.PTvar_Milady[card.ability.extra.Rank]}}
		else
			PT_Milady_resetGlobalVars()
			return {vars = {G.GAME.PTvar_Milady[card.ability.extra.Rank]}}
		end
	end,
	rarity = 2,
	pos = {x = 9, y = 0},
	soul_pos = {x = 11, y = 3},
	atlas = 'Jokers',
	cost = 7,
	unlocked = false,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	add_to_pool = function(self)
		return {add = false}
	end,
	linked_tarot = 'c_empress',
	calculate = function(self,card,context)
		if context.joker_main then
			PT_Milady_HandCalc(card,card.ability.extra.Rank)
		end
		if context.end_of_round and context.game_over == false then
			PT_Milady_RoundWon(card,card.ability.extra.Rank)
		end
		if context.using_consumeable then
			-- Calcola Rank Up e Evoluzione
			if context.consumeable.ability.name == 'The Empress' and card.ability.extra.Rank < 10 then
				PT_rankUp(card)
			end
            if not context.blueprint and card.ability.extra.Rank >= 10 then
				PT_evolve(card,'j_PT_Lucy')
			end
		end
	end
}

SMODS.Joker { -- 03.2 Lucy
	key = 'Lucy',
	loc_txt = {
		['it'] = {
			name = '{C:red}Lucy',
			text = {''},
			unlock = {'{C:red}Evolve{} the previous','Joker to unlock','this one'},
		},
		['default'] = {
			name = '{C:red}Lucy',
			text = {'Earn {C:money}$#1#{} after each','hand played'},
			unlock = {'{C:red}Evolve{} the previous','Joker to unlock','this one'},
		},
	},
	config = {extra = {Rank = 10}},
	loc_vars = function(self,info_queue,card)
		info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Empress', set = 'Other'}
		if G.GAME.PTvar_Milady then
			return {vars = {G.GAME.PTvar_Milady[card.ability.extra.Rank]}}
		else
			PT_Milady_resetGlobalVars()
			return {vars = {G.GAME.PTvar_Milady[card.ability.extra.Rank]}}
		end
	end,
	rarity = 2,
	pos = {x = 10, y = 0},
	soul_pos = {x = 12, y = 3},
	atlas = 'Jokers',
	cost = 10,
	unlocked = false,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	add_to_pool = function(self)
		return {add = false}
	end,
	linked_tarot = 'c_empress',
	calculate = function(self,card,context)
		if context.joker_main then
			PT_Milady_HandCalc(card,card.ability.extra.Rank)
		end
		if context.end_of_round and context.game_over == false then
			PT_Milady_RoundWon(card,card.ability.extra.Rank)
		end
	end
}

function PT_Milady_resetGlobalVars()
	G.GAME.PTvar_Milady = {}
	G.GAME.PTvar_Milady[1] = 3
    G.GAME.PTvar_Milady[2] = 3
    G.GAME.PTvar_Milady[3] = 6
    G.GAME.PTvar_Milady[4] = 6
    G.GAME.PTvar_Milady[5] = 9
    G.GAME.PTvar_Milady[6] = 9
    G.GAME.PTvar_Milady[7] = 15
    G.GAME.PTvar_Milady[8] = 15
    G.GAME.PTvar_Milady[9] = 15
    G.GAME.PTvar_Milady[10] = 20
	sendTraceMessage("Milady's variabiles have been reset","PT_Milady_resetGlobalVars")
end

function PT_Milady_HandCalc(card,rank)
	if rank > 8 then
		ease_dollars(G.GAME.PTvar_Milady[rank])
	end
end

function PT_Milady_RoundWon(card,rank)
	if rank < 9 then
		ease_dollars(G.GAME.PTvar_Milady[rank])
	end
end