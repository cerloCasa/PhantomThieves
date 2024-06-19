--- STEAMODDED HEADER
--- MOD_NAME: Phantom Thieves 0.3
--- MOD_ID: PhantomThieves
--- MOD_AUTHOR: [Cerlo]
--- MOD_DESCRIPTION: A Persona 5 Mod
--- BADGE_COLOR: DB2109
--- PREFIX: PT
--- PRIORITY: -1000000
--- LOADER_VERSION_GEQ: 1.0.0
_RELEASE_MODE = false

G.PhantomTheves_Vars = {
    PTvar_usedTarot = {},
    PTvar_mostUsedTarot_key = nil,
	PTvar_mostUsedTarot_name = nil,
    PTvar_mostUsedTarot_N = 0,
    PTvar_usefulTarots = {},
	PTvar_Milady = {},
	PTvar_RobinHood_canBetayalSpawn = false,
	PTvar_RobinHood_roundCounter = 0
}

-- MODIFY VANILLA GAME FUNCTIONS

local vanilla_Back_apply_to_run = Back.apply_to_run
function Back.apply_to_run(self)
	vanilla_Back_apply_to_run(self)
	PT_resetGlobalVars()
	return true
end

local vanilla_G_FUNCS_use_card = G.FUNCS.use_card
G.FUNCS.use_card = function(e,mute,nosave)
    vanilla_G_FUNCS_use_card(e,mute,nosave)
    local card = e.config.ref_table
    if card.ability.consumeable then
        if (card.ability.set == 'Tarot') then
            sendTraceMessage("Calling tarotUsed function","PT_use_card")
            PT_tarotUsed(card)
        end
    end
end

-- COMMON FUNCTIONS

function PT_createConsumable(key,set,edition,negative)
    if negative or (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) then
        G.E_MANAGER:add_event(Event({
            func = function() 
                local _card = create_card(set,G.consumeables, nil, nil, nil, nil, key)
                _card:add_to_deck()
                if edition then
                    _card:set_edition(edition, negative)
                end
                G.consumeables:emplace(_card)
            return true;
        end}))
    else
        sendTraceMessage("No room for new consumable :/","PT_createConsumable")
    end
end

function PT_createJoker(key,edition,negative)
    G.E_MANAGER:add_event(Event({
        func = function() 
            local _card = create_card('Joker',G.jokers, nil, nil, nil, edition and negative, key)
            _card:start_materialize()
            _card:add_to_deck()
            if edition then
                _card:set_edition(edition,negative)
            end
            G.jokers:emplace(_card)
            return true;
        end}))
end

function PT_destroyJoker(card)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
        func = function()
                G.jokers:remove_card(card)
                card:remove()
                card = nil
            return true;
        end}))
end

function PT_expandConsumeableArea(amount)
    G.E_MANAGER:add_event(Event({func = function()
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + amount
        return true;
    end}))
end

function PT_reduceConsumeableArea(amount)
    G.E_MANAGER:add_event(Event({func = function()
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - amount
        return true;
    end}))
end


-- UTIL FUNCTIONS

function PT_resetGlobalVars()
    G.GAME.PTvar_usedTarot = {}
    G.GAME.PTvar_mostUsedTarot_N = 0
    G.GAME.PTvar_mostUsedTarot_key = nil
    G.GAME.PTvar_mostUsedTarot_name = nil
    G.GAME.PTvar_usefulTarots = {}
	PT_Milady_resetGlobalVars()
	PT_RobinHood_resetGlobalVars()
	sendTraceMessage("All global variables have been reset","PT_resetGlobalVars")
end

function PT_evolve(start,dest)
    sendTraceMessage("Evolving to " .. dest,start.config.center_key)
    -- Save START's edition
    local Edition, Negative
    if start.edition then
        Edition = start.edition
        Negative = start.edition.negative
    end

    -- Destroy START
    PT_destroyJoker(start)
    
    -- Create DEST with Edition and Negative
    PT_createJoker(dest,Edition,Negative)
    sendTraceMessage("Successfully evolved to " .. dest,start.config.center_key)
end

function PT_rankUp(card) 
    card.ability.extra.Rank = card.ability.extra.Rank + 1
	PT_soulPos(card)
    sendTraceMessage("New rank is " .. card.ability.extra.Rank,card.config.center_key)
end

function PT_soulPos(card)
	card.config.center.soul_pos = {x = 2 + card.ability.extra.Rank, y = 3}
	card:set_sprites(card.config.center)
end

function PT_tarotUsed(tarot)
    sendTraceMessage("Adding "..tarot.config.center_key.." to the table","PT_tarotUsed")
    G.GAME.PTvar_usedTarot[tarot.config.center_key] = (G.GAME.PTvar_usedTarot[tarot.config.center_key] or 0) + 1
    sendTraceMessage(tarot.config.center_key.." has been used "..G.GAME.PTvar_usedTarot[tarot.config.center_key].." times","PT_tarotUsed")
    if G.GAME.PTvar_usedTarot[tarot.config.center_key] > G.GAME.PTvar_mostUsedTarot_N then
        G.GAME.PTvar_mostUsedTarot_key = tarot.config.center_key
		G.GAME.PTvar_mostUsedTarot_name = tarot.ability.name
        G.GAME.PTvar_mostUsedTarot_N = G.GAME.PTvar_usedTarot[tarot.config.center_key]
    end
    sendTraceMessage("The most used Tarot is now "..G.GAME.PTvar_mostUsedTarot_key.." with "..G.GAME.PTvar_mostUsedTarot_N.." uses","PT_tarotUsed")
end

function SMODS.current_mod.process_loc_text()
	G.localization.descriptions.Other['PT_LinkedTarot_Justice'] = {
		name = 'Linked Tarot',
		text = {'Use the {C:purple}Justice Tarot','to {C:red}rank up{} this Joker'}
	}
	G.localization.descriptions.Other['PT_LinkedTarot_Empress'] = {
		name = 'Linked Tarot',
		text = {'Use the {C:purple}Empress Tarot','to {C:red}rank up{} this Joker'}
	}
	G.localization.descriptions.Other['PT_LinkedTarot_Death'] = {
		name = 'Linked Tarot',
		text = {'Use the {C:purple}Death Tarot','to {C:red}rank up{} this Joker'}
	}
	G.localization.descriptions.Other['PT_RobinHood_MostUsedTarot'] = {
		name = 'Most used Tarot',
		text = {'Currently the most used','{C:purple}Tarot{} is {C:purple}#1#'}
	}
	G.localization.descriptions.Other['PT_RobinHood_NoUsedTarots'] = {
		name = 'Most used Tarot',
		text = {'No {C:purple}Tarots{} have ','been used this run'}
	}
	sendTraceMessage("Lock text done","PTprocessLocText")
end

-- JOKERS

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
	pos = {x = 8, y = 0},soul_pos = {x = 3, y = 3},
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
			if card.ability.extra.Rank == 10 then
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
	cost = 5,
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
			if card.ability.extra.Rank == 10 then
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
	end
}

SMODS.Joker { -- 13 Back Alley Doctor
	key = 'BackAlleyDoctor',
	loc_txt = {
		['it'] = {
			name = '',
			text = {''},
		},
		['default'] = {
			name = 'Back Alley Doctor',
			text = {
				'{C:chips}+#1#{} Chips#2#{C:mult}#3#{}#4#{C:purple}#5#',
				'#6#{C:purple}#7#{}#8#',
				'{C:inactive}#9#{C:chips}#10#{C:inactive}#11#{}#12#',
				'{C:inactive}#13#{C:chips}#14#{C:inactive}#15#{C:mult}#16#{C:inactive}#17#'
			},
		},
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Death', set = 'Other'}
		if G.GAME.consumeable_usage_total then
			if card.ability.extra.Rank < 7 then
				return {vars = {PT_BackAlleyDoctorTable(card,'chips'),' per ','','','Tarot','card used this run.','','','(Currently ','+'..PT_BackAlleyDoctorTotal(card,'chips'),' Chips)','','','','','','',}}
			else
				return {vars = {PT_BackAlleyDoctorTable(card,'chips'),' and ','+'..PT_BackAlleyDoctorTable(card,'mult'),' Mult','','per ','Tarot',' card','','','','used this run.','(Currently ','+'..PT_BackAlleyDoctorTotal(card,'chips'),' Chips and ','+'..PT_BackAlleyDoctorTotal(card,'mult'),' Mult)'}}
			end
		else
			return {vars = {20,' per ','','','Tarot','card used this run.','','','(Currently ','+0',' Chips)','','','','','','',}}
		end
	end,
	config = {extra = {Rank = 1}},
	rarity = 1,
	pos = {x = 5, y = 2},
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
	linked_tarot = 'c_death',
	calculate = function(self,card,context)
		if context.joker_main then
			if G.GAME.PTvar_mostUsedTarot_key then
				if PT_BackAlleyDoctorTable(card,'mult') == 0 then
					return {
						message = localize{type='variable',key='a_chips',vars={PT_BackAlleyDoctorTotal(card,'chips')}},
						chip_mod = PT_BackAlleyDoctorTotal(card,'chips'),
						colour = G.C.CHIPS
					}
				else
					return {
						message = localize{type='variable',key='a_chips',vars={PT_BackAlleyDoctorTotal(card,'chips')}},
						chip_mod = PT_BackAlleyDoctorTotal(card,'chips'),
						message = localize{type='variable',key='a_mult',vars={PT_BackAlleyDoctorTotal(card,'mult')}},
						mult_mod = PT_BackAlleyDoctorTotal(card,'mult'),
						colour = G.C.MULT
					}
				end
			end
		end
		if context.using_consumeable then
			-- Calcola Rank Up e Evoluzione
			if context.consumeable.ability.name == 'Death' and card.ability.extra.Rank < 10 then
				PT_rankUp(card)
			end
		end
	end
}

-- MILADY FUNCTIONS

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

-- ROBIN HOOD FUNCTIONS

function PT_RobinHood_resetGlobalVars()
	G.GAME.PTvar_RobinHood_canBetayalSpawn = false
	G.GAME.PTvar_RobinHood_roundCounter = 0
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
        PTvar_RobinHood_canBetayalSpawn = true
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

-- BACK ALLEY DOCTOR FUNCTIONS

function PT_BackAlleyDoctorTable(card,string)
	local rank = card.ability.extra.Rank
	if string == 'chips' then
		local first = 10*(rank - (rank % 2.4))/2.4
		local second = 10*(rank - (rank % 7.5))/7.5
		local third = 10*(rank - (rank % 8.5))/8.5
		return (20 + first - second + third)
	end
	if string == 'mult' then
		local first = (rank - (rank % 6.5))/6.5
		local second = (rank - (rank % 8.5))/8.5
		local third = (rank - (rank % 9.5))/9.5
		return (first + second + third)
	end
end

function PT_BackAlleyDoctorTotal(card,string)
	return PT_BackAlleyDoctorTable(card,string) * G.GAME.consumeable_usage_total.tarot
end

-- CONSUMEABLES

-- BLINDS

-- ASSETS
SMODS.Atlas { -- modicon
	key = 'modicon',
	px = 34,
	py = 34,
	path = 'modicon.png'
}

SMODS.Atlas { -- Jokers
	key = 'Jokers',
	px = 71,
	py = 95,
	path = 'Jokers.png'
}