local UTIL = load(NFS.read(SMODS.current_mod.path .. 'util/util.lua'))()

SMODS.Back {
    key = 'PhantomDeck',
    loc_txt = {
        name = 'Phantom Deck',
        text = {
            'Start with {C:attention}Igor{},',
            '{C:attention}+1{} consumable slot',
        },
    },
    atlas = 'Decks',
    pos = {x = 0, y = 0},
    unlocked = true,
    discovered = false,
    apply = function(self)
        UTIL.createJoker('j_PT_Igor')
        UTIL.addConsumeableSlots(1)
    end
}