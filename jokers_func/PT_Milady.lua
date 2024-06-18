PT_MILADY = {}

-- RESET VARIABILI

G.J03 = {}
G.J03[1] = 3
G.J03[2] = 3
G.J03[3] = 6
G.J03[4] = 6
G.J03[5] = 9
G.J03[6] = 9
G.J03[7] = 15
G.J03[8] = 15
G.J03[9] = 15
G.J03[10] = 20

function PT_MILADY.resetGlobalVars()
    G.GAME.J03 = {}
	G.GAME.J03[1] = 3
    G.GAME.J03[2] = 3
    G.GAME.J03[3] = 6
    G.GAME.J03[4] = 6
    G.GAME.J03[5] = 9
    G.GAME.J03[6] = 9
    G.GAME.J03[7] = 15
    G.GAME.J03[8] = 15
    G.GAME.J03[9] = 15
    G.GAME.J03[10] = 20
	sendTraceMessage("Global vars have been reset","Milady")
end

-- JOKERS INIT

SMODS.Joker { -- 03 - Milady
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
		if G.GAME.J03 then
			return {vars = {G.GAME.J03[card.ability.extra.Rank]}}
		else
			PT_MILADY.resetGlobalVars()
			return {vars = {G.GAME.J03[card.ability.extra.Rank]}}
		end
	end,
	rarity = 2,
	pos = { x = 0 , y = 0 },
	atlas = 'Milady',
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	linked_tarot = 'c_high_priestess',
	calculate = function(self,card,context)
		if context.joker_main then
			PT_MILADY.HandCalc(card,card.ability.extra.Rank)
		end
		if context.end_of_round and context.game_over == false then
			PT_MILADY.RoundWon(card,card.ability.extra.Rank)
		end
		if context.using_consumeable then
			-- Calcola Rank Up e Evoluzione
			if context.consumeable.ability.name == 'The High Priestess' and card.ability.extra.Rank < 10 then
				pt_util.rankUp(card)
			end
			if card.ability.extra.Rank == 9 then
				pt_util.evolve(card,'j_PT_Astarte')
			end
		end
	end
}

SMODS.Atlas {
	key = 'Milady',
	px = 71,
	py = 95,
	path = '03 - Milady.png'
}

SMODS.Joker { -- 03.1 - Astarte
	key = 'Astarte',
	loc_txt = {
		['it'] = {
			name = 'Astarte',
			text = {''},
			unlock = {'Evolve the previous','Joker to unlock','this one'},
		},
		['default'] = {
			name = 'Milady',
			text = {'Earn {C:money}$#1#{} after each','hand played'},
			unlock = {'Evolve the previous','Joker to unlock','this one'},
		},
	},
	config = {extra = {Rank = 9}},
	loc_vars = function(self,info_queue,card)
		if G.GAME.J03 then
			return {vars = {G.GAME.J03[card.ability.extra.Rank]}}
		else
			PT_MILADY.resetGlobalVars()
			return {vars = {G.GAME.J03[card.ability.extra.Rank]}}
		end
	end,
	rarity = 2,
	pos = { x = 0 , y = 0 },
	atlas = 'Astarte',
	cost = 7,
	unlocked = false,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	linked_tarot = 'c_high_priestess',
	calculate = function(self,card,context)
		if context.joker_main then
			PT_MILADY.HandCalc(card,card.ability.extra.Rank)
		end
		if context.end_of_round and context.game_over == false then
			PT_MILADY.RoundWon(card,card.ability.extra.Rank)
		end
		if context.using_consumeable then
			-- Calcola Rank Up e Evoluzione
			if context.consumeable.ability.name == 'The High Priestess' and card.ability.extra.Rank < 10 then
				pt_util.rankUp(card)
			end
			if card.ability.extra.Rank == 10 then
				pt_util.evolve(card,'j_PT_Lucy')
			end
		end
	end
}

SMODS.Atlas {
	key = 'Astarte',
	px = 71,
	py = 95,
	path = '03.1 - Astarte.png'
}

SMODS.Joker { -- 03.2 - Lucy
	key = 'Lucy',
	loc_txt = {
		['it'] = {
			name = 'Lucy',
			text = {''},
			unlock = {'Evolve the previous','Joker to unlock','this one'},
		},
		['default'] = {
			name = 'Lucy',
			text = {'Earn {C:money}$#1#{} after each','hand played'},
			unlock = {'Evolve the previous','Joker to unlock','this one'},
		},
	},
	config = {extra = {Rank = 10}},
	loc_vars = function(self,info_queue,card)
		if G.GAME.J03 then
			return {vars = {G.GAME.J03[card.ability.extra.Rank]}}
		else
			PT_MILADY.resetGlobalVars()
			return {vars = {G.GAME.J03[card.ability.extra.Rank]}}
		end
	end,
	rarity = 2,
	pos = { x = 0 , y = 0 },
	atlas = 'Lucy',
	cost = 10,
	unlocked = false,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	linked_tarot = 'c_high_priestess',
	calculate = function(self,card,context)
		if context.joker_main then
			PT_MILADY.HandCalc(card,card.ability.extra.Rank)
		end
		if context.end_of_round and context.game_over == false then
			PT_MILADY.RoundWon(card,card.ability.extra.Rank)
		end
	end
}

SMODS.Atlas {
	key = 'Lucy',
	px = 71,
	py = 95,
	path = '03.2 - Lucy.png'
}

-- CALCULATE JOKER

function PT_MILADY.HandCalc(card,rank)
	if rank > 8 then
		ease_dollars(G.GAME.J03[rank])
	end
end

function PT_MILADY.RoundWon(card,rank)
	if rank < 9 then
		ease_dollars(G.GAME.J03[rank])
	end
end

return PT_MILADY