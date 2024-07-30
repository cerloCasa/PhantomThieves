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
        text = {'All {C:red}Phantom Thieves{}','Jokers can\'t be below','Rank #1#'},
    }
    G.localization.descriptions.Joker['PT_Igor9'] = {
        name = '{C:blue}Igor',
        text = {'All {C:red}Phantom Thieves{}','Jokers can\'t be below','Rank 9'},
    }
    G.localization.descriptions.Joker['PT_IgorMAX'] = {
        name = '{C:red}Igor',
        text = {'All {C:red}Phantom Thieves{}','Jokers can\'t be below','Rank Max'},
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
end