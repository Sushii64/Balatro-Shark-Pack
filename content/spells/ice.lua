SMODS.Consumable {
    key = 'ice',
    set = 'shark_Spell',
    atlas = 'SharkSpells',
    pos = { x = 1, y = 0 },
    config = { max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = { key = 'eternal', set = 'Other' }
        return { vars = { card.ability.max_highlighted } }
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
        for i = 1, #G.jokers.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.jokers.highlighted[i]:juice_up(0.3, 0.5)
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.jokers.highlighted[i]:add_sticker("eternal", true)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.jokers:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    can_use = function(self, card)
        if not G.jokers or #G.jokers.highlighted <= 0 or #G.hand.highlighted > card.ability.max_highlighted then return false end
        for i = 1, #G.jokers.highlighted do if G.jokers.highlighted[i].ability.eternal then return false end end
        return true
    end,
    credit = {
        art = "sushii64",
        code = "sushii64",
        concept = "sushii64"
    },
}