# How to keep things organized

*I have to add the description of PT_JokerTemplate.lua* to this guide, but I think you can grasp its purpose even without my help.
## The main idea
I don't like having single long files with all the functions inside.
Whenever you need to modify something you need to scroll back and fourth on it and it looks messy in my opinion.
**Multiple short files is better than Single long file** 
The repo only has the main file (*Phantom Thieves Mod.lua*) on it, the rest is in its own folder.

Another concept is that whenever multiple lines of code are used many times, they are condensed into a *util* function. An example is the `rankUp()` function held inside `utils/PT_util.lua` and called by every Joker.
## Jokers
The main file adds the `SMODS.Joker` for every Joker, but the `calculate` functions are in their own file.
An example is the line Robin Hood, Loki, Hereward (which is a line of connected Jokers because the first evolves into the second and then into the third). All these Jokers are added inside the main file, but their `calculate` functions are like this
```lua
calculate = function(self,card,context) -- Robin Hood Joker
	if context.setting_blind then
		pt_RobinHood.RoundStart(card,rank)
	end
	if context.end_of_round and not context.game_over then
		pt_RobinHood.RoundWon(card,rank)
	end
	if context.selling_self then
		pt_RobinHood.SellingSelf(card,rank)
	end
	if context.using_consumeable then
		if context.consumeable.ability.name == 'Justice' then
			pt_util.rankUp(card)
		end
		if card.ability.extra.Rank == 9 then
			pt_util.evolve(card,'j_PT_Loki')
		end
	end
end
```
	and all the `pt_RobinHood` functions are held inside `jokers_func/PT_RobinHood.lua`.
## Global variables
Whenever I need to use variables that are used by multiple functions or in multiple files, I like to make global variables at the top of the file. An example of this concept is the start of `PT_RobinHood.lua`:
```lua
G.J08_RobinHood_Vars = {
	J08_canBetrayalSpawn = false,
	J08_roundsCounter = 0,
}

function PT_ROBINHOOD.resetGlobalVars()
	G.GAME.J08_canBetrayalSpawn = false
	G.GAME.J08_roundsCounter = 0
end
)
```
This Joker line sets the `canBetrayalSpawn` variable to `true` whenever Robin Hood or Loki are held for 5 rounds or more. The `resetGlobalVars()` is called whenever a new run is started to set the global variables to their initial state.
The `J08_` prefix is added to explain which Joker initializes that variable (Robin Hood's linked tarot is Justice, the tarot number 8).
## Util files
In this sections I will explain all the files inside the `utils/` folder.
### Util
The functions that are used the most by Jokers' abilities are held inside `utils/PT_util.lua`.
Here you can find `rankUp()`, `evolve()` and other common functions.

The function `PT_UTIL.resetGlobalVars()` also calls all the other `resetGlobalVars()` functions inside all the other helper files.
### Loader
I understand that all these helper files have to be called inside the main file to work, and the code
```lua
pt_util = require(SMODS.current_mod.path.."/utils/PT_util")
pt_manageCards = require(SMODS.current_mod.path.."/utils/PT_manageCards")
pt_gameModifiers = require(SMODS.current_mod.path.."/utils/PT_gameModifiers")
...
```
is a very big chunk of code to add at the start of the main file.
Solution?
The file `utils/PT_loader.lua`
The main file only calls the Loader, and the Loader calls all the other files of the repo. Easy.
### Game modifiers
All the functions that modify already existing functions in the game are held inside `utils/PT_gameModifiers.lua`. An example is
```lua
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
```
That adds new lines of code to the already existing `G.FUNCS.use_card` function, making it call `pt_util.tarotUsed(card)` whenever a tarot is used.
### Manage cards
All the functions that add, remove or modify cards are held inside `utils/PT_manageCards.lua`.
Here you can find `createJoker()`, `destroyJoker()`, `createConsumable()` and so on.