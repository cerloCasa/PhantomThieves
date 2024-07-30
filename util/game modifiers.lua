local function RunStart()
    G.GAME.PT = {        
        UsedTarots = {},
        MostUsedTarot = {
            key = false,
            name = false,
            uses = 0
        },

        Igor = {
            MinRank = 1
        }
    }
end

local vanilla_Back_apply_to_run = Back.apply_to_run
function Back.apply_to_run(self)
	vanilla_Back_apply_to_run(self)
    RunStart()
    if PT.Debug then
        print('RunStart has been added')
    end
    return true
end

local function ConsumeableUsed(e)
    local tarot = e.config.ref_table
    if tarot.ability.consumeable then
        if (tarot.ability.set == 'Tarot') then
            -- TAROT USED
            G.GAME.PT.UsedTarots[tarot.config.center_key] = (G.GAME.PT.UsedTarots[tarot.config.center_key] or 0) + 1
            if G.GAME.PT.UsedTarots[tarot.config.center_key] >= G.GAME.PT.MostUsedTarot.uses then
                G.GAME.PT.MostUsedTarot.key = tarot.config.center_key
                G.GAME.PT.MostUsedTarot.name = tarot.ability.name
                G.GAME.PT.MostUsedTarot.uses = G.GAME.PT.UsedTarots[tarot.config.center_key]
            end
            if PT.Debug then
                print("usedTarots = "..tprint(G.GAME.PT.UsedTarots))
                print("The most used Tarot is now "..G.GAME.PT.MostUsedTarot.name)
            end
        end
    end
end

local vanilla_G_FUNCS_use_card = G.FUNCS.use_card
G.FUNCS.use_card = function(e,mute,nosave)
    vanilla_G_FUNCS_use_card(e,mute,nosave)
    ConsumeableUsed(e)
    if PT.Debug then
        print('ConsumeableUsed has been added')
    end
end