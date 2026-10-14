SMODS.Consumable {
    key = 'swap',
    set = 'shark_Spell',
    atlas = 'SharkSpells',
    pos = { x = 4, y = 1 },
    config = { jokers = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.jokers } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i=1, #G.jokers.highlighted do
            negative = false
            if G.jokers.highlighted[i].edition then
                if G.jokers.highlighted[i].edition.key == "e_negative" then
                    negative = true
                end
            end
            SMODS.destroy_cards(G.jokers.highlighted[i])
            if negative then SMODS.add_card({ set = 'Joker', edition = 'e_negative' })
            else SMODS.add_card({ set = 'Joker' }) end
        end
        delay(0.5)
    end,
    can_use = function(self, card)
        if #G.jokers.highlighted <= 0 then return false end
        -- if #G.jokers.cards + G.GAME.joker_buffer >= G.jokers.config.card_limit then return false end
        return true
    end,
    credit = {
        art = "sushii64",
        code = "sushii64",
        concept = "sushii64"
    },
}