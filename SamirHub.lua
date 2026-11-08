-- [[ SAMIR HUB: JARVIS CYBER EDITIONS (STEAL AN EGG) ]]

if game.CoreGui:FindFirstChild("SamirHub") then
    game.CoreGui.SamirHub:Destroy()
end

-- 1. JARVIS SYSTEM & UI SETUP
local SamirHub = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local FrameBorder = Instance.new("UIStroke")
local FrameCorner = Instance.new("UICorner")

local Header = Instance.new("Frame")
local Logo = Instance.new("TextLabel")
local Title = Instance.new("TextLabel")

local AntiChaseBtn = Instance.new("TextButton")
local AntiHitBtn = Instance.new("TextButton")
local AntiTrapBtn = Instance.new("TextButton")
local Credit = Instance.new("TextLabel")

SamirHub.Name = "SamirHub"
SamirHub.Parent = game.CoreGui
SamirHub.ResetOnSpawn = false

-- Full Rad Clear & Semi-Transparent Charcoal Background (Jarvis Aesthetic)
MainFrame.Name = "MainFrame"
MainFrame.Parent = SamirHub
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.BackgroundTransparency = 0.25 -- Transparent effect
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 310)
MainFrame.Active = true
MainFrame.Draggable = true

-- Glowing Red Neon Borders
FrameBorder.Parent = MainFrame
FrameBorder.Color = Color3.fromRGB(255, 0, 50)
FrameBorder.Thickness = 1.5
FrameBorder.ApplyStrokeMode = Enum.StrokeMode.Border

FrameCorner.CornerRadius = UDim.new(0, 10)
FrameCorner.Parent = MainFrame

-- Jarvis Top Header
Header.Name = "Header"
Header.Parent = MainFrame
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Header.BackgroundTransparency = 0.4
Header.Size = UDim2.new(1, 0, 0, 45)

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header

-- [⚡] Khatarnak Red Logo
Logo.Name = "Logo"
Logo.Parent = Header
Logo.BackgroundTransparency = 1.000
Logo.Position = UDim2.new(0, 12, 0, 0)
Logo.Size = UDim2.new(0, 30, 1, 0)
Logo.Font = Enum.Font.GothamBold
Logo.Text = "⚡"
Logo.TextColor3 = Color3.fromRGB(255, 0, 50)
Logo.TextSize = 22.000

-- Sleek Tech Title
Title.Name = "Title"
Title.Parent = Header
Title.BackgroundTransparency = 1.000
Title.Position = UDim2.new(0, 42, 0, 0)
Title.Size = UDim2.new(1, -45, 1, 0)
Title.Font = Enum.Font.Code
Title.Text = "SAMIR HUB : JV"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16.000
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Variables
local AntiChaseActive = false
local AntiHitActive = false
local AntiTrapActive = false

-- Dynamic Jarvis Style Button Function
local function styleJarvisButton(btn, text, order)
    btn.Parent = MainFrame
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.BackgroundTransparency = 0.4
    btn.Position = UDim2.new(0, 20, 0, 65 + (order * 60))
    btn.Size = UDim2.new(0, 220, 0, 45)
    btn.Font = Enum.Font.Code
    btn.Text = ">> " .. text .. " [DISENGAGED]"
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 13.000
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Parent = btn
    btnStroke.Color = Color3.fromRGB(60, 60, 60)
    btnStroke.Thickness = 1
end

styleJarvisButton(AntiChaseBtn, "ANTI-CHASE", 0)
styleJarvisButton(AntiHitBtn, "ANTI-HIT", 1)
styleJarvisButton(AntiTrapBtn, "ANTI-TRAP", 2)

-- Status Footer
Credit.Name = "Credit"
Credit.Parent = MainFrame
Credit.BackgroundTransparency = 1.000
Credit.Position = UDim2.new(0, 0, 1, -30)
Credit.Size = UDim2.new(1, 0, 0, 25)
Credit.Font = Enum.Font.Code
Credit.Text = "SYS_STATUS: ONLINE // KEYLESS"
Credit.TextColor3 = Color3.fromRGB(100, 100, 100)
Credit.TextSize = 11.000

-- 2. CORE GAME MECHANICS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function getSafeZone()
    if workspace:FindFirstChild("SpawnLocation") then
        return workspace.SpawnLocation.CFrame + Vector3.new(0, 5, 0)
    elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 60, 0)
    end
    return CFrame.new(0, 60, 0)
end

RunService.Heartbeat:Connect(function()
    local character = LocalPlayer.Character
    if not character then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not rootPart or not humanoid then return end

    if AntiHitActive then
        rootPart.Velocity = Vector3.new(0, 0, 0)
        rootPart.RotVelocity = Vector3.new(0, 0, 0)
    end

    if AntiTrapActive and humanoid.Sit then
        humanoid.Sit = false
    end

    if AntiChaseActive then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (string.find(string.lower(obj.Name), "guard") or obj:FindFirstChild("Humanoid")) then
                if obj.Name ~= LocalPlayer.Name and not Players:GetPlayerFromCharacter(obj) then
                    local guardRoot = obj:FindFirstChild("HumanoidRootPart")
                    if guardRoot then
                        local distance = (rootPart.Position - guardRoot.Position).Magnitude
                        if distance < 16 then
                            rootPart.CFrame = getSafeZone()
                            break
                        end
                    end
                end
            end
        end
    end
end)

-- 3. INTERACTIVE TECH BUTTON HANDLERS
AntiChaseBtn.MouseButton1Click:Connect(function()
    AntiChaseActive = not AntiChaseActive
    if AntiChaseActive then
        AntiChaseBtn.Text = ">> ANTI-CHASE [ENGAGED]"
        AntiChaseBtn.TextColor3 = Color3.fromRGB(255, 0, 50)
        AntiChaseBtn.FindFirstChildOfClass("UIStroke").Color = Color3.fromRGB(255, 0, 50)
    else
        AntiChaseBtn.Text = ">> ANTI-CHASE [DISENGAGED]"
        AntiChaseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        AntiChaseBtn.FindFirstChildOfClass("UIStroke").Color = Color3.fromRGB(60, 60, 60)
    end
end)

AntiHitBtn.MouseButton1Click:Connect(function()
    AntiHitActive = not AntiHitActive
    if AntiHitActive then
        AntiHitBtn.Text = ">> ANTI-HIT [ENGAGED]"
        AntiHitBtn.TextColor3 = Color3.fromRGB(255, 0, 50)
        AntiHitBtn.FindFirstChildOfClass("UIStroke").Color = Color3.fromRGB(255, 0, 50)
    else
        AntiHitBtn.Text = ">> ANTI-HIT [DISENGAGED]"
        AntiHitBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        AntiHitBtn.FindFirstChildOfClass("UIStroke").Color = Color3.fromRGB(60, 60, 60)
    end
end)

AntiTrapBtn.MouseButton1Click:Connect(function()
    AntiTrapActive = not AntiTrapActive
    if AntiTrapActive then
        AntiTrapBtn.Text = ">> ANTI-TRAP [ENGAGED]"
        AntiTrapBtn.TextColor3 = Color3.fromRGB(255, 0, 50)
        AntiTrapBtn.FindFirstChildOfClass("UIStroke").Color = Color3.fromRGB(255, 0, 50)
    else
        AntiTrapBtn.Text = ">> ANTI-TRAP [DISENGAGED]"
        AntiTrapBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        AntiTrapBtn.FindFirstChildOfClass("UIStroke").Color = Color3.fromRGB(60, 60, 60)
    end
end)

-- Jarvis System Notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "SAMIR HUB INITIALIZED",
    Text = "Jarvis UI Booted successfully.",
    Duration = 4,
    Button1 = "OK"
})
