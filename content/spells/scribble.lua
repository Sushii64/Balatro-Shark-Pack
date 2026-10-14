SMODS.Consumable {
    key = 'scribble',
    set = 'shark_Spell',
    atlas = 'SharkSpells',
    pos = { x = 5, y = 1 },
    config = { spells = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.spells } }
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
        for i=1,card.ability.spells do
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.add_card {
                                    set = 'shark_Spell',
                                    key_append = 'shark_scribble' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                                }
                                G.GAME.consumeable_buffer = 0
                                return true
                            end
                        }))
                        return true
                    end)
                }))
            end
        end
        delay(0.5)
    end,
    can_use = function(self, card)
        if #G.consumeables.cards + G.GAME.consumeable_buffer >= G.consumeables.config.card_limit then return false end
        return true
    end,
    credit = {
        art = "sushii64",
        code = "sushii64",
        concept = "sushii64"
    },
}