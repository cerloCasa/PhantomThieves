local UTIL = SMODS.load_file('util/util.lua')()

local CHIPS = {
    [1] = 10,
    [2] = 20,
    [3] = 30,
    [4] = 40,
    [5] = 50,
    [6] = 50,
    [7] = 50,
    [8] = 50,
    [9] = 60,
    [10] = 80,
    Beyond = 10
}

local MULT = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 1,
    [7] = 2,
    [8] = 3,
    [9] = 5,
    [10] = 8,
    Beyond = 1
}

local function tarotsUsed()
    local total = 0
    for k,v in pairs(G.GAME.PT.UsedTarots) do
        total = total + v
    end
    return total
end

SMODS.Joker { -- 13 Back Alley Doctor
    key = 'BackAlleyDoctor',
    loc_txt = {
        name = 'Back alley doctor',
        text = {'{C:chips}+#1#{} Chips per','{C:purple}Tarot{} card used','{C:inactive}(Currently {C:chips}+#2# {C:inactive}Chips)'},
    },
    loc_vars = function(self, info_queue, card)
        if G.GAME and G.GAME.PT then
            local rank = card.ability.extra.Rank
            local beyond = card.ability.extra.Beyond
            local currentChips = 0
            local currentMult = 0
            if G.GAME.PT.MostUsedTarot.key then
                currentChips = tarotsUsed() * CHIPS[rank]
                currentMult = tarotsUsed() * MULT[rank]
            end
            if rank <= 5 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Death'}}
                return {vars = {CHIPS[rank], currentChips}}
            elseif rank <= 8 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Death'}}
                return {key = 'PT_BackAlleyDoctor6-8', set = 'Joker', vars = {CHIPS[rank], MULT[rank], currentChips, currentMult}}
            elseif rank == 9 then
                info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Death'}}
                return {key = 'PT_BackAlleyDoctor9', set = 'Joker', vars = {CHIPS[rank], MULT[rank], currentChips, currentMult}}
            else
                info_queue[#info_queue + 1] = {key = 'PT_Beyond_Death', set = 'Other', vars = {tarotsUsed()*beyond*CHIPS.Beyond, tarotsUsed()*beyond*MULT.Beyond}}
                return {key = 'PT_BackAlleyDoctorMAX', set = 'Joker', vars = {CHIPS[rank], MULT[rank], currentChips, currentMult}}
            end
        else
            info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot', set = 'Other', vars = {'Death'}}
            return {vars = {10,0}}
        end
    end,
    config = {extra = {Rank = 1, Beyond = 0}},
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 0, y = 13},
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
    linked_tarot = 'c_death',
    igor_rankUp = function(card)
        UTIL.rankUp(card,{igor = true})
    end,
    calculate = function(card,card,context)
        -- RANK UP
        UTIL.rankUp(card,context)
        -- ABILITY
        local rank = card.ability.extra.Rank
        local beyond = card.ability.extra.Beyond
        if context.joker_main then
            if G.GAME.PT.MostUsedTarot.key then
                local TOT_chips = tarotsUsed() * (CHIPS[rank] + beyond * CHIPS.Beyond)
                local TOT_mult = tarotsUsed() * (MULT[rank] + beyond * MULT.Beyond)
                -- if TOT_chips > 0 then
                --     G.GAME.hand_chips = mod_chips(G.GAME.hand_chips + TOT_chips)
                --     UTIL.showTextJoker{card = context.blueprint_card or card, type = 'Chips', value = TOT_chips}
                -- end
                -- if TOT_mult > 0 then
                --     G.GAME.mult = mod_mult(G.GAME.mult + TOT_mult)
                --     UTIL.showTextJoker{card = context.blueprint_card or card, type = 'Mult', value = TOT_mult}
                -- end
                return {
                    mult_mod = (TOT_mult > 0) and TOT_mult,
                    chip_mod = (TOT_chips > 0) and TOT_chips
                }
            end
        end
    end,
}