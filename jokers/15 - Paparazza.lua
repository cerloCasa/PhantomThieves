local UTIL = SMODS.load_file('util/util.lua')()

local Percent = {
    [1] = 5,
    [2] = 7.5,
    [3] = 10,
    [4] = 12.5,
    [5] = 15,
    [6] = 17.5,
    [7] = 20,
    [8] = 22.5,
    [9] = 25,
    [10] = 30,
    Beyond = 2
}

SMODS.Joker { -- 15 Paparazza
    key = 'Paparazza',
    loc_txt = {
        name = 'Paparazza',
        text = {'Reduce required {C:attention}chip','{C:attention}score{} of {C:attention}Blinds','by #1#%'},
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME and G.GAME.PT then
            local rank = card.ability.extra.Rank
            local beyond = card.ability.extra.Beyond
            if beyond > 30 then
                beyond = 30
            end
            if rank <= 8 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Devil'}}
                return {vars = {Percent[rank]}}
            elseif rank == 9 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Devil'}}
                return {key = 'PT_Paparazza9', set = 'Joker', vars = {Percent[rank]}}
            else
                info_queue[#info_queue + 1] = {key = 'PT_Beyond_Devil', set = 'Other', vars = {beyond * Percent.Beyond}}
                return {key = 'PT_PaparazzaMAX', set = 'Joker', vars = {Percent[rank]}}
            end
        else
            info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Devil'}}
            return {vars = {Percent[1]}}
        end
    end,
    config = {extra = {Rank = 1, Beyond = 0}},
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 0, y = 15},
    set_ability = function(self,card)
        UTIL.spriteCalc(card)
    end,
    atlas = 'Jokers',
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    linked_tarot = 'c_devil',
    igor_rankUp = function(card)
        UTIL.rankUp(card,{igor = true})
    end,
    calculate = function(self,card,context)
        -- RANK UP
        UTIL.rankUp(card,context)
        -- ABILITY
        local rank = card.ability.extra.Rank
        local beyond = card.ability.extra.Beyond
        if beyond > 30 then
            beyond = 30
        end
        if context.setting_blind and not context.blueprint then
            G.GAME.blind.chips = G.GAME.blind.chips * (1 - ((Percent[rank] + beyond * Percent.Beyond) / 100))
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end
    end,
}
