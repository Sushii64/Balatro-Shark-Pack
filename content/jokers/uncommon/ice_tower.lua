SMODS.Joker {
    key = "ice_tower",
    blueprint_compat = true,
    rarity = 2,
    cost = 5,
    atlas = "SharkJokers",
    pos = { x = 0, y = 1 },
    config = { extra = { xmult = 1.2 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = { key = 'eternal', set = 'Other' }
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.other_joker and SMODS.is_eternal(context.other_joker, self) then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    credit = {
        art = "Placeholder",
        code = "sushii64",
        concept = "sushii64"
    },
}