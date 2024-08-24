function SMODS.current_mod.process_loc_text()
	G.localization.descriptions.Other['PT_LinkedTarot'] = {
        name = 'Linked Tarot',
		text = {'Use the {C:purple}#1# Tarot','to {C:red}rank up{} this Joker'}
	}
	G.localization.descriptions.Other['PT_MostUsedTarot'] = {
		name = 'Most used Tarot',
		text = {'Currently the most used','{C:purple}Tarot{} is {C:purple}#1#'}
	}
	G.localization.descriptions.Other['PT_NoUsedTarots'] = {
		name = 'Most used Tarot',
		text = {'No {C:purple}Tarots{} have ','been used this run'}
	}

	-- 00. IGOR
	G.localization.descriptions.Joker['PT_Igor1'] = {
        name = 'Igor',
        text = {'{C:dark_edition}+1{} Joker slot','{C:inactive}(Permanent)'},
    }
    G.localization.descriptions.Joker['PT_Igor2-8'] = {
        name = 'Igor',
        text = {'All {C:red}Phantom Thieves{}','Jokers can\'t be below','Rank {C:attention}#1#'},
    }
    G.localization.descriptions.Joker['PT_Igor9'] = {
        name = '{C:blue}Igor',
        text = {'All {C:red}Phantom Thieves{}','Jokers can\'t be below','Rank {C:attention}9'},
    }
    G.localization.descriptions.Joker['PT_IgorMAX'] = {
        name = '{C:red}Igor',
        text = {'All {C:red}Phantom Thieves{}','Jokers can\'t be below','Rank {C:attention}Max'},
    }
	G.localization.descriptions.Other['PT_Beyond_Fool'] = {
		name = 'Beyond',
		text = {'Each {C:purple}Fool{} card played from','now gives {C:dark_edition}+1{} Joker slot','{C:inactive}(Currently {C:dark_edition}+#1# {C:inactive}Joker Slots)'}
	}

	-- 01. ZORRO
	G.localization.descriptions.Joker['PT_Zorro1-2'] = {
        name = 'Zorro',
        text = {'Create a random {C:planet}Planet','card at the end','of the round','{C:inactive}(Must have room)'},
    }
    G.localization.descriptions.Joker['PT_Zorro3-4'] = {
        name = 'Zorro',
        text = {'Create the {C:planet}Planet{} card','for final played','{C:attention}poker hand','{C:inactive}(Must have room)'},
    }
    G.localization.descriptions.Joker['PT_Zorro5-6'] = {
        name = 'Zorro',
        text = {'Create two {C:planet}Planet{} cards','for final played','{C:attention}poker hand','{C:inactive}(Must have room)'},
    }
    G.localization.descriptions.Joker['PT_Zorro7-8'] = {
        name = 'Zorro',
        text = {'Create the {C:planet}Planet{} cards','for played {C:attention}poker hand','{C:inactive}(Must have room)'},
    }
    G.localization.descriptions.Joker['PT_Zorro9'] = {
        name = '{C:blue}Mercurius',
        text = {'Create a {C:dark_edition}negative', '{C:planet}Planet{} card','for played {C:attention}poker hand'},
    }
    G.localization.descriptions.Joker['PT_ZorroMAX'] = {
        name = '{C:red}Diego',
        text = {'Create two {C:dark_edition}negative', '{C:planet}Planet{} cards','for played {C:attention}poker hand'},
    }
	G.localization.descriptions.Other['PT_Beyond_Magician'] = {
		name = 'Beyond',
		text = {'Each {C:purple}Magician{} card played from','now gives {C:planet}+1{} Planet','{C:inactive}(Currently {C:planet}+#1# {C:inactive}Planets)'}
	}
    
    -- 02. JOHANNA
    G.localization.descriptions.Joker['PT_Johanna1-2'] = {
        name = 'Johanna',
        text = {'Retrigger the first','scoring card'},
    }
    G.localization.descriptions.Joker['PT_Johanna3-4'] = {
        name = 'Johanna',
        text = {'Retrigger the first','{C:attention}2{} scoring cards'},
    }
    G.localization.descriptions.Joker['PT_Johanna5-6'] = {
        name = 'Johanna',
        text = {'Retrigger the first','{C:attention}3{} scoring cards'},
    }
    G.localization.descriptions.Joker['PT_Johanna7-8'] = {
        name = 'Johanna',
        text = {'Retrigger the first','{C:attention}4{} scoring cards'},
    }
    G.localization.descriptions.Joker['PT_Johanna9'] = {
        name = '{C:blue}Anat',
        text = {'Retrigger all','scoring cards'},
    }
    G.localization.descriptions.Joker['PT_JohannaMAX'] = {
        name = '{C:red}Agnes',
        text = {'Retrigger all','scoring cards {C:attention}2{} times'},
    }
    G.localization.descriptions.Other['PT_Beyond_HighPriestess'] = {
        name = 'Beyond',
        text = {'Each {C:purple}High Priestess{} card played from','now gives {C:attention}+1{} retrigger','{C:inactive}(Currently {C:attention}+#1# {C:inactive}retriggers)'}
    }
    
    -- 03. MILADY
    G.localization.descriptions.Joker['PT_Milady1-8'] = {
        name = 'Milady',
        text = {'Earn {C:money}$#1#{} at','end of round'},
    }
    G.localization.descriptions.Joker['PT_Milady9'] = {
        name = '{C:blue}Astarte',
        text = {'Earn {C:money}$5{} after each','hand played'},
    }
    G.localization.descriptions.Joker['PT_MiladyMAX'] = {
        name = '{C:red}Lucy',
        text = {'Earn {C:money}$5{} for each', 'card scored'},
    }
    G.localization.descriptions.Other['PT_Beyond_Empress'] = {
        name = 'Beyond',
        text = {'Each {C:purple}Empress{} card played from','now gives {C:money}+$1{}','{C:inactive}(Currently {C:attention}+$#1# {C:inactive})'}
    }
    
    -- 04. GOEMON
    G.localization.descriptions.Joker['PT_Goemon1'] = {
        name = 'Goemon',
        text = {'{C:green}#1# in 3{} chance to','duplicate first card','of first hand of round','and draw it to {C:attention}hand'},
    }
    G.localization.descriptions.Joker['PT_Goemon2'] = {
        name = 'Goemon',
        text = {'{C:green}#1# in 2{} chance to','duplicate first card','of first hand of round','and draw it to {C:attention}hand'},
    }
    G.localization.descriptions.Joker['PT_Goemon3'] = {
        name = 'Goemon',
        text = {'Duplicate first card','of first hand of round','and draw it to {C:attention}hand'},
    }
    G.localization.descriptions.Joker['PT_Goemon4-7'] = {
        name = 'Goemon',
        text = {'Duplicate first {C:attention}#1#{} cards','of first hand of round','and draw them to {C:attention}hand'},
    }
    G.localization.descriptions.Joker['PT_Goemon8'] = {
        name = 'Goemon',
        text = {'Duplicate first','hand of round','and draw it to {C:attention}hand'},
    }
    G.localization.descriptions.Joker['PT_Goemon9'] = {
        name = '{C:blue}Kamu Susano-o',
        text = {'Duplicate first {C:attention}2{}','hands of round','and draw them to {C:attention}hand'},
    }
    G.localization.descriptions.Joker['PT_GoemonMAX'] = {
        name = '{C:red}Gorokichi',
        text = {'Duplicate first {C:attention}3{}','hands of round','and draw them to {C:attention}hand'},
    }
    G.localization.descriptions.Other['PT_Beyond_Emperor'] = {
        name = 'Beyond',
        text = {'Each {C:purple}Emperor{} card played','from now gives {C:attention}+1{} hand','{C:inactive}(Currently {C:attention}+#1# {C:inactive}hands)'}
    }
    
    -- 05. BARISTA
    G.localization.descriptions.Joker['PT_Barista9'] = {
        name = '{C:blue}Sojiro',
        text = {'{C:chips}+#1#{} Chips for every','other {C:red}Phantom Thieves','{C:attention}Joker{} you own'},
    }
    G.localization.descriptions.Joker['PT_BaristaMAX'] = {
        name = '{C:red}Boss',
        text = {'{C:chips}+#1#{} Chips for every','other {C:red}Phantom Thieves','{C:attention}Joker{} you own'},
    }
    G.localization.descriptions.Other['PT_Beyond_Hierophant'] = {
        name = 'Beyond',
        text = {'Each {C:purple}Hierophant{} card played','from now gives {C:chips}+10{} Chips','{C:inactive}(Currently {C:chips}+#1# {C:inactive}chips)'}
    }

    -- 07. CAPTAIN KIDD
    G.localization.descriptions.Joker['PT_CaptainKidd2-4'] = {
        name = 'Captain Kidd',
        text = {'Level up first {C:attention}#1#{} hands','played each round'},
    }
    G.localization.descriptions.Joker['PT_CaptainKidd5-6'] = {
        name = 'Captain Kidd',
        text = {'Upgrade level of','played {C:attention}poker hand'},
    }
    G.localization.descriptions.Joker['PT_CaptainKidd7-8'] = {
        name = 'Captain Kidd',
        text = {'Upgrade level of','played {C:attention}poker hand','{C:attention}2{} times'},
    }
    G.localization.descriptions.Joker['PT_CaptainKidd9'] = {
        name = '{C:blue}Seiten Taisei',
        text = {'Upgrade level of','played {C:attention}poker hand','{C:attention}3{} times'},
    }
    G.localization.descriptions.Joker['PT_CaptainKiddMAX'] = {
        name = '{C:red}William',
        text = {'Upgrade level of','played {C:attention}poker hand','and all contained','hands {C:attention}3{} times'},
    }
    G.localization.descriptions.Other['PT_Beyond_Chariot'] = {
        name = 'Beyond',
        text = {'Each {C:purple}Chariot{} card played','from now gives {C:attention}+1{} upgrade','{C:inactive}(Currently {C:attention}+#1# {C:inactive}upgrades)'}
    }

    -- 08. ROBIN HOOD
    G.localization.descriptions.Joker['PT_RobinHood1-8'] = {
        name = 'Robin Hood',
        text = {'{C:green}#1# in #2#{} chance to','enhance a random {C:attention}Joker','you own to {C:dark_edition}negative{} at','end of round'},
    }
    G.localization.descriptions.Joker['PT_RobinHood9'] = {
        name = '{C:blue}Loki',
        text = {'{C:green}#1# in 3{} chance to','enhance a random {C:attention}Joker','you own to {C:dark_edition}negative{} at','end of round'},
    }
    G.localization.descriptions.Joker['PT_RobinHoodMAX'] = {
        name = '{C:red}Hereward',
        text = {'Enhance a random {C:attention}Joker','you own to {C:dark_edition}negative{} at','end of round'},
    }

    -- 09. NECRONOMICON
    G.localization.descriptions.Joker['PT_Necronomicon5-8'] = {
        name = 'Necronomicon',
        text = {'Create a {C:attention}useful {C:purple}Tarot','at the end of the round','{C:inactive}(Must have room)'},
    }
    G.localization.descriptions.Joker['PT_Necronomicon9'] = {
        name = '{C:blue}Prometheus',
        text = {'Create two {C:attention}useful {C:purple}Tarots','at the end of the round','{C:inactive}(Must have room)'},
    }
    G.localization.descriptions.Joker['PT_NecronomiconMAX'] = {
        name = '{C:red}Al Azif',
        text = {'Create two {C:dark_edition}negative {C:attention}useful','{C:purple}Tarots{} at the end of the round','{C:inactive}(Must have room)'},
    }
    G.localization.descriptions.Other['PT_Beyond_Hermit'] = {
        name = 'Beyond',
        text = {'Each {C:purple}Hermit{} card played','from now creates {C:purple}+1{} Tarot','{C:inactive}(Currently {C:purple}+#1# {C:inactive}Tarots)'}
    }
    G.localization.descriptions.Other['PT_UsefulTarot'] = {
        name = 'Useful Tarots',
        text = {'A {C:purple}Tarot{} is {C:attention}useful','when it is linked to a','{C:red}Phantom Thieves {C:attention}Joker{} you own'}
    }

    -- 10. PROPHETESS
    G.localization.descriptions.Joker['PT_Prophetess9'] = {
        name = '{C:blue}Chihaya',
        text = {'{C:green}1 in 2{} chance {C:inactive}(fixed){}.','If it\'s {X:green,C:white}Good{}, all scoring','cards give {C:chips}+#1#{} Chips.','If it\'s {X:red,C:white}Bad{}, all scoring','cards give {C:chips}-#2#{} Chips.'},
    }
    G.localization.descriptions.Joker['PT_ProphetessMAX'] = {
        name = '{C:red}Lucky charm',
        text = {'{C:green}1 in 2{} chance {C:inactive}(fixed){}.','If it\'s {X:green,C:white}Good{}, all scoring','cards give {C:chips}+#1#{} Chips.','If it\'s {X:red,C:white}Bad{}, all scoring','cards give {C:chips}-#2#{} Chips.'},
    }
    G.localization.descriptions.Other['PT_Beyond_WheelOfFortune'] = {
        name = 'Beyond',
        text = {'Each {C:purple}Wheel of Fortune{}','card played from now adds','{C:chips}+10{} Chips to the {X:green,C:white}Good{} and','{C:chips}+5{} Chips to the {X:red,C:white}Bad','{C:inactive}(Currently {C:chips}+#1#{} and {C:chips}#2# {C:inactive}Chips)'}
    }
    
    -- 11. WARDENS
    G.localization.descriptions.Joker['PT_Wardens2-4'] = {
        name = 'Wardens',
        text = {'{C:dark_edition}+1{} Joker slot'},
    }
    G.localization.descriptions.Joker['PT_Wardens5-8'] = {
        name = 'Wardens',
        text = {'{C:dark_edition}+2{} Joker slots'},
    }
    G.localization.descriptions.Joker['PT_Wardens9'] = {
        name = '{C:blue}Twins',
        text = {'{C:dark_edition}+2{} Joker slots'},
    }
    G.localization.descriptions.Joker['PT_WardensMAX'] = {
        name = '{C:red}Lavenza',
        text = {'{C:dark_edition}+3{} Joker slots'},
    }
    G.localization.descriptions.Other['PT_Beyond_Strength'] = {
        name = 'Beyond',
        text = {'Each {C:purple}Strength{} card played','from now gives {C:dark_edition}+1{} Joker slot','{C:inactive}(Currently {C:dark_edition}+#1# {C:inactive}Joker slots)'}
    }
    
    -- 12. WEAPONS DEALER
    G.localization.descriptions.Joker['PT_WeaponsDealer1-4'] = {
        name = 'Weapons dealer',
        text = {'Chance to {C:attention}upgrade','all scoring cards','to {C:dark_edition}Foil'},
    }
    G.localization.descriptions.Joker['PT_WeaponsDealer5-8'] = {
        name = 'Weapons dealer',
        text = {'Chance to {C:attention}upgrade','all scoring cards','to {C:dark_edition}Holographic'},
    }
    G.localization.descriptions.Joker['PT_WeaponsDealer9'] = {
        name = '{C:blue}Iwai',
        text = {'Chance to {C:attention}upgrade','all scoring cards','to {C:dark_edition}Holographic'},
    }
    G.localization.descriptions.Joker['PT_WeaponsDealerMAX'] = {
        name = '{C:red}Yakuza agent',
        text = {'Chance to {C:attention}upgrade','all scoring cards','to {C:dark_edition}Polychrome'},
    }
    G.localization.descriptions.Other['PT_Beyond_HangedMan'] = {
        name = 'Beyond',
        text = {'Each {C:purple}Hanged Man{} card played','from now gives {C:dark_edition}+1{} chance to transform','{C:inactive}(Currently {C:dark_edition}+#1# {C:inactive}transformations)'}
    }
    
    -- 13. BACK ALLEY DOCTOR
    G.localization.descriptions.Joker['PT_BackAlleyDoctor6-8'] = {
        name = 'Back alley doctor',
        text = {'{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult','per {C:purple}Tarot{} card used','{C:inactive}(Currently {C:chips}+#3# {C:inactive}Chips and {C:mult}+#4# {C:inactive}Mult)'},
    }
    G.localization.descriptions.Joker['PT_BackAlleyDoctor9'] = {
        name = '{C:blue}Takemi',
        text = {'{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult','per {C:purple}Tarot{} card used','{C:inactive}(Currently {C:chips}+#3# {C:inactive}Chips and {C:mult}+#4# {C:inactive}Mult)'},
    }
    G.localization.descriptions.Joker['PT_BackAlleyDoctorMAX'] = {
        name = '{C:red}Plague',
        text = {'{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult','per {C:purple}Tarot{} card used','{C:inactive}(Currently {C:chips}+#3# {C:inactive}Chips','and {C:mult}+#4# {C:inactive}Mult)'},
    }
    G.localization.descriptions.Other['PT_Beyond_Death'] = {
        name = 'Beyond',
        text = {'Each {C:purple}Death{} card played','from now gives {C:chips}+10{} Chips and {C:mult}+1{} Mult','{C:inactive}(Currently {C:chips}+#1# {C:inactive}and {C:mult}+#2#{C:inactive})'}
    }
    
    -- 14. TEACHER
    G.localization.descriptions.Joker['PT_Teacher9'] = {
        name = '{C:blue}Becky',
        text = {'Scoring cards give','{C:chips}+#1#{} Chips'},
    }
    G.localization.descriptions.Joker['PT_TeacherMAX'] = {
        name = '{C:red}Kawakami',
        text = {'Scoring cards give','{C:chips}+#1#{} Chips'},
    }
    G.localization.descriptions.Other['PT_Beyond_Temperance'] = {
        name = 'Beyond',
        text = {'Each {C:purple}Temperance{} card played','from now gives {C:chips}+10{} Chips','{C:inactive}(Currently {C:chips}+#1# {C:inactive}Chips)'}
    }

    -- 15. PAPARAZZA
    G.localization.descriptions.Joker['PT_Paparazza9'] = {
        name = '{C:blue}Ohya',
        text = {'Reduce required {C:attention}chip','{C:attention}score{} of {C:attention}Blinds','by #1#%'},
    }
    G.localization.descriptions.Joker['PT_PaparazzaMAX'] = {
        name = '{C:red}Truth finder',
        text = {'Reduce required {C:attention}chip','{C:attention}score{} of {C:attention}Blinds','by #1#%'},
    }
    G.localization.descriptions.Other['PT_Beyond_Devil'] = {
        name = 'Beyond',
        text = {'Each {C:purple}Devil{} card played','from now reduces required','{C:attention}chip score{} by 2%','{C:inactive}(Currently #1#%) (Max 60%)'}
    }
    
    -- 16. SKILLED GAMER
    G.localization.descriptions.Joker['PT_SkilledGamer4-6'] = {
        name = 'Skilled gamer',
        text = {'{C:blue}+1{} hand','each round'},
    }
    G.localization.descriptions.Joker['PT_SkilledGamer7-8'] = {
        name = 'Skilled gamer',
        text = {'{C:blue}+2{} hands','each round'},
    }
    G.localization.descriptions.Joker['PT_SkilledGamer9'] = {
        name = '{C:blue}Oda',
        text = {'{C:blue}+2{} hands','each round'},
    }
    G.localization.descriptions.Joker['PT_SkilledGamerMAX'] = {
        name = '{C:red}Arcade specialist',
        text = {'{C:blue}+3{} hands','each round'},
    }
    G.localization.descriptions.Other['PT_Beyond_Tower'] = {
        name = 'Beyond',
        text = {'Each {C:purple}Tower{} card played','from now adds {C:blue}+1{}','hand each round','{C:inactive}(Currently {C:blue}+#1#{C:inactive} hands)'}
    }
    
    -- 17. SHOGI PLAYER
    G.localization.descriptions.Joker['PT_ShogiPlayer4-6'] = {
        name = 'Shogi player',
        text = {'{C:red}+1{} hand','each round'},
    }
    G.localization.descriptions.Joker['PT_ShogiPlayer7-8'] = {
        name = 'Shogi player',
        text = {'{C:red}+2{} hands','each round'},
    }
    G.localization.descriptions.Joker['PT_ShogiPlayer9'] = {
        name = '{C:blue}Hifumi',
        text = {'{C:red}+2{} hands','each round'},
    }
    G.localization.descriptions.Joker['PT_ShogiPlayerMAX'] = {
        name = '{C:red}Strategist',
        text = {'{C:red}+3{} hands','each round'},
    }
    G.localization.descriptions.Other['PT_Beyond_Star'] = {
        name = 'Beyond',
        text = {'Each {C:purple}Star{} card played','from now adds {C:red}+1{}','hand each round','{C:inactive}(Currently {C:red}+#1#{C:inactive} hands)'}
    }
end