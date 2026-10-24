local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

if getgenv().AdvancedControlPanel then
    getgenv().AdvancedControlPanel:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdvancedControlPanel"
screenGui.ResetOnSpawn = false
getgenv().AdvancedControlPanel = screenGui

local success = pcall(function()
    screenGui.Parent = CoreGui
end)
if not success then
    screenGui.Parent = localPlayer:WaitForChild("PlayerGui")
end

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 240, 0, 240)
mainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 180, 0, 35)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "DEVELOPER MENU"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainFrame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(0, 200, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 14
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

local speedButton = Instance.new("TextButton")
speedButton.Size = UDim2.new(0, 220, 0, 40)
speedButton.Position = UDim2.new(0, 10, 0, 45)
speedButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speedButton.Text = "SPEED (100): OFF"
speedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
speedButton.TextSize = 14
speedButton.Font = Enum.Font.GothamBold
speedButton.Parent = mainFrame

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 6)
speedCorner.Parent = speedButton

local tpButton = Instance.new("TextButton")
tpButton.Size = UDim2.new(0, 220, 0, 40)
tpButton.Position = UDim2.new(0, 10, 0, 95)
tpButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tpButton.Text = "TELEPORT FORWARD"
tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButton.TextSize = 14
tpButton.Font = Enum.Font.GothamBold
tpButton.Parent = mainFrame

local tpCorner = Instance.new("UICorner")
tpCorner.CornerRadius = UDim.new(0, 6)
tpCorner.Parent = tpButton

local vanishButton = Instance.new("TextButton")
vanishButton.Size = UDim2.new(0, 220, 0, 40)
vanishButton.Position = UDim2.new(0, 10, 0, 145)
vanishButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
vanishButton.Text = "VANISH: OFF"
vanishButton.TextColor3 = Color3.fromRGB(255, 255, 255)
vanishButton.TextSize = 14
vanishButton.Font = Enum.Font.GothamBold
vanishButton.Parent = mainFrame

local vanishCorner = Instance.new("UICorner")
vanishCorner.CornerRadius = UDim.new(0, 6)
vanishCorner.Parent = vanishButton

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(0, 220, 0, 30)
infoLabel.Position = UDim2.new(0, 10, 0, 195)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "Press [Right Control] to hide/show"
infoLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
infoLabel.TextSize = 11
infoLabel.Font = Enum.Font.Gotham
infoLabel.Parent = mainFrame

getgenv().SpeedState = false
getgenv().VanishState = false
local normalSpeed = 16
local targetSpeed = 100

local function getCharacterElements()
    local char = localPlayer.Character
    if char then
        return char:FindFirstChildOfClass("Humanoid"), char:FindFirstChild("HumanoidRootPart"), char
    end
    return nil, nil, nil
end

speedButton.MouseButton1Click:Connect(function()
    getgenv().SpeedState = not getgenv().SpeedState
    if getgenv().SpeedState then
        speedButton.Text = "SPEED (100): ON"
        speedButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
    else
        speedButton.Text = "SPEED (100): OFF"
        speedButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        local hum = getCharacterElements()
        if hum then hum.WalkSpeed = normalSpeed end
    end
end)

tpButton.MouseButton1Click:Connect(function()
    local _, root = getCharacterElements()
    if root then
        root.CFrame = root.CFrame + (root.CFrame.LookVector * 25)
    end
end)

vanishButton.MouseButton1Click:Connect(function()
    getgenv().VanishState = not getgenv().VanishState
    local _, _, char = getCharacterElements()
    
    if getgenv().VanishState then
        vanishButton.Text = "VANISH: ON"
        vanishButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        if char then
            for _, obj in pairs(char:GetDescendants()) do
                if obj:IsA("BasePart") or obj:IsA("Decal") then
                    if obj.Name ~= "HumanoidRootPart" then
                        obj.Transparency = 1
                    end
                end
            end
        end
    else
        vanishButton.Text = "VANISH: OFF"
        vanishButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        if char then
            for _, obj in pairs(char:GetDescendants()) do
                if obj:IsA("BasePart") or obj:IsA("Decal") then
                    if obj.Name ~= "HumanoidRootPart" then
                        if obj.Name == "Head" then
                            obj.Transparency = 0
                        elseif obj:IsA("Decal") then
                            obj.Transparency = 0
                        else
