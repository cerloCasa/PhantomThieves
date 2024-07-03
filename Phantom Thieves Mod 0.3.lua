--- STEAMODDED HEADER
--- MOD_NAME: Phantom Thieves
--- MOD_ID: PhantomThieves
--- MOD_AUTHOR: [Cerlo]
--- MOD_DESCRIPTION: A Persona 5 Mod
--- BADGE_COLOR: DB2109
--- PREFIX: PT
--- PRIORITY: -1000000
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: 0.3.3

G.PhantomThieves_Vars = {
    PTvar_usedTarot = {},
    PTvar_mostUsedTarot_key = nil,
	PTvar_mostUsedTarot_name = nil,
    PTvar_mostUsedTarot_N = 0,
    PTvar_usefulTarots = {},

    -- 03 Milady
	PTvar_Milady = {},
    
    -- 08 Robin Hood
	PTvar_RobinHood_canBetrayalSpawn = false,
	PTvar_RobinHood_roundCounter = 0,
}

-- MODIFY VANILLA GAME FUNCTIONS

local vanilla_Back_apply_to_run = Back.apply_to_run
function Back.apply_to_run(self)
	vanilla_Back_apply_to_run(self)
	PT_resetGlobalVars()
	return true
end

local vanilla_G_FUNCS_use_card = G.FUNCS.use_card
G.FUNCS.use_card = function(e,mute,nosave)
    vanilla_G_FUNCS_use_card(e,mute,nosave)
    local card = e.config.ref_table
    if card.ability.consumeable then
        if (card.ability.set == 'Tarot') then
            PT_tarotUsed(card)
        end
    end
end

-- COMMON FUNCTIONS

function PT_createConsumable(key,set,edition,negative)
    if negative or (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) then
        if key == 'lastHandPlayed' then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.GAME.last_hand_played then
                        local _planet = 0
                        for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                            if v.config.hand_type == G.GAME.last_hand_played then
                                _planet = v.key
                            end
                        end
                        local _card = create_card(set, G.consumeables, nil, nil, nil, nil, _planet)
                        _card:add_to_deck()
                        if edition then
                            _card:set_edition(edition, negative)
                        end
                        G.consumeables:emplace(_card)
                    end
                    return true;
                end}))
        else
            G.E_MANAGER:add_event(Event({
                func = function() 
                    local _card = create_card(set, G.consumeables, nil, nil, nil, nil, key)
                    _card:add_to_deck()
                    if edition then
                        _card:set_edition(edition, negative)
                    end
                    G.consumeables:emplace(_card)
                return true;
            end}))
        end
    else
        sendTraceMessage("No room for new consumable :/","PT_createConsumable")
    end
end

function PT_createJoker(key,edition,negative)
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

function PT_destroyJoker(card)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
        func = function()
                G.jokers:remove_card(card)
                card:remove()
                card = nil
            return true;
        end}))
end

function PT_expandConsumeableArea(amount)
    G.E_MANAGER:add_event(Event({func = function()
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + amount
        return true;
    end}))
end

function PT_reduceConsumeableArea(amount)
    G.E_MANAGER:add_event(Event({func = function()
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - amount
        return true;
    end}))
end

function PT_random(prob,total)
    -- This function returns true with a (prob) in (total) chance
    prob = prob * (G.GAME and G.GAME.probabilities.normal or 1)
    if (prob >= total) then
        print("PROB: "..prob.." in "..total.." is FORCED TRUE")
        return true
    end
    if (pseudorandom('PT')) <= (prob/total) then
        print("PROB: "..prob.." in "..total.." is TRUE")
        return true
    end
    print("PROB: "..prob.." in "..total.." is FALSE")
    return false
end


-- UTIL FUNCTIONS

function PT_resetGlobalVars()
    G.GAME.PTvar_usedTarot = {}
    G.GAME.PTvar_mostUsedTarot_N = 0
    G.GAME.PTvar_mostUsedTarot_key = nil
    G.GAME.PTvar_mostUsedTarot_name = nil
    G.GAME.PTvar_usefulTarots = {}
	PT_Milady_resetGlobalVars()
	PT_RobinHood_resetGlobalVars()
	sendTraceMessage("All global variables have been reset","PT_resetGlobalVars")
end

function PT_evolve(start,dest)
    sendTraceMessage("Evolving to " .. dest,start.config.center_key)
    -- Save START's edition
    local Edition, Negative
    if start.edition then
        Edition = start.edition
        Negative = start.edition.negative
    end

    -- Destroy START
    PT_destroyJoker(start)
    
    -- Create DEST with Edition and Negative
    PT_createJoker(dest,Edition,Negative)
    sendTraceMessage("Successfully evolved to " .. dest,start.config.center_key)
end

function PT_rankUp(card) 
    card.ability.extra.Rank = card.ability.extra.Rank + 1
    if card.ability.extra.Rank > 10 then
        card.ability.extra.Rank = 10
    end
	PT_soulPos(card)
end

function PT_soulPos(card)
	card.config.center.soul_pos = {x = 2 + card.ability.extra.Rank, y = 3}
	card:set_sprites(card.config.center)
end

function PT_tarotUsed(tarot)
    G.GAME.PTvar_usedTarot[tarot.config.center_key] = (G.GAME.PTvar_usedTarot[tarot.config.center_key] or 0) + 1
    if G.GAME.PTvar_usedTarot[tarot.config.center_key] >= G.GAME.PTvar_mostUsedTarot_N then
        G.GAME.PTvar_mostUsedTarot_key = tarot.config.center_key
		G.GAME.PTvar_mostUsedTarot_name = tarot.ability.name
        G.GAME.PTvar_mostUsedTarot_N = G.GAME.PTvar_usedTarot[tarot.config.center_key]
    end
    print("usedTarot = "..tprint(G.GAME.PTvar_usedTarot))
    print("The most used Tarot is now "..G.GAME.PTvar_mostUsedTarot_key)
end

function SMODS.current_mod.process_loc_text()
	G.localization.descriptions.Other['PT_LinkedTarot_Magician'] = {
        name = 'Linked Tarot',
		text = {'Use the {C:purple}Magician Tarot','to {C:red}rank up{} this Joker'}
	}
	G.localization.descriptions.Other['PT_LinkedTarot_HighPriestess'] = {
        name = 'Linked Tarot',
		text = {'Use the {C:purple}High Priestess Tarot','to {C:red}rank up{} this Joker'}
	}
	G.localization.descriptions.Other['PT_LinkedTarot_Empress'] = {
        name = 'Linked Tarot',
		text = {'Use the {C:purple}Empress Tarot','to {C:red}rank up{} this Joker'}
	}
	G.localization.descriptions.Other['PT_LinkedTarot_Emperor'] = {
        name = 'Linked Tarot',
		text = {'Use the {C:purple}Emperor Tarot','to {C:red}rank up{} this Joker'}
	}
    G.localization.descriptions.Other['PT_LinkedTarot_Chariot'] = {
        name = 'Linked Tarot',
		text = {'Use the {C:purple}Chariot Tarot','to {C:red}rank up{} this Joker'}
	}
    G.localization.descriptions.Other['PT_LinkedTarot_Justice'] = {
        name = 'Linked Tarot',
        text = {'Use the {C:purple}Justice Tarot','to {C:red}rank up{} this Joker'}
    }
	G.localization.descriptions.Other['PT_LinkedTarot_Strength'] = {
		name = 'Linked Tarot',
		text = {'Use the {C:purple}Strength Tarot','to {C:red}rank up{} this Joker'}
	}
	G.localization.descriptions.Other['PT_LinkedTarot_Death'] = {
		name = 'Linked Tarot',
		text = {'Use the {C:purple}Death Tarot','to {C:red}rank up{} this Joker'}
	}
	G.localization.descriptions.Other['PT_LinkedTarot_Temperance'] = {
		name = 'Linked Tarot',
		text = {'Use the {C:purple}Temperance Tarot','to {C:red}rank up{} this Joker'}
	}
	G.localization.descriptions.Other['PT_LinkedTarot_Tower'] = {
		name = 'Linked Tarot',
		text = {'Use the {C:purple}Tower Tarot','to {C:red}rank up{} this Joker'}
	}
	G.localization.descriptions.Other['PT_LinkedTarot_Star'] = {
		name = 'Linked Tarot',
		text = {'Use the {C:purple}Star Tarot','to {C:red}rank up{} this Joker'}
	}
	G.localization.descriptions.Other['PT_RobinHood_MostUsedTarot'] = {
		name = 'Most used Tarot',
		text = {'Currently the most used','{C:purple}Tarot{} is {C:purple}#1#'}
	}
	G.localization.descriptions.Other['PT_RobinHood_NoUsedTarots'] = {
		name = 'Most used Tarot',
		text = {'No {C:purple}Tarots{} have ','been used this run'}
	}
	sendTraceMessage("Lock text done","PTprocessLocText")
end

-- JOKERS

load(NFS.read(SMODS.current_mod.path .. 'jokers/01_Zorro.lua'))()

load(NFS.read(SMODS.current_mod.path .. 'jokers/02_Johanna.lua'))()

load(NFS.read(SMODS.current_mod.path .. 'jokers/03_Milady.lua'))()

load(NFS.read(SMODS.current_mod.path .. 'jokers/04_Goemon.lua'))()

load(NFS.read(SMODS.current_mod.path .. 'jokers/07_CaptainKidd.lua'))()

load(NFS.read(SMODS.current_mod.path .. 'jokers/08_RobinHood.lua'))()

load(NFS.read(SMODS.current_mod.path .. 'jokers/11_Twins.lua'))()

load(NFS.read(SMODS.current_mod.path .. 'jokers/13_BackAlleyDoctor.lua'))()

load(NFS.read(SMODS.current_mod.path .. 'jokers/14_Teacher.lua'))()

load(NFS.read(SMODS.current_mod.path .. 'jokers/16_SkilledGamer.lua'))()

load(NFS.read(SMODS.current_mod.path .. 'jokers/17_ShogiPlayer.lua'))()

-- CONSUMEABLES

-- BLINDS

-- ASSETS
SMODS.Atlas { -- modicon
	key = 'modicon',
	px = 34,
	py = 34,
	path = 'modicon.png'
}

SMODS.Atlas { -- Jokers
	key = 'Jokers',
	px = 71,
	py = 95,
	path = 'Jokers.png'
}