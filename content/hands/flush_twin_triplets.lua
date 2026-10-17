SMODS.PokerHand {
    key = "flush_twin_triplets",
    visible = false,
    mult = 15,
    chips = 150,
    l_mult = 5,
    l_chips = 45,
    example = {
        { 'shark_SP_A', true },
        { 'shark_SP_A', true },
        { 'shark_SP_A', true },
        { 'shark_SP_Q', true },
        { 'shark_SP_Q', true },
        { 'shark_SP_Q', true }
    },
    evaluate = function(parts, hand)
        if #parts._3 < 2 or not next(parts._flush) then return {} end
        return { SMODS.merge_lists(parts._all_pairs, parts._flush) }
    end
}