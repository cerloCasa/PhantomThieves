local UTIL = SMODS.load_file('util/util.lua')()

local PROB = {
    [1] = 50,
    [2] = 40,
    [3] = 30,
    [4] = 20,
    [5] = 15,
    [6] = 10,
    [7] = 8,
    [8] = 5,
    [9] = 3,
    [10] = 1
}

SMODS.Joker { -- 08 Robin Hood
    key = 'RobinHood',
    loc_txt = {
        name = 'Robin Hood',
        text = {'{C:green}1 in 50{} chance to','enhance a random Joker','you own to {C:dark_edition}negative{} at','end of round'},
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME and G.GAME.PT then
            if card.ability.extra.Rank <= 8 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Justice'}}
                if not (card.edition and card.edition.negative == true) then
                    info_queue[#info_queue + 1] = G.P_CENTERS['e_negative']
                end
                return {key = 'PT_RobinHood1-8', set = 'Joker', vars = {G.GAME and G.GAME.probabilities.normal or 1, PROB[card.ability.extra.Rank]}}
            elseif card.ability.extra.Rank == 9 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Justice'}}
                if not (card.edition and card.edition.negative == true) then
                    info_queue[#info_queue + 1] = G.P_CENTERS['e_negative']
                end
                return {key = 'PT_RobinHood9', set = 'Joker', vars = {G.GAME and G.GAME.probabilities.normal or 1}}
            else
                if not (card.edition and card.edition.negative == true) then
                    info_queue[#info_queue + 1] = G.P_CENTERS['e_negative']
                end
                return {key = 'PT_RobinHoodMAX', set = 'Joker'}
            end
        else
            info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Justice'}}
            if not (card.edition and card.edition.negative == true) then
                info_queue[#info_queue + 1] = G.P_CENTERS['e_negative']
            end
        end
    end,
    config = {extra = {Rank = 1, Beyond = 0}},
    rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 0, y = 8},
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
    linked_tarot = 'c_justice',
    igor_rankUp = function(card)
        UTIL.rankUp(card,{igor = true})
    end,
    calculate = function(card,card,context)
        -- RANK UP
        UTIL.rankUp(card,context)
        -- ABILITY
        local rank = card.ability.extra.Rank
        if context.end_of_round and not context.repetition and not context.individual then
            if UTIL.random(1,PROB[rank]) then
                -- Fill a table with all non negative Jokers
                local nonNegJokers = {}
                for k,v in pairs(G.jokers.cards) do
                    if not G.jokers.cards[k].edition or not G.jokers.cards[k].edition.negative then
                        nonNegJokers[#nonNegJokers + 1] = v
                    end
                end
                -- Choose a random Joker from the table and make it negative
                if not next(nonNegJokers) then
                    return
                end
                local selected_joker = nonNegJokers[UTIL.randomInt(#nonNegJokers)]
                G.E_MANAGER:add_event(Event({
                    func = function()
                        selected_joker:set_edition{negative = true}
                        UTIL.showTextJoker{card = context.blueprint_card or card, delay = 0, istant = true, type = 'Negative'}
                        return true
                    end
                })) 
            end
        end
    end,
}