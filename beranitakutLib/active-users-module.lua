-- =====================================================
-- Real-time Active Users Module
-- beranitakutLib
-- =====================================================

local HttpService = game:GetService("HttpService")

local ActiveUsers = {}
ActiveUsers.__index = ActiveUsers

local API_URL = "https://beranitakut.vercel.app/api/active-users"
local HEARTBEAT_INTERVAL = 30
local UPDATE_INTERVAL = 10

local function executorRequest()
    return syn and syn.request
        or http_request
        or request
end

local function httpPost(url, data)
    local body = HttpService:JSONEncode(data)
    local req = executorRequest()

    if req then
        local res = req({
            Url = url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = body
        })

        return res and res.Body
    end

    if HttpService.PostAsync then
        return HttpService:PostAsync(
            url,
            body,
            Enum.HttpContentType.ApplicationJson
        )
    end

    return nil
end

local function httpGet(url)
    local req = executorRequest()

    if req then
        local res = req({
            Url = url,
            Method = "GET"
        })
        return res and res.Body
    end

    if HttpService.GetAsync then
        return HttpService:GetAsync(url)
    end

    return nil
end

function ActiveUsers.new(scriptName, window)
    local self = setmetatable({}, ActiveUsers)

    self.ScriptName = scriptName or "Unknown"
    self.Window = window
    self.SessionId = HttpService:GenerateGUID(false)
    self.Running = false
    self.ActiveCount = 0

    return self
end

function ActiveUsers:sendHeartbeat()
    local success, result = pcall(function()
        local response = httpPost(API_URL, {
            sessionId = self.SessionId,
            scriptName = self.ScriptName
        })

        if not response then
            error("No response from server")
        end

        return HttpService:JSONDecode(response)
    end)

    if success and result then
        self.ActiveCount = result.activeCount or self.ActiveCount

        if self.Window and self.Window.UpdateActiveNow then
            self.Window:UpdateActiveNow(tostring(self.ActiveCount))
        end

        return true
    else
        warn("[ActiveUsers] Heartbeat failed:", result)
        return false
    end
end

function ActiveUsers:updateCount()
    local success, result = pcall(function()
        local url = API_URL .. "?script=" .. HttpService:UrlEncode(self.ScriptName)
        local response = httpGet(url)

        if not response then
            error("No response from server")
        end

        return HttpService:JSONDecode(response)
    end)

    if success and result then
        self.ActiveCount = result.activeCount or self.ActiveCount

        if self.Window and self.Window.UpdateActiveNow then
            self.Window:UpdateActiveNow(tostring(self.ActiveCount))
        end
    else
        warn("[ActiveUsers] Update count failed:", result)
    end
end

function ActiveUsers:start()
    if self.Running then return end
    self.Running = true

    print("[ActiveUsers] Started:", self.ScriptName)

    self:sendHeartbeat()

    task.spawn(function()
        while self.Running do
            task.wait(HEARTBEAT_INTERVAL)
            self:sendHeartbeat()
        end
    end)

    task.spawn(function()
        while self.Running do
            task.wait(UPDATE_INTERVAL)
            self:updateCount()
        end
    end)
end

function ActiveUsers:stop()
    self.Running = false
end

function ActiveUsers:getCount()
    return self.ActiveCount
end

return ActiveUsers
