local UTIL = load(NFS.read(SMODS.current_mod.path .. 'util/util.lua'))()

local Money = {
    -- END OF ROUND
    [1] = 3,
    [2] = 4,
    [3] = 5,
    [4] = 6,
    [5] = 7,
    [6] = 9,
    [7] = 10,
    [8] = 12,
    -- HAND PLAYED
    [9] = 5,
    -- CARD SCORED
    MAX = 5
}

SMODS.Joker { -- 03 Milady
    key = 'Milady',
    loc_txt = {
        name = 'Milady',
        text = {'Earn {C:money}$#1#{} at','end of round'},
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME and G.GAME.PT then
            if card.ability.extra.Rank <= 8 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Empress'}}
                return {key = 'PT_Milady1-8', set = 'Joker', vars = {Money[card.ability.extra.Rank]}}
            elseif card.ability.extra.Rank == 9 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Empress'}}
                return {key = 'PT_Milady9', set = 'Joker'}
            else
                info_queue[#info_queue + 1] = {key = 'PT_Beyond_Empress', set = 'Other', vars = {card.ability.extra.Beyond}}
                return {key = 'PT_MiladyMAX', set = 'Joker'}
            end
        else
            info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Empress'}}
            return {vars = {Money[1]}}
        end
    end,
    config = {extra = {Rank = 1, Beyond = 0}},
    rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 0, y = 3},
    set_ability = function(self,card)
        UTIL.spriteCalc(card)
    end,
    atlas = 'Jokers',
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    linked_tarot = 'c_empress',
    igor_rankUp = function(card)
        UTIL.rankUp(card,{igor = true})
    end,
    calculate = function(self,card,context)
        -- RANK UP
        UTIL.rankUp(card,context)
        -- ABILITY
        local rank = card.ability.extra.Rank
        local beyond = card.ability.extra.Beyond
        if context.end_of_round and not context.repetition and not context.individual then
            if rank <= 8 then
                ease_dollars(Money[rank])
                UTIL.showTextJoker{card = context.blueprint_card or card, type = 'Money', value = Money[rank]}
            end
        end
        if context.joker_main then
            if rank == 9 then
                ease_dollars(Money[9])
                UTIL.showTextJoker{card = context.blueprint_card or card, type = 'Money', value = Money[9]}
            end
        end
        if context.individual and not context.repetition and context.cardarea == G.play then
            if rank == 10 then
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        ease_dollars(Money.MAX + beyond)
                        context.other_card:juice_up()
                        return true
                    end
                )}))
                UTIL.showTextJoker{card = context.blueprint_card or card, type = 'Money', value = Money.MAX + beyond}
            end
        end
    end,
}
