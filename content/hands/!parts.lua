SMODS.PokerHandPart {
    key = '_6',
    func = function(hand) return get_X_same(6, hand, true) end
}

SMODS.PokerHandPart {
    key = "_harmony",
    func = function(hand)
        local cards = {}
        local has_apple = false
        local has_balloon = false
        local has_sparkle = false
        local has_rainbow = false
        local has_gemstone = false
        local has_butterfly = false
        for i, card in ipairs(hand) do
            if not has_apple and card:is_suit("shark_Apples") then
                cards[i] = card
                has_apple = true
            end
            if not has_balloon and card:is_suit("shark_Balloons") then
                cards[i] = card
                has_balloon = true
            end
            if not has_sparkle and card:is_suit("shark_Sparkles") then
                cards[i] = card
                has_sparkle = true
            end
            if not has_rainbow and card:is_suit("shark_Rainbows") then
                cards[i] = card
                has_rainbow = true
            end
            if not has_gemstone and card:is_suit("shark_Gemstones") then
                cards[i] = card
                has_gemstone = true
            end
            if not has_butterfly and card:is_suit("shark_Butterflies") then
                cards[i] = card
                has_butterfly = true
            end
            if has_apple and has_balloon and has_butterfly and has_gemstone and has_rainbow and has_sparkle 
            and #hand >= 6 then
                return { cards }
            end
        end
        return {}
    end
}