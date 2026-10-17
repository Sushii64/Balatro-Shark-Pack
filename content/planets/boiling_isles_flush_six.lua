SMODS.Consumable {
    key = "p_boiling_isles",
    set = "Planet",
    cost = 3,
    atlas = "SharkPlanets",
    pos = { x = 2, y = 0 },
    config = { hand_type = 'shark_flush_six', softlock = true },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.GAME.hands[card.ability.hand_type].level,
                localize(card.ability.hand_type, 'poker_hands'),
                G.GAME.hands[card.ability.hand_type].l_mult,
                G.GAME.hands[card.ability.hand_type].l_chips,
                colours = { (G.GAME.hands[card.ability.hand_type].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[card.ability.hand_type].level)]) }
            }
        }
    end,
    -- in_pool = function (self, args)
    --     return G.GAME.used_vouchers["v_shark_unicorn_horn"]
    -- end,
    credit = {
        art = "sushii64",
        code = "sushii64",
        concept = "sushii64"
    },
}