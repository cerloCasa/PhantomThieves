local UTIL = load(NFS.read(SMODS.current_mod.path .. 'util/util.lua'))()

SMODS.Joker { -- 00 Igor
    key = 'Igor',
    loc_txt = {
        name = 'Igor',
        text = {'{C:dark_edition}+1{} Joker slot','{C:inactive}(Permanent)'},
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Fool'}}
        if G.GAME and G.GAME.PT then
            if card.ability.extra.Rank == 1 then
                return {key = 'PT_Igor1', set = 'Joker'}
            elseif card.ability.extra.Rank <= 8 then
                return {key = 'PT_Igor2-8', set = 'Joker', vars = {card.ability.extra.Rank}}
            elseif card.ability.extra.Rank == 9 then
                return {key = 'PT_Igor9', set = 'Joker'}
            else
                info_queue[#info_queue + 1] = {key = 'PT_Beyond_Fool', set = 'Other', vars = {card.ability.extra.Beyond}}
                return {key = 'PT_IgorMAX', set = 'Joker'}
            end
        else
            return {vars = {}}
        end
    end,
    config = {extra = {Rank = 1, Beyond = 0}},
    rarity = 4, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 0, y = 0},
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
    linked_tarot = 'c_fool',
    igor_rankUp = function(card)
        while card.ability.extra.Rank < G.GAME.PT.Igor.MinRank do
            UTIL.rankUp(card,{igor = true})
        end
    end,
    add_to_deck = function(self,card,from_debuff)
        UTIL.addJokerSlots(1)
    end,
    calculate = function(self,card,context)
        -- RANK UP
        local newBeyond = UTIL.rankUp(card,context)
        if newBeyond > 0 then
            UTIL.addJokerSlots(newBeyond)
        end
        -- ABILITY
        -- Update MinRank
        if card.ability.extra.Rank > G.GAME.PT.Igor.MinRank then
            G.GAME.PT.Igor.MinRank = card.ability.extra.Rank
        end
        -- Update all owned Jokers
        for i = 1, #G.jokers.cards do
            local j = G.jokers.cards[i].config.center
            if j.igor_rankUp and type(j.igor_rankUp) == 'function' then
                j.igor_rankUp(G.jokers.cards[i])
            end
        end
    end,
}