-- ------------------------------------------------------------------------------------------------
-- -------- 玩家创建事件 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function EventPlayerCreated( event )
	local player = game.players[event.player_index]
	SendInformation( player , "SIMODERTS.player-join" , player.name , SIMODERTS.mapData.name )
	for i , v in pairs( game.players ) do
		if i ~= event.player_index then
			SendInformation( v , "SIMODERTS.player-join-other" , player.name )
		end
	end
	-- 把玩家移动到观察者组
	player.force = SIMODERTS.observerForce
	-- 把玩家移动到对应的地图上
	player.teleport( { 0 , 0 } , game.get_surface( SIMODERTS.mapSurfaceName ) )
	-- 删除玩家的人物
	local character = player.character
	if character then
		character.destroy()
		player.character = nil
	end
	-- 修改玩家能力
	player.disable_flashlight()
end

-- ------------------------------------------------------------------------------------------------
-- -------- 玩家操作事件 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 挖掘事件 , 让东西挖不掉
function EventPlayerPreMinedItem( event )
	local entity = event.entity
	entity.surface.clone_entities{ entities = { entity } , destination_offset = { 0 , 0 } }
	entity.destroy()
end