local UTIL = {}

function UTIL.createJoker(key,edition,negative)
    if PT.Debug then
        print("Creating Joker: " .. key)
    end
    G.E_MANAGER:add_event(Event({
        func = function() 
            local _card = create_card('Joker',G.jokers, nil, nil, nil, edition and negative, key)
            _card:start_materialize()
            _card:add_to_deck()
            if edition then
                _card:set_edition(edition,negative)
            end
            G.jokers:emplace(_card)
            return true;
        end}))
end

function UTIL.destroyJoker(card)
    if PT.Debug then
        print("Removing Joker: "..card.config.center)
    end
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
        func = function()
                G.jokers:remove_card(card)
                card:remove()
                card = nil
            return true;
        end}))
end

function UTIL.createConsumeable(args) -- args{key,set,edition}
    if (args.edition and args.edition.negative) or (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) then
        if args.key == 'lastHandPlayed' then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.GAME.last_hand_played then
                        local _planet = 0
                        for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                            if v.config.hand_type == G.GAME.last_hand_played then
                                _planet = v.key
                            end
                        end
                        local _card = create_card('Planet', G.consumeables, nil, nil, nil, nil, _planet)
                        _card:add_to_deck()
                        if args.edition then
                            _card:set_edition(args.edition)
                        end
                        G.consumeables:emplace(_card)
                    end
                    return true;
                end}))
        else
            G.E_MANAGER:add_event(Event({
                func = function() 
                    local _card = create_card(args.set, G.consumeables, nil, nil, nil, nil, args.key)
                    _card:add_to_deck()
                    if args.edition then
                        _card:set_edition(args.edition)
                    end
                    G.consumeables:emplace(_card)
                return true;
            end}))
        end
        if PT.Debug then
            print(args.set.." created")
        end
    else
        if PT.Debug then
            print("No room for new consumeable")
        end
    end
end

function UTIL.random(prob,total)
    -- This function returns true with a (prob) in (total) chance
    prob = prob * (G.GAME and G.GAME.probabilities.normal or 1)
    if (prob >= total) then
        if PT.Debug then
            print("PROB: "..prob.." in "..total.." is FORCED TRUE")
        end
        return true
    end
    if (pseudorandom('PT')) <= (prob/total) then
        if PT.Debug then
            print("PROB: "..prob.." in "..total.." is TRUE")
        end
        return true
    end
    if PT.Debug then
        print("PROB: "..prob.." in "..total.." is FALSE")
    end
    return false
end

function UTIL.addJokerSlots(amt)
    G.jokers.config.card_limit = G.jokers.config.card_limit + amt
end

function UTIL.addConsumeableSlots(amount)
    G.E_MANAGER:add_event(Event({func = function()
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + amount
        return true;
    end}))
end

function UTIL.spriteCalc(card)
	card.children.center:set_sprite_pos({x = card.ability.extra.Rank - 1, y = card.config.center.pos.y})
end

function UTIL.rankUp(card,context)
    local beyondBefore = card.ability.extra.Beyond
    if context.using_consumeable then
        -- Calcola Rank Up e Evoluzione
        if context.consumeable.config.center_key == card.config.center.linked_tarot then
            if PT.Debug then
                print("Useful tarot used")
            end
            card.ability.extra.Rank = card.ability.extra.Rank + 1
            if card.ability.extra.Rank > 10 then
                card.ability.extra.Beyond = card.ability.extra.Beyond + card.ability.extra.Rank - 10
                card.ability.extra.Rank = 10
            end
            local eval = {
                message = 'Rank UP!',
                colour = G.C.RED
            }
            card_eval_status_text(card, 'jokers', nil, nil, nil, eval)
            G.E_MANAGER:add_event(Event({
                func = (function()
                    UTIL.spriteCalc(card)
                    return true
                end)
            }))
        end
    elseif context.igor then
        if PT.Debug then
            print("Forced Rank Up by Igor")
        end
        card.ability.extra.Rank = card.ability.extra.Rank + 1
        if card.ability.extra.Rank > 10 then
            card.ability.extra.Beyond = card.ability.extra.Beyond + card.ability.extra.Rank - 10
            card.ability.extra.Rank = 10
        end
        local eval = {
            message = 'Rank UP!',
            colour = G.C.RED
        }
        card_eval_status_text(card, 'jokers', nil, 1, nil, eval)
        G.E_MANAGER:add_event(Event({
            func = (function()
                UTIL.spriteCalc(card)
                return true
            end)
        }))
    end
    return card.ability.extra.Beyond - beyondBefore
end

return UTIL