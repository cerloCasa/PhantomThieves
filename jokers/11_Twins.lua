SMODS.Joker { -- 11 Twins
	key = 'Twins',
	loc_txt = {
		['it'] = {
			name = 'Gemelle',
			text = {''},
		},
		['default'] = {
			name = 'Twins',
			text = {'{C:inactive}#1#{}{C:purple}+#2#{}#3#'},
		},
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Strength', set = 'Other'}
		return {

        }
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
    add_to_deck = function(self, card, from_debuff)
    end,
    remove_from_deck = function(self, card, from_debuff)
    end,
	calculate = function(self,card,context)
		if context.using_consumeable then
			-- Calcola Rank Up e Evoluzione
			if context.consumeable.ability.name == 'Strength' and card.ability.extra.Rank < 10 then
				PT_rankUp(card)
			end
			if card.ability.extra.Rank == 10 then
				PT_evolve(card,'j_PT_Lavenza')
			end
		end
	end
}