SMODS.Joker { -- 04 Goemon
    key = 'Goemon',
    loc_txt = {
        ['default'] = {
            name = 'Goemon',
            text = {'{C:green}#1#{}#2#{C:attention}#3#{}#4#','#5#{C:attention}#6#{}#7#','#8#','#9#{C:attention}#10#{}#11#'},
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Emperor', set = 'Other'}
        if card and card.ability and card.ability.extra and card.ability.extra.Rank then
            if card.ability.extra.Rank <= 3 then
                return {vars = {(G.GAME and G.GAME.probabilities.normal or 1).." in 3 ","chance to","","","duplicate ","first hand ","of","round if it has","only ","1 ","card"}}
            elseif card.ability.extra.Rank <= 6 then
                return {vars = {(G.GAME and G.GAME.probabilities.normal or 1).." in 2 ","chance to","","","duplicate ","first hand ","of","round if it has","only ","1 ","card"}}
            else
                return {vars = {"","If ","first hand ","of round","has only ","1 ","card, add a","permanent copy to deck","and draw it to ","hand",""}}
            end
        else
            return {vars = {"1 in 3 ","chance to","","","duplicate ","first hand ","of","round if it has","only ","1 ","card"}}
        end
    end,
    config = {extra = {Rank = 1}},
    rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 11, y = 0},
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
    linked_tarot = 'c_emperor',
    calculate = function(self,card,context)
        if context.joker_main then
            PT_Goemon_HandCalc(card,card.ability.extra.Rank,context)
        end
        if context.using_consumeable then
            -- Calcola Rank Up e Evoluzione
            if context.consumeable.ability.name == 'The Emperor' and card.ability.extra.Rank < 10 then
                PT_rankUp(card)
            end
            if not context.blueprint and card.ability.extra.Rank == 9 then
                PT_evolve(card,'j_PT_KamuSusanoo')
            end
            if not context.blueprint and card.ability.extra.Rank >= 10 then
                PT_evolve(card,'j_PT_Gorokichi')
            end
        end
    end,
}

SMODS.Joker { -- 04.1 Kamu Susano-o
    key = 'KamuSusanoo',
    loc_txt = {
        ['default'] = {
            name = '{C:blue}Kamu Susano-o',
            text = {'If {C:attention}first hand{} of round','has only {C:attention}1{} card, add two','permanent copies to deck','and draw them to {C:attention}hand'},
            unlock = {'{C:red}Evolve{} the previous','Joker to unlock','this one'},
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Emperor', set = 'Other'}
    end,
    config = {extra = {Rank = 9}},
    rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 12, y = 0},
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
    linked_tarot = 'c_emperor',
    calculate = function(self,card,context)
        if context.joker_main then
            PT_Goemon_HandCalc(card,card.ability.extra.Rank,context)
        end
        if context.using_consumeable then
            -- Calcola Rank Up e Evoluzione
            if context.consumeable.ability.name == 'The Emperor' and card.ability.extra.Rank < 10 then
                PT_rankUp(card)
            end
            if not context.blueprint and card.ability.extra.Rank >= 10 then
                PT_evolve(card,'j_PT_Gorokichi')
            end
        end
    end,
}

SMODS.Joker { -- 04.2 Gorokichi
    key = 'Gorokichi',
    loc_txt = {
        ['default'] = {
            name = '{C:red}Gorokichi',
            text = {'If {C:attention}first hand{} of round','has only {C:attention}1{} card, add two','permanent copies to deck','and draw them to {C:attention}hand'},
            unlock = {'{C:red}Evolve{} the previous','Joker to unlock','this one'},
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'PT_LinkedTarot_Emperor', set = 'Other'}
    end,
    config = {extra = {Rank = 10}},
    rarity = 2, -- 1 common, 2 uncommon, 3 rare, 4 legendary
    pos = {x = 0, y = 1},
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
    linked_tarot = 'c_emperor',
    calculate = function(self,card,context)
        if context.joker_main then
            PT_Goemon_HandCalc(card,card.ability.extra.Rank,context)
        end
    end,
}

function PT_Goemon_HandCalc(card,rank,context)
    if #context.full_hand == 1 and G.GAME.current_round.hands_played == 0 then
        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
        if rank <= 3 and PT_random(1,3) then
            PT_Goemon_DuplicateCard(G.playing_card,context)
        elseif rank <= 6 and PT_random(1,2) then
            PT_Goemon_DuplicateCard(G.playing_card,context)
        elseif rank <= 8 then
            PT_Goemon_DuplicateCard(G.playing_card,context)
        else
            PT_Goemon_DuplicateCard(G.playing_card,context)
            PT_Goemon_DuplicateCard(G.playing_card,context)
        end
    end
end

function PT_Goemon_DuplicateCard(playing_card,context)
    local _card = copy_card(context.full_hand[1],nil,nil,playing_card)
    _card:add_to_deck()
    G.deck.config.card_limit = G.deck.config.card_limit + 1
    table.insert(G.playing_cards,_card)
    G.hand:emplace(_card)
    _card.states.visible = nil
    G.E_MANAGER:add_event(Event({
        func = function()
            _card:start_materialize()
            return true
        end
    }))
    playing_cards_created = true
end