GetSteamID = function(source)
    local sid = GetPlayerIdentifiers(source)[1] or false

    if (sid == false or sid:sub(1, 5) ~= "steam") then

        return false
    end

    return sid
end

GetIdentity = function(source, identity)
    local num = 0
    if not source then return end
    
    local num2 = GetNumPlayerIdentifiers(source)

    if GetNumPlayerIdentifiers(source) > 0 then
        local ident = nil
        while num < num2 and not ident do
            local a = GetPlayerIdentifier(source, num)
            if string.find(a, identity) then ident = a end
            num = num + 1
        end
        --return ident;
        if ident == nil then
            return ""
        end
        return string.sub(ident, 9)
    end
end
