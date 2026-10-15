SMODS.Back {
    key = "harmony",
    atlas = "SharkDecks",
    pos = { x = 1, y = 0 },
    config = { voucher = 'v_shark_unicorn_horn' },
    apply = function(self, back)
        if not G.GAME.shark_forbidden_keys then G.GAME.shark_forbidden_keys = {} end
        local suits = {'Spades', 'Hearts', 'Clubs', 'Diamonds'}
        for _, suit in ipairs(suits) do
            for _, v in ipairs(SMODS.get_attribute_pool(suit:lower())) do
                G.GAME.shark_forbidden_keys[v] = true
                G.GAME.shark_forbidden_keys[suit] = true
            end
        end
        G.E_MANAGER:add_event(Event({
            func = function()
                if not G.playing_cards then return false end
                for _, suit in ipairs({"shark_Sparkles", "shark_Balloons", "shark_Apples", "shark_Rainbows", "shark_Butterflies", "shark_Gemstones"}) do
                    for _, rank in ipairs(SMODS.Rank.obj_buffer) do
                        SMODS.add_card({set = "Base", rank = rank, suit = suit, area = G.deck})
                    end
                end
				return true
            end
        }))
    end,
    credit = {
        art = "The Shrimp",
        code = "sushii64",
        concept = "sushii64"
    },
}