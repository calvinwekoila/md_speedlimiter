if not lib then
    error('ox_lib required')
end

local GLOBAL_LIMIT = Vehicles['GLOBAL']

lib.onCache('vehicle', function(value)
    if not value then return end
    SetTimeout(0, function()
        if cache.seat ~= -1 then return end

        local vehicleLimit = Vehicles[GetEntityModel(value)]
        CreateThread(function()
            if GLOBAL_LIMIT and not vehicleLimit then
                while cache.vehicle == value do
                    Wait(0)
                    SetEntityMaxSpeed(value, GLOBAL_LIMIT / 3.6)
                end
            elseif vehicleLimit then
                while cache.vehicle == value do
                    Wait(0)
                    SetEntityMaxSpeed(value, vehicleLimit / 3.6)
                end
            end
        end)
    end)
end)
