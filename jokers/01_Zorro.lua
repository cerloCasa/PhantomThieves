SMODS.Joker { -- 01 Zorro
    key = 'Zorro',
    loc_txt = {
        ['default'] = {
            name = 'Zorro',
            text = {'Jokers ability'},
        },
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {}}
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
        if context.setting_blind then
            PT_Zorro_RoundStart(card,card.ability.extra.Rank)
        end
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
            if card.ability.extra.Rank == 9 then
                PT_evolve(card,'j_PT_Mercurius')
            end
        end
    end,
}

function PT_Zorro_RoundStart(card,rank)
end
function PT_Zorro_HandCald(card,rank)
end
function PT_Zorro_RoundWon(card,rank)
end