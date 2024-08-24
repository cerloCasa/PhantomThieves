local UTIL = SMODS.load_file('util/util.lua')()

local function partialTransform(card, scoringCard, rank, dest)
    local INT = 15
    if dest == 'foil' then
        -- CHECK IF CARD IS TOO GOOD
        if scoringCard.edition then
            return
        end
        -- APPLY EFFECT
        if UTIL.randomInt(INT) <= rank then
            scoringCard:set_edition{foil = true}
            UTIL.showTextJoker{card = card, delay = 0, istant = true, type = 'Upgrade'}
        end
        return
    elseif dest == 'holo' then
        -- CHECK IF CARD IS TOO LOW
        if not scoringCard.edition then
            partialTransform(card, scoringCard, rank, 'foil')
            return
        end
        -- CHECK IF CARD IS TOO GOOD
        if scoringCard.edition.holo or scoringCard.edition.polychrome then
            return
        end
        -- APPLY EFFECT
        if UTIL.randomInt(INT) <= rank then
            scoringCard:set_edition{holo = true}
            UTIL.showTextJoker{card = card, delay = 0, istant = true, type = 'Upgrade'}
        end
        return
    elseif dest == 'polychrome' then
        -- CHECK IF CARD IS TOO LOW
        if not scoringCard.edition then
            partialTransform(card, scoringCard, rank, 'foil')
            return
        end
        if scoringCard.edition.foil then
            partialTransform(card, scoringCard, rank, 'holo')
            return
        end
        -- CHECK IF CARD IS TOO GOOD
        if scoringCard.edition.polychrome then
            return
        end
        -- APPLY EFFECT
        if UTIL.randomInt(INT) <= rank then
            scoringCard:set_edition{polychrome = true}
            UTIL.showTextJoker{card = card, delay = 0, istant = true, type = 'Upgrade'}
        end
        return
    else
        if PT.Debug then
            print("Wrong DEST in function partialTransform")
        end
    end
end

SMODS.Joker { -- 12 Weapons Dealer
key = 'WeaponsDealer',
loc_txt = {
    name = 'Weapons dealer',
    text = {'Chance to {C:attention}upgrade','all scoring cards','to {C:dark_edition}Foil'},
},
loc_vars = function(self, info_queue, card)
    if G.GAME and G.GAME.PT then
        local rank = card.ability.extra.Rank
        if rank <= 4 then
            info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Hanged Man'}}
            return {key = 'PT_WeaponsDealer1-4', set = 'Joker'}
        elseif rank <= 8 then
            info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Hanged Man'}}
            return {key = 'PT_WeaponsDealer5-8', set = 'Joker'}
        elseif rank == 9 then
            info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Hanged Man'}}
            return {key = 'PT_WeaponsDealer9', set = 'Joker'}
        else
            info_queue[#info_queue + 1] = {key = 'PT_Beyond_HangedMan', set = 'Other', vars = {card.ability.extra.Beyond}}
            return {key = 'PT_WeaponsDealerMAX', set = 'Joker'}
        end
    else
        info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Hanged Man'}}
    end
end,
config = {extra = {Rank = 1, Beyond = 0}},
rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
pos = {x = 0, y = 12},
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
linked_tarot = 'c_hanged_man',
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
        if rank <= 4 then
            partialTransform(context.blueprint_card or card, context.other_card, rank, 'foil')
        elseif rank <= 9 then
            partialTransform(context.blueprint_card or card, context.other_card, rank, 'holo')
        else
            for i = 0, beyond do
                partialTransform(context.blueprint_card or card, context.other_card, rank, 'polychrome')
            end
        end
    end
end,
}