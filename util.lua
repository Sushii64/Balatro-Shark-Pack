SHARK_UTIL = {}

SHARK_UTIL.SLIB = {}

-- CODE FROM HERE UNTIL NEXT COMMENT ABOUT THIS IS FROM SPECTRALLIB
-- THANKS GUYS
-- YAR FUCKING HAR
function SHARK_UTIL.SLIB.deck_effects(card, func)
	if not card.added_to_deck then
		return func(card)
	else
		card.from_quantum = true
		card:remove_from_deck(true)
		local ret = func(card)
		card:add_to_deck(true)
		card.from_quantum = nil
		return ret
	end
end
-- needed for compat
SHARK_UTIL.SLIB.with_deck_effects = SHARK_UTIL.SLIB.deck_effects

function SHARK_UTIL.SLIB.safe_get(t, ...)
	local current = t
	for _, k in ipairs({ ... }) do
		if not current or type(current) ~= "table" or current[k] == nil then
			return false
		end
		current = current[k]
	end
	return current
end

function Card:no(m, no_no)
	if no_no then
		return self.config.center[m] or SHARK_UTIL.SLIB.safe_get(G.GAME, m, self.config.center_key) or false --[[@as boolean|nil]]
	end
	return Card.no(self, "no_" .. m, true)
end

function SHARK_UTIL.SLIB.is_card_big(card)
	if not SHARK_UTIL.SLIB.can_mods_load({'Talisman'}) then
		return false
	end

	local center = card.config and card.config.center
	if not center then
		return false
	end

	if center.immutable and center.immutable == true then
		return false
	end

    -- im making bignums not work with Spectrallib. since i dont see the point
    -- could be changed but i dont feel like making 2 blacklists or making this mod use the Spectrallib table either
	if center.mod and not (SHARK_UTIL.SLIB or {}).mod_whitelist[center.mod.name] then
		return false
	end

	local in_blacklist = ((SHARK_UTIL.SLIB or {}).big_num_blacklist or {})[center.key or "Nope!"] or false

	return not in_blacklist
end

function SHARK_UTIL.SLIB.list_to_keys(list, all_values)
	if type(list) ~= "table" then return {} end
	if all_values == nil then all_values = true end
	local ret_table = {}
	for _,key in ipairs(list) do
		ret_table[key] = all_values
	end
	return ret_table
end

SHARK_UTIL.SLIB.base_values = {}

SHARK_UTIL.SLIB.misprintize_value_blacklist = SHARK_UTIL.SLIB.list_to_keys({
	"perish_tally", "id", "suit_nominal", "base_nominal", "face_nominal",
	"qty", "h_x_chips", "d_size", "h_size", "selected_d6_face",
	"cry_hook_id", "colour", "suit_nominal_original", "times_played",
	"extra_slots_used", "card_limit"
}, false)

SHARK_UTIL.SLIB.misprintize_bignum_blacklist = SHARK_UTIL.SLIB.list_to_keys({
	"odds", "cry_prob", "perma_repetitions", "repetitions", "nominal"
}, false)

SHARK_UTIL.SLIB.misprintize_value_cap = { --yeahh.. this is mostly just for retriggers, but i might as well make it fully functional
	perma_repetitions = 40,
	repetitions = 40,
}

function SHARK_UTIL.SLIB.deep_copy(obj, seen)
	if type(obj) ~= "table" then return obj end
	if seen and seen[obj] then return seen[obj] end

	local s = seen or {}
	local res = setmetatable({}, getmetatable(obj))
	s[obj] = res
	for k, v in pairs(obj) do
		res[SHARK_UTIL.SLIB.deep_copy(k, s)] = SHARK_UTIL.SLIB.deep_copy(v, s)
	end
	return res
end

function Card:get_nominal(mod)
	local mult = 1
	local rank_mult = 1
	if mod == "suit" then
		mult = 1000000
	end

	if self.ability.effect == "Stone Card" or (self.config.center.no_suit and self.config.center.no_rank) then
		mult = -10000
	elseif self.config.center.no_suit then
		mult = 0
	elseif self.config.center.no_rank then
		rank_mult = 0
	end

	local nominal = 10 * (self.base.id or 0.1) * rank_mult
		+ self.base.suit_nominal * mult
		+ (self.base.suit_nominal_original or 0) * 0.0001 * mult
		+ 10 * self.base.face_nominal * rank_mult
		+ 0.000001 * self.unique_val

	return to_number(nominal)
end

function SHARK_UTIL.SLIB.manipulate(card, args)
	if not card or not card.config or not card.config.center then return end
	if not (not Card.no(card, "immutable", true) or (args and args.bypass_checks)) then return end

	args = args or {
		min = G.GAME.modifiers.cry_misprint_min or 1,
		max = G.GAME.modifiers.cry_misprint_max or 1,
		dont_stack = true,
		no_deck_effects = true,
	}
	args.type = args.type or "X"

	-- If a center doesn't have its base values recorded yet,
	-- record it
	local center_config = copy_table(card.config.center.config)
	local center_key = card.config.center.key
	if not SHARK_UTIL.SLIB.base_values[center_key] then
		SHARK_UTIL.SLIB.base_values[center_key] = {}
		local recorded_config = SHARK_UTIL.SLIB.base_values[center_key]

		for config_key, config_value in pairs(center_config) do
			if SHARK_UTIL.SLIB.is_number(config_value) and config_value ~= 0 then
				recorded_config[config_key .. "ability"] = config_value
			elseif type(config_value) == "table" then
				for subability_key, subability_value in pairs(config_value) do
					recorded_config[subability_key .. config_key] = subability_value
				end
			end
		end
	end

	-- Where the manipulation actually occurs (called later)
	local func = function(cardd) -- cardd is effectively exactly card
		-- hardcoded whatever
		if cardd.config.center.set == "Booster" then
			args.big = false
		end

		-- maybe we could try and convince infinifusion folks to
		-- make this a patch instead of hardcoding this into default Spectrallib
		if cardd.infinifusion then
			if cardd.config.center == cardd.infinifusion_center or cardd.config.center.key == "j_infus_fused" then
				---@diagnostic disable-next-line: undefined-global
				calculate_infinifusion(cardd, nil, function(i)
					SHARK_UTIL.SLIB.manipulate(cardd, args)
				end)
			end
		end

		-- Manipulate values
		SHARK_UTIL.SLIB.manipulate_table(cardd, cardd, "ability", args)
		if cardd.base then
			SHARK_UTIL.SLIB.manipulate_table(cardd, cardd, "base", args)
		end

		-- Randomize cost
		if G.GAME.modifiers.cry_misprint_min then
			local misprint_seed = pseudoseed("cry_misprint" .. G.GAME.round_resets.ante)
			local logrnd_min = G.GAME.modifiers.cry_misprint_min
			local logrnd_max = G.GAME.modifiers.cry_misprint_max
			cardd.misprint_cost_fac = 1 / SHARK_UTIL.SLIB.log_random(misprint_seed, logrnd_min, logrnd_max)
			cardd:set_cost()
		end

		-- Set caps on all values
		local misprintize_caps = cardd.config.center.misprintize_caps or {}
		for ability_key, value_cap in pairs(misprintize_caps) do
			if (
				type(card.ability[ability_key]) == "table"
				and type(value_cap) == "table"
				and not SHARK_UTIL.SLIB.is_number(value_cap)
			) then
				for subability_key, subability_value_cap in pairs(value_cap) do
					if cardd.ability[ability_key][subability_key] > subability_value_cap then
						cardd.ability[ability_key][subability_key] = SHARK_UTIL.SLIB.sanity_check(subability_value_cap, SHARK_UTIL.SLIB.is_card_big(cardd))
					end
				end
			else
				if cardd.ability[ability_key] > value_cap then
					cardd.ability[ability_key] = SHARK_UTIL.SLIB.sanity_check(value_cap, SHARK_UTIL.SLIB.is_card_big(cardd))
				end
			end
		end
	end

	-- Finally perform manipulation
	if not args.bypass_checks and not args.no_deck_effects then
		SHARK_UTIL.SLIB.with_deck_effects(card, func)
	else
		func(card)
	end

	if card.ability.consumeable then
		for consumable_cfg_key in pairs(card.ability.consumeable) do
			card.ability.consumeable[consumable_cfg_key] = SHARK_UTIL.SLIB.deep_copy(card.ability[consumable_cfg_key])
		end
	end

	--ew ew ew ew
		-- What makes this ew? 
	G.P_CENTERS[card.config.center.key].config = center_config

	return true
end

function SHARK_UTIL.SLIB.manipulate_table(card, ref_table, ref_value, args, full_path)
	full_path = full_path or ""
	if ref_value == "consumeable" then return end

	local base_values = SHARK_UTIL.SLIB.base_values[card.config.center.key]

	for tbl_key, tbl_value in pairs(ref_table[ref_value]) do
		if
			SHARK_UTIL.SLIB.is_number(tbl_value)
			and SHARK_UTIL.SLIB.misprintize_value_blacklist[tbl_key] ~= false
		then
			-- Determine which value to manipulate
			if (
				args.dont_stack
				and base_values
				and (
					base_values[tbl_key .. ref_value]
					or (ref_value == "ability" and base_values[tbl_key .. "consumeable"])
				)
			) then
				tbl_value = base_values[tbl_key .. ref_value] or base_values[tbl_key .. "consumeable"]
			end

			-- Proceed to manipulation
			if args.big ~= nil then
				ref_table[ref_value][tbl_key] = SHARK_UTIL.SLIB.manipulate_value(tbl_value, args, args.big, tbl_key, full_path.."."..tbl_key)
			else
				ref_table[ref_value][tbl_key] = SHARK_UTIL.SLIB.manipulate_value(tbl_value, args, SHARK_UTIL.SLIB.is_card_big(card), tbl_key, full_path.."."..tbl_key)
			end
		elseif (
			tbl_key ~= "immutable"
			and type(tbl_value) == "table"
			and SHARK_UTIL.SLIB.misprintize_value_blacklist[tbl_key] ~= false
		) then
			SHARK_UTIL.SLIB.manipulate_table(card, ref_table[ref_value], tbl_key, args, full_path.."."..tbl_key)
		end
	end
end

local manipulate_types = {
	["+"] = function (tbl_value, args, is_big, value_key)
		if not SHARK_UTIL.SLIB.is_number(args.value) then return end
		if tbl_value ~= 0 and tbl_value ~= 1 then
			return tbl_value + args.value
		end
	end,
	["X"] = function (tbl_value, args, is_big, value_key)
		if not SHARK_UTIL.SLIB.is_number(args.value) then return end
		if tbl_value ~= 0 and (tbl_value ~= 1 or (value_key ~= "x_chips" and value_key ~= "x_mult")) then
			return tbl_value * args.value
		end
	end,
	["^"] = function (tbl_value, args, is_big, value_key)
		if not SHARK_UTIL.SLIB.is_number(args.value) then return end
		return tbl_value ^ args.value
	end,
	["hyper"] = function (tbl_value, args, is_big, value_key)
		if (
			SHARK_UTIL.SLIB.can_mods_load("Talisman")
			and type(args.value) == "table"
			and args.value.arrows and args.value.height
		) then
			tbl_value = to_big(tbl_value)
			local arrows = args.value.arrows
			local height = to_big(args.value.height)
			return tbl_value:arrow(arrows, height)
		end
	end,
}

function SHARK_UTIL.SLIB.manipulate_value(tbl_value, args, is_big, value_key, full_path)
	if not SHARK_UTIL.SLIB.is_number(tbl_value) then return end

	-- Calculate new value
	if args.func then
		tbl_value = args.func(tbl_value, args, is_big, value_key, full_path)
	else
		local new_num
		if args.min and args.max then
			local seed = pseudoseed(args.seed or ("cry_misprint" .. G.GAME.round_resets.ante))
			local big_min = to_big(args.min)
			local big_max = to_big(args.max)
			local value = SHARK_UTIL.SLIB.log_random(seed, big_min, big_max)
			local operand
			if args.type == "hyper" and type(args.value) == "table" and args.value.arrows then
				operand = {arrows = args.value.arrows, height = value}
			else
				operand = value
			end
			new_num = (
				manipulate_types[args.type]
				and manipulate_types[args.type](tbl_value, {value=operand}, is_big, value_key)
				or nil
			)
		elseif args.value then
			new_num = (
				type(manipulate_types[args.type]) == "function"
				and manipulate_types[args.type](tbl_value, args, is_big, value_key)
				or nil
			)
		end
		if new_num then tbl_value = new_num end
	end

	-- Place cap on new value
	if SHARK_UTIL.SLIB.misprintize_value_cap[value_key] then
		tbl_value = math.min(tbl_value, SHARK_UTIL.SLIB.misprintize_value_cap[value_key])
	end

	-- Prevent blacklisted keys from being BigNum
	if SHARK_UTIL.SLIB.misprintize_bignum_blacklist[value_key] == false then
		tbl_value = to_number(tbl_value)
		return to_number(SHARK_UTIL.SLIB.sanity_check(tbl_value, false))
	end

	local val = SHARK_UTIL.SLIB.sanity_check(tbl_value, is_big)
	if -1e100 < val and val < 1e100 then
		return to_number(val)
	end
	return val
end

function SHARK_UTIL.SLIB.sanity_check(val, is_big)
	if not SHARK_UTIL.SLIB.can_mods_load("Talisman") then return val end

	if is_big then
		if not val or type(val) == "number" and (val < -1e300 or 1e300 < val) then
			val = 1e300
		end
		if SHARK_UTIL.SLIB.is_big(val) then
			return val
		end
		if val < -1e100 or 1e100 < val then
			return to_big(val)
		end
	end

	if not val or type(val) == "number" and (val < -1e300 or 1e300 < val)  then
		return 1e300
	end

	if SHARK_UTIL.SLIB.is_big(val) then
		if val > 1e300 then
			return 1e300
		end
		if val < -1e300 then
			return -1e300
		end
		return to_number(val)
	end

	return val
end

function SHARK_UTIL.SLIB.can_mods_load(...)
    local mods = {...}
    if type(mods[1]) == "table" then
        mods = mods[1] --[[@as string[] ]]
    end
    for _,mod_key in pairs(mods) do
        if (SMODS.Mods[mod_key] or {}).can_load then return true end
    end
end

function SHARK_UTIL.SLIB.is_number(x)
	return type(x) == "number" or SHARK_UTIL.SLIB.is_big(x)
end

local is_number = is_number or function(x) return type(x) == "number" end

function SHARK_UTIL.SLIB.is_big(x)
	return (type(x) == "cdata" and is_number(x)) or (is_big and is_big(x))
end
-- END OF SPECTRALLIB CODE.

local oldsmodsaddtopool = SMODS.add_to_pool
function SMODS.add_to_pool(prototype_obj, args)
	if G.GAME.shark_forbidden_keys and G.GAME.shark_forbidden_keys[prototype_obj.key] then
		return false
	end
    return oldsmodsaddtopool(prototype_obj, args)
end

local old_generate_card_ui = generate_card_ui
function generate_card_ui(center, ...)
    local full_ui_table = old_generate_card_ui(center, ...)
	if G.GAME.shark_forbidden_keys and G.GAME.shark_forbidden_keys[center.key] then
		old_generate_card_ui({key = 'shark_tooltip_forbidden', set = 'Other'}, full_ui_table)
	end
    return full_ui_table
end

SMODS.DrawStep {
    key = 'shark_forbid_debuff',
    order = 70,
    func = function(self)
        if G.GAME.shark_forbidden_keys and G.GAME.shark_forbidden_keys[self.config.center_key] then
            self.children.center:draw_shader('debuff', nil, self.ARGS.send_to_shader)
            if self.children.front and (self.ability.delayed or not self:should_hide_front()) then
                self.children.front:draw_shader('debuff', nil, self.ARGS.send_to_shader)
            end
		end
    end,
    conditions = { vortex = false, facing = 'front' },
}

function SHARK_UTIL.load_folder(path)
	local items = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. path)
	for _, item in ipairs(items) do
		assert(SMODS.load_file(path .. "/" .. item))()
	end
end

function SHARK_UTIL.load_folders(paths)
	for _, path in ipairs(paths) do
		SHARK_UTIL.load_folder(path)
	end
end