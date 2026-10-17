SMODS.Consumable {
    key = "p_horsehead",
    set = "Planet",
    cost = 3,
    atlas = "SharkPlanets",
    pos = { x = 2, y = 1 },
    config = { hand_type = 'shark_straight_harmony', softlock = true },
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
    set_card_type_badge = function(self, card, badges)
        badges[#badges + 1] = create_badge(localize('k_shark_nebula'),
            get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.Planet.text_colour,
            1.2)
    end,
    credit = {
        art = "Le Ginger",
        code = "sushii64",
        concept = "sushii64"
    },
}