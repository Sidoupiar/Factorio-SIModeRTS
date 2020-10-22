-- ------------------------------------------------------------------------------------------------
-- ---------- 数据结构 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

defaultForceList = { "player" , "enemy" , "neutral" , SIMODERTS.observerForce }

function InitMainData()
	local mainData = {}
	mainData.gamePauseFlag = false
	mainData.gameRunTick = game.tick
	local forceDataList = {}
	for name , force in pairs( game.forces ) do
		if not table.Has( defaultForceList , name ) then
			local forceData =
			{
				electricity = 0 ,
				spawn = { 0 , 0 } ,
				forceType = "base" ,
				statistics =
				{
					buildingCount = 0 ,
					destroyCount = 0
					-- 添加其他数据
				} ,
				buildings = {}
			}
			for index , typeName in pairs( SIMODERTS.buildingList ) do forceData.buildings[typeName] = {} end
			-- 添加其他数据
			forceDataList[name] = forceData
		end
	end
	SetGlobalData( "mainData" , mainData )
	SetGlobalData( "forceDataList" , forceDataList )
end

function CalculateElectricity()
	local forceDataList = GetGlobalData( "forceDataList" )
	if forceDataList then
		for name , forceData in pairs( forceDataList ) do
			local electricity = forceData.electricity or 0
			for index , buildingData in pairs( forceData.buildings ) do electricity = electricity + buildingData.generateElectricity end
			forceData.electricity = electricity
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 刷新方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function TickAction()
	local currentTick = math.fmod( event.tick , SIMODERTS.tickCycleLength )
	local surface = game.get_surface( SIMODERTS.mapSurfaceName )
	local forceDataList = GetGlobalData( "forceDataList" )
	if forceDataList then
		for name , forceData in pairs( forceDataList ) do
			for index = currentTick , #forceData.buildings , SIMODERTS.tickCycleLength do
				local buildingData = forceData.buildings[index]
				if buildingData and buildingData.index then
					local entity = surface.find_entity( buildingData.name , buildingData.position )
					if entity and entity.active then
						-- 设备运行处理
					end
				end
			end
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function AddBuilding( entity )
	local surface = game.get_surface( SIMODERTS.mapSurfaceName )
	if entity.surface.index == surface.index then
		
	end
end

function RemoveBuilding( force , entity )
	local surface = game.get_surface( SIMODERTS.mapSurfaceName )
	if entity.surface.index == surface.index then
		
	end
end

function StartGame()
	if GetGlobalData( "mainData" ) then GetGlobalData( "mainData" ).gamePauseFlag = false
	else InitMainData() end
	script.on_event( SIEvents.on_tick , TickAction )
end

function PauseGame()
	GetGlobalData( "mainData" ).gamePauseFlag = true
	script.on_event( SIEvents.on_tick , nil )
end