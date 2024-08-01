SMODS.Atlas { -- modicon
    key = 'modicon',
    px = 34,
    py = 34,
    path = 'modicon.png',
}

SMODS.Atlas { -- Jokers
    key = 'Jokers',
    px = 71,
    py = 95,
    path = 'Jokers.png',
}

if PT.UpdateVanillaTarots == 'Semi' then
    SMODS.Atlas { -- Vanilla Tarots
        key = 'Tarots',
        px = 71,
        py = 95,
        path = 'Tarots Semi.png',
    }
end
if PT.UpdateVanillaTarots == 'Full' then
    SMODS.Atlas { -- Vanilla Tarots
        key = 'Tarots',
        px = 71,
        py = 95,
        path = 'Tarots Full.png',
    }
end

SMODS.Atlas { -- Decks
    key = 'Decks',
    px = 71,
    py = 95,
    path = 'Decks.png',
}