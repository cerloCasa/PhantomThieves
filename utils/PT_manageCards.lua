PT_MANAGECARDS = {}

-- FUNZIONI DI SUPPORTO 

function PT_MANAGECARDS.createConsumable()
    -- TO-DO
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
            return true; end}))
end

function PT_MANAGECARDS.destroyJoker(card)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
        func = function()
                G.jokers:remove_card(card)
                card:remove()
                card = nil
            return true; end}))
end

return PT_MANAGECARDS