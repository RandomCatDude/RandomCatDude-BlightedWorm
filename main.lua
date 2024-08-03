local function blightify()
	local blight = gm.elite_type_find("blighted")
	if not blight then
		log.error("blighted elite type can't be found????")
		return
	end

	local monster_cards = gm.variable_global_get("class_monster_card")
	for i=1, #monster_cards do
		local card = monster_cards[i]
		if monster_cards[i][5] == gm.constants.oWorm then
			gm.array_set(card, 8, true) -- can_be_blighted
			local worm_elite_list = gm.array_get(card, 7) -- elite_list
			gm.ds_list_add(worm_elite_list, blight)
		end
	end
	log.info("the Worm awaits..")
end

local hooks = {}

gm.pre_code_execute(function(self, other, code, result, flags)
    if hooks[code.name] then
        hooks[code.name](self)
    end
end)

hooks["gml_Object_oStartMenu_Step_2"] = function(self)
    hooks["gml_Object_oStartMenu_Step_2"] = nil
    blightify()
end
