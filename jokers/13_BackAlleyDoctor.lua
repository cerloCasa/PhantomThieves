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
	cost = 4,
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