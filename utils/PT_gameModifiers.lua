PT_GAMEMODIFIERS = {}

-- MODIFICA LA FUNZIONE use_card CHE SI ATTIVA QUANDO UN CONSUMABILE VIENE USATO
 
-- INIZIO DELLA PARTITA / START OF THE RUN
local vanilla_Back_apply_to_run = Back.apply_to_run
function Back.apply_to_run(self)
	vanilla_Back_apply_to_run(self)
	pt_util.resetGlobalVars()
	return true
end

local vanilla_G_FUNCS_use_card = G.FUNCS.use_card
G.FUNCS.use_card = function(e,mute,nosave)
    vanilla_G_FUNCS_use_card(e,mute,nosave)
    local card = e.config.ref_table
    if card.ability.consumeable then
        if (card.ability.set == 'Tarot') then
            sendTraceMessage("Calling tarotUsed function","PT_UTIL:use_card")
            pt_util.tarotUsed(card)
        end
    end
end

return PT_GAMEMODIFIERS