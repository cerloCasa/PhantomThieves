SMODS.Joker { -- 01 Zorro
    key = 'Zorro',
    loc_txt = {
        ['default'] = {
            name = 'Zorro',
            text = {'#1#{C:planet}#2#{}#3#',
            '{C:planet}#4#{}#5#{C:attention}#6#',
            '{C:green}#7#{}#8#{C:attention}#9#',
            '{C:inactive}(Must have room)'},
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Magician', set = 'Other'}
        if card and card.ability and card.ability.extra and card.ability.extra.Rank then
            if card.ability.extra.Rank < 3 then
                return {vars = {'Creates a random ','','','Planet ','card at','','','the end of the round',''}}
            end
            if card.ability.extra.Rank < 5 then
                return {vars = {'Creates the ','Planet ','card','','for final played','','','','poker hand'}}
            end
            if card.ability.extra.Rank < 7 then
                return {vars = {'Creates the ','Planet','','','card for played','','','','poker hand'}}
            end
            return {vars = {'Creates the ','Planet ','card','','for played ','poker hand',(G.GAME and G.GAME.probabilities.normal or 1) .. ' in 3 ','chance to create two',''}}    
        else
            return {vars = {'Creates a random ','','','Planet ','card at','','','the end of the round',''}}
        end
    end,
    config = {extra = {Rank = 1}},
    rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 2, y = 0},
    soul_pos = {x = 3, y = 3},
    atlas = 'Jokers',
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    linked_tarot = 'c_magician',
    calculate = function(self,card,context)
        if context.joker_main then
            PT_Zorro_HandCalc(card,card.ability.extra.Rank)
        end
        if context.end_of_round and context.game_over == false then
            PT_Zorro_RoundWon(card,card.ability.extra.Rank)
        end
        if context.using_consumeable then
            -- Calcola Rank Up e Evoluzione
            if context.consumeable.ability.name == 'The Magician' and card.ability.extra.Rank < 9 then
                PT_rankUp(card)
            end
            if not context.blueprint and card.ability.extra.Rank == 9 then
                PT_evolve(card,'j_PT_Mercurius')
            end
            if not context.blueprint and card.ability.extra.Rank >= 10 then
                PT_evolve(card,'j_PT_Diego')
            end
        end
    end,
}

SMODS.Joker { -- 01.1 Mercurius
    key = 'Mercurius',
    loc_txt = {
        ['default'] = {
            name = '{C:blue}Mercurius',
            text = {'Creates a {C:dark_edition}Negative','{C:blue}Planet{} card for','played {C:attention}poker hand','{C:green}#1# in 3{} chance to create two'},
            unlock = {'{C:red}Evolve{} the previous','Joker to unlock','this one'},
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Magician', set = 'Other'}
        return {vars = {""..(G.GAME and G.GAME.probabilities.normal or 1)}}
    end,
    config = {extra = {Rank = 9}},
    rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 3, y = 0},
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
    linked_tarot = 'c_magician',
    calculate = function(self,card,context)
        if context.joker_main then
            PT_Zorro_HandCalc(card,card.ability.extra.Rank)
        end
        if context.using_consumeable then
            -- Calcola Rank Up e Evoluzione
            if context.consumeable.ability.name == 'The Magician' and card.ability.extra.Rank < 10 then
                PT_rankUp(card)
            end
            if not context.blueprint and card.ability.extra.Rank >= 10 then
                PT_evolve(card,'j_PT_Diego')
            end
        end
    end,
}

SMODS.Joker { -- 01.2 Diego
    key = 'Diego',
    loc_txt = {
        ['default'] = {
            name = '{C:red}Diego',
            text = {'Creates two {C:dark_edition}Negative','{C:blue}Planet{} cards for','played {C:attention}poker hand'},
            unlock = {'{C:red}Evolve{} the previous','Joker to unlock','this one'},
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Magician', set = 'Other'}
    end,
    config = {extra = {Rank = 10}},
    rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 4, y = 0},
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
    linked_tarot = 'c_magician',
    calculate = function(self,card,context)
        if context.joker_main then
            PT_Zorro_HandCalc(card,card.ability.extra.Rank)
        end
    end,
}

function PT_Zorro_HandCalc(card,rank)
    if rank > 4 and rank < 9 then
        PT_createConsumable('lastHandPlayed','Planet',nil,nil)
    end
    if rank == 7 or rank == 8 then
        if PT_random(1,3) then
            PT_createConsumable('lastHandPlayed','Planet',nil,nil)
        end
    end
    if rank == 9 then
        PT_createConsumable('lastHandPlayed','Planet',{negative = true},true)
        if PT_random(1,3) then
            PT_createConsumable('lastHandPlayed','Planet',{negative = true},true)
        end
    end
    if rank == 10 then
        PT_createConsumable('lastHandPlayed','Planet',{negative = true},true)
        PT_createConsumable('lastHandPlayed','Planet',{negative = true},true)
    end
end

function PT_Zorro_RoundWon(card,rank)
    if rank < 3 then
        PT_createConsumable(nil,'Planet',nil,nil)
    elseif rank < 5 then
        PT_createConsumable('lastHandPlayed','Planet',nil,nil)
    end
end