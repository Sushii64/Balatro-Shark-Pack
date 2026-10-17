SMODS.PokerHand {
    key = "six_of_a_kind",
    visible = false,
    mult = 13,
    chips = 135,
    l_mult = 2,
    l_chips = 45,
    example = {
        { 'shark_SP_A', true },
        { 'shark_GE_A', true },
        { 'shark_BA_A', true },
        { 'shark_AP_A', true },
        { 'shark_RA_A', true },
        { 'shark_BU_A', true }
    },
    evaluate = function(parts, hand)
        return parts.shark__6
    end,
    modify_display_text = function(self, cards, scoring_hand)
        local mane6 = true
        local harmony = false
        for _, v in ipairs(scoring_hand) do
            local rank = SMODS.Ranks[v.base.value]
            mane6 = mane6 and rank.key == 'Queen'
        end
        local has_apple = false
        local has_balloon = false
        local has_sparkle = false
        local has_rainbow = false
        local has_gemstone = false
        local has_butterfly = false
        for i, card in ipairs(scoring_hand) do
            if not has_apple and card:is_suit("shark_Apples") then
                has_apple = true
            end
            if not has_balloon and card:is_suit("shark_Balloons") then
                has_balloon = true
            end
            if not has_sparkle and card:is_suit("shark_Sparkles") then
                has_sparkle = true
            end
            if not has_rainbow and card:is_suit("shark_Rainbows") then
                has_rainbow = true
            end
            if not has_gemstone and card:is_suit("shark_Gemstones") then
                has_gemstone = true
            end
            if not has_butterfly and card:is_suit("shark_Butterflies") then
                has_butterfly = true
            end
            if has_apple and has_balloon and has_butterfly and has_gemstone and has_rainbow and has_sparkle 
            and #scoring_hand >= 6 then
                harmony = true
            end
        end
        if mane6 and harmony then
            return 'shark_mane_six'
        end
    end
}