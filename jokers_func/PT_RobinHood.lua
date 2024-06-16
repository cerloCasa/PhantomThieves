PT_ROBINHOOD = {}

-- RESET VARIABILI

function PT_ROBINHOOD.resetGlobalVars()
    G.GAME.J08_canBetrayalSpawn = false
    sendTraceMessage("J08_canBetrayalSpawn is " .. tostring(G.GAME.J08_canBetrayalSpawn),"RobinHood")
    G.GAME.J08_RoundsCounter = 0
    sendTraceMessage("J08_RoundsCounter is " .. G.GAME.J08_RoundsCounter,"RobinHood")
end

-- JOKERS INIT

SMODS.Joker { -- Robin Hood
	key = 'RobinHood',
	loc_txt = {
		['it'] = {
			name = 'Robin Hood',
			text = {'Crea il tuo {C:purple}Tarocco','più usato alla','fine del round','{C:inactive}(Serve spazio)'},
		},
		['default'] = {
			name = 'Robin Hood',
			text = {'Create your most','used {C:purple}Tarot{} at the end','of the round','{C:inactive}(Must have room)'},
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

SMODS.Atlas {
	key = 'RobinHood',
	px = 71,
	py = 95,
	path = '08 - Robin Hood.png'
}

SMODS.Joker { -- Loki
	key = 'Loki',
	loc_txt = {
		['it'] = {
			name = 'Loki',
			text = {'Crea una copia {C:dark_edition}negativa','del tuo {C:purple}Tarot{} più','usato alla fine del round','{C:red}(ATTENZIONE!)'},
		},
		['default'] = {
			name = 'Loki',
			text = {'Create a {C:dark_edition}negative{} copy','of your most used','{C:purple}Tarot{} at the end','of the round','{C:red}(WATCH OUT!)'},
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

SMODS.Atlas {
	key = 'Loki',
	px = 71,
	py = 95,
	path = '08.1 - Loki.png'
}

SMODS.Joker { -- Hereward
	key = 'Hereward',
	loc_txt = {
		['it'] = {
			name = '{C:red}Hereward',
			text = {'Crea una copia {C:dark_edition}negativa','del tuo {C:purple}Tarot{} più','usato alla fine del round'},
		},
		['default'] = {
			name = '{C:red}Hereward',
			text = {'Create a {C:dark_edition}negative{} copy','of your most used','{C:purple}Tarot{} at the end','of the round'},
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
	end
}

SMODS.Atlas {
	key = 'Hereward',
	px = 71,
	py = 95,
	path = '08.2 - Hereward.png'
}

-- CALCULATE JOKER

function PT_ROBINHOOD.RoundStart(card,rank)
    if rank < 10 then
	    G.GAME.J08_RoundsCounter = G.GAME.J08_RoundsCounter + 1
    end
    if rank < 9 then
        G.GAME.J08_RoundsCounter = G.GAME.J08_RoundsCounter + 1
    end
end

function PT_ROBINHOOD.RoundWon(card,rank)
    if G.GAME.J08_RoundsCounter >= 5 then
        J08_canBetrayalSpawn = true
    end
    if rank < 9 then
	    pt_RobinHood.createMostUsedTarot()
    else
        pt_RobinHood.createNegativeMostUsedTarot()
    end
end

-- FUNZIONI DI SUPPORTO

function PT_ROBINHOOD.createMostUsedTarot()
    -- Create most used tarot
	sendTraceMessage("Creating most useful tarot...","RobinHood")
    if G.GAME.Util_MostUsedTarot_key then
        sendTraceMessage("Creating "..G.GAME.Util_MostUsedTarot_key.."...","RobinHood")
        pt_manageCards.createConsumable(G.GAME.Util_MostUsedTarot_key,'Tarot',nil,nil)
    else
        sendTraceMessage("No tarots used in this run :(","RobinHood")
    end
end

function PT_ROBINHOOD.createNegativeMostUsedTarot()
    -- Create negative most used tarot
	sendTraceMessage("Creating negative most useful tarot...","RobinHood")
    if G.GAME.Util_MostUsedTarot_key then
        sendTraceMessage("Creating "..G.GAME.Util_MostUsedTarot_key.."...","RobinHood")
        pt_manageCards.createConsumable(G.GAME.Util_MostUsedTarot_key,'Tarot',{negative = true},true)
    else
        sendTraceMessage("No tarots used in this run :(","RobinHood")
    end
end

return PT_ROBINHOOD