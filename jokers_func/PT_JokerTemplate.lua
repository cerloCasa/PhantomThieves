PT_TEMPLATE = {}

-- RESET VARIABILI

function PT_TEMPLATE.resetGlobalVars()
    G.GAME.J00_x = false
    sendTraceMessage("J00_x is " .. tostring(G.GAME.J00_x),"TEMPLATE")
    G.GAME.J00_y = 0
    sendTraceMessage("J00_y is " .. G.GAME.J00_y,"TEMPLATE")
end

-- JOKERS INIT

SMODS.Joker { -- TEMPLATE
	key = 'TEMPLATE',
	loc_txt = {
		['it'] = {
			name = 'TEMPLATE',
			text = {''},
		},
		['default'] = {
			name = 'TEMPLATE',
			text = {''},
		},
	},
	config = {extra = {Rank = 1}},
	rarity = 2,
	pos = { x = 0 , y = 0 },
	atlas = 'TEMPLATE',
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	linked_tarot = 'c_tarot',
	calculate = function(self,card,context)
		if context.setting_blind then
			pt_TEMPLATE.RoundStart(card,card.ability.extra.Rank)
		end
		if context.end_of_round and context.game_over == false then
			pt_TEMPLATE.RoundWon(card,card.ability.extra.Rank)
		end
		if context.selling_self then
			pt_TEMPLATE.SellingSelf(card,card.ability.extra.Rank)
		end
		if context.using_consumeable then
			-- Calcola Rank Up e Evoluzione
			if context.consumeable.ability.name == 'Tarot Name' and card.ability.extra.Rank < 10 then
				card.ability.extra.Rank = card.ability.extra.Rank + 1
                sendTraceMessage("New rank is " .. card.ability.extra.Rank,card.conficenter_key)
			end
			if card.ability.extra.Rank == 9 then
				pt_util.evolve(card,'j_PT_Loki')
			end
		end
	end
}

SMODS.Atlas {
	key = 'TEMPLATE',
	px = 71,
	py = 95,
	path = '00 - TEMPLATE.png'
}

-- CALCULATE JOKER

function PT_TEMPLATE.RoundStart(card,rank)
    if rank < 10 then
	    G.GAME.J00_y = G.GAME.J00_y + 1
    end
    if rank < 9 then
        G.GAME.J00_y = G.GAME.J00_y + 1
    end
end

function PT_TEMPLATE.RoundWon(card,rank)
    if G.GAME.J00_y >= 5 then
        J00_x = true
    end
    if rank < 9 then
	    pt_TEMPLATE.createMostUsedTarot()
    else
        pt_TEMPLATE.createNegativeMostUsedTarot()
    end
end

-- FUNZIONI DI SUPPORTO

function PT_TEMPLATE.createMostUsedTarot()
    -- Create most used tarot
	sendTraceMessage("Creating most useful tarot...","TEMPLATE")
    if G.GAME.Util_MostUsedTarot_key then
        sendTraceMessage("Creating "..G.GAME.Util_MostUsedTarot_key.."...","TEMPLATE")
        pt_manageCards.createConsumable(G.GAME.Util_MostUsedTarot_key,'Tarot',nil,nil)
    else
        sendTraceMessage("No tarots used in this run :(","TEMPLATE")
    end
end

function PT_TEMPLATE.createNegativeMostUsedTarot()
    -- Create negative most used tarot
	sendTraceMessage("Creating negative most useful tarot...","TEMPLATE")
    if G.GAME.Util_MostUsedTarot_key then
        sendTraceMessage("Creating "..G.GAME.Util_MostUsedTarot_key.."...","TEMPLATE")
        pt_manageCards.createConsumable(G.GAME.Util_MostUsedTarot_key,'Tarot',{negative = true},true)
    else
        sendTraceMessage("No tarots used in this run :(","TEMPLATE")
    end
end

return PT_TEMPLATE