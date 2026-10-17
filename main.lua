assert(SMODS.load_file("util.lua"))()
assert(SMODS.load_file("content/atlas.lua"))()

G.C.SHARK_SPELL = HEX('8F82D1')
G.ARGS.LOC_COLOURS['shark_spell'] = G.C.SHARK_SPELL

SHARK_UTIL.load_folders({
    "content/jokers/common",
    "content/jokers/uncommon",
    "content/jokers/rare",
    "content/jokers/legendary",
    "content/spells",
    "content/decks",
    "content/vouchers",
    "content/hands",
    "content/boosters",
    "content/planets",
    "content/tarots"
})
assert(SMODS.load_file("content/suits.lua"))()

SMODS.current_mod.reset_game_globals = function(run_start)
    if run_start then
        if not G.GAME.shark_forbidden_keys then
            G.GAME.shark_forbidden_keys = {}
        end
    end
end