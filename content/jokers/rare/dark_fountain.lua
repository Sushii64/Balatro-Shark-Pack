SMODS.Joker {
    key = "dark_fountain",
    config = {
        extra = {
            odds = 5,
        }
    },
    pos = {
        x = 4,
        y = 0
    },
    cost = 6,
    rarity = 3,
    atlas = 'SharkJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = { G.GAME.probabilities.normal, card.ability.extra.odds}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and context.game_over == false and G.GAME.blind.boss then
            if pseudorandom('shark_darkfountain') < G.GAME.probabilities.normal / card.ability.extra.odds then
                local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
                local eligible_card = pseudorandom_element(editionless_jokers, 'shark_darkfountain', {})
                if eligible_card then
                    eligible_card:set_edition('e_negative', true)
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.DARK_EDITION
                    }
                end
            end
        end
    end,
    credit = {
        art = "The Shrimp",
        code = "sushii64",
        concept = "sushii64"
    },
}