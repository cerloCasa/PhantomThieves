local UTIL = SMODS.load_file('util/util.lua')()

local SLOTS = {
    [0] = 0,
    [1] = 0,
    [2] = 1,
    [3] = 1,
    [4] = 1,
    [5] = 2,
    [6] = 2,
    [7] = 2,
    [8] = 2,
    [9] = 2,
    [10] = 3,
    Beyond = 1
}

SMODS.Joker { -- 11 Wardens
    key = 'Wardens',
    loc_txt = {
        name = 'Wardens',
        text = {'{C:inactive}Does nothing...'},
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME and G.GAME.PT then
            local rank = card.ability.extra.Rank
            local beyond = card.ability.extra.Beyond
            if rank == 1 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Strength'}}
                return
            elseif card.ability.extra.Rank <= 4 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Strength'}}
                return {key = 'PT_Wardens2-4', set = 'Joker'}
            elseif card.ability.extra.Rank <= 8 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Strength'}}
                return {key = 'PT_Wardens5-8', set = 'Joker'}
            elseif card.ability.extra.Rank == 9 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Strength'}}
                return {key = 'PT_Wardens9', set = 'Joker'}
            else
                info_queue[#info_queue + 1] = {key = 'PT_Beyond_Strength', set = 'Other', vars = {beyond}}
                return {key = 'PT_WardensMAX', set = 'Joker'}
            end
        else
            info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Strength'}}
        end
    end,
    config = {extra = {Rank = 1, Beyond = 0}},
    rarity = 3, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 0, y = 11},
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
    linked_tarot = 'c_strength',
    remove_from_deck = function(self,card,from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - SLOTS[card.ability.extra.Rank] - card.ability.extra.Beyond
    end,
    igor_rankUp = function(card)
        local oldRank = card.ability.extra.Rank or 1
        local beyondGained = UTIL.rankUp(card,{igor = true}) or 0
        local rank = card.ability.extra.Rank or 1
        if rank > oldRank or beyondGained > 0 then
            G.jokers.config.card_limit = G.jokers.config.card_limit + SLOTS[rank] - SLOTS[oldRank] + beyondGained
            UTIL.showTextJoker{card = card, type = '+JokerSlot', value = (SLOTS[rank] - SLOTS[oldRank] + beyondGained)}
        end
    end,
    calculate = function(card,card,context)
        local oldRank = card.ability.extra.Rank
        -- RANK UP
        local beyondGained = UTIL.rankUp(card,context) or 0
        -- ABILITY
        local rank = card.ability.extra.Rank
        if rank > oldRank or beyondGained > 0 then
            G.jokers.config.card_limit = G.jokers.config.card_limit + SLOTS[rank] - SLOTS[oldRank] + beyondGained
            UTIL.showTextJoker{card = card, type = '+JokerSlot', value = (SLOTS[rank] - SLOTS[oldRank] + beyondGained)}
        end
    end,
}