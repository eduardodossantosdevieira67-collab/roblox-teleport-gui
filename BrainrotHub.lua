local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local UserInputService = game:GetService("UserInputService")

local isFlying = false
local isJumping = false
local isClimbing = false

local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 200)
frame.Position = UDim2.new(0.5, -125, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 100, 100)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🧠 BRAINROT HUB"
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255, 100, 100)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.BorderSizePixel = 0
title.Parent = frame

local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(1, -20, 0, 35)
flyButton.Position = UDim2.new(0, 10, 0, 50)
flyButton.Text = "🚀 Flutuar"
flyButton.TextSize = 14
flyButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.Parent = frame

local jumpButton = Instance.new("TextButton")
jumpButton.Size = UDim2.new(1, -20, 0, 35)
jumpButton.Position = UDim2.new(0, 10, 0, 95)
jumpButton.Text = "⬆️ Pulos Infinitos"
jumpButton.TextSize = 14
jumpButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
jumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpButton.Parent = frame

local climbButton = Instance.new("TextButton")
climbButton.Size = UDim2.new(1, -20, 0, 35)
climbButton.Position = UDim2.new(0, 10, 0, 140)
climbButton.Text = "📈 Subir"
climbButton.TextSize = 14
climbButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
climbButton.TextColor3 = Color3.fromRGB(255, 255, 255)
climbButton.Parent = frame

flyButton.MouseButton1Click:Connect(function()
    isFlying = not isFlying
    
    if isFlying then
        flyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        flyButton.Text = "🚀 Flutuar [ON]"
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Parent = humanoidRootPart
        
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bodyGyro.P = 10000
        bodyGyro.Parent = humanoidRootPart
        
        while isFlying do
            local camera = workspace.CurrentCamera
            bodyGyro.CFrame = camera.CFrame
            
            local moveDirection = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                moveDirection = moveDirection - Vector3.new(0, 1, 0)
            end
            
            if moveDirection.Magnitude > 0 then
                moveDirection = moveDirection.Unit
            end
            
            bodyVelocity.Velocity = moveDirection * 50
            task.wait(0.01)
        end
        
        bodyVelocity:Destroy()
        bodyGyro:Destroy()
        flyButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        flyButton.Text = "🚀 Flutuar"
    end
end)

jumpButton.MouseButton1Click:Connect(function()
    isJumping = not isJumping
    
    if isJumping then
        jumpButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        jumpButton.Text = "⬆️ Pulos Infinitos [ON]"
        
        local connection
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            if not isJumping then
                connection:Disconnect()
                jumpButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                jumpButton.Text = "⬆️ Pulos Infinitos"
                return
            end
            
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                humanoid:Jump()
            end
        end)
    end
end)

climbButton.MouseButton1Click:Connect(function()
    isClimbing = not isClimbing
    
    if isClimbing then
        climbButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        climbButton.Text = "📈 Subir [ON]"
        
        local platform = Instance.new("Part")
        platform.Name = "ClimbPlatform"
        platform.Shape = Enum.PartType.Block
        platform.Size = Vector3.new(10, 1, 10)
        platform.BrickColor = BrickColor.new("Bright blue")
        platform.CanCollide = true
        platform.CFrame = humanoidRootPart.CFrame - Vector3.new(0, 5, 0)
        platform.Parent = workspace
        
        local connection
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            if not isClimbing or not platform.Parent then
                if platform.Parent then
                    platform:Destroy()
                end
                climbButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                climbButton.Text = "📈 Subir"
                connection:Disconnect()
                return
            end
            
            local newPosition = humanoidRootPart.Position - Vector3.new(0, 5, 0)
            platform.CFrame = CFrame.new(newPosition)
            humanoidRootPart.AssemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity + Vector3.new(0, 50 * 0.016, 0)
        end)
    end
end)