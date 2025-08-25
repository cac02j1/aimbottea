--// Aimbot Tea (delay 0.5s rồi click vào thân)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local VirtualInputManager = game:GetService("VirtualInputManager")

-- GUI nhỏ nhẹ drag được
local gui = Instance.new("ScreenGui")
gui.Name = "AimbotTea"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 120, 0, 40)
frame.Position = UDim2.new(0.1, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, 0, 1, 0)
button.Text = "🎯 Aimbot Tea"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundTransparency = 1
button.Font = Enum.Font.SourceSansBold
button.TextSize = 16
button.Parent = frame

-- Hàm tìm player gần nhất
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if dist < shortestDistance then
                shortestDistance = dist
                closestPlayer = player
            end
        end
    end
    return closestPlayer
end

-- Khi bấm nút
button.MouseButton1Click:Connect(function()
    local target = getClosestPlayer()
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = target.Character.HumanoidRootPart

        -- Xoay camera nhìn vào thân
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, hrp.Position)

        -- Delay 0.5s rồi click
        task.wait(0.5)

        local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
        if onScreen then
            VirtualInputManager:SendMouseMoveEvent(screenPos.X, screenPos.Y, game)

            task.wait(0.05)

            VirtualInputManager:SendMouseButtonEvent(screenPos.X, screenPos.Y, 0, true, game, 0)
            VirtualInputManager:SendMouseButtonEvent(screenPos.X, screenPos.Y, 0, false, game, 0)
        end
    end
end)
