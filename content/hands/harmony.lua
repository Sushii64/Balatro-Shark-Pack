SMODS.PokerHand {
    key = "harmony",
    mult = 6,
    chips = 60,
    l_mult = 2,
    l_chips = 20,
    example = {
        { 'shark_AP_A', true },
        { 'shark_BA_K', true },
        { 'shark_SP_J', true },
        { 'shark_RA_8', true },
        { 'shark_GE_7', true },
        { 'shark_BU_3', true }
    },
    evaluate = function(parts, hand)
        return parts.shark__harmony
    end
}