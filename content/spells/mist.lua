SMODS.Consumable {
    key = 'mist',
    set = 'shark_Spell',
    atlas = 'SharkSpells',
    pos = { x = 0, y = 1 },
    config = { jokers = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_negative
        local is_plural = card.ability.jokers > 1
        return { vars = { card.ability.jokers, is_plural and "s" or "" } }
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
        for i=1,card.ability.jokers,1 do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    SMODS.add_card{ -- For a random one
                        set = "Joker", -- You can use a custom pool/ObjectType. See `What's a pool/set?`
                        key_append = "shark_mist", -- Optional, key for randomization/pool checking
                        edition = "e_negative",
                        force_stickers = { "eternal" }
                    }
                    return true
                end
            }))
        end
    end,
    can_use = function(self, card)
        return true
    end,
    credit = {
        art = "sushii64",
        code = "sushii64",
        concept = "sushii64"
    },
}