SMODS.PokerHand {
    key = "straight_harmony",
    visible = false,
    mult = 7,
    chips = 80,
    l_mult = 3,
    l_chips = 30,
    example = {
        { 'shark_AP_Q', true },
        { 'shark_BA_J', true },
        { 'shark_SP_T', true },
        { 'shark_RA_9', true },
        { 'shark_GE_8', true },
        { 'shark_BU_7', true }
    },
    evaluate = function(parts, hand)
        if not next(parts._straight) or not next(parts.shark__harmony) then return {} end
        return { SMODS.merge_lists(parts._straight, parts.shark__harmony) }
    end
}