local minSsn = 1
local maxSsn = 1000

function GenerateRandomSSN()
    return math.random(minSsn, maxSsn)
end


RegisterServerEvent('JMT:GenerateSsn')
AddEventHandler('JMT:GenerateSsn', function()
    local _source = source

    local characterId = ESX.GetPlayerFromId(_source).getIdentifier()

    MySQL.Async.fetchScalar('SELECT ssn FROM users WHERE identifier = @identifier', {
        ['@identifier'] = characterId
    }, function(ssn)
        if not ssn then
            local newSSN = GenerateRandomSSN()

            
            MySQL.Async.execute('UPDATE users SET ssn = @ssn WHERE identifier = @identifier', {
                ['@ssn'] = newSSN,
                ['@identifier'] = characterId
            })

        else

        end
    end)
end)

RegisterCommand('ssn', function(source, args, rawCommand)
    local _source = source

    local characterId = ESX.GetPlayerFromId(_source).getIdentifier()

    MySQL.Async.fetchScalar('SELECT ssn FROM users WHERE identifier = @identifier', {
        ['@identifier'] = characterId
    }, function(ssn)
        if ssn then
            TriggerClientEvent('esx:showNotification', _source, 'Twoje Social Security Number: ' .. ssn)
        else
            TriggerClientEvent('esx:showNotification', _source, 'Nie znaleziono twoje SSN.')
        end
    end)
end, false)
