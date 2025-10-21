-- MainUI.lua
-- FINAL PURE UI SHELL (NO STATUS, NO LOGIC)
-- Title text will be set from MainScript dynamically.

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local module = {}

local function create(class, props)
	local inst = Instance.new(class)
	for k,v in pairs(props or {}) do
		if k ~= "Parent" then inst[k] = v end
	end
	if props and props.Parent then inst.Parent = props.Parent end
	return inst
end

-- Destroy old version
if playerGui:FindFirstChild("FishIt_UI") then
	playerGui.FishIt_UI:Destroy()
end

-- ScreenGui
local screen = create("ScreenGui", {
	Name = "FishIt_UI",
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	Parent = playerGui
})

-- Main Frame
local main = create("Frame", {
	Name = "MainFrame",
	Parent = screen,
	Size = UDim2.new(0,320,0,350),
	Position = UDim2.new(0.5,-160,0.5,-175),
	BackgroundColor3 = Color3.fromRGB(18,18,22),
	BorderSizePixel = 0
})
create("UICorner",{Parent=main,CornerRadius=UDim.new(0,8)})

-- TITLE BAR
local bar = create("Frame",{
	Parent = main,
	Size = UDim2.new(1,0,0,32),
	BackgroundColor3 = Color3.fromRGB(28,28,34)
})
create("UICorner",{Parent=bar,CornerRadius=UDim.new(0,8)})

local title = create("TextLabel", {
	Parent = bar,
	Size = UDim2.new(1,-80,1,0),
	Position = UDim2.new(0,10,0,0),
	BackgroundTransparency = 1,
	Text = "", -- << will be set via mainscript
	TextColor3 = Color3.fromRGB(180,200,255),
	Font = Enum.Font.GothamBold,
	TextSize = 13,
	TextXAlignment = Enum.TextXAlignment.Left
})

local closeBtn = create("TextButton", {
	Parent = bar,
	Size = UDim2.new(0,26,0,26),
	Position = UDim2.new(1,-34,0,3),
	Text = "X",
	TextColor3 = Color3.fromRGB(255,255,255),
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	BackgroundColor3 = Color3.fromRGB(180,40,40)
})
create("UICorner",{Parent=closeBtn,CornerRadius=UDim.new(0,6)})

local minimizeBtn = create("TextButton", {
	Parent = bar,
	Size = UDim2.new(0,26,0,26),
	Position = UDim2.new(1,-64,0,3),
	Text = "—",
	TextColor3 = Color3.fromRGB(255,255,255),
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	BackgroundColor3 = Color3.fromRGB(60,60,70)
})
create("UICorner",{Parent=minimizeBtn,CornerRadius=UDim.new(0,6)})

-- TABS
local tabContainer = create("Frame",{
	Parent = main,
	Size = UDim2.new(1,-20,0,28),
	Position = UDim2.new(0,10,0,38),
	BackgroundTransparency = 1
})

local tabButtons = {}
local tabNames = {"Main","Teleports","Misc"}

for i,name in ipairs(tabNames) do
	local btn = create("TextButton", {
		Parent = tabContainer,
		Size = UDim2.new(1/#tabNames,-6,1,0),
		Position = UDim2.new((i-1)/#tabNames,(i-1)*3,0,0),
		Text = name,
		Font = Enum.Font.GothamBold,
		TextSize = 10,
		TextColor3 = Color3.fromRGB(220,220,230),
		BackgroundColor3 = i==1 and Color3.fromRGB(44,44,56) or Color3.fromRGB(28,28,34),
	})
	create("UICorner", { Parent = btn, CornerRadius = UDim.new(0,6) })
	tabButtons[name] = btn
end

-- CONTENT (scrolling)
local content = create("ScrollingFrame", {
	Parent = main,
	Size = UDim2.new(1,-20,1,-80),
	Position = UDim2.new(0,10,0,75),
	BackgroundTransparency = 1,
	ScrollBarThickness = 6,
	ScrollBarImageColor3 = Color3.fromRGB(90,110,150),
	CanvasSize = UDim2.new(0,0,0,0)
})

module.ScreenGui = screen
module.MainFrame = main
module.TitleBar = bar
module.TitleLabel = title
module.CloseButton = closeBtn
module.MinimizeButton = minimizeBtn
module.TabButtons = tabButtons
module.ContentFrame = content

return module
