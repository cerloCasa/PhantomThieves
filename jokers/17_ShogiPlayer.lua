SMODS.Joker { -- 17 Shogi Player
    key = 'ShogiPlayer',
    loc_txt = {
        ['default'] = {
            name = 'Shogi Player',
            text = {'{C:green}#1#{}{C:red}#2#{}#3#','{C:red}#4#{}#5#'},
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Star', set = 'Other'}
        if G.GAME.PTvar_ShogiPlayer then
            if card.ability.extra.Rank <= 2 then
                return {vars = {(G.GAME and G.GAME.probabilities.normal or 1)..' in 2 ','','chance of', '+1 ','discard each round'}}
            end
            if card.ability.extra.Rank <= 5 then
                return {vars = {'','+1 ','discard', '','each round'}}
            end
            if card.ability.extra.Rank <= 9 then
                return {vars = {'','+2 ','discards', '','each round'}}
            end
            return {vars = {'','+3 ','discards', '','each round'}}
        else
            return {vars = {'1 in 2 ','','chance of', '+1 ','discard each round'}}
        end
    end,
    config = {extra = {Rank = 1}},
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 9, y = 2},
    soul_pos = {x = 3, y = 3},
    set_ability = function(self,card)
        PT_soulPos(card)
    end,
    atlas = 'Jokers',
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    linked_tarot = 'c_star',
    calculate = function(self,card,context)
        if context.setting_blind and not context.blueprint then
            PT_ShogiPlayer_RoundStart(card,card.ability.extra.Rank)
        end
        if context.using_consumeable then
            -- Calcola Rank Up e Evoluzione
            if context.consumeable.ability.name == 'The Star' and card.ability.extra.Rank < 10 then
                PT_rankUp(card)
            end
        end
    end,
}

function PT_ShogiPlayer_resetGlobalVars()
    G.GAME.PTvar_ShogiPlayer = true
end

function PT_ShogiPlayer_RoundStart(card,rank)
    if rank <= 2 and PT_random(1,2) then
       ease_discard(1)
    elseif rank <= 5 then
        ease_discard(1)
    elseif rank <= 9 then
        ease_discard(2)
    else
        ease_discard(3)
    end
end