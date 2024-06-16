PT_MANAGECARDS = {}

-- FUNZIONI DI SUPPORTO 

function PT_MANAGECARDS.createConsumable(key,set,edition,negative)
    G.E_MANAGER:add_event(Event({
        func = function() 
            if set == 'Tarot' then
                local _card = create_card('Tarot',G.tarots, nil, nil, nil, nil, key)
                _card:add_to_deck()
                if edition then
                    _card:set_edition(edition, negative)
                end
                G.consumeables:emplace(_card)
            else
                sendErrorMessage('Attempt to create a non valid consumable','manageCards')
                return true;
            end
            return true; end}))
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