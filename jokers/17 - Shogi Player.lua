local UTIL = SMODS.load_file('util/util.lua')()

local Discards = {
    [1] = 1,
    [2] = 1,
    [3] = 1,
    [4] = 1,
    [5] = 1,
    [6] = 1,
    [7] = 2,
    [8] = 2,
    [9] = 2,
    [10] = 3,
    Beyond = 1
}
local Prob = {
    [1] = 4,
    [2] = 3,
    [3] = 2,
}
    
SMODS.Joker { -- 17 Shogi Player
    key = 'ShogiPlayer',
    loc_txt = {
        name = 'Shogi player',
        text = {'{C:green}#1# in #2#{} chance of','{C:red}+1{} discard per round'},
    },
    loc_vars = function(self, info_queue, card)
        local prob = (G.GAME and G.GAME.probabilities.normal or 1)
        if G.GAME and G.GAME.PT then
            local rank = card.ability.extra.Rank
            local beyond = card.ability.extra.Beyond
            if rank <= 3 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Star'}}
                return {vars = {prob, Prob[rank]}}
            elseif rank <= 6 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Star'}}
                return {key = 'PT_ShogiPlayer4-6', set = 'Joker'}
            elseif rank <= 8 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Star'}}
                return {key = 'PT_ShogiPlayer7-8', set = 'Joker'}
            elseif rank == 9 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Star'}}
                return {key = 'PT_ShogiPlayer9', set = 'Joker'}
            else
                info_queue[#info_queue + 1] = {key = 'PT_Beyond_Star', set = 'Other', vars = {beyond * Discards.Beyond}}
                return {key = 'PT_ShogiPlayerMAX', set = 'Joker'}
            end
        else
            info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Star'}}
            return {vars = {prob, 4}}
        end
    end,
    config = {extra = {Rank = 1, Beyond = 0}},
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 0, y = 17},
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
    linked_tarot = 'c_star',
    igor_rankUp = function(card)
        UTIL.rankUp(card,{igor = true})
    end,
    calculate = function(self,card,context)
        -- RANK UP
        UTIL.rankUp(card,context)
        -- ABILITY
        local rank = card.ability.extra.Rank
        local beyond = card.ability.extra.Beyond
        if context.setting_blind and not self.getting_sliced then
            if Prob[rank] and not UTIL.random(1,Prob[rank]) then
                return
            end
            G.E_MANAGER:add_event(Event({func = function()
                ease_discard(Discards[rank] + beyond * Discards.Beyond)
            return true end }))
        end
    end,
}
