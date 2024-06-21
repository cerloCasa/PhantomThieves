SMODS.Joker { -- 11 Twins
    key = 'Twins',
    loc_txt = {
		['default'] = {
			name = 'Twins',
			text = {'{C:inactive}#1#{C:purple}#2#{}#3#'},
		},
	},
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Strength', set = 'Other'}
		if PTvar_Twins then
			if card.ability.extra.Rank < 3 then
				return {vars = {
					'Does nothing...','',''
				}}
			elseif card.ability.extra.Rank < 7 then
				return {vars = {
					'','+1',' Joker slot'
				}}
			else
				return {vars = {
					'','+2',' Joker slots'
				}}
			end
		else
			return {vars = {
				'Does nothing...','',''
			}}
		end
	end,
	config = {extra = {Rank = 1}},
	rarity = 1,
	pos = {x = 2, y = 2},
	soul_pos = {x = 3, y = 3},
	set_ability = function(self, card)
		PT_soulPos(card)
	end,
	atlas = 'Jokers',
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	linked_tarot = 'c_strength',
    calculate = function(self,card,context)
		if context.using_consumeable then
			-- Rank Up
			if context.consumeable.ability.name == 'Strength' and card.ability.extra.Rank < 10 then
				PT_rankUp(card)
				if card.ability.extra.Rank == 10 then
					PT_evolve(card,'j_PT_Lavenza')
				else
                	PT_Twins_AddJokerSlots(card.ability.extra.Rank)
				end            
			end
		end
	end,
    remove_from_deck = function(self, card, from_debuff)
        PT_Twins_RemoveJokerSlots(card.ability.extra.Rank)
    end
}

SMODS.Joker { -- 11.1 Lavenza
    key = 'Lavenza',
    loc_txt = {
		['default'] = {
			name = 'Lavenza',
			text = {'{C:purple}+3{} Joker slots'},
		},
	},
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Strength', set = 'Other'}
		return {

        }
	end,
	config = {extra = {Rank = 10}},
	rarity = 1,
	pos = {x = 3, y = 2},
	soul_pos = {x = 12, y = 3},
	set_ability = function(self, card)
		PT_soulPos(card)
	end,
	atlas = 'Jokers',
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	linked_tarot = 'c_strength',
	add_to_deck = function(self,card,from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + 3 
	end
    remove_from_deck = function(self, card, from_debuff)
        PT_Twins_RemoveJokerSlots(card.ability.extra.Rank)
    end
}

function PT_Twins_resetGlobalVars(){
	G.GAME.PTvar_Twins = true
	print("PTvarTwins = "..tostring(G.GAME.PTvar_Twins))
	sendTraceMessage("Twins's variabiles have been reset","PT_Twins_resetGlobalVars")
}

function PT_Twins_AddJokerSlots(rank)
    local jokerSlots = G.jokers.config.card_limit
    if rank == 3 then
        jokerSlots = jokerSlots + 1
    end
    if rank == 7 then
        jokerSlots = jokerSlots + 1
    end
    G.jokers.config.card_limit = jokerSlots
end

function PT_Twins_RemoveJokerSlots(rank)
    if rank >= 3 then
        G.jokers.config.card_limit = G.jokers.config.card_limit - 1
    end
    if rank >= 7 then
        G.jokers.config.card_limit = G.jokers.config.card_limit - 1
    end
    if rank == 10 then
        G.jokers.config.card_limit = G.jokers.config.card_limit - 1
    end
end