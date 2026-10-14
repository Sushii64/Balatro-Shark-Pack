SMODS.Joker {
    key = "sandcastle",
    blueprint_compat = true,
    rarity = 3,
    cost = 6,
    atlas = "SharkJokers",
    pos = { x = 3, y = 1 },
    config = { extra = { id = 0 } },
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            _card = copy_card(context.other_card)
            _card.states.visible = false
            _card.ability["from_sandcastle"..card.ability.extra.id] = true
            table.insert(G.shark_sandcastle_storage.cards, _card)
        end
        if context.destroy_card and context.cardarea == G.play then
            return { remove = true }
        end
        if context.selling_self then
            local cards_to_remove = {}
            for _, playing_card in ipairs(G.shark_sandcastle_storage.cards) do
                if playing_card.ability["from_sandcastle"..card.ability.extra.id] then
                    table.insert(G.playing_cards, playing_card)
                    playing_card:add_to_deck()
                    table.insert(cards_to_remove, playing_card)
                end
            end
            for _, playing_card in ipairs(cards_to_remove) do
                G.shark_sandcastle_storage:remove_card(playing_card)
                G.deck:emplace(playing_card)
            end
        end
    end,
    add_to_deck = function(self,card,context)
        G.GAME.shark_sandcastle_count = (G.GAME.shark_sandcastle_count or 0) + 1
        card.ability.extra.id = G.GAME.shark_sandcastle_count
    end,
    credit = {
        art = "weird mal",
        code = "sushii64",
        concept = "Fazzie"
    },
}

SMODS.current_mod.custom_card_areas = function(game)
    game.shark_sandcastle_storage = CardArea(
        2,
        2,
        game.CARD_W * 1.9,
        game.CARD_H * 0.95,
        {
            highlighted_limit = 0,
            card_limit = 10000,
            type = 'joker'
        }
    )
    game.shark_sandcastle_storage.states.visible = false
end