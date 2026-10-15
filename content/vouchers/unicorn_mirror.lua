SMODS.Voucher {
    key = 'unicorn_horn',
    atlas = 'SharkVouchers',
    pos = { x = 2, y = 0 },
    redeem = function(self, card)
        SMODS.change_play_limit(1)
        SMODS.change_discard_limit(1)
    end,
    credit = {
        art = "Placeholder",
        code = "sushii64",
        concept = "sushii64"
    },
}

SMODS.Voucher {
    key = 'magic_mirror',
    atlas = 'SharkVouchers',
    pos = { x = 3, y = 0 },
    requires = {
        'v_shark_unicorn_horn'
    },
    redeem = function(self, card)
        for _, v in ipairs({"c_uranus", "c_planet_x", "c_eris"}) do
            G.GAME.shark_forbidden_keys[v] = true
        end
    end,
    credit = {
        art = "Placeholder",
        code = "sushii64",
        concept = "sushii64"
    },
}