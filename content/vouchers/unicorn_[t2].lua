SMODS.Voucher {
    key = 'unicorn_horn',
    atlas = 'SharkVouchers',
    pos = { x = 2, y = 0 },
    redeem = function(self, card)
        SMODS.change_play_limit(1)
        SMODS.change_discard_limit(1)
    end,
}

SMODS.Voucher {
    key = 'merchant',
    atlas = 'SharkVouchers',
    pos = { x = 3, y = 0 },
    redeem = function(self, card)
        -- code here
    end,
}