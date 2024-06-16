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

-- VARIABILI GLOBALI / GLOBAL VARIABLES
G.PhantomThieves = {
}

-- UTIL FUNCTIONS

pt_util = require(SMODS.current_mod.path.."/utils/PT_util")
pt_manageCards = require(SMODS.current_mod.path.."/utils/PT_manageCards")
pt_gameModifiers = require(SMODS.current_mod.path.."/utils/PT_gameModifiers")

-- JOKERS

--pt_TheContract = require(SMODS.current_mod.path.."/jokers_func/PT_TheContract")
--pt_Zorro = require(SMODS.current_mod.path.."/jokers_func/PT_Zorro")
--pt_Johanna = require(SMODS.current_mod.path.."/jokers_func/PT_Johanna")
pt_Milady = require(SMODS.current_mod.path.."/jokers_func/PT_Milady")
--pt_Goemon = require(SMODS.current_mod.path.."/jokers_func/PT_Goemon")
--pt_Chief = require(SMODS.current_mod.path.."/jokers_func/PT_Chief")
--pt_Carmen = require(SMODS.current_mod.path.."/jokers_func/PT_Carmen")
--pt_CaptainKidd = require(SMODS.current_mod.path.."/jokers_func/PT_CaptainKidd")
pt_RobinHood = require(SMODS.current_mod.path.."/jokers_func/PT_RobinHood")
--pt_Necronomicon = require(SMODS.current_mod.path.."/jokers_func/PT_Necronomicon")
--pt_FortuneTeller = require(SMODS.current_mod.path.."/jokers_func/PT_FortuneTeller")
--pt_Twins = require(SMODS.current_mod.path.."/jokers_func/PT_Twins")
--pt_WeaponsDealer = require(SMODS.current_mod.path.."/jokers_func/PT_WeaponsDealer")
--pt_BackAlleyDoctor = require(SMODS.current_mod.path.."/jokers_func/PT_BackAlleyDoctor")
--pt_Teacher = require(SMODS.current_mod.path.."/jokers_func/PT_Teacher")
--pt_Paparazza = require(SMODS.current_mod.path.."/jokers_func/PT_Paparazza")
--pt_SkilledGamer = require(SMODS.current_mod.path.."/jokers_func/PT_SkilledGamer")
--pt_ShogiPlayer = require(SMODS.current_mod.path.."/jokers_func/PT_ShogiPlayer")
--pt_Admin = require(SMODS.current_mod.path.."/jokers_func/PT_Admin")
--pt_ManOfThePeople = require(SMODS.current_mod.path.."/jokers_func/PT_ManOfThePeople")
--pt_Prosecutor = require(SMODS.current_mod.path.."/jokers_func/PT_Prosecutor")
--pt_Arsene = require(SMODS.current_mod.path.."/jokers_func/PT_Arsene")

-- CONSUMEABLES

-- BLINDS

-- ASSETS
SMODS.Atlas {
	key = 'modicon',
	px = 34,
	py = 34,
	path = 'modicon.png'
}