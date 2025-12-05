-- BAI_bankAccountInterest
-- Main driver class for BAI
--

BAI_bankAccountInterest = {}
BAI_bankAccountInterest.rate = 0.03
BAI_bankAccountInterest.commands = {
    --- call name, description, function
    { 'biSetInterestRate', 'sets annual bank account interest rate', 'setInterestRate' },
    { 'biGetInterestRate', 'gets annual bank account interest rate', 'getInterestRate' },
}

function BAI_bankAccountInterest:loadMap()
    g_messageCenter:subscribe(MessageType.PERIOD_CHANGED, self.onPeriodChanged, self)
end

function BAI_bankAccountInterest:onPeriodChanged()
    if g_currentMission:getIsServer() then
        local farms = g_farmManager.farmIdToFarm
        for _, farm in pairs(farms) do
            cashAmount = farm.money
            farmId = farm.farmId

            if cashAmount ~= nil and cashAmount > 0 then
                local interestAmount = cashAmount * (BAI_bankAccountInterest.rate / 12)
                g_currentMission:addMoney(interestAmount, farmId, MoneyType.OTHER, true, true)
            end

        end

    end
end

-- Borrowed from Courseplay
function BAI_bankAccountInterest:init()
    self:registerConsoleCommands()
end

-- Borrowed from Courseplay
function BAI_bankAccountInterest:registerConsoleCommands()
    for _, commandData in ipairs(self.commands) do
        local name, desc, funcName = unpack(commandData)
        addConsoleCommand(name, desc, funcName, self)
    end
end

-- @param myRate rate to be set, expressed as float
function BAI_bankAccountInterest:setInterestRate(myRate)
    BAI_bankAccountInterest.rate = myRate
    print("BAI_bankAccountInterest.rate=" .. tostring(BAI_bankAccountInterest.rate))
    return myString
end

function BAI_bankAccountInterest:getInterestRate()
    print("BAI_bankAccountInterest.rate=" .. tostring(BAI_bankAccountInterest.rate))
    return BAI_bankAccountInterest.rate
end

BAI_bankAccountInterest:init()
addModEventListener(BAI_bankAccountInterest)
