require( "__SICoreFunctionLibrary__/util" )

need( "__SICoreFunctionLibrary__/define/load" )
need( "__SICoreFunctionLibrary__/function/load" )
need( "__SICoreFunctionLibrary__/runtime/globalData" )

load()

-- ------------------------------------------------------------------------------------------------
-- ---------- 使用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------
-- 对于自建场景 , 请使用如下代码
-- require( "__SIModeRTS__/scenarios_main_control" )
-- ------------------------------------------------------------------------------------------------
-- 如果想在原版或其他 MOD 添加的场景中使用
-- 则需要创建一个附属 MOD 并在 MOD 中的 control.lua 中写入上面的代码
-- ------------------------------------------------------------------------------------------------
-- 引用完主要框架后还需要设置【主要的地图参数】和【额外的地图参数】
--   【主要的地图参数】用于确定地图的基本信息
--   【额外的地图参数】用于确定各个势力的作战起始位置 , 可用的科技水平 , 资源比例等设置
-- 如果没有设置【额外的地图参数】 , 则在游戏开始的时候 , 会强制要求玩家进行一定的设置
-- 所有参数设置完毕后才能正常进行游戏
-- ------------------------------------------------------------------------------------------------
-- 【主要的地图参数】 :
-- 必要参数 :
--   name        地图的名称 , 用于各种消息显示 , 语言字符串 , 需要加大括号
-- 可选参数 :
--   width       地图宽度 , 不能超过 4096 格 , 这里设置的是最大值
--   height      地图高度 , 不能超过 4096 格 , 这里设置的是最大值
--   resizeMap   当地图宽高与给定宽高最大值的不一致时 , 是否自动重置地图宽高为最大值 , 默认不重置
-- 如果缺少必要的主要参数 , 则会由框架自动赋予默认值
-- ------------------------------------------------------------------------------------------------
-- 【额外的地图参数】 :
-- 允许的阵营 :
--   SetMapAllowForceType( 阵营列表 )
--   默认是全部阵营可用
--   如果设置了 , 则可用的阵营是【系统中存在的阵营组成的列表】和【这里输入的阵营列表】的交集
-- 科技等级 :
--   SetMapAllowTechnologyLevel( 等级 )
--   超过(大于)科技等级的建筑将无法建造
-- 出生点 :
--   AddMapSpawnPoint( 名称 , x坐标 , y坐标 , 是否在附近生成矿物 , 是否清除障碍物和水 )
--   每增加一个出生点 , 就意味着可以多一名玩家
--   每名玩家占用一个出生点
--   当没有出生点时 , 将无法开始游戏 , 这时候框架就会要求玩家自己指定出生点
--   当存在出生点时 , 如果玩家数量超过出生点的数量 , 开始游戏后 , 没有出生点的玩家将成为【观察者】
--   所有出生点设置完毕后 , 且所有拥有出生点的玩家同意后 , 才能开始游戏
--   可以设置出生点附近自动生成或不生成矿物 , 缺少矿物会导致游戏无法正常进行
--   可以设置是否清除出生点附近的障碍物和水 , 基地不能建造在水上
--   【名称】 , 【x 坐标】 , 【y 坐标】不能为空 , 默认在出生点附近生成矿物 , 并清除障碍物和水
--   【名称】为语言字符串 , 需要加大括号
-- ------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------------
-- ---------- 装载数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIMODERTS.LoadControlFiles( SIMODERTS.forceList )
need( "zaction/settings" )
need( "zaction/messages" )
need( "zaction/ai_lines" )
need( "zaction/data_pack" )
need( "zaction/event_player" )
need( "zaction/event_view" )
need( "zaction/event_build" )
need( "zaction/event_time" )
need( "zaction/event_control" )

-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 检测地图大小
local function SendMapErrorMessage( event )
	SendSystemMessage( "SIMODERTS.map-settings-unknown" )
	script.on_nth_tick( nil )
end

local function SendMapTooBigMessage( event )
	SendSystemMessage( "SIMODERTS.map-too-big" , tostring( SIMODERTS.mapData.width ) , tostring( SIMODERTS.mapData.height ) )
	script.on_nth_tick( nil )
end

local function SendMapResizeMessage( event )
	SendSystemMessage( "SIMODERTS.map-resize" , tostring( SIMODERTS.mapData.width ) , tostring( SIMODERTS.mapData.height ) )
	script.on_nth_tick( nil )
end

local function CheckSurfaceSize()
	local mapSurface = game.get_surface( SIMODERTS.mapSurfaceName )
	if mapSurface then
		local genSettings = mapSurface.map_gen_settings
		if genSettings then
			if genSettings.width > SIMODERTS.mapData.width or genSettings.height > SIMODERTS.mapData.height then
				script.on_nth_tick( 15 , SendMapTooBigMessage )
				SIMODERTS.canLoad = false
				return false
			end
		else
			script.on_nth_tick( 15 , SendMapErrorMessage )
			SIMODERTS.canLoad = false
			return false
		end
	else
		local mapGenSettings = nil
		for i , v in pairs( game.surfaces ) do
			if v then
				local genSettings = v.map_gen_settings
				if genSettings then
					if genSettings.width > SIMODERTS.mapData.width or genSettings.height > SIMODERTS.mapData.height then
						if not SIMODERTS.mapData.resizeMap then
							script.on_nth_tick( 15 , SendMapTooBigMessage )
							SIMODERTS.canLoad = false
							return false
						end
					end
					mapGenSettings = table.deepcopy( genSettings )
					break
				else
					script.on_nth_tick( 15 , SendMapErrorMessage )
					SIMODERTS.canLoad = false
					return false
				end
			end
		end
		local resizeFlag = false
		if mapGenSettings.width ~= SIMODERTS.mapData.width then
			mapGenSettings.width = SIMODERTS.mapData.width
			resizeFlag = true
		end
		if mapGenSettings.height ~= SIMODERTS.mapData.height then
			mapGenSettings.height = SIMODERTS.mapData.height
			resizeFlag = true
		end
		game.create_surface( SIMODERTS.mapSurfaceName , mapGenSettings )
		if resizeFlag then script.on_nth_tick( 15 , SendMapResizeMessage ) end
	end
	return true
end

-- 检测地图标记
local function SendMapLostDataMessage( event )
	SendSystemMessage( "SIMODERTS.map-lost-data" )
	script.on_nth_tick( nil )
end

local function CheckSettingFlagData()
	if not SIStartup.SIMODERTS.use_in_new_map() then
		if not HasSettingFlagData() then
			script.on_nth_tick( 15 , SendMapLostDataMessage )
			SIMODERTS.canLoad = false
			return false
		end
	end
	return true
end

-- 初始化
function OnInit()
	-- 检测存档情况
	if not CheckSurfaceSize() or not CheckSettingFlagData() then return end
	-- 添加地图标记
	AddSettingFlagData()
	-- 创建观察者组
	local observerForce = game.create_force( SIMODERTS.observerForce )
	observerForce.set_friend( "player" , false )
	observerForce.set_friend( "enemy" , false )
	observerForce.set_friend( "neutral" , false )
	observerForce.set_cease_fire( "player" , false )
	observerForce.set_cease_fire( "enemy" , false )
	observerForce.disable_all_prototypes()
	observerForce.share_chart = true
	observerForce.manual_mining_speed_modifier = -0.99999999
	-- 调整数据
	CalculateElectricity()
	OnLoad()
end

script.on_init( OnInit )
script.on_configuration_changed( OnInit )

-- ------------------------------------------------------------------------------------------------
-- ---------- 玩家事件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function LoadEventPlayer()
	script.on_event( SIEvents.on_player_created , EventPlayerCreated )
	script.on_event( SIEvents.on_pre_player_mined_item , EventPlayerPreMinedItem )
end

function UnloadEventPlayer()
	script.on_event( SIEvents.on_player_created , nil )
	script.on_event( SIEvents.on_pre_player_mined_item , nil )
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 界面事件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function LoadEventView()
	
end
function UnloadEventView()
	
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 建造事件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function LoadEventBuild()
	
end

function UnloadEventBuild()
	
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 时间事件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function LoadEventTime()
	
end

function UnloadEventTime()
	
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 控制事件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function LoadEventControl()
	
end

function UnloadEventControl()
	
end

-- ------------------------------------------------------------------------------------------------
-- -------- 载入存档事件 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function OnLoad()
	if SIMODERTS.canLoad then
		CheckMapData()
		
		LoadEventPlayer()
		LoadEventView()
		LoadEventBuild()
		LoadEventTime()
		LoadEventControl()
	else
		UnloadEventPlayer()
		UnloadEventView()
		UnloadEventBuild()
		UnloadEventTime()
		UnloadEventControl()
	end
end

script.on_load( OnLoad )

-- ------------------------------------------------------------------------------------------------
-- ---------- 地图数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SetMapMainData( mapMainData )
	for k , v in pairs( table.deepcopy( mapMainData ) ) do SIMODERTS.mapData[k] = v end
	if not SIMODERTS.mapData.width then SIMODERTS.mapData.width = SIMODERTS.mapMaxSize end
	if not SIMODERTS.mapData.height then SIMODERTS.mapData.height = SIMODERTS.mapMaxSize end
end

function SetMapAllowForceType( forceTypeList )
	if not forceTypeList or type( forceTypeList ) ~= "table" or #forceTypeList < 1 then return end
	SIMODERTS.mapData.forceTypeList = {}
	for i , v in pairs( forceTypeList ) do
		for n , m in pairs( SIMODERTS.forceList ) do
			if m == v then
				table.insert( SIMODERTS.mapData.forceTypeList , v )
				break
			end
		end
	end
end

function SetMapAllowTechnologyLevel( levelNumber )
	if levelNumber < 0 then return end
	SIMODERTS.mapData.technologyLevel = levelNumber
end

function AddMapSpawnPoint( name , x , y , spawnOre , clearObstacleAndWater , player )
	if not name or not x or not y then
		if player then SendWarning( player , "SIMODERTS.spawn-point-empty-data" ) end
		return
	end
	if math.abs( x ) >= SIMODERTS.mapData.width/2 or math.abs( y ) >= SIMODERTS.mapData.height/2 then
		if player then SendWarning( player , "SIMODERTS.spawn-point-position-out-of-bound" ) end
		return
	end
	if not SIMODERTS.mapData.spawnPoints then SIMODERTS.mapData.spawnPoints = {} end
	for i , point in pairs( SIMODERTS.mapData.spawnPoints ) do
		if point.name == name then
			if player then SendWarning( player , "SIMODERTS.spawn-point-name-duplicate" ) end
			return
		end
		if math.pow( math.pow( x-point.x , 2 )+math.pow( y-point.y , 2 ) , 0.5 ) < SIMODERTS.pointDistance then
			if player then SendWarning( player , "SIMODERTS.spawn-point-too-close" , tostring( SIMODERTS.pointDistance ) ) end
			return
		end
	end
	table.insert( SIMODERTS.mapData.spawnPoints ,
	{
		name = table.deepcopy( name ) ,
		x = x ,
		y = y ,
		spawnOre = spawnOre ,
		clearObstacleAndWater = clearObstacleAndWater
	} )
	if player then SendInformation( nil , "SIMODERTS.spawn-point-create" , player.name , name , tostring( x ) , tostring( y ) ) end
end