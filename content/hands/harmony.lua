SMODS.PokerHand {
    key = "Harmony",
    mult = 6,
    chips = 60,
    l_mult = 3,
    l_chips = 30,
    example = {
        { 'shark_AP_A', true },
        { 'shark_BA_K', true },
        { 'shark_SP_J', true },
        { 'shark_RA_8', true },
        { 'shark_GE_7', true },
        { 'shark_BU_3', true }
    },
    evaluate = function(parts, hand)
        local i = 1
        local cards = {}
        local has_apple = false
        local has_balloon = false
        local has_sparkle = false
        local has_rainbow = false
        local has_gemstone = false
        local has_butterfly = false
        for _, card in ipairs(hand) do
            if not has_apple and card:is_suit("shark_Apples") then
                cards[i] = card
                has_apple = true
                i = i + 1
            end
            if not has_balloon and card:is_suit("shark_Balloons") then
                cards[i] = card
                has_balloon = true
                i = i + 1
            end
            if not has_sparkle and card:is_suit("shark_Sparkles") then
                cards[i] = card
                has_sparkle = true
                i = i + 1
            end
            if not has_rainbow and card:is_suit("shark_Rainbows") then
                cards[i] = card
                has_rainbow = true
                i = i + 1
            end
            if not has_gemstone and card:is_suit("shark_Gemstones") then
                cards[i] = card
                has_gemstone = true
                i = i + 1
            end
            if not has_butterfly and card:is_suit("shark_Butterflies") then
                cards[i] = card
                has_butterfly = true
                i = i + 1
            end
            if has_apple and has_balloon and has_butterfly and has_gemstone and has_rainbow and has_sparkle then
                return { cards }
            end
        end
    end
}