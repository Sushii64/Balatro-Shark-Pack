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
        for _, v in ipairs(scoring_hand) do
            local rank = SMODS.Ranks[v.base.value]
            mane6 = mane6 and rank.key == 'Queen'
        end
        if mane6 then
            return 'shark_mane_six'
        end
    end
}