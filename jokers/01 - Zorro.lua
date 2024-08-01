local UTIL = SMODS.load_file('util/util.lua')()

SMODS.Joker { -- 01 Zorro
    key = 'Zorro',
    loc_txt = {
        name = 'Zorro',
        text = {'Create a random {C:planet}Planet','card at the end','of the round','{C:inactive}(Must have room)'},
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME and G.GAME.PT then
            if card.ability.extra.Rank <= 2 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Magician'}}
                return {key = 'PT_Zorro1-2', set = 'Joker'}
            elseif card.ability.extra.Rank <= 4 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Magician'}}
                return {key = 'PT_Zorro3-4', set = 'Joker'}
            elseif card.ability.extra.Rank <= 6 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Magician'}}
                return {key = 'PT_Zorro5-6', set = 'Joker'}
            elseif card.ability.extra.Rank <= 8 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Magician'}}
                return {key = 'PT_Zorro7-8', set = 'Joker'}
            elseif card.ability.extra.Rank == 9 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Magician'}}
                return {key = 'PT_Zorro9', set = 'Joker'}
            else
                info_queue[#info_queue + 1] = {key = 'PT_Beyond_Magician', set = 'Other', vars = {card.ability.extra.Beyond}}
                return {key = 'PT_ZorroMAX', set = 'Joker'}
            end
        else
            info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Magician'}}
            return {vars = {}}
        end
    end,
    config = {extra = {Rank = 1, Beyond = 0}},
    rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 0, y = 1},
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
    linked_tarot = 'c_magician',
    igor_rankUp = function(card)
        UTIL.rankUp(card,{igor = true})
    end,
    calculate = function(self,card,context)
        -- RANK UP
        UTIL.rankUp(card,context)
        -- ABILITY
        local rank = card.ability.extra.Rank
        if context.end_of_round and not context.repetition and not context.individual then
            if rank == 1 or rank == 2 then
                UTIL.createConsumeable{set = 'Planet'}
            elseif rank == 3 or rank == 4 then
                UTIL.createConsumeable{set = 'Planet', key = 'lastHandPlayed'}
            elseif rank == 5 or rank == 6 then
                UTIL.createConsumeable{set = 'Planet', key = 'lastHandPlayed'}
                UTIL.createConsumeable{set = 'Planet', key = 'lastHandPlayed'}
            end
        end
        if context.after then
            if rank == 7 or rank == 8 then
                UTIL.createConsumeable{set = 'Planet', key = 'lastHandPlayed'}
            elseif rank == 9 then
                UTIL.createConsumeable{set = 'Planet', key = 'lastHandPlayed', edition = {negative = true}}
            elseif rank == 10 then
                UTIL.createConsumeable{set = 'Planet', key = 'lastHandPlayed', edition = {negative = true}}
                UTIL.createConsumeable{set = 'Planet', key = 'lastHandPlayed', edition = {negative = true}}
                for i = 1, card.ability.extra.Beyond do
                    UTIL.createConsumeable{set = 'Planet', key = 'lastHandPlayed', edition = {negative = true}}
                end
            end
        end
    end,
}

-- UTIL.createConsumeable{set = 'Planet',key = 'lastHandPlayed'}