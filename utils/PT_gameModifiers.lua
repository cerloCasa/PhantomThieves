PT_GAMEMODIFIERS = {}

-- MODIFICA LA FUNZIONE use_card CHE SI ATTIVA QUANDO UN CONSUMABILE VIENE USATO

local G_FUNCS_use_card_ref = G.FUNCS.use_card
G.FUNCS.use_card = function(e,mute,nosave)
    G_FUNCS_use_card_ref(e,mute,nosave)
    local card = e.config.ref_table
    if card.ability.consumeable then
        if (card.ability.set == 'Tarot') then
            sendTraceMessage("Calling tarotUsed function","PT_UTIL:use_card")
            pt_util.tarotUsed(card)
        end
    end
end

return PT_GAMEMODIFIERS