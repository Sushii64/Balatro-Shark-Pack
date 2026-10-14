SMODS.Joker {
    key = "spellcaster",
    blueprint_compat = true,
    rarity = 1,
    cost = 3,
    atlas = "SharkJokers",
    pos = { x = 5, y = 0 },
    config = { extra = { mult = 5 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.shark_spell or 0) * card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "shark_Spell" then
            return {
                message = localize {
                    type = 'variable',
                    key = 'a_mult',
                    vars = {
                        (G.GAME.consumeable_usage_total.shark_spell or 0) * card.ability.extra.mult
                    }
                },
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult *
                (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.shark_spell or 0)
            }
        end
    end,
    credit = {
        art = "sushii64",
        code = "sushii64",
        concept = "sushii64"
    },
}