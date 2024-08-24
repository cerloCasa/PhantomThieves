local UTIL = SMODS.load_file('util/util.lua')()

local SCORE = {
    [1] = 10,
    [2] = 15,
    [3] = 20,
    [4] = 25,
    [5] = 30,
    [6] = 35,
    [7] = 40,
    [8] = 50,
    [9] = 75,
    [10] = 100,
    Beyond = 10
}

SMODS.Joker { -- 14 Teacher
    key = 'Teacher',
    loc_txt = {
        name = 'Teacher',
        text = {'Scoring cards give','{C:chips}+#1#{} Chips'},
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME and G.GAME.PT then
            local rank = card.ability.extra.Rank
            local beyond = card.ability.extra.Beyond
            if rank <= 8 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Temperance'}}
                return {vars = {SCORE[rank]}}
            elseif rank == 9 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Temperance'}}
                return {key = 'PT_Teacher9', set = 'Joker', vars = {SCORE[rank]}}
            else
                info_queue[#info_queue + 1] = {key = 'PT_Beyond_Temperance', set = 'Other', vars = {beyond * SCORE.Beyond}}
                return {key = 'PT_TeacherMAX', set = 'Joker', vars = {SCORE[rank]}}
            end
        else
            info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Temperance'}}
            return {vars = {10}}
        end
    end,
    config = {extra = {Rank = 1, Beyond = 0}},
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 0, y = 14},
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
    linked_tarot = 'c_temperance',
    igor_rankUp = function(card)
        UTIL.rankUp(card,{igor = true})
    end,
    calculate = function(card,card,context)
        -- RANK UP
        UTIL.rankUp(card,context)
        -- ABILITY
        local rank = card.ability.extra.Rank
        local beyond = card.ability.extra.Beyond
        if context.individual and not context.repetition and context.cardarea == G.play then
            return {
                chips = SCORE[rank] + beyond * SCORE.Beyond,
                card = context.blueprint_card or card
            }
        end
    end,
}