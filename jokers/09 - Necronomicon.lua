local UTIL = SMODS.load_file('util/util.lua')()

SMODS.Joker { -- 09 Necronomicon
    key = 'Necronomicon',
    loc_txt = {
        name = 'Necronomicon',
        text = {'Create a random {C:purple}Tarot','at the end of the round','{C:inactive}(Must have room)'},
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME and G.GAME.PT then
            if card.ability.extra.Rank <= 4 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Hermit'}}
            elseif card.ability.extra.Rank <= 8 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Hermit'}}
                info_queue[#info_queue + 1] = {key = 'PT_UsefulTarot', set = 'Other'}
                return {key = 'PT_Necronomicon5-8', set = 'Joker'}
            elseif card.ability.extra.Rank <= 9 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Hermit'}}
                info_queue[#info_queue + 1] = {key = 'PT_UsefulTarot', set = 'Other'}
                return {key = 'PT_Necronomicon9', set = 'Joker'}
            else
                info_queue[#info_queue + 1] = {key = 'PT_Beyond_Hermit', set = 'Other', vars = {card.ability.extra.Beyond}}
                info_queue[#info_queue + 1] = {key = 'PT_UsefulTarot', set = 'Other'}
                return {key = 'PT_NecronomiconMAX', set = 'Joker'}
            end
        else
            info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Hermit'}}
        end
    end,
    config = {extra = {Rank = 1, Beyond = 0}},
    rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 0, y = 9},
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
    linked_tarot = 'c_hermit',
    igor_rankUp = function(card)
        UTIL.rankUp(card,{igor = true})
    end,
    calculate = function(card,card,context)
        -- RANK UP
        UTIL.rankUp(card,context)
        -- ABILITY
        local rank = card.ability.extra.Rank
        local beyond = card.ability.extra.Beyond
        if context.end_of_round and not context.repetition and not context.individual then
            if rank <= 4 then
                UTIL.createConsumeable{set = 'Tarot'}
            elseif rank <= 8 then
                local UsefulTarots = {}
                for k,v in pairs(G.jokers.cards) do
                    if G.jokers.cards[k].config.center.linked_tarot then
                        UsefulTarots[#UsefulTarots + 1] = G.jokers.cards[k].config.center.linked_tarot
                    end
                end
                if not next(UsefulTarots) then
                    return
                end
                local selected_tarot = UsefulTarots[UTIL.randomInt(#UsefulTarots)]
                UTIL.createConsumeable{set = 'Tarot', key = selected_tarot}
            elseif rank == 9 then
                local UsefulTarots = {}
                for k,v in pairs(G.jokers.cards) do
                    if G.jokers.cards[k].config.center.linked_tarot then
                        UsefulTarots[#UsefulTarots + 1] = G.jokers.cards[k].config.center.linked_tarot
                    end
                end
                if not next(UsefulTarots) then
                    return
                end
                for i = 1, 2 do
                    local selected_tarot = UsefulTarots[UTIL.randomInt(#UsefulTarots)]
                    UTIL.createConsumeable{set = 'Tarot', key = selected_tarot}
                end
            else
                local UsefulTarots = {}
                for k,v in pairs(G.jokers.cards) do
                    if G.jokers.cards[k].config.center.linked_tarot then
                        UsefulTarots[#UsefulTarots + 1] = G.jokers.cards[k].config.center.linked_tarot
                    end
                end
                if not next(UsefulTarots) then
                    return
                end
                for i = 1, (2 + beyond) do
                    local selected_tarot = UsefulTarots[UTIL.randomInt(#UsefulTarots)]
                    UTIL.createConsumeable{set = 'Tarot', key = selected_tarot, edition = {negative = true}}
                end
            end
        end
    end,
}