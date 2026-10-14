SMODS.Joker {
    key = "juggling",
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    atlas = "SharkJokers",
    pos = { x = 2, y = 1 },
    config = { money = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.money
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:get_id() == 4
        and #context.full_hand >= 4 then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    dollars = card.ability.money
                }
            end
        end
    end,
    credit = {
        art = "Placeholder",
        code = "sushii64",
        concept = "Fazzie"
    },
}