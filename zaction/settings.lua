-- ------------------------------------------------------------------------------------------------
-- ---------- 存档参数 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function AddSettingFlagData()
	local settingFlagData = {}
	settingFlagData.name = "SIModeRTS"
	settingFlagData.version = game.active_mods["SIModeRTS"]
	SetGlobalData( "SettingFlagData" , settingFlagData )
end

function HasSettingFlagData()
	local settingFlagData = GetGlobalData( "SettingFlagData" )
	if settingFlagData then return true
	else return false end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 地图参数 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function CheckMapData()
	if not SIMODERTS.mapData.name then SIMODERTS.mapData.name = { "SIMODERTS.scenario-unknown" } end
	if SIMODERTS.mapData.spawnPoints then
		for i , spawnPoint in pairs( SIMODERTS.mapData.spawnPoints ) do
			if math.abs( spawnPoint.x ) >= SIMODERTS.mapData.width/2 or math.abs( spawnPoint.y ) >= SIMODERTS.mapData.height/2 then table.remove( SIMODERTS.mapData.spawnPoints , i ) end
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 制定规则 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------------
-- ---------- 单位参数 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------
