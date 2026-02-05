-- Load Library
local beranitakut = loadstring(game:HttpGet("https://raw.githubusercontent.com/AmertaNestapa/scripts/refs/heads/main/beranitakut.lua"))()

-- Create Window
local Window = beranitakut:CreateWindow({
    Title = "beranitakutLib Demo",
    SubTitle = "v1.0.0",
    Size = UDim2.fromOffset(600, 450),
    
    -- Config System
    ConfigSystem = true, -- Enable save/load configs (default: true)
    
    -- Changelog Window
    ShowChangelog = true, -- Show changelog window (default: true)
    ChangelogContent = {
        {
            Version = "v0.0.0",
            Date = "Feb 4, 2026",
            Changes = {
                "Demo beranitakutLib"
            }
        }
    },
    
    -- Info Window
    ShowInfo = true, -- Show info window (default: true)
    InfoContent = {
        Links = {
            {
                Name = "Website",
                URL = "https://beranitakut.vercel.app",
                Icon = "🌐"
            },
            {
                Name = "Discord Server",
                URL = "https://discord.gg/yourinvite",
                Icon = "💬"
            },
            {
                Name = "Report Bugs",
                URL = "https://github.com/yourusername/yourrepo/issues",
                Icon = "🐛"
            }
        },

        -- Credits
        Credits = {
            Developer = "beranitakut",
            UILibrary = "beranitakutLib v1.0.0"
        }
    }
})

-- =====================================================
-- UPDATE STATS DYNAMICALLY
-- =====================================================

-- Update runtime counter
local startTime = os.time()
task.spawn(function()
    while task.wait(1) do
        local uptime = os.time() - startTime
        local hours = math.floor(uptime / 3600)
        local minutes = math.floor((uptime % 3600) / 60)
        local seconds = uptime % 60
        
        -- Update stats in Info Window
        Window:UpdateStat("Runtime", string.format("%dh %dm %ds", hours, minutes, seconds))
        Window:UpdateStat("Status", "✅ Active")
    end
end)

-- =====================================================
-- CREATE TABS
-- =====================================================

local MainTab = Window:AddTab({
    Title = "Main"
})

-- =====================================================
-- MAIN TAB
-- =====================================================

-- Paragraph
MainTab:AddParagraph({
    Title = "📱 Welcome!",
    Content = "This is a demo of beranitakutLib. Try all the features below!"
})

-- Create Toggle
local Toggle = MainTab:AddToggle("Toggle", {
    Title = "Toggle",
    Description = "Demo Toggle",
    Default = false,
    Callback = function(value)
        print("Toggle:", value)
    end
})

-- Toggle methods
-- Toggle:SetValue(true) -- Set value
-- print(Toggle.Value) -- Get value

-- Create Button
MainTab:AddButton({
    Title = "Button",
    Description = "Demo BUtton (Reset Walkspeed)",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 16
        end
    end
})

-- Create Slider
local Slider = MainTab:AddSlider("Slider", {
    Title = "Slider",
    Description = "Demo Slider (Walkspeed)",
    Min = 16,
    Max = 100,
    Default = 16,
    Rounding = 0,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
        print("Walk Speed:", value)
    end
})

-- Slider methods
-- Slider:SetValue(50) -- Set value
-- print(Slider.Value) -- Get value

-- Create Input
local Input = MainTab:AddInput("Input", {
    Title = "Input",
    Description = "Demo Input",
    Default = "",
    Placeholder = "Input",
    Numeric = false,
    Callback = function(value)
        print("Input:", value)
    end
})

-- Input methods
-- Input:SetValue("NewName") -- Set value
-- print(Input.Value) -- Get value

-- Create Dropdown
local Dropdown = MainTab:AddDropdown("Dropdown", {
    Title = "Dropdown",
    Description = "Demo Dropdown",
    Values = {"1", "2", "3", "4", "5"},
    Default = 1,
    Callback = function(value)
        print("Dropdown:", value)
    end
})

-- Dropdown methods
-- Dropdown:SetValue("1") -- Set value
-- Dropdown:Refresh({"1", "2", "3"}) -- Update options
-- print(Dropdown.Value) -- Get value

-- Create Multi-Select Dropdown
local MultiSelectDropdown = MainTab:AddDropdown("Multi_Select_Dropdown", {
    Title = "Multi-Select Dropdown",
    Description = "Demo Multi-Select Dropdown",
    Values = {"1", "2", "3", "4", "5"},
    Multi = true,
    Default = {"1"},
    Callback = function(value)
        print("Selected Dropdown:", table.concat(value, ", "))
    end
})

-- Multi-select methods
-- MultiSelectDropdown:SetValue({"1", "2"}) -- Set values
-- print(table.concat(MultiSelectDropdown.Value, ", ")) -- Get values

-- =====================================================
-- CONFIG TAB - Save/Load System
-- =====================================================

local ConfigTab = Window:AddTab({
    Title = "Config"
})

-- Add config section (automatically creates save/load UI)
ConfigTab:AddConfigSection()

-- =====================================================
-- NOTIFICATIONS
-- =====================================================

beranitakut:Notify({
    Title = "Script Loaded!",
    Content = "beranitakutLib demo is ready to use!",
    Type = "Success", -- Types: "Info", "Success", "Warning", "Error"
    Duration = 5 -- Seconds
})

-- Example notifications for each type
task.wait(1)
beranitakut:Notify({
    Title = "Info",
    Content = "This is an info notification",
    Type = "Info",
    Duration = 3
})

task.wait(0.5)
beranitakut:Notify({
    Title = "Warning",
    Content = "This is a warning notification",
    Type = "Warning",
    Duration = 3
})

task.wait(0.5)
beranitakut:Notify({
    Title = "Error",
    Content = "This is an error notification",
    Type = "Error",
    Duration = 3
})

-- =====================================================
-- USEFUL FUNCTIONS
-- =====================================================

-- Get/Set element values programmatically
task.spawn(function()
    task.wait(5)
    
    -- Toggle
    Toggle:SetValue(true)
    print("Toggle set to true programmatically")
    
    task.wait(2)
    
    -- Slider
    Slider:SetValue(50)
    print("Walkspeed set to 50 programmatically")
    
    task.wait(2)
    
    -- Dropdown
    Dropdown:SetValue("3")
    print("Dropdown changed to 3 programmatically")
end)

-- =====================================================
-- RE-EXECUTE (Optional)
-- =====================================================

local queue_on_teleport = queue_on_teleport or syn and syn.queue_on_teleport or fluxus and fluxus.queue_on_teleport

if queue_on_teleport then
    queue_on_teleport([[
        repeat task.wait() until game:IsLoaded()
        print("Re-executing beranitakutLib demo...")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AmertaNestapa/scripts/refs/heads/main/beranitakut_usage.lua"))()
    ]])
end

print("✅ beranitakutLib loaded successfully!")
print("💾 Save your config in the Config tab")
