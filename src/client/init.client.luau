--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local RbxCircleMath = require(ReplicatedStorage.Common.RbxCircleMath)
local Player = game.Players.LocalPlayer
local PlayerGui = Player.PlayerGui

print("Starting example")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0,300,0,300)
Frame.Position = UDim2.new(0.5,0,0.5,0)
Frame.AnchorPoint = Vector2.new(0.5,0.5)
Frame.BackgroundTransparency = 1

local Origin = Instance.new("Frame")
Origin.Parent = Frame
Origin.Size = UDim2.new(0,1,0,1)
Origin.BackgroundColor3 = Color3.new(1,0,0)
Origin.AnchorPoint = Vector2.new(0.5,0.5)
Origin.Position = UDim2.new(0.5,0,0.5,0)

local Point = Instance.new("Frame")
Point.Parent = Frame
Point.Size = UDim2.new(0,1,0,1)
Point.BackgroundColor3 = Color3.new(0.168627, 1, 0)
Point.AnchorPoint = Vector2.new(0.5,0.5)
Point.Position = UDim2.new(0,0,0,0)

local Circle = RbxCircleMath.new(Vector2.new(Origin.AbsolutePosition.X, Origin.AbsolutePosition.Y), 200)

local Result = Circle:debugDraw()
Result.Parent = PlayerGui

local Line = Circle:debugDrawLine(Origin.AbsolutePosition, Point.AbsolutePosition, 1)
Line.Parent = PlayerGui
Line.Line.BackgroundColor3 = Color3.new(0.925490, 0.427450, 0.776470)

local ClosestPoint = Circle:getClosestPoint(Point.AbsolutePosition)
local Intersect = Circle:debugDrawPixel(ClosestPoint)
Intersect.Parent = PlayerGui

local function update()
    if Line then
        Line:Destroy()
    end
    if Intersect then
        Intersect:Destroy()
    end
    Line = Circle:debugDrawLine(Origin.AbsolutePosition, UserInputService:GetMouseLocation(), 1)
    Line.Parent = PlayerGui

    ClosestPoint = Circle:getClosestPoint(UserInputService:GetMouseLocation())
    Intersect = Circle:debugDrawPixel(ClosestPoint)
    Intersect.Parent = PlayerGui
end

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent then
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if Line then 
                Line:Destroy() 
            end
            if Intersect then
                Intersect:Destroy()
            end
            if Point then
                Point:Destroy()
            end

            RunService:BindToRenderStep("update", Enum.RenderPriority.Camera.Value - 1, update)
            -- bind
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent then
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            -- unbind
            RunService:UnbindFromRenderStep("update")
        end
    end
end)

print("done")