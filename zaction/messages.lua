-- ------------------------------------------------------------------------------------------------
-- ---------- 发送消息 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SendSystemMessage( ... )
	game.print( { "SIMODERTS.system" , { ... } } , SIColors.printColor.red )
end

function SendMessage( player , ... )
	if not player then player = game end
	player.print( { "SIMODERTS.message" , { ... } } , SIColors.printColor.white )
end

function SendInformation( player , ... )
	if not player then player = game end
	player.print( { "SIMODERTS.information" , { ... } } , SIColors.printColor.blue )
end

function SendWarning( player , ... )
	if not player then player = game end
	player.print( { "SIMODERTS.warning" , { ... } } , SIColors.printColor.orange )
end

function SendError( player , ... )
	if not player then player = game end
	player.print( { "SIMODERTS.error" , { ... } } , SIColors.printColor.red )
end