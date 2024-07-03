SMODS.Joker { -- 14 Teacher
    key = 'Teacher',
    loc_txt = {
        ['default'] = {
            name = 'Teacher',
            text = {'Played cards give','{C:chips}#1#{} Chips','when scored'},
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Temperance', set = 'Other'}
        if card and card.ability and card.ability.extra and card.ability.extra.Rank then
            return {vars = {PT_Teacher_locvars(card.ability.extra.Rank)}}
        end
        return {vars = {"+20"}}
    end,
    config = {extra = {Rank = 1}},
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 6, y = 2},
    soul_pos = {x = 3, y = 3},
    set_ability = function(self,card)
        PT_soulPos(card)
    end,
    atlas = 'Jokers',
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    linked_tarot = 'c_temperance',
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            PT_Teacher_CardPlay(card,card.ability.extra.Rank,context)
        end
        if context.using_consumeable then
            -- Calcola Rank Up e Evoluzione
            if context.consumeable.ability.name == 'Temperance' and card.ability.extra.Rank < 10 then
                PT_rankUp(card)
            end
        end
    end,
}

function PT_Teacher_locvars(rank)
    if rank <= 2 then
        return ("+20")
    elseif rank <= 4 then
        return ("+30")
    elseif rank <= 6 then
        return ("+40")
    elseif rank <= 8 then
        return ("X2")
    elseif rank <= 9 then
        return ("X3")
    end
    return ("X4")
end

function PT_Teacher_CardPlay(card,rank,context)
    if rank <= 2 then
        aChips(20,context.other_card,context)
    elseif rank <= 4 then
        aChips(30,context.other_card,context)
    elseif rank <= 6 then
        aChips(40,context.other_card,context)
    elseif rank <= 8 then
        xChips(2,context.other_card,context)
    elseif rank <= 9 then
        xChips(3,context.other_card,context)
    else
        xChips(4,context.other_card,context)
    end
end