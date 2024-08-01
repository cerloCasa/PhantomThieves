local UTIL = load(NFS.read(SMODS.current_mod.path .. 'util/util.lua'))()

local C = {
    [1] = 10,
    [2] = 20,
    [3] = 30,
    [4] = 40,
    [5] = 50,
    [6] = 60,
    [7] = 70,
    [8] = 80,
    [9] = 100,
    [10] = 120,
    Beyond = 10
}

SMODS.Joker { -- 05 Barista
    key = 'Barista',
    loc_txt = {
        name = 'Barista',
        text = {'{C:chips}+#1#{} Chips for every','other {C:red}Phantom Thieves','Joker you own'},
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME and G.GAME.PT then
            if card.ability.extra.Rank <= 8 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Hierophant'}}
            elseif card.ability.extra.Rank == 9 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Hierophant'}}
                return {key = 'PT_Barista9', set = 'Joker', vars = {C[card.ability.extra.Rank]}}
            else
                info_queue[#info_queue + 1] = {key = 'PT_Beyond_Hierophant', set = 'Other', vars = {card.ability.extra.Beyond * C.Beyond}}
                return {key = 'PT_BaristaMAX', set = 'Joker', vars = {C[card.ability.extra.Rank]}}
            end
        else
            info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Hierophant'}}
        end
        return {vars = {(G.GAME and G.GAME.PT and C[card.ability.extra.Rank]) or 10}}
    end,
    config = {extra = {Rank = 1, Beyond = 0}},
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 0, y = 5},
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
    linked_tarot = 'c_heirophant',
    igor_rankUp = function(card)
        UTIL.rankUp(card,{igor = true})
    end,
    calculate = function(card,card,context)
        -- RANK UP
        UTIL.rankUp(card,context)
        -- ABILITY
        local rank = card.ability.extra.Rank
        local beyond = card.ability.extra.Beyond
        if context.other_joker then
            if context.other_joker ~= card and context.other_joker.config.center.linked_tarot then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.other_joker:juice_up(0.5, 0.5)
                        return true
                    end
                })) 
                local chips = C[rank] + beyond * C.Beyond
                return{
                    message = localize{type='variable',key='a_chips',vars={chips}},
                    chip_mod = chips
                }
            end
        end
    end,
}