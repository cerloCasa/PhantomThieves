local UTIL = SMODS.load_file('util/util.lua')()

local HANDS = {
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 'ALL',
    [6] = 'ALL',
    [7] = 'ALL',
    [8] = 'ALL',
    [9] = 'ALL',
    [10] = 'ALL + CONTAINED'
}

local LEVELS = {
    [1] = 1,
    [2] = 1,
    [3] = 1,
    [4] = 1,
    [5] = 1,
    [6] = 1,
    [7] = 2,
    [8] = 2,
    [9] = 3,
    [10] = 3
}

local function allContainedPokerHands(poker_hands)
    local RET = {}
    for i,v in pairs(poker_hands) do
        if next(poker_hands[i]) then
            RET[i] = true
        end
    end
    RET[G.GAME.last_hand_played] = nil
    RET.top = nil
    return RET
end

SMODS.Joker { -- 07 Captain Kidd
    key = 'CaptainKidd',
    loc_txt = {
        name = 'Captain Kidd',
        text = {'Level up {C:attention}first{} hand','played each round'},
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME and G.GAME.PT then
            if card.ability.extra.Rank == 1 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Chariot'}}
                return
            elseif card.ability.extra.Rank <= 4 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Chariot'}}
                return {key = 'PT_CaptainKidd2-4', set = 'Joker', vars = {HANDS[card.ability.extra.Rank]}}
            elseif card.ability.extra.Rank <= 6 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Chariot'}}
                return {key = 'PT_CaptainKidd5-6', set = 'Joker'}
            elseif card.ability.extra.Rank <= 8 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Chariot'}}
                return {key = 'PT_CaptainKidd7-8', set = 'Joker'}
            elseif card.ability.extra.Rank == 9 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Chariot'}}
                return {key = 'PT_CaptainKidd9', set = 'Joker'}
            else
                info_queue[#info_queue + 1] = {key = 'PT_Beyond_Chariot', set = 'Other', vars = {card.ability.extra.Beyond}}
                return {key = 'PT_CaptainKiddMAX', set = 'Joker'}
            end
        else
            info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Charriot'}}
        end
    end,
    config = {extra = {Rank = 1, Beyond = 0}},
    rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 0, y = 7},
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
    linked_tarot = 'c_chariot',
    igor_rankUp = function(card)
        UTIL.rankUp(card,{igor = true})
    end,
    calculate = function(card,card,context)
        -- RANK UP
        UTIL.rankUp(card,context)
        -- ABILITY
        local rank = card.ability.extra.Rank
        local beyond = card.ability.extra.Beyond
        local hand = G.GAME.current_round.hands_played + 1
        if context.before then
            if rank <= 4 then
                if hand <= rank then
                    level_up_hand(context.blueprint_card or card, G.GAME.last_hand_played, nil, 1)
                end
            elseif rank <= 9 then
                level_up_hand(context.blueprint_card or card, G.GAME.last_hand_played, nil, LEVELS[rank])
            else
                level_up_hand(context.blueprint_card or card, G.GAME.last_hand_played, nil, LEVELS[rank] + beyond)
                for k,v in pairs(allContainedPokerHands(context.poker_hands)) do
                    level_up_hand(context.blueprint_card or card, k, true, LEVELS[rank] + beyond)
                end
            end 
        end
    end,
}