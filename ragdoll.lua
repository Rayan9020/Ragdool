-- تحميل مكتبة Rayfield
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- إنشاء نافذة
local Window = Rayfield:CreateWindow({
    Name = "SystemBroken",
    LoadingTitle = "Loading",
    LoadingSubtitle = "Please wait...",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil,
       FileName = "SystemBrokenConfig"
    },
    Discord = {
       Enabled = false,
       Invite = "sirius",
       RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
       Title = "SystemBroken",
       Subtitle = "Key System",
       Note = "Join the discord (discord.gg/sirius)",
       FileName = "Key",
       SaveKey = true,
       GrabKeyFromSite = false,
       Key = "3BD"
    }
})

-- إنشاء تبويب
local MainTab = Window:CreateTab("Main Tab")

-- الوظائف الأصلية

local function ToggleRagdoll(bool)
	pcall(function()
		plr.Character["Falling down"].Disabled = bool
		plr.Character["Swimming"].Disabled = bool
		plr.Character["StartRagdoll"].Disabled = bool
		plr.Character["Pushed"].Disabled = bool
		plr.Character["RagdollMe"].Disabled = bool
	end)
end

-- وظيفة تفعيل ANTI Fling
local RunService = game:GetService("RunService")
local players = game:GetService("Players")
local plr = players.LocalPlayer
local AntiFlingFunction = nil

local function EnableAntiFling()
    AntiFlingFunction = RunService.Stepped:Connect(function()
        for i,p in pairs(players:GetPlayers()) do
            task.spawn(function()
                if p ~= plr and p.Character then
                    for i,v in pairs(p.Character:GetChildren()) do
                        pcall(function()
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                                v.Velocity = Vector3.new(0,0,0)
                                v.RotVelocity = Vector3.new(0,0,0)
                                v.CustomPhysicalProperties = PhysicalProperties.new(0,0,0,0,0)
                                v.Massless = true
                            elseif v:IsA("Accessory") then
                                v.Handle.CanCollide = false
                                v.Handle.Velocity = Vector3.new(0,0,0)
                                v.RotVelocity = Vector3.new(0,0,0)
                                v.CustomPhysicalProperties = PhysicalProperties.new(0,0,0,0,0)
                                v.Massless = true
                            end
                        end)
                    end
                end
            end)
        end
    end)
end

-- وظيفة تعطيل ANTI Fling
local function DisableAntiFling()
    if AntiFlingFunction then
        AntiFlingFunction:Disconnect()
        AntiFlingFunction = nil
    end
end

-- إضافة زر ANTI Fling
MainTab:CreateToggle({
    Name = "ANTI Fling",
    CurrentValue = _G.AntiFlingToggled,
    Callback = function(Value)
        _G.AntiFlingToggled = Value
        if Value then
            print("ANTI Fling Enabled")
            EnableAntiFling()  -- استدعاء وظيفة التفعيل
        else
            print("ANTI Fling Disabled")
            DisableAntiFling()  -- استدعاء وظيفة التعطيل
        end
    end
})

-- إضافة زر ANTI Ragdoll
MainTab:CreateToggle({
    Name = "ANTI Ragdoll",
    CurrentValue = false,
    Callback = function(Value)
        ToggleRagdoll(Value)
        if Value then
            print("ANTI Ragdoll Enabled")
        else
            print("ANTI Ragdoll Disabled")
        end
    end
})

-- إضافة زر Game Pass
MainTab:CreateButton({
    Name = "Game Pass",
    Callback = function()
        -- الكود الخاص بـ Game Pass
        print("Game Pass Activated")
    end
})

-- تفعيل أو تعطيل ANTI Fling بناءً على حالة الزر
if _G.AntiFlingToggled then
    EnableAntiFling()
else
    DisableAntiFling()
end
