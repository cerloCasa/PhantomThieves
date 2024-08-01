--- STEAMODDED HEADER
--- MOD_NAME: Phantom Thieves
--- MOD_ID: PhantomThieves
--- MOD_AUTHOR: [Cerlo]
--- MOD_DESCRIPTION: A Persona 5 Mod
--- BADGE_COLOR: DB2109
--- PREFIX: PT
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: Build3-Ver1.0

-- MOD SETTINGS
PT = {
    Debug = true,
    UpdateVanillaTarots = 'Full'
}


-- UTILITY FUNCTIONS
local GM = SMODS.load_file('util/game modifiers.lua')()
local ATLAS = SMODS.load_file('util/atlas.lua')()
local UTIL = SMODS.load_file('util/util.lua')()
local TEXT = SMODS.load_file('util/localization.lua')()

-- JOKERS
local IGOR = SMODS.load_file('jokers/00 - Igor.lua')()
local ZORRO = SMODS.load_file('jokers/01 - Zorro.lua')()
local JOHANNA = SMODS.load_file('jokers/02 - Johanna.lua')()
local MILADY = SMODS.load_file('jokers/03 - Milady.lua')()
local GOEMON = SMODS.load_file('jokers/04 - Goemon.lua')()
local BARISTA = SMODS.load_file('jokers/05 - Barista.lua')()
-- local CARMEN = SMODS.load_file('jokers/06 - Carmen.lua')()
local CAPTAIN_KIDD = SMODS.load_file('jokers/07 - Captain Kidd.lua')()
local ROBIN_HOOD = SMODS.load_file('jokers/08 - Robin Hood.lua')()
local NECRONOMICON = SMODS.load_file('jokers/09 - Necronomicon.lua')()
local PROPHETESS = SMODS.load_file('jokers/10 - Prophetess.lua')()
-- local TWINS = SMODS.load_file('jokers/11 - Twins.lua')()
-- local WEAPONS_DEALER = SMODS.load_file('jokers/12 - Weapons Dealer.lua')()
-- local BACK_ALLEY_DOCTOR = SMODS.load_file('jokers/13 - Back Alley Doctor.lua')()
-- local TEACHER = SMODS.load_file('jokers/14 - Teacher.lua')()
-- local PAPARAZZA = SMODS.load_file('jokers/15 - Paparazza.lua')()
-- local SKILLED_GAMER = SMODS.load_file('jokers/16 - Skilled Gamer.lua')()
-- local SHOGI_PLAYER = SMODS.load_file('jokers/17 - Shogi Player.lua')()
-- local ADMIN = SMODS.load_file('jokers/18 - Admin.lua')()
-- local POLITICIAN = SMODS.load_file('jokers/19 - Politician.lua')()
-- local PROSECUTOR = SMODS.load_file('jokers/20 - Prosecutor.lua')()
-- local ARSÈNE = SMODS.load_file('jokers/21 - Arsène.lua')()

-- TAROTS
local VANILLA = SMODS.load_file('tarots/Vanilla.lua')()


-- DECKS
local PHANTOM_DECK = SMODS.load_file('decks/Phantom Deck.lua')()