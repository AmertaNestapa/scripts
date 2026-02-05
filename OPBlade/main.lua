-- =====================================================
-- OP BLADE v1.4.0
-- Made by beranitakut
-- =====================================================

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

getgenv().__OPB_CONTEXT = {
    issuedAt = os.time(),
    nonce = tostring(math.random(100000, 999999))
}

local function notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 5
        })
    end)
end

notify(
    "OP Blade by beranitakut v1.4.0",
    "Getting script from server...",
    3
)

task.wait(1)

local SCRIPT_URL = "https://beranitakut.vercel.app/api/opblade?t=" .. os.time()

local success, err = pcall(function()
    local source = game:HttpGet(SCRIPT_URL)

    if not source or source == "" then
        error("Server returned empty response")
    end

    local fn, loadErr = loadstring(source)
    if not fn then
        error("Loadstring failed: " .. tostring(loadErr))
    end

    fn()
end)

if not success then
    notify(
        "OP Blade - Error",
        tostring(err),
        8
    )
    warn("[OP Blade] Error:", err)
end
