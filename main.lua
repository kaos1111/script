-- Wait for game to load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Frame_2 = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local TextLabel = Instance.new("TextLabel")
local TextButton = Instance.new("TextButton")   -- TP Head
local UICorner_3 = Instance.new("UICorner")
local TextButton_2 = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local TextButton_3 = Instance.new("TextButton") -- Anti Aim
local UICorner_5 = Instance.new("UICorner")
local TextButton_4 = Instance.new("TextButton")
local UICorner_6 = Instance.new("UICorner")
local TextButton_5 = Instance.new("TextButton")
local UICorner_7 = Instance.new("UICorner")

-- Properties
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.new(0.0784314, 0.0784314, 0.0784314)
Frame.BorderColor3 = Color3.new(0.00784314, 0.00784314, 0.00784314)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.313264698, 80, 0.0807061791, 67)
Frame.Size = UDim2.new(0, 405, 0, 516)
UICorner.Parent = Frame
UICorner.CornerRadius = UDim.new(0, 15)

Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
Frame_2.BorderColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0.0345679, 0, 0.0349264704, 0)
Frame_2.Size = UDim2.new(0, 373, 0, 62)
UICorner_2.Parent = Frame_2
UICorner_2.CornerRadius = UDim.new(0, 15)

TextLabel.Parent = Frame_2
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0.0187667552, 0, 0.258064508, 0)
TextLabel.Size = UDim2.new(0, 358, 0, 29)
TextLabel.Font = Enum.Font.Unknown
TextLabel.Text = "rivals lua by kaos and cat"
TextLabel.TextColor3 = Color3.new(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14
TextLabel.TextWrapped = true

-- === TP HEAD TOGGLE ===
local tpHeadEnabled = false
local tpConnection = nil

TextButton.Parent = Frame_2
TextButton.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
TextButton.Position = UDim2.new(-0.0179922804, 0, 6.93091869, 0)
TextButton.Size = UDim2.new(0, 385, 0, 40)
TextButton.Font = Enum.Font.LuckiestGuy
TextButton.Text = "TP Head: OFF"
TextButton.TextColor3 = Color3.new(0, 0, 0)
TextButton.TextSize = 14
UICorner_3.Parent = TextButton
UICorner_3.CornerRadius = UDim.new(0, 17)

TextButton.MouseButton1Click:Connect(function()
    tpHeadEnabled = not tpHeadEnabled
    if tpHeadEnabled then
        TextButton.Text = "TP Head: ON"
        TextButton.BackgroundColor3 = Color3.new(0, 0.6, 0)
        tpConnection = RunService.Heartbeat:Connect(function()
            local Character = LocalPlayer.Character
            if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
            local Root = Character.HumanoidRootPart
            local Closest = nil
            local ShortestDistance = math.huge

            for _, Player in ipairs(Players:GetPlayers()) do
                if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("Head") then
                    local Head = Player.Character.Head
                    local Dist = (Head.Position - Root.Position).Magnitude
                    if Dist < ShortestDistance then
                        ShortestDistance = Dist
                        Closest = Head
                    end
                end
            end

            if Closest then
                Root.CFrame = Closest.CFrame * CFrame.new(0, 3, 0)
            end
        end)
    else
        TextButton.Text = "TP Head: OFF"
        TextButton.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
        if tpConnection then tpConnection:Disconnect() tpConnection = nil end
    end
end)

-- === ANTI AIM TOGGLE (Button 3) ===
local antiAimEnabled = false
local antiAimConnection = nil
local ANTI_AIM_DISTANCE = 12

TextButton_3.Parent = Frame_2
TextButton_3.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
TextButton_3.Position = UDim2.new(-0.0204613414, 0, 1.51049554, 0)
TextButton_3.Size = UDim2.new(0, 385, 0, 40)
TextButton_3.Font = Enum.Font.LuckiestGuy
TextButton_3.Text = "Anti Aim: OFF"
TextButton_3.TextColor3 = Color3.new(0, 0, 0)
TextButton_3.TextSize = 14
UICorner_5.Parent = TextButton_3
UICorner_5.CornerRadius = UDim.new(0, 17)

TextButton_3.MouseButton1Click:Connect(function()
    antiAimEnabled = not antiAimEnabled
    
    if antiAimEnabled then
        TextButton_3.Text = "Anti Aim: ON"
        TextButton_3.BackgroundColor3 = Color3.new(0, 0.6, 0)
        
        local originalCFrame = nil
        local isAway = false
        
        antiAimConnection = RunService.Heartbeat:Connect(function()
            local Character = LocalPlayer.Character
            if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
            
            local Root = Character.HumanoidRootPart
            
            if not originalCFrame then
                originalCFrame = Root.CFrame
            end
            
            isAway = not isAway
            
            if isAway then
                local angle = math.random() * math.pi * 2
                local offset = Vector3.new(
                    math.cos(angle) * ANTI_AIM_DISTANCE,
                    0,
                    math.sin(angle) * ANTI_AIM_DISTANCE
                )
                Root.CFrame = originalCFrame * CFrame.new(offset)
            else
                Root.CFrame = originalCFrame
            end
        end)
    else
        TextButton_3.Text = "Anti Aim: OFF"
        TextButton_3.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
        if antiAimConnection then
            antiAimConnection:Disconnect()
            antiAimConnection = nil
        end
    end
end)

-- Make GUI Draggable
local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging and dragInput then
        update(dragInput)
    end
end)

-- Other Buttons (Visual Only)
TextButton_2.Parent = Frame_2
TextButton_2.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
TextButton_2.Position = UDim2.new(-0.020884987, 0, 5.67943621, 0)
TextButton_2.Size = UDim2.new(0, 385, 0, 40)
TextButton_2.Font = Enum.Font.LuckiestGuy
TextButton_2.Text = "Button 2"
TextButton_2.TextColor3 = Color3.new(0, 0, 0)
TextButton_2.TextSize = 14
UICorner_4.Parent = TextButton_2
UICorner_4.CornerRadius = UDim.new(0, 17)

TextButton_4.Parent = Frame_2
TextButton_4.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
TextButton_4.Position = UDim2.new(-0.0219494198, 0, 4.33792305, 0)
TextButton_4.Size = UDim2.new(0, 385, 0, 40)
TextButton_4.Font = Enum.Font.LuckiestGuy
TextButton_4.Text = "Button 4"
TextButton_4.TextColor3 = Color3.new(0, 0, 0)
TextButton_4.TextSize = 14
UICorner_6.Parent = TextButton_4
UICorner_6.CornerRadius = UDim.new(0, 17)

TextButton_5.Parent = Frame_2
TextButton_5.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
TextButton_5.Position = UDim2.new(-0.019268455, 0, 2.92811537, 0)
TextButton_5.Size = UDim2.new(0, 385, 0, 40)
TextButton_5.Font = Enum.Font.LuckiestGuy
TextButton_5.Text = "Button 5"
TextButton_5.TextColor3 = Color3.new(0, 0, 0)
TextButton_5.TextSize = 14
UICorner_7.Parent = TextButton_5
UICorner_7.CornerRadius = UDim.new(0, 17)
