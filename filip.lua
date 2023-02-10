local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local UserInputService = game:GetService("UserInputService")
local Toggle = false
local tweenService = game:GetService("TweenService")
local info = TweenInfo.new(5)

local RoundedCorner = Instance.new("UICorner")
RoundedCorner.CornerRadius = UDim.new(0, 15)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player.PlayerGui

local RootFrame = Instance.new("Frame")
RootFrame.Parent = ScreenGui
RootFrame.Size = UDim2.new(0, 400, 0, 400)
RootFrame.AnchorPoint = Vector2.new(0, 1)
RootFrame.Position = UDim2.new(0, -400, 1, 0)
RootFrame.BackgroundColor3 = Color3.new(255,255,255)
RootFrame.ClipsDescendants = true
RoundedCorner:Clone().Parent = RootFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 46, 46)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Parent = RootFrame
CloseButton.AnchorPoint = Vector2.new(1, 0)
CloseButton.Position = UDim2.new(1, 0, 0, 0)
CloseButton.TextSize = 18
RoundedCorner:Clone().Parent = CloseButton
CloseButton.ZIndex = 6

local Menu = Instance.new("Frame")
Menu.Size = UDim2.new(0, 125, 1, 0)
local UIGridLayout = Instance.new("UIGridLayout")
UIGridLayout.SortOrder = 2
UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 10)
UIGridLayout.CellSize = UDim2.new(1, -20, 0, 30)
UIGridLayout.Parent = Menu
UIGridLayout.HorizontalAlignment = "Center"
UIGridLayout.VerticalAlignment = "Center"
Menu.Transparency = 1
Menu.Parent = RootFrame

local Line = Instance.new("Frame")
Line.Size = UDim2.new(0, 2, 1, 0)
Line.BorderSizePixel = 0
Line.BackgroundColor3 = Color3.fromRGB(184, 184, 184)
Line.Position = UDim2.new(0,124,0,0)
Line.Parent = RootFrame

local Title = Instance.new("TextLabel")
Title.Text = "RCEZ to zoo"
Title.TextScaled = true
Title.Font = Enum.Font.ArialBold
Title.BackgroundTransparency = 1
Title.Parent = Menu

local MenuButton = Instance.new("TextButton")
MenuButton.BackgroundColor3 = Color3.fromRGB(255, 201, 51)
MenuButton.Font = Enum.Font.ArialBold
MenuButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RoundedCorner:Clone().Parent = MenuButton
MenuButton.TextSize = 20

local MenuScrollFrame = Instance.new("ScrollingFrame")
MenuScrollFrame.Size = UDim2.new(0, 300, 1, -20)
MenuScrollFrame.BackgroundTransparency = 1
MenuScrollFrame.BorderSizePixel = 0
MenuScrollFrame.Position = UDim2.new(1,0,0.5,0)
MenuScrollFrame.Visible = false
MenuScrollFrame.AnchorPoint = Vector2.new(1, 0.5)

local MenuFrame = Instance.new("Frame")
MenuFrame.Size = UDim2.new(0, 300, 1, 0)
MenuFrame.BackgroundTransparency = 1
MenuFrame.AnchorPoint = Vector2.new(1, 0)
MenuFrame.Position = UDim2.new(1,0,0,0)
MenuFrame.Visible = false

--HOME

local Home = MenuFrame:Clone()
Home.Parent = RootFrame

--TELEPORTS

local TeleportsFrame = MenuFrame:Clone()
TeleportsFrame.Parent = RootFrame
local UIListLayout = Instance.new("UIListLayout", TeleportsFrame)
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.HorizontalAlignment = "Center"
UIListLayout.VerticalAlignment = "Center"
UIListLayout.SortOrder = 0

local TeleportOresFrame = MenuScrollFrame:Clone()
UIListLayout:Clone().Parent = TeleportOresFrame
TeleportOresFrame.UIListLayout.VerticalAlignment = "Top"
TeleportOresFrame.Parent = RootFrame

local TeleportToPlot = MenuButton:Clone()
TeleportToPlot.Size = UDim2.new(0, 200, 0, 35)
TeleportToPlot.TextScaled = true
TeleportToPlot.Text = "Teleportuj do działki (Twojej)"
TeleportToPlot.Parent = TeleportsFrame


local TeleportToMeFrame = TeleportOresFrame:Clone()
TeleportToMeFrame.Parent = RootFrame

local TeleportOtherFrame = TeleportToMeFrame:Clone()
TeleportOtherFrame.Parent = RootFrame

local TeleportStoresFrame = TeleportOresFrame:Clone()
TeleportStoresFrame.Parent = RootFrame

local TeleportLocationsFrame = TeleportOresFrame:Clone()
TeleportLocationsFrame.Parent = RootFrame

local TeleportButtons = {
    {"Lokalizacje", TeleportLocationsFrame},
    {"Sklepy", TeleportStoresFrame},
    {"Surowce", TeleportOresFrame},
    {"Moje surowce", TeleportToMeFrame, function()
        for _, v in pairs(TeleportToMeFrame:GetChildren()) do
           if v:IsA("TextButton") then
                v:Destroy()
           end
        end
        local Grabable = {}
        for _, v in pairs(workspace.Grabable:GetChildren()) do
            if v:findFirstChild("Owner") and v:findFirstChild("Configuration") and v.Configuration:findFirstChild("Data") and v.Configuration.Data:findFirstChild("MatInd") and v.Owner.Value.UserId == Player.UserId then
                local f = true
                for _, a in ipairs(Grabable) do 
                    if a[1] == v.Configuration.Data.MatInd.Value then
                        f = false
                        table.insert(a[2], v)
                    end
                end
                if f then
                    table.insert(Grabable, {v.Configuration.Data.MatInd.Value, {v}})
                end
            end
        end
        for _, v in ipairs(Grabable) do
            local Btn = MenuButton:Clone()
            Btn.Text = v[1].." x"..#v[2]
            Btn.Parent = TeleportToMeFrame
            Btn.Size = UDim2.new(0, 200, 0, 35)
            Btn.MouseButton1Click:Connect(function()
                for i=0, 5, 1 do
                    wait(.01)
                    for _, e in pairs(v[2]) do
                        if e and e.PrimaryPart then
                            e:SetPrimaryPartCFrame(Character:GetPrimaryPartCFrame() * CFrame.new(0, 5, 0))
                        end
                    end
                end
            end)
        end
    end},
    {"Wolne przedmioty", TeleportOtherFrame, function()
        for _, v in pairs(TeleportOtherFrame:GetChildren()) do
           if v:IsA("TextButton") then
                v:Destroy()
           end
        end
        local Grabable = {}
        for _, v in pairs(workspace.Grabable:GetChildren()) do
            if v:findFirstChild("Owner") and v.Owner.Value == nil then
                local f = true
                for _, a in ipairs(Grabable) do 
                    if a[1] == v.Name then
                        f = false
                        table.insert(a[2], v)
                    end
                end
                if f then
                    table.insert(Grabable, {v.Name, {v}})
                end
            end
        end
        for _, v in ipairs(Grabable) do
            local Btn = MenuButton:Clone()
            Btn.Text = v[1].." x"..#v[2]
            Btn.Parent = TeleportOtherFrame
            Btn.Size = UDim2.new(0, 200, 0, 35)
            Btn.MouseButton1Click:Connect(function()
                for i=0, 5, 1 do
                    wait(.01)
                    for _, e in pairs(v[2]) do
                        if e then
                            e:SetPrimaryPartCFrame(Character:GetPrimaryPartCFrame() * CFrame.new(0, 5, 0))
                        end
                    end
                end
            end)
        end
    end}
}

local MenuButtons = {
    {"Teleporty", TeleportsFrame}
}

local TeleportOresLocations = {
    {"Uranium", Vector3.new(-71.5, 74.3, 4621.2)}
}

local TeleportStoresLocations = {
    {"UCS", Vector3.new(-999.4, 5, -611)},
    {"Land Agency", Vector3.new(-1008, 5, -717.75)},
    {"Ore sellary", Vector3.new(-464.25, 6, -71)},
    {"Pickaxes store", Vector3.new(738, 2, 54)},
    {"Secret store", Vector3.new(-500, 5, -668)},
    {"Furniture store", Vector3.new(-1017.5, 5, 756)},
    {"Merchant's keep", Vector3.new(-3175.5, 17, 607.4)},
    {"Electronics antsishop", Vector3.new(-98, 240, 1075)},
    {"Meteor Rug", Vector3.new(-3479.5, 17.3, 1046.8)}
}

local TeleportLocations = {
    {"", Vector3.new()}
}

local function tweenModel(model, CF)
	local CFrameValue = Instance.new("CFrameValue")
	CFrameValue.Value = model:GetPrimaryPartCFrame()

	CFrameValue:GetPropertyChangedSignal("Value"):Connect(function()
		model:SetPrimaryPartCFrame(CFrameValue.Value)
	end)
	
	local tween = tweenService:Create(CFrameValue, info, {Value = CF})
	tween:Play()
	
	tween.Completed:Connect(function()
		CFrameValue:Destroy()
	end)
end

function getOre(name)
    if game.ReplicatedStorage.Materials:findFirstChild(name) then
        return game.ReplicatedStorage.Materials:findFirstChild(name)
    end
    return nil
end

function teleportToLocation(vector)
Character:MoveTo(vector)
    for i=0, 15, 1 do
        
        Character.Humanoid.Jump = true
        wait()
        Character.Humanoid.Jump = false
    end
end

function kill()
    ScreenGui:Destroy()
end

local CurrentFrame = nil

function showFrame(frame)
    if CurrentFrame then
        CurrentFrame.Visible = false
    end
    CurrentFrame = frame
    CurrentFrame.Visible = true
end

function getPlayerPlot(player)
    for _, Plot in pairs(workspace.Plots:GetChildren()) do
        if Plot.Owner.Value and Plot.Owner.Value.UserId == player.UserId then
            return Plot
        end
    end
    return nil
end



for i, v in ipairs(TeleportOresLocations) do
    local Btn = MenuButton:Clone()
    local Ore = getOre(v[1])
    if Ore then
        Btn.Text = Ore.Name
        Btn.BackgroundColor3 = Ore.Color
        Btn.Size = UDim2.new(0, 200, 0, 35)
        Btn.SelectionOrder = i
        Btn.Parent = TeleportOresFrame
        Btn.MouseButton1Click:Connect(function()
            teleportToLocation(v[2])
        end)
    end
end

for i, v in ipairs(TeleportStoresLocations) do
    local Btn = MenuButton:Clone()
    Btn.Text = v[1]
    Btn.Size = UDim2.new(0, 200, 0, 35)
    Btn.SelectionOrder = i
    Btn.Parent = TeleportStoresFrame
    Btn.MouseButton1Click:Connect(function()
        teleportToLocation(v[2])
    end)

end


for i, Button in ipairs(TeleportButtons) do
    local Btn = MenuButton:Clone()
    Btn.Text = Button[1]
    Btn.SelectionOrder = i
    Btn.Size = UDim2.new(0, 200, 0, 35)
    Btn.Parent = TeleportsFrame
    Btn.MouseButton1Click:Connect(function()
        showFrame(Button[2])
        if Button[3] then
            Button[3]()
        end
    end)
end 

TeleportToPlot.MouseButton1Click:Connect(function()
    local Plot = getPlayerPlot(Player)
    if Plot then
        teleportToLocation(Plot.Base.Position + Vector3.new(0, 5, 0))
    end
end)

for a, Button in ipairs(MenuButtons) do
    local Btn = MenuButton:Clone()
    Btn.Text = Button[1]
    Btn.Parent = Menu
    Btn.SelectionOrder = a
    local f = Button[2]
    Btn.MouseButton1Click:Connect(function() 
        showFrame(f)
    end)
end


Player.CharacterAdded:Connect(function(character)
    Character = character
end)

CloseButton.MouseButton1Click:Connect(kill)
UserInputService.InputBegan:Connect(function(key)
    if key.keyCode == Enum.KeyCode.B then
        if Toggle then
            Toggle = false
            RootFrame:TweenPosition(UDim2.new(0, -400, 1, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2)
        else
            Toggle = true
            RootFrame:TweenPosition(UDim2.new(0, 0, 1, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2)
        end
    end
end)
