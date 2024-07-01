SMODS.Joker { -- 07 Captain Kidd
    key = 'CaptainKidd',
    loc_txt = {
        ['default'] = {
            name = 'Captain Kidd',
            text = {'{C:green}#1#{}#2#','#3#{C:attention}#4#','{C:green}#5#{}#6#{C:attention}#7#','#8#'},
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Chariot', set = 'Other'}
        if G.GAME.PTvar_CaptainKidd then
            if card.ability.extra.Rank <= 2 then
                return {vars = {(G.GAME and G.GAME.probabilities.normal or 1)..' in 2 ','chance to ','upgrade level of','','','played ','poker hand',''}}
            end
            if card.ability.extra.Rank <= 4 then
                return {vars = {'','Upgrade level of','played ','poker hand','','','',''}}
            end
            if card.ability.extra.Rank <= 6 then
                return {vars = {'','Upgrade level of','played ','poker hand,',(G.GAME and G.GAME.probabilities.normal or 1)..' in 3 ','chance to','','upgrade again'}}
            end
            if card.ability.extra.Rank <= 8 then
                return {vars = {'','Upgrade level of','played ','poker hand,',(G.GAME and G.GAME.probabilities.normal or 1)..' in 2 ','chance to','','upgrade again'}}
            end
        else
            return {vars = {'1 in 2 ','chance to ','upgrade level of','','','played ','poker hand',''}}
        end
    end,
    config = {extra = {Rank = 1}},
    rarity = 3, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 5, y = 1},
    soul_pos = {x = 3, y = 3},
    set_ability = function(self,card)
        PT_soulPos(card)
    end,
    atlas = 'Jokers',
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    linked_tarot = 'c_chariot',
    calculate = function(self,card,context)
        if context.cardarea == G.jokers and context.before then
            PT_CaptainKidd_BeforeHandCalc(card,card.ability.extra.Rank)
        end
        if context.using_consumeable then
            -- Calcola Rank Up e Evoluzione
            if context.consumeable.ability.name == 'The Chariot' and card.ability.extra.Rank < 10 then
                PT_rankUp(card)
            end
            if not context.blueprint and card.ability.extra.Rank == 9 then
                PT_evolve(card,'j_PT_SeitenTaisei')
            end
            if not context.blueprint and card.ability.extra.Rank >= 10 then
                PT_evolve(card,'j_PT_William')
            end
        end
    end,
}

SMODS.Joker { -- 07.1 Seiten Taisei
    key = 'SeitenTaisei',
    loc_txt = {
        ['default'] = {
            name = '{C:blue}Seiten Taisei',
            text = {'Upgrade level of','played {C:attention}poker hand','twice'},
            unlock = {'{C:red}Evolve{} the previous','Joker to unlock','this one'},
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Chariot', set = 'Other'}
    end,
    config = {extra = {Rank = 9}},
    rarity = 3, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 6, y = 1},
    soul_pos = {x = 11, y = 3},
    set_ability = function(self,card)
        PT_soulPos(card)
    end,
    atlas = 'Jokers',
    cost = 7,
    unlocked = false,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	add_to_pool = function(self)
		return {add = false}
	end,
    linked_tarot = 'c_chariot',
    calculate = function(self,card,context)
        if context.cardarea == G.jokers and context.before then
            PT_CaptainKidd_BeforeHandCalc(card,card.ability.extra.Rank)
        end
        if context.using_consumeable then
            -- Calcola Rank Up e Evoluzione
            if context.consumeable.ability.name == 'The Chariot' and card.ability.extra.Rank < 10 then
                PT_rankUp(card)
            end
            if not context.blueprint and card.ability.extra.Rank >= 10 then
                PT_evolve(card,'j_PT_William')
            end
        end
    end,
}

SMODS.Joker { -- 07.2 William
    key = 'William',
    loc_txt = {
        ['default'] = {
            name = '{C:red}William',
            text = {'Upgrade level of','played {C:attention}poker hand','three times'},
            unlock = {'{C:red}Evolve{} the previous','Joker to unlock','this one'},
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Chariot', set = 'Other'}
    end,
    config = {extra = {Rank = 10}},
    rarity = 3, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 7, y = 1},
    soul_pos = {x = 12, y = 3},
    set_ability = function(self,card)
        PT_soulPos(card)
    end,
    atlas = 'Jokers',
    cost = 10,
    unlocked = false,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	add_to_pool = function(self)
		return {add = false}
	end,
    linked_tarot = 'c_chariot',
    calculate = function(self,card,context)
        if context.cardarea == G.jokers and context.before then
            PT_CaptainKidd_BeforeHandCalc(card,card.ability.extra.Rank)
        end
    end,
}

function PT_CaptainKidd_resetGlobalVars()
    G.GAME.PTvar_CaptainKidd = true
end

function PT_CaptainKidd_BeforeHandCalc(card,rank)
    if rank == 1 or rank == 2 then
        if PT_random(1,2) then
            level_up_hand(card, G.GAME.last_hand_played, nil, 1)
        end
    end
    if rank == 3 or rank == 4 then
        level_up_hand(card, G.GAME.last_hand_played, nil, 1)
    end
    if rank == 5 or rank == 6 then
        if PT_random(1,3) then
            level_up_hand(card, G.GAME.last_hand_played, nil, 2)
        end
        level_up_hand(card, G.GAME.last_hand_played, nil, 1)
    end
    if rank == 7 or rank == 8 then
        if PT_random(1,2) then
            level_up_hand(card, G.GAME.last_hand_played, nil, 2)
        end
        level_up_hand(card, G.GAME.last_hand_played, nil, 1)
    end
    if rank == 9 then
        level_up_hand(card, G.GAME.last_hand_played, nil, 2)
    end
    if rank == 10 then
        level_up_hand(card, G.GAME.last_hand_played, nil, 3)
    end
end