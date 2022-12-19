--!strict

local RbxCircleMath = {}
RbxCircleMath.__index = RbxCircleMath

function RbxCircleMath.new(origin: Vector2, radius: number)
    local self = {}
    self.origin = origin
    self.radius = radius
    self.circumference = -1

    return setmetatable(self, RbxCircleMath)
end

function RbxCircleMath:debugDrawLine(a: Vector2, b: Vector2, thickness: number): ScreenGui
    local distance = math.sqrt(math.pow(a.X - b.X, 2) + math.pow(a.Y - b.Y, 2))
    local center = Vector2.new((a.X + b.X)/2, (a.Y + b.Y)/2)
    local rotation = math.atan2(a.Y - b.Y, a.X - b.X)
    
    local container = Instance.new("ScreenGui")
    container.Name = "Line"

    local line = Instance.new("Frame")
    line.Parent = container
    line.Size = UDim2.new(0, distance, 0, thickness)
    line.AnchorPoint = Vector2.new(0.5, 0.5)
    line.Position = UDim2.new(0, center.X, 0, center.Y)
    line.Rotation = math.deg(rotation)
    line.Name = "Line"


    return container
end

function RbxCircleMath:debugDrawPixel(point: Vector2): ScreenGui
    local container = Instance.new("ScreenGui")
    container.Name = "Pixel"

    local pixel = Instance.new("Frame")
    pixel.Parent = container
    pixel.Size = UDim2.new(0,1,0,1)
    pixel.BackgroundColor3 = Color3.new(1,0,0)
    pixel.AnchorPoint = Vector2.new(0.5,0.5)
    pixel.Position = UDim2.new(0,point.X,0,point.Y)

    return container
end

function RbxCircleMath:debugDraw(): ScreenGui
    local container = Instance.new("ScreenGui")

    for i=1, 360 do
        local pos = self:getPosFromAngle(i)

        local pixel = Instance.new("Frame")
        pixel.Parent = container
        pixel.Size = UDim2.new(0,1,0,1)
        pixel.BackgroundColor3 = Color3.new(0.184313, 0.258823, 0.941176)
        pixel.AnchorPoint = Vector2.new(0.5,0.5)
        pixel.Position = UDim2.new(0,pos.X,0,pos.Y)
        pixel.Name = ""..i
    end

    return container
end

function RbxCircleMath:getPosFromAngle(angle: number): Vector2
    local x = (self.origin.X) + (self.radius*math.cos(angle))
    local y = (self.origin.Y) + (self.radius*math.sin(angle))

    return Vector2.new(x, y)
end

function RbxCircleMath:distanceFromCenter(point: Vector2): number
    local distance = (Vector3.new(point.X, point.Y, 0) - Vector3.new(self.origin.X, self.origin.Y, 0)).Magnitude
    return distance
end

function RbxCircleMath:getClosestPoint(point: Vector2): Vector2
    --[[
        double vX = pX - cX;
        double vY = pY - cY;
        double magV = sqrt(vX*vX + vY*vY);
        double aX = cX + vX / magV * R;
        double aY = cY + vY / magV * R;

        V = (P - C); Answer = C + V / |V| * R;
        where P is the point, C is the center, and R is the radius, in a suitable "mathy" language:
        where |V| is length of V.

        p = point
        c = origin
        r = radius

        v = distance ?
    ]]

    local vX = point.X - self.origin.X
    local vY = point.Y - self.origin.Y
    local magV = math.sqrt(vX*vX +vY*vY)
    local aX = self.origin.X + vX / magV * self.radius
    local aY = self.origin.Y + vY / magV * self.radius

    return Vector2.new(aX, aY)
end

export type RbxCircleMath = typeof(RbxCircleMath.new(Vector2.new(0,0), 0))

return RbxCircleMath