local UTIL = SMODS.load_file('util/util.lua')()

local GOOD = {
    [1] = 15,
    [2] = 20,
    [3] = 25,
    [4] = 30,
    [5] = 40,
    [6] = 40,
    [7] = 50,
    [8] = 70,
    [9] = 80,
    [10] = 100,
    Beyond = 10
}
local BAD = {
    [1] = 15,
    [2] = 20,
    [3] = 20,
    [4] = 20,
    [5] = 40,
    [6] = 30,
    [7] = 30,
    [8] = 50,
    [9] = 50,
    [10] = 50,
    Beyond = 5
}

SMODS.Joker { -- 10 Prophetess
    key = 'Prophetess',
    loc_txt = {
        name = 'Prophetess',
        text = {'{C:green}1 in 2{} chance {C:inactive}(fixed){}.','If it\'s {X:green,C:white}Good{}, all scoring','cards give {C:chips}+#1#{} Chips.','If it\'s {X:red,C:white}Bad{}, all scoring','cards give {C:chips}-#2#{} Chips.'},
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME and G.GAME.PT then
            local rank = card.ability.extra.Rank
            local beyond = card.ability.extra.Beyond
            if rank <= 8 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Wheel of Fortune'}}
                return{vars = {GOOD[rank],BAD[rank]}}
            elseif rank == 9 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Wheel of Fortune'}}
                return {key = 'PT_Prophetess9', set = 'Joker', vars = {GOOD[rank],BAD[rank]}}
            else
                info_queue[#info_queue + 1] = {key = 'PT_Beyond_WheelOfFortune', set = 'Other', vars = {beyond*GOOD.Beyond, beyond*BAD.Beyond}}
                return {key = 'PT_ProphetessMAX', set = 'Joker', vars = {GOOD[rank],BAD[rank]}}
            end
        else
            info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Wheel of Fortune'}}
            return{vars = {15,15}}
        end
    end,
    config = {extra = {Rank = 1, Beyond = 0, Roll = 0}},
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 0, y = 10},
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
    linked_tarot = 'c_wheel_of_fortune',
    igor_rankUp = function(card)
        UTIL.rankUp(card,{igor = true})
    end,
    calculate = function(self, card, context)
        -- RANK UP
        UTIL.rankUp(card,context)
        -- ABILITY
        if context.before and not context.blueprint then
            if UTIL.randomInt(2) == 1 then
                card.ability.extra.Roll = true
                UTIL.showTextJoker{card = card, type = 'Good'}
            else
                card.ability.extra.Roll = false
                UTIL.showTextJoker{card = card, type = 'Bad'}
            end
        end
        if context.individual and context.cardarea == G.play and not context.repetition then
            if card.ability.extra.Roll then
                return{
                    chips = GOOD[card.ability.extra.Rank] + card.ability.extra.Beyond * GOOD.Beyond,
                    card = context.blueprint_card or card
                }
            else
                return{
                    chips = -1 * BAD[card.ability.extra.Rank] + card.ability.extra.Beyond * BAD.Beyond,
                    card = context.blueprint_card or card
                }
            end
        end
    end
}