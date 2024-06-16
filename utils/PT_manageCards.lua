PT_MANAGECARDS = {}

-- FUNZIONI DI SUPPORTO 

function PT_MANAGECARDS.createConsumable(key,set,edition,negative)
    if negative or (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) then
        G.E_MANAGER:add_event(Event({
            func = function() 
                local _card = create_card(set,G.consumeables, nil, nil, nil, nil, key)
                _card:add_to_deck()
                if edition then
                    _card:set_edition(edition, negative)
                end
                G.consumeables:emplace(_card)
            return true;
        end}))
    else
        sendTraceMessage("No room for new consumable :/","PTmanagecard")
    end
end

function PT_MANAGECARDS.createJoker(key,edition,negative)
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

function PT_MANAGECARDS.destroyJoker(card)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
        func = function()
                G.jokers:remove_card(card)
                card:remove()
                card = nil
            return true;
        end}))
end

function PT_MANAGECARDS.expandConsumeableArea(amount)
    G.E_MANAGER:add_event(Event({func = function()
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + amount
        return true;
    end}))
end

function PT_MANAGECARDS.reduceConsumeableArea(amount)
    G.E_MANAGER:add_event(Event({func = function()
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - amount
        return true;
    end}))
end

return PT_MANAGECARDS