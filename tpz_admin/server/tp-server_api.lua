-- local AdminAPI = exports.tpz_admin:getAPI()

-----------------------------------------------------------
--[[ Local Functions ]]--
-----------------------------------------------------------

exports('getAPI', function()

	local self = {}
  
	-- The specified drops (kicks) the player from the server.
	self.banPlayerBySource = function(source, reason)
		BanPlayerBySource(source, reason)
	end
	
	-- The specified should be used for online players, there is no player drop (kicking).
	self.banPlayerBySteamIdentifier = function(steamIdentifier, reason)
		BanPlayerBySteamIdentifier(steamIdentifier, reason)
	end

	self.resetBanBySteamIdentifier = function(steamIdentifier)
		ResetBanBySteamIdentifier(steamIdentifier)
	end

	self.getSteamIdentifierBySource = function(source)
		return GetSteamID(source)
	end




end)