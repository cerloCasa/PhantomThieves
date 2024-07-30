--- STEAMODDED HEADER
--- MOD_NAME: Phantom Thieves
--- MOD_ID: PhantomThieves
--- MOD_AUTHOR: [Cerlo]
--- MOD_DESCRIPTION: A Persona 5 Mod
--- BADGE_COLOR: DB2109
--- PREFIX: PT
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: Build1-Ver1.0

-- MOD SETTINGS
PT = {
    Debug = true,
    UpdateVanillaTarots = true
}

-- UTILITY FUNCTIONS
local GM = load(NFS.read(SMODS.current_mod.path .. 'util/game modifiers.lua'))()
local ATLAS = load(NFS.read(SMODS.current_mod.path .. 'util/atlas.lua'))()
local UTIL = load(NFS.read(SMODS.current_mod.path .. 'util/util.lua'))()
local TEXT = load(NFS.read(SMODS.current_mod.path .. 'util/localization.lua'))()

-- JOKERS
local IGOR = load(NFS.read(SMODS.current_mod.path .. 'jokers/00 - Igor.lua'))()
local ZORRO = load(NFS.read(SMODS.current_mod.path .. 'jokers/01 - Zorro.lua'))()
local JOHANNA = load(NFS.read(SMODS.current_mod.path .. 'jokers/02 - Johanna.lua'))()
local MILADY = load(NFS.read(SMODS.current_mod.path .. 'jokers/03 - Milady.lua'))()
-- local GOEMON = load(NFS.read(SMODS.current_mod.path .. 'jokers/04 - Goemon.lua'))()
-- local CHIEF = load(NFS.read(SMODS.current_mod.path .. 'jokers/05 - Chief.lua'))()
-- local CARMEN = load(NFS.read(SMODS.current_mod.path .. 'jokers/06 - Carmen.lua'))()
-- local CAPTAIN_KIDD = load(NFS.read(SMODS.current_mod.path .. 'jokers/07 - Captain Kidd.lua'))()
-- local ROBIN_HOOD = load(NFS.read(SMODS.current_mod.path .. 'jokers/08 - Robin Hood.lua'))()
-- local NECRONOMICON = load(NFS.read(SMODS.current_mod.path .. 'jokers/09 - Necronomicon.lua'))()
-- local PROPHETESS = load(NFS.read(SMODS.current_mod.path .. 'jokers/10 - Prophetess.lua'))()
-- local TWINS = load(NFS.read(SMODS.current_mod.path .. 'jokers/11 - Twins.lua'))()
-- local WEAPONS_DEALER = load(NFS.read(SMODS.current_mod.path .. 'jokers/12 - Weapons Dealer.lua'))()
-- local BACK_ALLEY_DOCTOR = load(NFS.read(SMODS.current_mod.path .. 'jokers/13 - Back Alley Doctor.lua'))()
-- local TEACHER = load(NFS.read(SMODS.current_mod.path .. 'jokers/14 - Teacher.lua'))()
-- local PAPARAZZA = load(NFS.read(SMODS.current_mod.path .. 'jokers/15 - Paparazza.lua'))()
-- local SKILLED_GAMER = load(NFS.read(SMODS.current_mod.path .. 'jokers/16 - Skilled Gamer.lua'))()
-- local SHOGI_PLAYER = load(NFS.read(SMODS.current_mod.path .. 'jokers/17 - Shogi Player.lua'))()
-- local ADMIN = load(NFS.read(SMODS.current_mod.path .. 'jokers/18 - Admin.lua'))()
-- local MAN_OF_THE_PEOPLE = load(NFS.read(SMODS.current_mod.path .. 'jokers/19 - Man of the People.lua'))()
-- local PROSECUTOR = load(NFS.read(SMODS.current_mod.path .. 'jokers/20 - Prosecutor.lua'))()
-- local ARSÈNE = load(NFS.read(SMODS.current_mod.path .. 'jokers/21 - Arsène.lua'))()

-- TAROTS
local VANILLA = load(NFS.read(SMODS.current_mod.path .. 'tarots/Vanilla.lua'))()


-- DECKS
local PHANTOM_DECK = load(NFS.read(SMODS.current_mod.path .. 'decks/Phantom Deck.lua'))()