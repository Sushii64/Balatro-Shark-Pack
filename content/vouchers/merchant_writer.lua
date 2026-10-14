SMODS.Voucher {
    key = 'merchant',
    atlas = 'SharkVouchers',
    pos = { x = 0, y = 0 },
    redeem = function(self, card)
      G.GAME.shark_spell_rate = 1.5
    end,
}

SMODS.Voucher {
    key = 'writer',
    atlas = 'SharkVouchers',
    pos = { x = 1, y = 0 },
    requires = {
        'v_shark_merchant'
    },
    redeem = function(self, card)
      G.GAME.shark_spell_rate = 3
    end,
}