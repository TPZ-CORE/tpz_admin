local TPZ = exports.tpz_core:getCoreAPI()

-----------------------------------------------------------
--[[ Exports ]]--
-----------------------------------------------------------

exports('getAPI', function()
  local self = {}

  self.InsertHistoryAction = function(source, text)
    InsertHistoryAction(source, text)
  end

  self.CreateTicket = function(source, title, message, exclamation)
    CreateTicket(source, title, message, exclamation)
  end

  return self
end)