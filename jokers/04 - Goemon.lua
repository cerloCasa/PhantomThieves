local UTIL = SMODS.load_file('util/util.lua')()

local Dups = {
    [4] = 2,
    [5] = 2,
    [6] = 3,
    [7] = 4,
}

local function copyCard(args) -- cardN, context
    -- args.cardN is the position of the card in the played hand. If it's 0, then copy all hand
    -- args.context is context 
    local context = args.context
    local i = args.cardN
    if i > 0 then
        if not context.full_hand[i] then
            return
        end
        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
        local _card = copy_card(context.full_hand[i], nil, nil, G.playing_card)
        _card:add_to_deck()
        G.deck.config.card_limit = G.deck.config.card_limit + 1
        table.insert(G.playing_cards, _card)
        G.hand:emplace(_card)
        _card.states.visible = nil
        playing_card_joker_effects({[1] = _card})
        G.E_MANAGER:add_event(Event({
            func = function()
                _card:start_materialize()
                return true
            end
        }))
    else
        copyCard{cardN = 1, context = context}
        copyCard{cardN = 2, context = context}
        copyCard{cardN = 3, context = context}
        copyCard{cardN = 4, context = context}
        copyCard{cardN = 5, context = context}
    end
end

SMODS.Joker { -- 04 Goemon
    key = 'Goemon',
    loc_txt = {
        name = 'Goemon',
        text = {'{C:green}1 in 3{} chance to','duplicate first card','of first hand of round','and draw it to {C:attention}hand'},
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME and G.GAME.PT then
            if card.ability.extra.Rank == 1 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Emperor'}}
                return {key = 'PT_Goemon1', set = 'Joker', vars = {G.GAME and G.GAME.probabilities.normal or 1}}
            elseif card.ability.extra.Rank == 2 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Emperor'}}
                return {key = 'PT_Goemon2', set = 'Joker', vars = {G.GAME and G.GAME.probabilities.normal or 1}}
            elseif card.ability.extra.Rank == 3 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Emperor'}}
                return {key = 'PT_Goemon3', set = 'Joker'}
            elseif card.ability.extra.Rank <= 7 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Emperor'}}
                return {key = 'PT_Goemon4-7', set = 'Joker', vars = {Dups[card.ability.extra.Rank]}}
            elseif card.ability.extra.Rank == 8 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Emperor'}}
                return {key = 'PT_Goemon8', set = 'Joker'}
            elseif card.ability.extra.Rank == 9 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Emperor'}}
                return {key = 'PT_Goemon9', set = 'Joker'}
            else
                info_queue[#info_queue + 1] = {key = 'PT_Beyond_Emperor', set = 'Other', vars = {card.ability.extra.Beyond}}
                return {key = 'PT_GoemonMAX', set = 'Joker'}
            end
        else
            info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Emperor'}}
        end
    end,
    config = {extra = {Rank = 1, Beyond = 0}},
    rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 0, y = 4},
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
    linked_tarot = 'c_emperor',
    igor_rankUp = function(card)
        UTIL.rankUp(card,{igor = true})
    end,
    calculate = function(self,card,context)
        -- RANK UP
        UTIL.rankUp(card,context)
        -- ABILITY
        local rank = card.ability.extra.Rank
        local beyond = card.ability.extra.Beyond
        local hand = G.GAME.current_round.hands_played + 1
        if context.before then
            if rank == 1 then
                if hand == 1 and UTIL.random(1,3) then
                    copyCard{cardN = 1, context = context}
                    UTIL.showTextJoker{card = context.blueprint_card or card, type = 'CopyCard'}
                end
            elseif rank == 2 then
                if hand == 1 and UTIL.random(1,2) then
                    copyCard{cardN = 1, context = context}
                    UTIL.showTextJoker{card = context.blueprint_card or card, type = 'CopyCard'}
                end
            elseif rank == 3 then
                if hand == 1 then
                    copyCard{cardN = 1, context = context}
                    UTIL.showTextJoker{card = context.blueprint_card or card, type = 'CopyCard'}
                end
            elseif rank <= 7 then
                if hand == 1 then
                    for i = 1, Dups[rank] do
                        copyCard{cardN = i, context = context}
                    end
                    UTIL.showTextJoker{card = context.blueprint_card or card, type = 'CopyCard'}
                end
            elseif rank == 8 then
                if hand == 1 then
                    copyCard{cardN = 0, context = context}
                    UTIL.showTextJoker{card = context.blueprint_card or card, type = 'CopyCard'}
                end
            elseif rank == 9 then
                if hand <= 2 then
                    copyCard{cardN = 0, context = context}
                    UTIL.showTextJoker{card = context.blueprint_card or card, type = 'CopyCard'}
                end
            else
                if hand <= 3 + beyond then
                    copyCard{cardN = 0, context = context}
                    UTIL.showTextJoker{card = context.blueprint_card or card, type = 'CopyCard'}
                end
            end
        end
    end,
}