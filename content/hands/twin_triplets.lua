SMODS.PokerHand {
    key = "twin_triplets",
    mult = 5,
    chips = 50,
    l_mult = 2,
    l_chips = 25,
    example = {
        { 'shark_AP_A', true },
        { 'shark_GE_A', true },
        { 'shark_BU_A', true },
        { 'shark_SP_Q', true },
        { 'shark_SP_Q', true },
        { 'shark_RA_Q', true }
    },
    evaluate = function(parts, hand)
        if #parts._3 < 2 then return {} end
        return parts._all_pairs
    end
}