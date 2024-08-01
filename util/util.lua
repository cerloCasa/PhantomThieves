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
    if args.key == 'lastHandPlayed' then
        G.E_MANAGER:add_event(Event({
            func = function()
                local canCreate = (args.edition and args.edition.negative) or (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit)
                if not canCreate then
                    return
                end
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
                local canCreate = (args.edition and args.edition.negative) or (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit)
                if not canCreate then
                    return
                end
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

function UTIL.randomInt(N)
    local INT = math.ceil(N*pseudorandom(pseudoseed('PT')))
    if PT.Debug then
        print("Random number from 1 to "..N.." is "..INT)
    end
    return INT
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

function UTIL.showTextJoker(args) -- args{card,type,value,istant,scale,noJuice}
    -- CHECK FOR REQUIRED ARGUMENTS
    if not args.card then
        if PT.Debug then
            print('Missing args.card in showTextJoker function')
        end
        return
    end
    if not args.type then
        if PT.Debug then
            print('Missing args.type in showTextJoker function')
        end
        return
    end

    -- SETUP eval ACCORDING TO args.type
    local eval = {}
    if args.type == 'RankUp' then
        eval = {
            message = 'Rank UP!',
            colour = G.C.RED
        }
    elseif args.type == 'Beyond' then
        eval = {
            message = 'Beyond!',
            colour = G.C.RED
        }
    elseif args.type == '+JokerSlot' then
        if not args.value or args.value == 1 then
            eval = {
                sound = 'foil2',
                scale = 0.7,
                message = '+1 Joker slot',
                colour = G.C.ORANGE
            }
        else
            eval = {
                sound = 'foil2',
                scale = 0.7,
                message = '+'..args.value..' Joker slots',
                colour = G.C.ORANGE
            }
        end
    elseif args.type == 'Money' then
        if not args.value then
            if PT.Debug then
                print('Missing args.value in showTextJoker function')
            end
            return
        end
        eval = {
            sound = 'coin3',
            scale = 1,
            message = (args.value < 0 and '-' or '')..'$'..args.value,
            colour = args.value < 0 and G.C.RED or G.C.MONEY
        }
    elseif args.type == 'CopyCard' then
        eval = {
            message = 'Copied!',
            colour = G.C.CHIPS,
        }
    elseif args.type == 'Negative' then
        eval = {
            message = 'Negative!',
            colour = G.C.BLACK,
        }
    elseif args.type == 'Good' then
        eval = {
            message = 'Good!',
            colour = G.C.GREEN,
        }
    elseif args.type == 'Bad' then
        eval = {
            message = 'Bad!',
            colour = G.C.RED,
        }
    end

    -- CHECK FOR SUPPORTED args.type
    if not next(eval) then
        if PT.Debug then
            print('args.type: '..args.type..' not supported')
        end    
        return
    end

    -- SHOWING TEXT
    if PT.Debug then
        print('Showing text of type '..args.type..'...')
    end    
    if args.instant then
        attention_text{
            text = eval.message,
            scale = args.scale or eval.scale or 0.7,
            hold = 0.7,
            backdrop_colour = eval.colour or G.C.BLACK,
            align = 'bm',
            major = args.card,
            offset = {x = 0, y = -0.05 * args.card.T.h}
        }
        play_sound(eval.sound, 0.98 + 0.04*math.random(), 1)
        if not args.noJuice or not eval.noJuice then
            args.card:juice_up(0.6, 0.1)
            G.ROOM.jiggle = G.ROOM.jiggle + 0.7
        end
    else
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.7,
            func = function()
                attention_text{
                    text = eval.message,
                    scale = args.scale or eval.scale or 0.7,
                    hold = 0.7,
                    backdrop_colour = eval.colour or G.C.BLACK,
                    align = 'bm',
                    major = args.card,
                    offset = {x = 0, y = -0.05 * args.card.T.h}
                }
                play_sound(eval.sound or 'generic1', 0.98 + 0.04*math.random(), 1)
                if not args.noJuice or not eval.noJuice then
                    args.card:juice_up(0.6, 0.1)
                    G.ROOM.jiggle = G.ROOM.jiggle + 0.7
                end
                return true
            end
        }))
    end
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
                UTIL.showTextJoker{card = context.blueprint_card or card, type = 'Beyond'}
            else
                UTIL.showTextJoker{card = context.blueprint_card or card, type = 'RankUp'}
            end
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
        if card.ability.extra.Rank >= G.GAME.PT.Igor.MinRank then
            return
        end
        card.ability.extra.Rank = G.GAME.PT.Igor.MinRank
        UTIL.showTextJoker{card = card, type = 'RankUp'}
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

-- G.E_MANAGER:add_event(Event({
--     func = function()
        
--         return true;
--     end
-- }))