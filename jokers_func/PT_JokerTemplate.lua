PT_JOKERNAME = {}

G.J00_JokerName_Vars = { -- Replace 00 with the Joker's number
    J00_x = false, -- examples
    J00_y = 0,
}

-- RESET VARIABILI GLOBALI

function PT_JOKERNAME.resetGlobalVars()
    G.GAME.J00_x = false
    sendTraceMessage("J00_x is " .. tostring(G.GAME.J00_x),"Joker00")
    G.GAME.J00_y = 0
    sendTraceMessage("J00_y is " .. G.GAME.J00_y,"Joker00")
end

-- CALCULATE JOKER

function PT_JOKERNAME.RoundStart(card,rank)
	-- Quando inizia il round
end

function PT_JOKERNAME.HandCalc(card,rank)
	-- Quando si calcola il punteggio della mano
end

function PT_JOKERNAME.RoundWon(card,rank)
	-- Quando finisce il round
end

-- FUNZIONI DI SUPPORTO

function PT_JOKERNAME.helperFunction()
    -- Una funzione di supporto da chiamare con
	-- pt_JokerName.helperFunction()
end

return PT_JOKERNAME

------------------------------------------------------------------

-- IL SEGUENTE CODICE VA AGGIUNTO AL MAIN

SMODS.Joker { -- Joker Name
	key = 'JokerName',
	loc_txt = {
		['it'] = {
			name = 'Nome Joker',
			text = {''},
		},
		['default'] = {
			name = 'Joker Name',
			text = {'Joker Text'},
		},
	},
	config = {extra = {Rank = 1}},
	rarity = 1, -- 1 for common, 2 for uncommon, 3 for rare, 4 for legendary
	pos = { x = 0 , y = 0 },
	atlas = 'JokerName',
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	linked_tarot = 'c_Tarot', -- Replace with Tarot key
	calculate = function(self,card,context)
		if context.setting_blind then
			pt_JokerName.RoundStart(card,card.ability.extra.Rank)
		end
		if context.joker_main then
			pt_JokerName.HandCalc(card,card.ability.extra.Rank)
		end
		if context.end_of_round and context.game_over == false then
			pt_JokerName.RoundWon(card,card.ability.extra.Rank)
		end
		if context.using_consumeable then
			-- Calcola Rank Up e Evoluzione
			if context.consumeable.ability.name == 'TarotName' and card.ability.extra.Rank < 10 then
				pt_util.rankUp(card)
			end
			if card.ability.extra.Rank == 9 then -- Rank when evolves
				pt_util.evolve(card,'j_PT_EvoJokerName')
			end
		end
	end
}

SMODS.Atlas {
	key = 'JokerName',
	px = 71,
	py = 95,
	path = '00 - Joker Name.png'
}