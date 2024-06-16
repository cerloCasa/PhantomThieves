--- STEAMODDED HEADER
--- MOD_NAME: Phantom Thieves 0.2
--- MOD_ID: PhantomThieves
--- MOD_AUTHOR: [Cerlo,Eremel]
--- MOD_DESCRIPTION: A Persona 5 Mod
--- BADGE_COLOR: DB2109
--- PREFIX: PT
--- PRIORITY: -1000000
--- LOADER_VERSION_GEQ: 1.0.0
_RELEASE_MODE = false

-- FUNZIONI DI SUPPORTO / SUPPORT FUNCTIONS
pt_loader = require(SMODS.current_mod.path.."/utils/PT_loader")

-- VARIABILI GLOBALI / GLOBAL VARIABLES
G.PhantomThieves = {
}

-- ASSETS
SMODS.Atlas {
	key = 'modicon',
	px = 34,
	py = 34,
	path = 'modicon.png'
}

SMODS.Atlas {
	key = 'Milady',
	px = 71,
	py = 95,
	path = '03 - Milady.png'
}