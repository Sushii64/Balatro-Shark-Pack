SMODS.Joker {
    key = "emoji",
    blueprint_compat = true,
    rarity = 1,
    cost = 3,
    atlas = "SharkJokers",
    pos = { x = 1, y = 1 },
    config = { extra = { chips = 39, mult = 53 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end,
    credit = {
        art = "Google",
        code = "sushii64",
        concept = "sushii64"
    },
}