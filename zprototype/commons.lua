-- ------------------------------------------------------------------------------------------------
-- -------- 添加框架方法 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIGen.FillRTSDataEntity( itemName , rtsData )
	local currentData = SIGen.GetCurrentDataEntity()
	if table.Has( SITypes.entity , currentData:GetType() ) then
		local customData =
		{
			ingredient_count = 255 ,
			map_color = SIColors.baseColor.blue ,
			friendly_map_color = SIColors.baseColor.green ,
			enemy_map_color = SIColors.baseColor.red ,
			energy_source = SIPackers.EnergySource() ,
			minable = { mining_time = 10000 , result = name }
		}
		if rtsData then
			if rtsData.generateElectricity then customData.energy_usage = tostring( math.abs( rtsData.generateElectricity ) ) .. "KW" end
			if rtsData.defaultRecipe then
				customData.show_recipe_icon = false
				customData.fixed_recipe = rtsData.defaultRecipe
			end
		end
		SIGen.SetCustomData( customData ).SetItemName( itemName ).Fill()
	end
	return SIGen
end