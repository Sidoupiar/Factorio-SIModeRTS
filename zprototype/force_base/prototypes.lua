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

local recipeType =
{
	main = "si-rts-base-recipe-type-main" ,
	
	coal = "si-rts-base-recipe-type-coal" ,
	stone = "si-rts-base-recipe-type-stone" ,
	iron = "si-rts-base-recipe-type-iron" ,
	copper = "si-rts-base-recipe-type-copper" ,
	uranium = "si-rts-base-recipe-type-uranium"
}

local oreRecipe =
{
	coal = "si-rts-base-recipe-coal" ,
	stone = "si-rts-base-recipe-stone" ,
	iron = "si-rts-base-recipe-iron" ,
	copper = "si-rts-base-recipe-copper" ,
	uranium = "si-rts-base-recipe-uranium"
}

-- ------------------------------------------------------------------------------------------------
-- --- 定义建筑实体和建造配方 ---------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen.NewSubGroup( "1-buildings" )

-- 建造中心
.NewMachine( constructionCenter.prototypeEntityName , SIGen.GetData( SITypes.entity.rocket , "rocket-silo" ) )
.SetHealth( 2500 )
.SetSpeed( 1 )
.SetRecipeTypes( recipeType.main )
.FillRTSDataEntity( constructionCenter.prototypeItemName , constructionCenter )

.NewRecipe( constructionCenter.prototypeRecipeName )
.SetRecipeTypes( recipeType.main )
.SetEnergy( 60 )
.AddCosts( resourceIron.prototypeItemName , 500 )
.AddCosts( resourceCopper.prototypeItemName , 500 )
.AddResults( constructionCenter.prototypeItemName )

-- 建造信标
.NewRoboport( constructionSign.prototypeEntityName , SIGen.GetData( SITypes.entity.roboport , "roboport" ) )
.SetHealth( 800 )
.SetSlotCount( 0 , 0 )
.SetEffectRadius( 8 , 8 , 20 )
.FillRTSDataEntity( constructionSign.prototypeItemName , constructionSign )

.NewRecipe( constructionSign.prototypeRecipeName )
.SetRecipeTypes( recipeType.main )
.SetEnergy( 20 )
.AddCosts( resourceIron.prototypeItemName , 200 )
.AddCosts( resourceCopper.prototypeItemName , 200 )
.AddResults( constructionSign.prototypeItemName )

-- 仓库
.NewContainerLogic( warehouse.prototypeEntityName , SIGen.GetData( SITypes.entity.containerLogic , "logistic-chest-passive-provider" ) )
.SetHealth( 1200 )
.SetSlotCount( 49 )
.FillRTSDataEntity( warehouse.prototypeItemName , warehouse )

.NewRecipe( warehouse.prototypeRecipeName )
.SetRecipeTypes( recipeType.main )
.SetEnergy( 15 )
.AddCosts( resourceStone.prototypeItemName , 500 )
.AddResults( warehouse.prototypeItemName )

-- 蒸汽发电厂


-- 日光发电厂


-- 核能发电厂


-- 煤矿厂
.NewMachine( minerCoal.prototypeEntityName , SIGen.GetData( SITypes.entity.mining , "electric-mining-drill" ) )
.SetHealth( 600 )
.SetSpeed( 1 )
.SetMainRecipe( oreRecipe.coal )
.SetRecipeTypes( recipeType.coal )
.FillRTSDataEntity( minerCoal.prototypeItemName , minerCoal )

.NewRecipe( minerCoal.prototypeRecipeName )
.SetRecipeTypes( recipeType.main )
.SetEnergy( 25 )
.AddCosts( resourceCoal.prototypeItemName , 200 )
.AddCosts( resourceStone.prototypeItemName , 800 )
.AddResults( minerCoal.prototypeItemName )

.NewRecipe( oreRecipe.coal )
.SetRecipeTypes( recipeType.coal )
.SetEnergy( 60 )
.AddResults( resourceCoal.prototypeItemName , 500 )

-- 石矿厂
.NewMachine( minerStone.prototypeEntityName , SIGen.GetData( SITypes.entity.mining , "electric-mining-drill" ) )
.SetHealth( 600 )
.SetSpeed( 1 )
.SetMainRecipe( oreRecipe.stone )
.SetRecipeTypes( recipeType.stone )
.FillRTSDataEntity( minerStone.prototypeItemName , minerStone )

.NewRecipe( minerStone.prototypeRecipeName )
.SetRecipeTypes( recipeType.main )
.SetEnergy( 25 )
.AddCosts( resourceCoal.prototypeItemName , 800 )
.AddCosts( resourceStone.prototypeItemName , 200 )
.AddResults( minerStone.prototypeItemName )

.NewRecipe( oreRecipe.stone )
.SetRecipeTypes( recipeType.stone )
.SetEnergy( 60 )
.AddResults( resourceStone.prototypeItemName , 500 )

-- 铁矿厂
.NewMachine( minerIron.prototypeEntityName , SIGen.GetData( SITypes.entity.mining , "electric-mining-drill" ) )
.SetHealth( 600 )
.SetSpeed( 1 )
.SetMainRecipe( oreRecipe.iron )
.SetRecipeTypes( recipeType.iron )
.FillRTSDataEntity( minerIron.prototypeItemName , minerIron )

.NewRecipe( minerIron.prototypeRecipeName )
.SetRecipeTypes( recipeType.main )
.SetEnergy( 35 )
.AddCosts( resourceCoal.prototypeItemName , 1000 )
.AddCosts( resourceStone.prototypeItemName , 1000 )
.AddResults( minerIron.prototypeItemName )

.NewRecipe( oreRecipe.iron )
.SetRecipeTypes( recipeType.iron )
.SetEnergy( 60 )
.AddResults( resourceIron.prototypeItemName , 500 )

-- 铜矿厂
.NewMachine( minerCopper.prototypeEntityName , SIGen.GetData( SITypes.entity.mining , "electric-mining-drill" ) )
.SetHealth( 600 )
.SetSpeed( 1 )
.SetMainRecipe( oreRecipe.copper )
.SetRecipeTypes( recipeType.copper )
.FillRTSDataEntity( minerCopper.prototypeItemName , minerCopper )

.NewRecipe( minerCopper.prototypeRecipeName )
.SetRecipeTypes( recipeType.main )
.SetEnergy( 35 )
.AddCosts( resourceCoal.prototypeItemName , 1000 )
.AddCosts( resourceStone.prototypeItemName , 1000 )
.AddResults( minerCopper.prototypeItemName )

.NewRecipe( oreRecipe.copper )
.SetRecipeTypes( recipeType.copper )
.SetEnergy( 60 )
.AddResults( resourceCopper.prototypeItemName , 500 )

-- 铀矿厂
.NewMachine( minerUranium.prototypeEntityName , SIGen.GetData( SITypes.entity.mining , "electric-mining-drill" ) )
.SetHealth( 600 )
.SetSpeed( 1 )
.SetMainRecipe( oreRecipe.uranium )
.SetRecipeTypes( recipeType.uranium )
.FillRTSDataEntity( minerUranium.prototypeItemName , minerUranium )

.NewRecipe( minerUranium.prototypeRecipeName )
.SetRecipeTypes( recipeType.main )
.SetEnergy( 50 )
.AddCosts( resourceIron.prototypeItemName , 1200 )
.AddCosts( resourceCopper.prototypeItemName , 1200 )
.AddResults( minerUranium.prototypeItemName )

.NewRecipe( oreRecipe.uranium )
.SetRecipeTypes( recipeType.uranium )
.SetEnergy( 60 )
.AddResults( resourceUranium.prototypeItemName , 150 )

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
