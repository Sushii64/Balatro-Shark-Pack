SMODS.Suit {
    key = 'Sparkles',
    card_key = 'SP',
    lc_atlas = 'SharkSuits',
    hc_atlas = 'SharkSuits',
    lc_ui_atlas = 'SharkSuitsUI',
    hc_ui_atlas = 'SharkSuitsUI',
    pos = { y = 0 },
    ui_pos = { x = 0, y = 0 },
    lc_colour = HEX('ea428b'),
    hc_colour = HEX('ea428b'),
    in_pool = function(self, args)
        return G.GAME.selected_back_key and G.GAME.selected_back_key.key == "b_shark_harmony" and (not args or not args.initial_deck)
    end,
}
SMODS.Suit {
    key = 'Balloons',
    card_key = 'BA',
    lc_atlas = 'SharkSuits',
    hc_atlas = 'SharkSuits',
    lc_ui_atlas = 'SharkSuitsUI',
    hc_ui_atlas = 'SharkSuitsUI',
    pos = { y = 3 },
    ui_pos = { x = 0, y = 1 },
    lc_colour = HEX('f28ccc'),
    hc_colour = HEX('f28ccc'),
    in_pool = function(self, args)
        return G.GAME.selected_back_key and G.GAME.selected_back_key.key == "b_shark_harmony" and (not args or not args.initial_deck)
    end,
}
SMODS.Suit {
    key = 'Apples',
    card_key = 'AP',
    lc_atlas = 'SharkSuits',
    hc_atlas = 'SharkSuits',
    lc_ui_atlas = 'SharkSuitsUI',
    hc_ui_atlas = 'SharkSuitsUI',
    pos = { y = 5 },
    ui_pos = { x = 2, y = 1 },
    lc_colour = HEX('ec3f41'),
    hc_colour = HEX('ec3f41'),
    in_pool = function(self, args)
        return G.GAME.selected_back_key and G.GAME.selected_back_key.key == "b_shark_harmony" and (not args or not args.initial_deck)
    end,
}
SMODS.Suit {
    key = 'Rainbows',
    card_key = 'RA',
    lc_atlas = 'SharkSuits',
    hc_atlas = 'SharkSuits',
    lc_ui_atlas = 'SharkSuitsUI',
    hc_ui_atlas = 'SharkSuitsUI',
    pos = { y = 2 },
    ui_pos = { x = 2, y = 0 },
    lc_colour = HEX('1b98d1'),
    hc_colour = HEX('1b98d1'),
    in_pool = function(self, args)
        return G.GAME.selected_back_key and G.GAME.selected_back_key.key == "b_shark_harmony" and (not args or not args.initial_deck)
    end,
}
SMODS.Suit {
    key = 'Butterflies',
    card_key = 'BU',
    lc_atlas = 'SharkSuits',
    hc_atlas = 'SharkSuits',
    lc_ui_atlas = 'SharkSuitsUI',
    hc_ui_atlas = 'SharkSuitsUI',
    pos = { y = 4 },
    ui_pos = { x = 1, y = 1 },
    lc_colour = HEX('69c8c3'),
    hc_colour = HEX('69c8c3'),
    in_pool = function(self, args)
        return G.GAME.selected_back_key and G.GAME.selected_back_key.key == "b_shark_harmony" and (not args or not args.initial_deck)
    end,
}
SMODS.Suit {
    key = 'Gemstones',
    card_key = 'GE',
    lc_atlas = 'SharkSuits',
    hc_atlas = 'SharkSuits',
    lc_ui_atlas = 'SharkSuitsUI',
    hc_ui_atlas = 'SharkSuitsUI',
    pos = { y = 1 },
    ui_pos = { x = 1, y = 0 },
    lc_colour = HEX('7dd1f5'),
    hc_colour = HEX('7dd1f5'),
    in_pool = function(self, args)
        return G.GAME.selected_back_key and G.GAME.selected_back_key.key == "b_shark_harmony" and (not args or not args.initial_deck)
    end,
}
