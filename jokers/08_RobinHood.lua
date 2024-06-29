SMODS.Joker { -- 08 Robin Hood
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
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Justice', set = 'Other'}
		if G.GAME.PTvar_mostUsedTarot_key then
			info_queue[#info_queue + 1] = {key = 'PT_RobinHood_MostUsedTarot', set = 'Other', vars = {G.GAME.PTvar_mostUsedTarot_name}}
		else
			info_queue[#info_queue + 1] = {key = 'PT_RobinHood_NoUsedTarots', set = 'Other'}
		end
		return {}
	end,
	config = {extra = {Rank = 1}},
	rarity = 2,
	pos = {x = 8, y = 1},
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
	linked_tarot = 'c_justice',
	calculate = function(self,card,context)
		if context.setting_blind then
			PT_RobinHood_RoundStart(card,card.ability.extra.Rank)
		end
		if context.end_of_round and context.game_over == false then
			PT_RobinHood_RoundWon(card,card.ability.extra.Rank)
		end
		if context.using_consumeable then
			-- Calcola Rank Up e Evoluzione
			if context.consumeable.ability.name == 'Justice' and card.ability.extra.Rank < 10 then
				PT_rankUp(card)
			end
			if card.ability.extra.Rank == 9 then
				PT_evolve(card,'j_PT_Loki')
			end
            if not context.blueprint and card.ability.extra.Rank >= 10 then
				PT_evolve(card,'j_PT_Hereward')
			end
		end
	end
}

SMODS.Joker { -- 08.1 Loki
	key = 'Loki',
	loc_txt = {
		['it'] = {
			name = '{C:blue}Loki',
			text = {'Crea una copia {C:dark_edition}negativa','del tuo {C:purple}Tarot{} più','usato alla fine del round','{C:red}(ATTENZIONE!)'},
			unlock = {'{C:red}Evolve{} the previous','Joker to unlock','this one'},
		},
		['default'] = {
			name = '{C:blue}Loki',
			text = {'Create a {C:dark_edition}negative{} copy','of your most used','{C:purple}Tarot{} at the end','of the round','{C:red}(WATCH OUT!)'},
			unlock = {'{C:red}Evolve{} the previous','Joker to unlock','this one'},
		},
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Justice', set = 'Other'}
		if G.GAME.PTvar_mostUsedTarot_key then
			info_queue[#info_queue + 1] = {key = 'PT_RobinHood_MostUsedTarot', set = 'Other', vars = {G.GAME.PTvar_mostUsedTarot_name}}
		else
			info_queue[#info_queue + 1] = {key = 'PT_RobinHood_NoUsedTarots', set = 'Other'}
		end
		return {}
	end,
	config = {extra = {Rank = 9}},
	rarity = 2,
	pos = {x = 9, y = 1},
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
	linked_tarot = 'c_justice',
	calculate = function(self,card,context)
		if context.setting_blind then
			PT_RobinHood_RoundStart(card,card.ability.extra.Rank)
		end
		if context.end_of_round and context.game_over == false then
			PT_RobinHood_RoundWon(card,card.ability.extra.Rank)
		end
		if context.using_consumeable then
			-- Calcola Rank Up e Evoluzione
			if context.consumeable.ability.name == 'Justice' then
				PT_rankUp(card)
			end
            if not context.blueprint and card.ability.extra.Rank >= 10 then
				PT_evolve(card,'j_PT_Hereward')
			end
		end
	end
}

SMODS.Joker { -- 08.2 Hereward
	key = 'Hereward',
	loc_txt = {
		['it'] = {
			name = '{C:red}Hereward',
			text = {'Crea una copia {C:dark_edition}negativa','del tuo {C:purple}Tarot{} più','usato alla fine del round'},
			unlock = {'{C:red}Evolve{} the previous','Joker to unlock','this one'},
		},
		['default'] = {
			name = '{C:red}Hereward',
			text = {'Create a {C:dark_edition}negative{} copy','of your most used','{C:purple}Tarot{} at the end','of the round'},
			unlock = {'{C:red}Evolve{} the previous','Joker to unlock','this one'},
		},
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Justice', set = 'Other'}
		if G.GAME.PTvar_mostUsedTarot_key then
			info_queue[#info_queue + 1] = {key = 'PT_RobinHood_MostUsedTarot', set = 'Other', vars = {G.GAME.PTvar_mostUsedTarot_name}}
		else
			info_queue[#info_queue + 1] = {key = 'PT_RobinHood_NoUsedTarots', set = 'Other'}
		end
		return {}
	end,
	config = {extra = {Rank = 10}},
	rarity = 2,
	pos = {x = 10, y = 1},
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
	linked_tarot = 'c_justice',
	calculate = function(self,card,context)
		if context.setting_blind then
			PT_RobinHood_RoundStart(card,card.ability.extra.Rank)
		end
		if context.end_of_round and context.game_over == false then
			PT_RobinHood_RoundWon(card,card.ability.extra.Rank)
		end
	end
}

function PT_RobinHood_resetGlobalVars()
	G.GAME.PTvar_RobinHood_canBetrayalSpawn = false
	G.GAME.PTvar_RobinHood_roundCounter = 0
	print("canBetrayalSpawn = "..tostring(G.GAME.PTvar_RobinHood_canBetrayalSpawn))
	sendTraceMessage("Robin Hood's variabiles have been reset","PT_RobinHood_resetGlobalVars")
end

function PT_RobinHood_RoundStart(card,rank)
    if rank == 9 then
	    G.GAME.PTvar_RobinHood_roundCounter = G.GAME.PTvar_RobinHood_roundCounter + 1
    end
    if rank < 9 then
        G.GAME.PTvar_RobinHood_roundCounter = G.GAME.PTvar_RobinHood_roundCounter + 1
    end
end

function PT_RobinHood_RoundWon(card,rank)
    if G.GAME.PTvar_RobinHood_roundCounter >= 5 then
        PTvar_RobinHood_canBetrayalSpawn = true
    end
    if rank < 9 then
	    PT_RobinHood_createMostUsedTarot()
    else
        PT_RobinHood_createNegativeMostUsedTarot()
    end
end

function PT_RobinHood_createMostUsedTarot()
    -- Create most used tarot
	sendTraceMessage("Creating most useful tarot...","RobinHood")
    if G.GAME.PTvar_mostUsedTarot_key then
        sendTraceMessage("Creating "..G.GAME.PTvar_mostUsedTarot_key.."...","RobinHood")
        PT_createConsumable(G.GAME.PTvar_mostUsedTarot_key,'Tarot',nil,nil)
    else
        sendTraceMessage("No tarots used in this run :(","RobinHood")
    end
end

function PT_RobinHood_createNegativeMostUsedTarot()
    -- Create negative most used tarot
	sendTraceMessage("Creating negative most useful tarot...","RobinHood")
    if G.GAME.PTvar_mostUsedTarot_key then
        sendTraceMessage("Creating "..G.GAME.PTvar_mostUsedTarot_key.."...","RobinHood")
        PT_createConsumable(G.GAME.PTvar_mostUsedTarot_key,'Tarot',{negative = true},true)
    else
        sendTraceMessage("No tarots used in this run :(","RobinHood")
    end
end