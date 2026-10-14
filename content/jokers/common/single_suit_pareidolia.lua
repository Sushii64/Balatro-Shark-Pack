SMODS.Joker {
    key = 'greed_parei',
    atlas = 'SharkJokers',
    pos = { x = 0, y = 0 },
    cost = 3,
    rarity = 1,
    credit = {
        art = "The Shrimp",
        code = "sushii64",
        concept = "sushii64"
    },
    attributes = {
        'diamonds'
    }
}

SMODS.Joker {
    key = 'lust_parei',
    atlas = 'SharkJokers',
    pos = { x = 1, y = 0 },
    cost = 3,
    rarity = 1,
    credit = {
        art = "The Shrimp",
        code = "sushii64",
        concept = "sushii64"
    },
    attributes = {
        'hearts'
    }
}

SMODS.Joker {
    key = 'wrath_parei',
    atlas = 'SharkJokers',
    pos = { x = 2, y = 0 },
    cost = 3,
    rarity = 1,
    credit = {
        art = "The Shrimp",
        code = "sushii64",
        concept = "sushii64"
    },
    attributes = {
        'spades'
    }
}

SMODS.Joker {
    key = 'glutton_parei',
    atlas = 'SharkJokers',
    pos = { x = 3, y = 0 },
    cost = 3,
    rarity = 1,
    credit = {
        art = "The Shrimp",
        code = "sushii64",
        concept = "sushii64"
    },
    attributes = {
        'clubs'
    }
}

local _is_face = Card.is_face
function Card:is_face(from_boss)
    if self.debuff and not from_boss then _is_face(self, from_boss) end
    if next(SMODS.find_card("j_shark_greed_parei")) and self:is_suit("Diamonds")
    or next(SMODS.find_card("j_shark_lust_parei")) and self:is_suit("Hearts")
    or next(SMODS.find_card("j_shark_wrath_parei")) and self:is_suit("Spades")
    or next(SMODS.find_card("j_shark_glutton_parei")) and self:is_suit("Clubs") then
        return true
    end
    return _is_face(self, from_boss)
end