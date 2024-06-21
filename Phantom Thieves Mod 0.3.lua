--- STEAMODDED HEADER
--- MOD_NAME: Phantom Thieves 0.3
--- MOD_ID: PhantomThieves
--- MOD_AUTHOR: [Cerlo]
--- MOD_DESCRIPTION: A Persona 5 Mod
--- BADGE_COLOR: DB2109
--- PREFIX: PT
--- PRIORITY: -1000000
--- LOADER_VERSION_GEQ: 1.0.0
_RELEASE_MODE = false

G.PhantomTheves_Vars = {
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

    -- 11 Twins
    PTvar_Twins = true,
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
            sendTraceMessage("Calling tarotUsed function","PT_use_card")
            PT_tarotUsed(card)
        end
    end
end

-- COMMON FUNCTIONS

function PT_createConsumable(key,set,edition,negative)
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


-- UTIL FUNCTIONS

function PT_resetGlobalVars()
    G.GAME.PTvar_usedTarot = {}
    G.GAME.PTvar_mostUsedTarot_N = 0
    G.GAME.PTvar_mostUsedTarot_key = nil
    G.GAME.PTvar_mostUsedTarot_name = nil
    G.GAME.PTvar_usefulTarots = {}
	PT_Milady_resetGlobalVars()
	PT_RobinHood_resetGlobalVars()
    PT_Twins_resetGlobalVars()
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
	PT_soulPos(card)
    sendTraceMessage("New rank is " .. card.ability.extra.Rank,card.config.center_key)
end

function PT_soulPos(card)
	card.config.center.soul_pos = {x = 2 + card.ability.extra.Rank, y = 3}
	card:set_sprites(card.config.center)
end

function PT_tarotUsed(tarot)
    sendTraceMessage("Adding "..tarot.config.center_key.." to the table","PT_tarotUsed")
    G.GAME.PTvar_usedTarot[tarot.config.center_key] = (G.GAME.PTvar_usedTarot[tarot.config.center_key] or 0) + 1
    sendTraceMessage(tarot.config.center_key.." has been used "..G.GAME.PTvar_usedTarot[tarot.config.center_key].." times","PT_tarotUsed")
    if G.GAME.PTvar_usedTarot[tarot.config.center_key] > G.GAME.PTvar_mostUsedTarot_N then
        G.GAME.PTvar_mostUsedTarot_key = tarot.config.center_key
		G.GAME.PTvar_mostUsedTarot_name = tarot.ability.name
        G.GAME.PTvar_mostUsedTarot_N = G.GAME.PTvar_usedTarot[tarot.config.center_key]
    end
    sendTraceMessage("The most used Tarot is now "..G.GAME.PTvar_mostUsedTarot_key.." with "..G.GAME.PTvar_mostUsedTarot_N.." uses","PT_tarotUsed")
end

function SMODS.current_mod.process_loc_text()
	G.localization.descriptions.Other['PT_LinkedTarot_Justice'] = {
		name = 'Linked Tarot',
		text = {'Use the {C:purple}Justice Tarot','to {C:red}rank up{} this Joker'}
	}
	G.localization.descriptions.Other['PT_LinkedTarot_Empress'] = {
		name = 'Linked Tarot',
		text = {'Use the {C:purple}Empress Tarot','to {C:red}rank up{} this Joker'}
	}
	G.localization.descriptions.Other['PT_LinkedTarot_Strength'] = {
		name = 'Linked Tarot',
		text = {'Use the {C:purple}Strength Tarot','to {C:red}rank up{} this Joker'}
	}
	G.localization.descriptions.Other['PT_LinkedTarot_Death'] = {
		name = 'Linked Tarot',
		text = {'Use the {C:purple}Death Tarot','to {C:red}rank up{} this Joker'}
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

load(NFS.read(SMODS.current_mod.path .. 'jokers/03_Milady.lua'))()

load(NFS.read(SMODS.current_mod.path .. 'jokers/08_RobinHood.lua'))()

load(NFS.read(SMODS.current_mod.path .. 'jokers/11_Twins.lua'))() -- line 197

load(NFS.read(SMODS.current_mod.path .. 'jokers/13_BackAlleyDoctor.lua'))()

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