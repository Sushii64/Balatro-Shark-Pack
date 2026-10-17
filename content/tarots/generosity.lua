SMODS.Consumable {
    key = 't_generosity',
    set = 'Tarot',
    atlas = "SharkTarots",
    pos = { x = 0, y = 0 },
    config = { max_highlighted = 3, suit_conv = 'shark_Gemstones' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted, localize(card.ability.suit_conv, 'suits_plural'), colours = { G.C.SUITS[card.ability.suit_conv] } } }
    end,
    in_pool = function (self, args)
        return false and G.GAME.selected_back_key.key == "b_shark_harmony"
    end
}