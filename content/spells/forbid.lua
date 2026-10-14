-- THANK YOU SO MUCH somethingcom515 for the choosing code!
SMODS.Consumable {
    key = 'forbid',
    set = 'shark_Spell',
    atlas = 'SharkSpells',
    pos = { x = 3, y = 2 },
    config = { selectable_tarots = 3, tarots = 5 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'shark_tooltip_forbidden', set = 'Other'}
        return { vars = { card.ability.selectable_tarots, card.ability.tarots } }
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
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                G.SETTINGS.paused = true
                G.GAME.shark_chosen_tarots = {}
                G.shark_tarotchoosecardarea = CardArea(
                    G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2,
                    G.ROOM.T.h,
                    5.3 * G.CARD_W,
                    1.03 * G.CARD_H,
                    {card_limit = 5, type = 'title', highlight_limit = 0, collection = true}
                )
                local tarots = {
                    n = G.UIT.R,
                    config = {align = 'cm', padding = 0, no_fill = true},
                    nodes = {
                        {n = G.UIT.O, config = {object = G.shark_tarotchoosecardarea}},
                    },
                }
                for i=1, 5 do
                    G.shark_tarotchoosecardarea:emplace(SMODS.create_card({set = 'Tarot', area = G.shark_tarotchoosecardarea}))
                end
                G.FUNCS.overlay_menu({
                    definition = create_UIBox_generic_options({
                        no_back = true,
                        snap_back = true,
                        contents = {
                            {
                                n = G.UIT.R,
                                config = {align = 'cm', minw = 2.5, padding = 0.1, r = 0.1, colour = G.C.BLACK, emboss = 0.05},
                                nodes = {tarots},
                            },
                        },
                    }),
                })
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return true
    end,
    credit = {
        art = "sushii64",
        code = "sushii64, somethingcom515",
        concept = "sushii64"
    }
}

local oldclick = Card.click
function Card:click()
    local g = oldclick(self)
    if G.GAME.shark_chosen_tarots and G.shark_tarotchoosecardarea and self.area == G.shark_tarotchoosecardarea then
        table.insert(G.GAME.shark_chosen_tarots, self.config.center.key)
        SMODS.destroy_cards(self)
        if #G.GAME.shark_chosen_tarots >= 3 then
            G.FUNCS.exit_overlay_menu()
            for _,v in ipairs(G.GAME.shark_chosen_tarots) do
                G.GAME.shark_forbidden_keys[v] = true
            end
        end
    end
    return g
end