-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local forceName = SIMODERTS.currentLoadForce .. "-"

local constructionCenter = SIMODERTS.FindTypeData( forceName.."construction-center" )
local constructionSign = SIMODERTS.FindTypeData( forceName.."construction-sign" )
local warehouse = SIMODERTS.FindTypeData( forceName.."warehouse" )
local generatorSteam = SIMODERTS.FindTypeData( forceName.."generator-steam" )
local generatorSunLight = SIMODERTS.FindTypeData( forceName.."generator-sun-light" )
local generatorNuclear = SIMODERTS.FindTypeData( forceName.."generator-nuclear" )
local minerCoal = SIMODERTS.FindTypeData( forceName.."miner-coal" )
local minerStone = SIMODERTS.FindTypeData( forceName.."miner-stone" )
local minerIron = SIMODERTS.FindTypeData( forceName.."miner-iron" )
local minerCopper = SIMODERTS.FindTypeData( forceName.."miner-copper" )
local minerUranium = SIMODERTS.FindTypeData( forceName.."miner-uranium" )
local factoryVehicle = SIMODERTS.FindTypeData( forceName.."factory-vehicle" )
local factoryRobot = SIMODERTS.FindTypeData( forceName.."factory-robot" )
local researchLab = SIMODERTS.FindTypeData( forceName.."research-lab" )
local researchRepair = SIMODERTS.FindTypeData( forceName.."research-repair" )
local researchProduct = SIMODERTS.FindTypeData( forceName.."research-product" )
local turretMachineGun = SIMODERTS.FindTypeData( forceName.."turret-machine-gun" )
local turretLaser = SIMODERTS.FindTypeData( forceName.."turret-laser" )
local turretFlame = SIMODERTS.FindTypeData( forceName.."turret-flame" )
local turretHeavyGun = SIMODERTS.FindTypeData( forceName.."turret-heavy-gun" )
local auxiliaryWall = SIMODERTS.FindTypeData( forceName.."auxiliary-wall" )
local auxiliaryRadar = SIMODERTS.FindTypeData( forceName.."auxiliary-radar" )

local unitCar = SIMODERTS.FindTypeData( forceName.."unit-car" )
local unitTank = SIMODERTS.FindTypeData( forceName.."unit-tank" )
local robotConstruct = SIMODERTS.FindTypeData( forceName.."robot-construct" )
local robotCombat = SIMODERTS.FindTypeData( forceName.."robot-combat" )

local resourceCoal = SIMODERTS.FindResourceData( forceName.."resource-coal" )
local resourceStone = SIMODERTS.FindResourceData( forceName.."resource-stone" )
local resourceIron = SIMODERTS.FindResourceData( forceName.."resource-iron" )
local resourceCopper = SIMODERTS.FindResourceData( forceName.."resource-copper" )
local resourceUranium = SIMODERTS.FindResourceData( forceName.."resource-uranium" )

-- ------------------------------------------------------------------------------------------------
-- --- 定义建筑实体和建造配方 ---------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen.NewSubGroup( "1-buildings" )

-- 建造中心
.NewMachine( constructionCenter.prototypeEntityName , SIGen.GetData( SITypes.entity.rocket , "rocket-silo" ) )
.SetHealth( 2500 )
.SetSpeed( 1 )
.SetRecipeTypes( "si-rts-base-recipe-type-main" )
.FillRTSDataEntity( constructionCenter.prototypeItemName , constructionCenter )

.NewRecipe( constructionCenter.prototypeRecipeName )
.SetRecipeTypes( "si-rts-base-recipe-type-main" )
.SetEnergy( 60 )
.AddCosts( resourceIron.prototypeItemName , 500 )
.AddCosts( resourceCopper.prototypeItemName , 500 )
.SetResults( constructionCenter.prototypeItemName )

-- 建造信标
.NewRoboport( constructionSign.prototypeEntityName , SIGen.GetData( SITypes.entity.roboport , "roboport" ) )
.SetHealth( 800 )
.SetSlotCount( 0 , 0 )
.SetEffectRadius( 8 , 8 , 20 )
.FillRTSDataEntity( constructionSign.prototypeItemName , constructionSign )

.NewRecipe( constructionSign.prototypeRecipeName )
.SetRecipeTypes( "si-rts-base-recipe-type-main" )
.SetEnergy( 20 )
.AddCosts( resourceIron.prototypeItemName , 200 )
.AddCosts( resourceCopper.prototypeItemName , 200 )
.SetResults( constructionSign.prototypeItemName )

-- 仓库
.NewContainerLogic( warehouse.prototypeEntityName , SIGen.GetData( SITypes.entity.containerLogic , "logistic-chest-passive-provider" ) )
.SetHealth( 1200 )
.SetSlotCount( 49 )
.FillRTSDataEntity( warehouse.prototypeItemName , warehouse )

.NewRecipe( warehouse.prototypeRecipeName )
.SetRecipeTypes( "si-rts-base-recipe-type-main" )
.SetEnergy( 15 )
.AddCosts( resourceStone.prototypeItemName , 600 )
.SetResults( warehouse.prototypeItemName )

-- 蒸汽发电厂


-- 日光发电厂


-- 核能发电厂


-- 煤矿厂


-- 石矿厂


-- 铁矿厂


-- 铜矿厂


-- 铀矿厂


-- 载具工厂


-- 无人机工厂


-- 研究中心


-- 维护中心


-- 产能中心


-- 机枪炮塔


-- 激光炮塔


-- 喷火炮塔


-- 重炮炮塔


-- 围墙


-- 雷达


-- ------------------------------------------------------------------------------------------------
-- --- 定义单位实体和建造配方 ---------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

.NewSubGroup( "2-units" )

-- 汽车


-- 坦克


-- 建设无人机


-- 战斗无人机
