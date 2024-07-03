SMODS.Joker { -- 16 Skilled Gamer
    key = 'SkilledGamer',
    loc_txt = {
        ['default'] = {
            name = 'Skilled Gamer',
            text = {'{C:green}#1#{}{C:blue}#2#{}#3#','{C:blue}#4#{}#5#'},
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Tower', set = 'Other'}
        if card and card.ability and card.ability.extra and card.ability.extra.Rank then
            if card.ability.extra.Rank <= 2 then
                return {vars = {(G.GAME and G.GAME.probabilities.normal or 1)..' in 2 ','','chance of', '+1 ','hand each round'}}
            end
            if card.ability.extra.Rank <= 5 then
                return {vars = {'','+1 ','hand', '','each round'}}
            end
            if card.ability.extra.Rank <= 9 then
                return {vars = {'','+2 ','hands', '','each round'}}
            end
            return {vars = {'','+3 ','hands', '','each round'}}
        else
            return {vars = {'1 in 2 ','','chance of', '+1 ','hand each round'}}
        end
    end,
    config = {extra = {Rank = 1}},
    rarity = 1, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 8, y = 2},
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
    linked_tarot = 'c_tower',
    calculate = function(self,card,context)
        if context.setting_blind and not context.blueprint and not self.getting_sliced then
            PT_SkilledGamer_RoundStart(card,card.ability.extra.Rank)
        end
        if context.using_consumeable then
            -- Calcola Rank Up e Evoluzione
            if context.consumeable.ability.name == 'The Tower' and card.ability.extra.Rank < 10 then
                PT_rankUp(card)
            end
        end
    end,
}

function PT_SkilledGamer_RoundStart(card,rank)
    if rank <= 2 and PT_random(1,2) then
       ease_hands_played(1)
    elseif rank <= 5 then
        ease_hands_played(1)
    elseif rank <= 9 then
        ease_hands_played(2)
    else
        ease_hands_played(3)
    end
end