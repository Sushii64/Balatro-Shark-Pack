SMODS.PokerHand {
    key = "three_pair",
    mult = 2,
    chips = 35,
    l_mult = 1,
    l_chips = 30,
    example = {
        { 'shark_AP_A', true },
        { 'shark_GE_A', true },
        { 'shark_BU_3', true },
        { 'shark_SP_3', true },
        { 'shark_SP_Q', true },
        { 'shark_RA_Q', true }
    },
    evaluate = function(parts, hand)
        if #parts._2 < 3 then return {} end
        return parts._all_pairs
    end
}