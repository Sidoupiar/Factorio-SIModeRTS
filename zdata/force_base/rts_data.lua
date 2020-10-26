-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local forceName = SIMODERTS.currentLoadForce

local itemName = "si-rts-base-item-"
local entityName = "si-rts-base-entity-"
local recipeName = "si-rts-base-recipe-"
local iconName = "si-rts-base-icon-"
local technologyName = "si-rts-base-technology-"

-- ------------------------------------------------------------------------------------------------
-- ---------- 定义建筑 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 建造中心
local constructionCenter = table.deepcopy( SIMODERTS.buildingData )
constructionCenter.type = SIMODERTS.buildingDataType.main
constructionCenter.name = "construction-center"
constructionCenter.technologyLevel = 0
constructionCenter.generateElectricity = 20
constructionCenter.productType = SIFlags.productType.material

-- 建造信标
local constructionSign = table.deepcopy( SIMODERTS.buildingData )
constructionSign.type = SIMODERTS.buildingDataType.mainSign
constructionSign.name = "construction-sign"
constructionSign.technologyLevel = 0
constructionSign.generateElectricity = 0

-- 仓库
local warehouse = table.deepcopy( SIMODERTS.buildingData )
warehouse.type = SIMODERTS.buildingDataType.mainWare
warehouse.name = "warehouse"
warehouse.technologyLevel = 0
warehouse.generateElectricity = 0

-- 蒸汽发电厂
local generatorSteam = table.deepcopy( SIMODERTS.buildingData )
generatorSteam.type = SIMODERTS.buildingDataType.generator
generatorSteam.name = "generator-steam"
generatorSteam.technologyLevel = 0
generatorSteam.generateElectricity = 120

-- 日光发电厂
local generatorSunLight = table.deepcopy( SIMODERTS.buildingData )
generatorSunLight.type = SIMODERTS.buildingDataType.generator
generatorSunLight.name = "generator-sun-light"
generatorSunLight.technologyLevel = 3
generatorSunLight.generateElectricity = 20

-- 核能发电厂
local generatorNuclear = table.deepcopy( SIMODERTS.buildingData )
generatorNuclear.type = SIMODERTS.buildingDataType.generator
generatorNuclear.name = "generator-nuclear"
generatorNuclear.technologyLevel = 9
generatorNuclear.generateElectricity = 650

-- 煤矿厂
local minerCoal = table.deepcopy( SIMODERTS.buildingData )
minerCoal.type = SIMODERTS.buildingDataType.miner
minerCoal.name = "miner-coal"
minerCoal.technologyLevel = 0
minerCoal.generateElectricity = -15
minerCoal.productType = SIFlags.productType.resource

-- 石矿厂
local minerStone = table.deepcopy( SIMODERTS.buildingData )
minerStone.type = SIMODERTS.buildingDataType.miner
minerStone.name = "miner-stone"
minerStone.technologyLevel = 0
minerStone.generateElectricity = -15
minerStone.productType = SIFlags.productType.resource

-- 铁矿厂
local minerIron = table.deepcopy( SIMODERTS.buildingData )
minerIron.type = SIMODERTS.buildingDataType.miner
minerIron.name = "miner-iron"
minerIron.technologyLevel = 0
minerIron.generateElectricity = -15
minerIron.productType = SIFlags.productType.resource

-- 铜矿厂
local minerCopper = table.deepcopy( SIMODERTS.buildingData )
minerCopper.type = SIMODERTS.buildingDataType.miner
minerCopper.name = "miner-copper"
minerCopper.technologyLevel = 0
minerCopper.generateElectricity = -15
minerCopper.productType = SIFlags.productType.resource

-- 铀矿厂
local minerUranium = table.deepcopy( SIMODERTS.buildingData )
minerUranium.type = SIMODERTS.buildingDataType.miner
minerUranium.name = "miner-uranium"
minerUranium.technologyLevel = 6
minerUranium.generateElectricity = -50
minerUranium.productType = SIFlags.productType.resource

-- 载具工厂
local factoryVehicle = table.deepcopy( SIMODERTS.buildingData )
factoryVehicle.type = SIMODERTS.buildingDataType.factoryVehicle
factoryVehicle.name = "factory-vehicle"
factoryVehicle.technologyLevel = 0
factoryVehicle.generateElectricity = -40
factoryVehicle.productType = SIFlags.productType.unit

-- 无人机工厂
local factoryRobot = table.deepcopy( SIMODERTS.buildingData )
factoryRobot.type = SIMODERTS.buildingDataType.factoryAirplane
factoryRobot.name = "factory-robot"
factoryRobot.technologyLevel = 6
factoryRobot.generateElectricity = -60
factoryRobot.productType = SIFlags.productType.unit

-- 研究中心
local researchLab = table.deepcopy( SIMODERTS.buildingData )
researchLab.type = SIMODERTS.buildingDataType.research
researchLab.name = "research-lab"
researchLab.technologyLevel = 3
researchLab.generateElectricity = -120

-- 维护中心
local researchRepair = table.deepcopy( SIMODERTS.buildingData )
researchRepair.type = SIMODERTS.buildingDataType.research
researchRepair.name = "research-repair"
researchRepair.technologyLevel = 6
researchRepair.generateElectricity = -160

-- 产能中心
local researchProduct = table.deepcopy( SIMODERTS.buildingData )
researchProduct.type = SIMODERTS.buildingDataType.research
researchProduct.name = "research-product"
researchProduct.technologyLevel = 9
researchProduct.generateElectricity = -230

-- 机枪炮塔
local turretMachineGun = table.deepcopy( SIMODERTS.buildingData )
turretMachineGun.type = SIMODERTS.buildingDataType.turret
turretMachineGun.name = "turret-machine-gun"
turretMachineGun.technologyLevel = 0
turretMachineGun.generateElectricity = 0

-- 激光炮塔
local turretLaser = table.deepcopy( SIMODERTS.buildingData )
turretLaser.type = SIMODERTS.buildingDataType.turret
turretLaser.name = "turret-laser"
turretLaser.technologyLevel = 3
turretLaser.generateElectricity = -20

-- 喷火炮塔
local turretFlame = table.deepcopy( SIMODERTS.buildingData )
turretFlame.type = SIMODERTS.buildingDataType.turret
turretFlame.name = "turret-flame"
turretFlame.technologyLevel = 6
turretFlame.generateElectricity = -35

-- 重炮炮塔
local turretHeavyGun = table.deepcopy( SIMODERTS.buildingData )
turretHeavyGun.type = SIMODERTS.buildingDataType.turret
turretHeavyGun.name = "turret-heavy-gun"
turretHeavyGun.technologyLevel = 9
turretHeavyGun.generateElectricity = -65

-- 围墙
local auxiliaryWall = table.deepcopy( SIMODERTS.buildingData )
auxiliaryWall.type = SIMODERTS.buildingDataType.auxiliaryWall
auxiliaryWall.name = "auxiliary-wall"
auxiliaryWall.technologyLevel = 0
auxiliaryWall.generateElectricity = 0

-- 雷达
local auxiliaryRadar = table.deepcopy( SIMODERTS.buildingData )
auxiliaryRadar.type = SIMODERTS.buildingDataType.auxiliaryRadar
auxiliaryRadar.name = "auxiliary-radar"
auxiliaryRadar.technologyLevel = 0
auxiliaryRadar.generateElectricity = -25

-- ------------------------------------------------------------------------------------------------
-- ---------- 定义单位 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 汽车
local unitCar = table.deepcopy( SIMODERTS.unitData )
unitCar.type = SIMODERTS.unitDataType.vehicle
unitCar.name = "unit-car"
unitCar.technologyLevel = 0

-- 坦克
local unitTank = table.deepcopy( SIMODERTS.unitData )
unitTank.type = SIMODERTS.unitDataType.vehicle
unitTank.name = "unit-tank"
unitTank.technologyLevel = 6

-- 建设无人机
local robotConstruct = table.deepcopy( SIMODERTS.unitData )
robotConstruct.type = SIMODERTS.unitDataType.worker
robotConstruct.name = "robot-construct"
robotConstruct.technologyLevel = 6

-- 战斗无人机
local robotCombat = table.deepcopy( SIMODERTS.unitData )
robotCombat.type = SIMODERTS.unitDataType.airplane
robotCombat.name = "robot-combat"
robotCombat.technologyLevel = 9

-- ------------------------------------------------------------------------------------------------
-- ---------- 定义技能 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------------
-- -------- 定义建造条件 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local function CreatePreConditions( data , ... )
	data.preConditions =
	{
		buildingList =
		{
			operation = SIFlags.condition.And ,
			typeList = {}
		}
	}
	for i , v in pairs{ ... } do data.preConditions.buildingList.typeList[v.name] = 1 end
end

-- 建筑
CreatePreConditions( constructionCenter , researchRepair )                            -- 建造中心
CreatePreConditions( generatorSunLight  , researchLab )                               -- 日光发电厂
CreatePreConditions( generatorNuclear   , researchProduct , minerUranium )            -- 核能发电厂
CreatePreConditions( minerIron          , minerCoal , minerStone )                    -- 铁矿厂
CreatePreConditions( minerCopper        , minerCoal , minerStone )                    -- 铜矿厂
CreatePreConditions( minerUranium       , researchProduct , minerIron , minerCopper ) -- 铀矿厂
CreatePreConditions( factoryVehicle     , minerIron , minerCopper )                   -- 载具工厂
CreatePreConditions( factoryRobot       , researchRepair , minerIron , minerCopper )  -- 无人机工厂
CreatePreConditions( researchLab        , minerIron , minerCopper )                   -- 研究中心
CreatePreConditions( researchRepair     , researchLab , minerIron , minerCopper )     -- 维护中心
CreatePreConditions( researchProduct    , researchRepair , minerIron , minerCopper )  -- 产能中心
CreatePreConditions( turretLaser        , researchLab )                               -- 激光炮塔
CreatePreConditions( turretFlame        , researchRepair )                            -- 喷火炮塔
CreatePreConditions( turretHeavyGun     , researchProduct )                           -- 重炮炮塔

-- 载具
CreatePreConditions( unitCar            , factoryVehicle )                            -- 汽车
CreatePreConditions( unitTank           , factoryVehicle )                            -- 坦克
CreatePreConditions( robotConstruct     , factoryRobot )                              -- 建设无人机
CreatePreConditions( robotCombat        , factoryRobot )                              -- 战斗无人机

-- ------------------------------------------------------------------------------------------------
-- ---------- 定义资源 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 煤资源
local resourceCoal = table.deepcopy( SIMODERTS.resourceData )
resourceCoal.name = "resource-coal"

-- 石资源
local resourceStone = table.deepcopy( SIMODERTS.resourceData )
resourceStone.name = "resource-stone"

-- 铁资源
local resourceIron = table.deepcopy( SIMODERTS.resourceData )
resourceIron.name = "resource-iron"

-- 铜资源
local resourceCopper = table.deepcopy( SIMODERTS.resourceData )
resourceCopper.name = "resource-copper"

-- 铀资源
local resourceUranium = table.deepcopy( SIMODERTS.resourceData )
resourceUranium.name = "resource-uranium"
resourceUranium.worth = 3

-- ------------------------------------------------------------------------------------------------
-- ---------- 定义矿物 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 煤矿
local oreCoal = table.deepcopy( SIMODERTS.oreData )
oreCoal.prototypeEntityName = "coal"
oreCoal.name = "ore-coal"

-- 石矿
local oreStone = table.deepcopy( SIMODERTS.oreData )
oreStone.prototypeEntityName = "stone"
oreStone.name = "ore-stone"

-- 铁矿
local oreIron = table.deepcopy( SIMODERTS.oreData )
oreIron.prototypeEntityName = "iron-ore"
oreIron.name = "ore-iron"

-- 铜矿
local oreCopper = table.deepcopy( SIMODERTS.oreData )
oreCopper.prototypeEntityName = "copper-ore"
oreCopper.name = "ore-copper"

-- 铀矿
local oreUranium = table.deepcopy( SIMODERTS.oreData )
oreUranium.prototypeEntityName = "uranium-ore"
oreUranium.name = "ore-uranium"

-- ------------------------------------------------------------------------------------------------
-- -------- 定义消耗矿物 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

minerCoal.oreName = oreCoal.name
minerStone.oreName = oreStone.name
minerIron.oreName = oreIron.name
minerCopper.oreName = oreCopper.name
minerUranium.oreName = oreUranium.name

-- ------------------------------------------------------------------------------------------------
-- ---------- 封装数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local forceData =
{
	displayName = { "SIMODERTS.force-name-"..forceName } ,
	buildingDataList =
	{
		constructionCenter , -- 建造中心
		constructionSign ,   -- 建造信标
		warehouse ,          -- 仓库
		generatorSteam ,     -- 蒸汽发电厂
		generatorSunLight ,  -- 日光发电厂
		generatorNuclear ,   -- 核能发电厂
		minerCoal ,          -- 煤矿厂
		minerStone ,         -- 石矿厂
		minerIron ,          -- 铁矿厂
		minerCopper ,        -- 铜矿厂
		minerUranium ,       -- 铀矿厂
		factoryVehicle ,     -- 载具工厂
		factoryRobot ,       -- 无人机工厂
		researchLab ,        -- 研究中心
		researchRepair ,     -- 维护中心
		researchProduct ,    -- 产能中心
		turretMachineGun ,   -- 机枪炮塔
		turretLaser ,        -- 激光炮塔
		turretFlame ,        -- 喷火炮塔
		turretHeavyGun ,     -- 重炮炮塔
		auxiliaryWall ,      -- 围墙
		auxiliaryRadar       -- 雷达
	} ,
	unitDataList =
	{
		unitCar ,        -- 汽车
		unitTank ,       -- 坦克
		robotConstruct , -- 建设无人机
		robotCombat      -- 战斗无人机
	} ,
	skillDataList = {} ,
	resourceDataList =
	{
		resourceCoal ,   -- 煤资源
		resourceStone ,  -- 石资源
		resourceIron ,   -- 铁资源
		resourceCopper , -- 铜资源
		resourceUranium  -- 铀资源
	} ,
	oreDataList =
	{
		oreCoal ,   -- 煤矿
		oreStone ,  -- 石矿
		oreIron ,   -- 铁矿
		oreCopper , -- 铜矿
		oreUranium  -- 铀矿
	}
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 后期处理 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 补全参数
for i , v in pairs( forceData.buildingDataList ) do
	v.prototypeItemName = itemName .. v.name
	v.prototypeEntityName = entityName .. v.name
	v.prototypeRecipeName = recipeName .. v.name
	v.name = forceName .. "-" .. v.name
	v.forceType = forceName
	if v.oreName then
		v.oreName = forceName .. "-" .. v.oreName
		v.oreCount = 10
	end
end
for i , v in pairs( forceData.unitDataList ) do
	v.prototypeItemName = itemName .. v.name
	v.prototypeEntityName = entityName .. v.name
	v.prototypeRecipeName = recipeName .. v.name
	v.name = forceName .. "-" .. v.name
	v.forceType = forceName
end
for i , v in pairs( forceData.skillDataList ) do
	v.prototypeIconName = iconName .. v.name
	v.prototypeTechnologyName = technologyName .. v.name
	v.name = forceName .. "-" .. v.name
	v.forceType = forceName
end
for i , v in pairs( forceData.resourceDataList ) do
	v.prototypeItemName = itemName .. v.name
	v.type = SIMODERTS.resourceDataType.common
	v.name = forceName .. "-" .. v.name
	v.forceType = forceName
end
for i , v in pairs( forceData.oreDataList ) do
	v.type = SIMODERTS.oreDataType.common
	v.name = forceName .. "-" .. v.name
	v.forceType = forceName
end

-- 建筑的建造条件增加建造中心
for i , v in pairs( forceData.buildingDataList ) do
	if not v.preConditions then v.preConditions = {} end
	if not v.preConditions.buildingList then v.preConditions.buildingList = { operation = SIFlags.condition.And } end
	if not v.preConditions.buildingList.operation then v.preConditions.buildingList.operation = SIFlags.condition.And end
	if not v.preConditions.buildingList.typeList then v.preConditions.buildingList.typeList = {} end
	local typeList = {}
	for n , m in pairs( v.preConditions.buildingList.typeList ) do typeList[forceName.."-"..n] = m end
	v.preConditions.buildingList.typeList = typeList
	v.preConditions.buildingList.typeList[constructionCenter.name] = 1
end

forceData.startup =
{
	buildings =
	{
		{ type = constructionCenter.name , position = { 0 , 0 } } ,
		{ type = constructionSign.name , position = { 0 , -4 } } ,
		{ type = warehouse.name , position = { 0 , 4 } } ,
	} ,
	units =
	{
		{ type = robotConstruct.name , position = { 3 , 3 } } ,
		{ type = robotConstruct.name , position = { 3 , -3 } } ,
		{ type = robotConstruct.name , position = { -3 , 3 } } ,
		{ type = robotConstruct.name , position = { -3 , -3 } }
	} ,
	skills = {} ,
	material = {} ,
	resource =
	{
		{ type = resourceCoal.name , count = 300 } ,
		{ type = resourceStone.name , count = 300 } ,
		{ type = resourceIron.name , count = 300 } ,
		{ type = resourceCopper.name , count = 300 }
	} ,
	ore =
	{
		{ type = oreCoal.name , count = 10000 } ,
		{ type = oreStone.name , count = 10000 } ,
		{ type = oreIron.name , count = 10000 } ,
		{ type = oreCopper.name , count = 10000 } ,
		{ type = oreUranium.name , count = 10000 }
	}
}

return forceData