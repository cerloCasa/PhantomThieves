PT_MILADY = {}

-- VARIABILI GLOBALI
function PT_MILADY.resetGlobalVars()
    G.J03_MiladyRef = {}
	G.J03_MiladyRef[1] = 3 -- end of round
	G.J03_MiladyRef[2] = 3
	G.J03_MiladyRef[3] = 6
	G.J03_MiladyRef[4] = 6
	G.J03_MiladyRef[5] = 9
	G.J03_MiladyRef[6] = 9
	G.J03_MiladyRef[7] = 15
	G.J03_MiladyRef[8] = 15
	G.J03_MiladyRef[9] = 15 -- each hand
	G.J03_MiladyRef[10] = 20
end

-- JOKER INIT

SMODS.Joker { -- 03 - Milady
	key = 'Milady',
	loc_txt = {
		['it'] = {
			name = 'Milady',
			text = {''},
		},
		['default'] = {
			name = 'Milady',
			text = {'Earn {C:money}$#1#{} at the end of','the round'},
		},
	},
	config = {extra = {Money = 1}},
	loc_vars = function(self,info_queue,card)
		return {vars = {card.rank}}
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
	rank = 1,
	linked_tarot = 'c_high_priestess',
	calculate = function(self,card,context)
		if context.joker_main then
			pt_Milady.HandCalc(card,card.rank)
		end
		if context.end_of_round and context.game_over == false then
			pt_Milady.RoundWon(card,card.rank)
		end
		if context.using_consumeable then
			-- Calcola Rank Up e Evoluzione
			if context.consumeable.ability.name == 'The High Priestess' and card.rank < 10 then
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

-- CALCULATE JOKER

function PT_MILADY.HandCalc(card,rank)
	if rank > 8 then
		ease_dollars(G.GAME.J03_MiladyRef[rank])
	end
end

function PT_MILADY.RoundWon(card,rank)
	if rank < 9 then
		ease_dollars(G.GAME.J03_MiladyRef[rank])
	end
end

-- FUNZIONI DI SUPPORTO

function PT_MILADY.locTxtMoney(rank)
    return G.GAME.J03_MiladyRef[rank]
end

return PT_MILADY