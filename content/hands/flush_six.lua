SMODS.PokerHand {
    key = "flush_six",
    visible = false,
    mult = 17,
    chips = 170,
    l_mult = 3,
    l_chips = 60,
    example = {
        { 'shark_SP_A', true },
        { 'shark_SP_A', true },
        { 'shark_SP_A', true },
        { 'shark_SP_A', true },
        { 'shark_SP_A', true },
        { 'shark_SP_A', true }
    },
    evaluate = function(parts, hand)
        if not next(parts.shark__6) or not next(parts._flush) then return {} end
        return { SMODS.merge_lists(parts.shark__6, parts._flush) }
    end
}