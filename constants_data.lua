local constantData =
{
	base = "ModeRTS" ,
	autoLoad = true ,
	autoName = false
}

-- ------------------------------------------------------------------------------------------------
-- -------- 阵营数据结构 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------
-- 文件结构 :
-- - zdata
--     - force_阵营代码名称    阵营文件夹
--         - rts_data.lua      定义阵营 RTS 数据的数据包 , 返回一个表 , 所有最终数据要填充在表中
-- - zprototype
--     - force_阵营代码名称    阵营文件夹
--         - prototypes.lua    阵营的旗帜物品 , 建筑 , 单位 , 资源 , 矿物 , 以及其他杂项
-- ------------------------------------------------------------------------------------------------
-- 构建数据 :
--   data 模块 :
--     在 data 模块中 , zdata 文件夹中的 rts_data.lua 和 zprototype 文件夹中的所有文件会被装载
--     先是构建 constants
--     然后装载 rts_data.lua
--     接着创建阵营的物品分组 , 名称为 "simoderts-阵营名称"
--     最后装载 prototypes.lua
--   control 模块 :
--     在 control 模块中只有 zdata 文件夹中的文件会被装载
--     会按照 rts_data.lua 的顺序装载数据
-- ------------------------------------------------------------------------------------------------
-- 在 rts_data.lua 中定义的 RTS 数据包的标准格式均由下面的【标准数据包格式】模块给出
-- 当然这些是标准数据 , 可以添加其他的数据 , 那些数据也会被一并装载
-- 但是非标准数据并不会被框架读取 , 所以需要自行添加额外的控制脚本
-- ------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 基础参数
constantData.mapMaxSize = 4096
constantData.pointDistance = 32
constantData.tickCycleLength = 120

constantData.mapSurfaceName = "si-rts-map"
constantData.observerForce = "si-rts-observer"
constantData.gameForcePrefix = "si-rts-force-"

-- 自带的阵营列表
constantData.forceList = { "base" }

-- 数据系统
constantData.canLoad = true
constantData.mapData = {}
constantData.forceData = {}
constantData.typeData = {}
constantData.skillData = {}
constantData.resourceData = {}
constantData.oreData = {}

-- ------------------------------------------------------------------------------------------------
-- ------- 标准数据包格式 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 建筑数据的标准数据格式 , 使用的时候需要先 table.deepcopy()
-- 此处给出的是默认值
constantData.buildingData =
{
	dataType = "building" ,                      -- 数据类型 , 此项不要修改
	
	prototypeItemName = "prototype" ,            -- 实体物品原型的名称
	prototypeEntityName = "prototype" ,          -- 实体原型的名称
	prototypeRecipeName = "prototype" ,          -- 实体的建造配方原型的名称
	position = { 0 , 0 } ,                       -- 实体的坐标
	
	type = "ConstructionCenter" ,                -- 建筑类型 , 不是实体原型的建筑类型 , 是 RTS 系统中的建筑类型 , 可用值在下方列表中给出
	name = "construction-center" ,               -- 建筑数据的调用名称 , 这个要求是唯一的 , 注意别与其他类型或阵营的数据重名
	forceType = "base" ,                         -- 所属的 RTS 阵营类型
	technologyLevel = 0 ,                        -- 所属的科技等级 , 用于游戏模式设定
	generateElectricity = 0 ,                    -- 耗电 , 正数发电 , 负数耗电
	preConditions = nil ,                        -- 解锁建筑的条件 , 条件格式见下
	
	oreName = nil ,                              -- 需要的矿物数据的名称 , 这里是指消耗的地上的矿物 , 建造所消耗的资源由配方指定
	oreCount = 1 ,                               -- 上面需要的矿物的数量
	defaultRecipe = nil ,                        -- 工厂的默认配方 , 前提是支持配方逻辑 , 且不是 main 类型
	productType = SIFlags.productType.resource , -- 填 material 或 resource 或 unit , material 和 resource 会直接进仓库 , unit 会放出来
	autoCraft = false                            -- 是否会自动建造 , 否则需要在菜单中选择才会建造
}
constantData.buildingDataType =
{
	main = "MainConstructionCenter" ,     -- 建造中心 , 负责建造建筑
	mainSign = "MainConstructionSign" ,   -- 建造信标 , 负责创建建造区域
	mainWare = "MainWarehouse" ,          -- 仓库 , 负责存储资源和造好的建筑
	generator = "Generator" ,             -- 发电厂
	miner = "ResourceFactory" ,           -- 资源收集器 , 采矿机
	factoryInfantry = "FactoryInfantry" , -- 步兵工厂
	factoryVehicle = "FactoryVehicle" ,   -- 载具工厂
	factoryAirplane = "FactoryAirplane" , -- 飞机工厂
	factoryShip = "FactoryShip" ,         -- 船舶工厂
	research = "ResearchCenter" ,         -- 研究中心
	turret = "Turret" ,                   -- 炮塔
	auxiliaryWall = "AuxiliaryWall" ,     -- 围墙
	auxiliaryRadar = "AuxiliaryRadar"     -- 雷达
}
-- 单位数据的标准数据格式 , 使用的时候需要先 table.deepcopy()
constantData.unitData =
{
	dataType = "unit" ,                 -- 数据类型 , 此项不要修改
	
	prototypeItemName = "prototype" ,   -- 实体物品原型的名称
	prototypeEntityName = "prototype" , -- 实体原型的名称
	prototypeRecipeName = "prototype" , -- 实体的建造配方原型的名称
	position = { 0 , 0 } ,              -- 实体的坐标
	
	type = "UnitWorker" ,               -- 单位类型 , 不是实体原型的单位类型 , 是 RTS 系统中的单位类型 , 可用值在下方列表中给出
	name = "unit-worker" ,              -- 单位数据的调用名称 , 这个要求是唯一的 , 注意别与其他类型或阵营的数据重名
	forceType = "base" ,                -- 所属的 RTS 阵营类型
	technologyLevel = 0 ,               -- 所属的科技等级 , 用于游戏模式设定
	preConditions = nil ,               -- 解锁单位的条件 , 条件格式见下
	
	skills = {}                         -- 技能列表
}
constantData.unitDataType =
{
	worker = "UnitWorker" ,     -- 建造单元
	infantry = "UnitInfantry" , -- 步兵
	vehicle = "UnitVehicle" ,   -- 载具
	airplane = "UnitAirplane" , -- 飞机
	ship = "UnitShip" ,         -- 船舶
}
-- 技能数据的标准数据格式 , 使用的时候需要先 table.deepcopy()
constantData.skillData = 
{
	dataType = "skill" ,                    -- 数据类型 , 此项不要修改
	
	prototypeIconName = "prototype" ,       -- 图标物品原型的名称
	prototypeTechnologyName = "prototype" , -- 科技原型的名称
	
	type = "NormalSkill" ,                  -- 技能类型 , 不是实体原型的技能类型 , 是 RTS 系统中的技能类型 , 可用值在下方列表中给出
	name = "normal-skill" ,                 -- 技能数据的调用名称 , 这个要求是唯一的 , 注意别与其他类型或阵营的数据重名
	forceType = "base" ,                    -- 所属的 RTS 阵营类型
	technologyLevel = 0 ,                   -- 所属的科技等级 , 用于游戏模式设定
	preConditions = nil ,                   -- 解锁技能的条件 , 条件格式见下
	
	enabled = false ,                       -- 默认解锁状态
	effects = {} ,                          -- 技能效果
	lastTrigger = 0 ,                       -- 上次触发的时间 , game.tick
	coldDown = 0                            -- 冷却时间 , 冷却状态 = game.tick - skillData.lastTrigger > skillData.coldDown
}
constantData.skillDataType =
{
	normal = "SkillNormal" ,       -- 工具类型的技能
	active = "SkillActive" ,       -- 主动技能
	passive = "SkillPassive" ,     -- 被动技能
	technology = "SkillTechnology" -- 科技技能
}
-- 资源数据的标准数据格式 , 使用的时候需要先 table.deepcopy()
constantData.resourceData =
{
	dataType = "resource" ,           -- 数据类型 , 此项不要修改
	
	prototypeItemName = "prototype" , -- 物品原型的名称
	type = "ResourcePrivate" ,        -- 资源类型
	name = "resource-private" ,       -- 资源数据的调用名称 , 这个要求是唯一的 , 注意别与其他类型或阵营的数据重名
	forceType = "base" ,              -- 所属的 RTS 阵营类型
	
	worth = 1 ,                       -- 等价货币概念 , 1 单位资源能转换为多少标准等级货币 , 此项用于资源相关设置和贸易
	canTransaction = true             -- 是否可以用于贸易
}
constantData.resourceDataType =
{
	common = "ResourceCommon" , -- 公用资源
	private = "ResourcePrivate" -- 专用资源
}
-- 矿物数据的标准数据格式 , 使用的时候需要先 table.deepcopy()
constantData.constantData.oreData =
{
	dataType = "ore" ,                  -- 数据类型 , 此项不要修改
	
	prototypeEntityName = "prototype" , -- 实体原型的名称
	type = "OrePrivate" ,               -- 矿物类型
	name = "ore-private" ,              -- 矿物数据的调用名称 , 这个要求是唯一的 , 注意别与其他类型或阵营的数据重名
	forceType = "base" ,                -- 所属的 RTS 阵营类型
	
	spawnSettings = nil                 -- 矿物生成方式 , 用于随机地图
}
constantData.oreDataType =
{
	common = "OreCommon" , -- 公用矿物
	private = "OrePrivate" -- 专用矿物
}
-- 解锁条件的标准数据格式 , 使用的时候需要先 table.deepcopy()
-- 此处给出的是默认值 , 其中所有字段都可以是 nil
constantData.preConditionsData =
{
	buildingList =                          -- 需要拥有的建筑
	{
		operation = SIFlags.condition.And , -- 判断的运算符 , 可用值 and 和 or , 不支持其他值
		typeList =                          -- 建筑类型列表 , 类型和数量 , and 运算则需要全部满足 , or 则是只要满足一个即可
		{
			["construction-center"] = 1     -- 这里是需要一个建造中心  ,这里的名称是具体的建筑数据类型( buildingData.name ) , 而不是 buildingDataType 中的类型
		}
	} ,
	unitList =                              -- 需要拥有的单位 , 其他参数同上
	{
		operation = "and" ,
		typeList = {}
	} ,
	skillList =                             -- 需要拥有的技能 , 科技也算在技能中 , 未解锁的技能是不在判断列表中的
	{
		operation = "and" ,
		typeList =
		{
			["automation"] = true           -- true 表示就绪(研究完成) , false 表示冷却中(未研究完成) , 这些都是指已获得的技能
		}
	}
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 构建数据
function constantData.LoadDataFiles( forceList , constants )
	if not constants then constants = SIMODERTS end
	SIGen.Init( constants )
	local basePath = constants.base
	for i , v in pairs( forceList ) do
		SIMODERTS.currentLoadForce = v
		SIMODERTS.InitForceData( v , need( basePath.."/zdata/force_"..v.."/rts_data" ) )
		SIGen.NewGroup( "simoderts-"..v )
		need( basePath.."/zprototype/force_"..v.."/prototypes" )
	end
	SIGen.Finish()
end

function constantData.LoadControlFiles( forceList , constants )
	if not constants then constants = SIMODERTS end
	local basePath = constants.base
	for i , v in pairs( forceList ) do
		SIMODERTS.currentLoadForce = v
		SIMODERTS.InitForceData( v , need( basePath.."/zdata/force_"..v.."/rts_data" ) )
	end
end

function constantData.InitForceData( forceName , forceData )
	local newForceData = SIMODERTS.forceData[forceName]
	if newForceData then
		if not newForceData.buildingDataList then newForceData.buildingDataList = {} end
		if not newForceData.unitDataList then newForceData.unitDataList = {} end
		if not newForceData.skillDataList then newForceData.skillDataList = {} end
		if not newForceData.resourceDataList then newForceData.resourceDataList = {} end
		if not newForceData.oreDataList then newForceData.oreDataList = {} end
	else
		newForceData =
		{
			displayName = { "SIMODERTS.force-name-unknown" } ,
			buildingDataList = {} ,
			unitDataList = {} ,
			skillDataList = {} ,
			resourceDataList = {} ,
			oreDataList = {}
		}
	end
	if forceData.displayName then newForceData.displayName = table.deepcopy( forceData.displayName ) end
	if forceData.startup then newForceData.startup = table.deepcopy( forceData.startup ) end
	if not SIMODERTS.typeData then SIMODERTS.typeData = {} end
	if forceData.buildingDataList then
		for name , data in pairs( forceData.buildingDataList ) do
			newForceData.buildingDataList[name] = data
			SIMODERTS.typeData[name] = data
		end
	end
	if forceData.unitDataList then
		for name , data in pairs( forceData.unitDataList ) do
			newForceData.unitDataList[name] = data
			SIMODERTS.typeData[name] = data
		end
	end
	if not SIMODERTS.skillData then SIMODERTS.skillData = {} end
	if forceData.skillDataList then
		for name , data in pairs( forceData.skillDataList ) do
			newForceData.skillDataList[name] = data
			SIMODERTS.skillData[name] = data
		end
	end
	if not SIMODERTS.resourceData then SIMODERTS.resourceData = {} end
	if forceData.resourceDataList then
		for name , data in pairs( forceData.resourceDataList ) do
			newForceData.resourceDataList[name] = data
			SIMODERTS.resourceData[name] = data
		end
	end
	if not SIMODERTS.oreData then SIMODERTS.oreData = {} end
	if forceData.oreDataList then
		for name , data in pairs( forceData.oreDataList ) do
			newForceData.oreDataList[name] = data
			SIMODERTS.oreData[name] = data
		end
	end
	if not SIMODERTS.forceData then SIMODERTS.forceData = {} end
	SIMODERTS.forceData[forceName] = newForceData
end

-- 查询数据
function constantData.FindTypeData( name , type )
	if SIMODERTS.typeData then
		for dataName , data in pairs( SIMODERTS.typeData ) do
			if dataName == name then
				if type then
					if data.type == type then return data end
				else return data end
			end
		end
	end
	return nil
end

function constantData.FindSkillData( name , type )
	if SIMODERTS.skillData then
		for dataName , data in pairs( SIMODERTS.skillData ) do
			if dataName == name then
				if type then
					if data.type == type then return data end
				else return data end
			end
		end
	end
	return nil
end

function constantData.FindResourceData( name , type )
	if SIMODERTS.resourceData then
		for dataName , data in pairs( SIMODERTS.resourceData ) do
			if dataName == name then
				if type then
					if data.type == type then return data end
				else return data end
			end
		end
	end
	return nil
end

function constantData.FindOreData( name , type )
	if SIMODERTS.oreData then
		for dataName , data in pairs( SIMODERTS.oreData ) do
			if dataName == name then
				if type then
					if data.type == type then return data end
				else return data end
			end
		end
	end
	return nil
end

return constantData