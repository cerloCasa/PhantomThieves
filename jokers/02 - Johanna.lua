local UTIL = load(NFS.read(SMODS.current_mod.path .. 'util/util.lua'))()

SMODS.Joker { -- 02 Johanna
    key = 'Johanna',
    loc_txt = {
        name = 'Johanna',
        text = {'ABILITY'},
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'High Priestess'}}
        if G.GAME and G.GAME.PT then
            if card.ability.extra.Rank <= 2 then
                return {key = 'PT_Johanna1-2', set = 'Joker'}
            elseif card.ability.extra.Rank <= 4 then
                return {key = 'PT_Johanna3-4', set = 'Joker'}
            elseif card.ability.extra.Rank <= 6 then
                return {key = 'PT_Johanna5-6', set = 'Joker'}
            elseif card.ability.extra.Rank <= 8 then
                return {key = 'PT_Johanna7-8', set = 'Joker'}
            elseif card.ability.extra.Rank == 9 then
                return {key = 'PT_Johanna9', set = 'Joker'}
            else
                info_queue[#info_queue + 1] = {key = 'PT_Beyond_HighPriestess', set = 'Other', vars = {card.ability.extra.Beyond}}
                return {key = 'PT_JohannaMAX', set = 'Joker'}
            end
        else
            return {vars = {}}
        end
    end,
    config = {extra = {Rank = 1, Beyond = 0}},
    rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 0, y = 2},
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
    linked_tarot = 'c_high_priestess',
    igor_rankUp = function(card)
        while card.ability.extra.Rank < G.GAME.PT.Igor.MinRank do
            UTIL.rankUp(card,{igor = true})
        end
    end,
    calculate = function(card,card,context)
        -- RANK UP
        UTIL.rankUp(card,context)
        -- ABILITY
        local rank = card.ability.extra.Rank
        if context.repetition and context.cardarea == G.play then
            if rank == 1 or rank == 2 then
                if context.other_card == context.scoring_hand[1] then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = 1,
                        card = card
                    }
                end
            elseif rank == 3 or rank == 4 then
                if context.other_card == context.scoring_hand[1] or context.other_card == context.scoring_hand[2] then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = 1,
                        card = card
                    }
                end
            elseif rank == 5 or rank == 6 then
                if context.other_card == context.scoring_hand[1] or context.other_card == context.scoring_hand[2] or context.other_card == context.scoring_hand[3] then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = 1,
                        card = card
                    }
                end
            elseif rank == 7 or rank == 8 then
                if context.other_card == context.scoring_hand[1] or context.other_card == context.scoring_hand[2] or context.other_card == context.scoring_hand[3] or context.other_card == context.scoring_hand[4] then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = 1,
                        card = card
                    }
                end
            elseif rank == 9 then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = card
                }
            else
                return {
                    message = localize('k_again_ex'),
                    repetitions = 2 + card.ability.extra.Beyond,
                    card = card
                }
            end
        end
    end,
}