--// FULL OPTIMIZED ESP LIBRARY //--

local Library = {}

-- 🔧 Pool Tables
Library.Pools = {
	Highlights = {},
	TextLabels = {},
	Frames = {},
	Tracers = {},
	Strokes = {}
}

-- 🧤 Pool Utilities
function Library:GetFromPool(poolName, className)
	local pool = Library.Pools[poolName]
	for i, obj in ipairs(pool) do
		if obj and obj.Parent == nil then
			table.remove(pool, i)
			return obj
		end
	end
	return Instance.new(className)
end



function Library:ReturnToPool(poolName, obj)
	obj.Parent = nil
	table.insert(Library.Pools[poolName], obj)
end

-- 🎯 Constants & Services
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

-- ⚙️ Config
local FRAME_SKIP = 2
local tickCounter = 0
Library.TextSize = 20
Library.TextTransparency = 0
Library.TextOutlineTransparency = 0
Library.Font = Enum.Font.Oswald
Library.FadeTime = 0.2
Library.FillTransparency = 0.75
Library.OutlineTransparency = 0
Library.OutlineColor = Color3.new(1, 1, 1)
Library.TracerThickness = 0.75
Library.DistanceSizeRatio = 1
Library.TracerOrigin = "Bottom"
Library.ShowDistance = false
Library.MatchColors = true
Library.Rainbow = false
Library.Tracers = false
Library.Unloaded = false

local TweenInfoFade = TweenInfo.new(Library.FadeTime, Enum.EasingStyle.Quad)

-- 🌈 Rainbow Setup
local RainbowTable = { Hue = 0, Step = 0, Color = Color3.new() }

-- 🖼️ GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

local HighlightsFolder = Instance.new("Folder", ScreenGui)
local BillboardsFolder = Instance.new("Folder", ScreenGui)
local TracersFrame = Instance.new("Frame")
TracersFrame.Size = UDim2.new(1, 0, 1, 0)
TracersFrame.BackgroundTransparency = 1
TracersFrame.Visible = false
TracersFrame.Parent = ScreenGui

-- 📦 Internal Tables
local Labels, Frames, Highlights, Lines, Texts, Colors = {}, {}, {}, {}, {}, {}
local ElementsEnabled, TransparencyEnabled, Objects = {}, {}, {}
local RemovedObjects = {}

-- 📍 AddESP
function Library:AddESP(params)
	local obj = params.Object
	if not obj or ElementsEnabled[obj] or Library.Unloaded then return end

	ElementsEnabled[obj] = true
	TransparencyEnabled[obj] = false
	Objects[obj] = obj
	Texts[obj] = params.Text
	Colors[obj] = params.Color

	local highlight = Library:GetFromPool("Highlights", "Highlight")
	highlight.Adornee = obj
	highlight.FillTransparency = 1
	highlight.OutlineTransparency = 1
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = HighlightsFolder
	Highlights[obj] = highlight

	local frame = Library:GetFromPool("Frames", "Frame")
	frame.BackgroundTransparency = 1
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.Visible = false
	frame.Parent = BillboardsFolder
	Frames[obj] = frame

	local label = Library:GetFromPool("TextLabels", "TextLabel")
	label.BackgroundTransparency = 1
	label.Text = params.Text
	label.TextSize = Library.TextSize
	label.Font = Library.Font
	label.RichText = true
	label.TextTransparency = 1
	label.TextStrokeTransparency = Library.TextOutlineTransparency
	label.TextColor3 = params.Color
	label.Size = UDim2.new(1, 0, 1, 0)
	label.Parent = frame
	Labels[obj] = label

	
		local lineFrame = Library:GetFromPool("Tracers", "Frame")
		lineFrame.Size = UDim2.new(0, 0, 0, 0)
		lineFrame.BackgroundTransparency = 0
		lineFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		lineFrame.Parent = TracersFrame
	lineFrame.BorderSizePixel = 0

		local stroke = Library:GetFromPool("Strokes", "UIStroke")
		stroke.Thickness = Library.TracerThickness
		stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		stroke.Transparency = 0
		stroke.Parent = lineFrame

		Lines[obj] = {lineFrame, stroke}
	

	-- Fade in
	TweenService:Create(highlight, TweenInfoFade, {
		FillTransparency = Library.FillTransparency,
		OutlineTransparency = Library.OutlineTransparency
	}):Play()
	local tween = TweenService:Create(label, TweenInfoFade, {
		TextTransparency = Library.TextTransparency
	})
	tween:Play()
	TweenService:Create(label, TweenInfoFade, {
		TextStrokeTransparency = Library.TextOutlineTransparency
	}):Play()
	tween.Completed:Connect(function()
		TransparencyEnabled[obj] = true
	end)
end

-- 🧹 RemoveESP
function Library:RemoveESP(obj)
	if RemovedObjects[obj] or not ElementsEnabled[obj] then return end
	RemovedObjects[obj] = true
	ElementsEnabled[obj] = false
	TransparencyEnabled[obj] = false

	local highlight, label, frame = Highlights[obj], Labels[obj], Frames[obj]
	Highlights[obj], Labels[obj], Frames[obj], Objects[obj] = nil, nil, nil, nil

	if label then
		TweenService:Create(label, TweenInfoFade, { TextTransparency = 1 }):Play()
	end
	if highlight then
		TweenService:Create(highlight, TweenInfoFade, { FillTransparency = 1, OutlineTransparency = 1 }):Play()
	end
	if Lines[obj] then
		local line, stroke = Lines[obj][1], Lines[obj][2]
		if line then TweenService:Create(line, TweenInfoFade, { BackgroundTransparency = 1 }):Play() end
		if stroke then TweenService:Create(stroke, TweenInfoFade, { Transparency = 1 }):Play() end
	end

	task.delay(Library.FadeTime + 0.2, function()
		if frame then Library:ReturnToPool("Frames", frame) end
		if label then Library:ReturnToPool("TextLabels", label) end
		if highlight then Library:ReturnToPool("Highlights", highlight) end
		if Lines[obj] then
			if Lines[obj][1] then Library:ReturnToPool("Tracers", Lines[obj][1]) end
			if Lines[obj][2] then Library:ReturnToPool("Strokes", Lines[obj][2]) end
		end
		Lines[obj] = nil
		RemovedObjects[obj] = nil
	end)
end

-- 📡 Main Update Loop
RunService.RenderStepped:Connect(function()
	tickCounter += 1
	if tickCounter % FRAME_SKIP ~= 0 then return end

	for obj in pairs(Objects) do
		if not obj:IsDescendantOf(workspace) then
			Library:RemoveESP(obj)
			continue
		end

		local pos = obj:IsA("BasePart") and obj.Position or obj:GetPivot().Position
		local screenPoint, onScreen = Camera:WorldToViewportPoint(pos)

		local label = Labels[obj]
		local frame = Frames[obj]
		local highlight = Highlights[obj]

		if frame then frame.Visible = onScreen end
		if not onScreen then
			if highlight then highlight:Destroy() Highlights[obj] = nil end
			if Lines[obj] and Lines[obj][1] then Lines[obj][1].Visible = false end
			continue
		end

		if frame then frame.Position = UDim2.new(0, screenPoint.X, 0, screenPoint.Y) end

		local dist = math.round(Players.LocalPlayer:DistanceFromCharacter(pos))
		local distText = Library.ShowDistance and ("\n<font size=\"" .. math.round(Library.TextSize * Library.DistanceSizeRatio) .. "\">[" .. dist .. "]</font>") or ""
		if label then label.Text = Texts[obj] .. distText end

		if highlight then
		if Library.Rainbow then
			highlight.FillColor = RainbowTable.Color
			label.TextColor3 = RainbowTable.Color
		elseif Colors[obj] then
			highlight.FillColor = Colors[obj]
			label.TextColor3 = Colors[obj]
		end

		highlight.OutlineColor = Library.MatchColors and highlight.FillColor or Library.OutlineColor
		highlight.Enabled = true

		if TransparencyEnabled[obj] then
			highlight.FillTransparency = Library.FillTransparency
			highlight.OutlineTransparency = Library.OutlineTransparency
			label.TextTransparency = Library.TextTransparency
			label.TextStrokeTransparency = Library.TextOutlineTransparency
		end
		else
			highlight = Library:GetFromPool("Highlights", "Highlight")
			highlight.Adornee = obj
			highlight.FillTransparency = 1
			highlight.OutlineTransparency = 1
			highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			highlight.Parent = HighlightsFolder
			Highlights[obj] = highlight
		end

		if Library.Tracers and Lines[obj] then
			local origin
			if Library.TracerOrigin == "Center" then
				origin = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
			elseif Library.TracerOrigin == "Top" then
				origin = Vector2.new(Camera.ViewportSize.X / 2, 0)
			elseif Library.TracerOrigin == "Mouse" then
				origin = UIS:GetMouseLocation()
			else
				origin = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
			end

			local destination = Vector2.new(screenPoint.X, screenPoint.Y)
			local midpoint = (origin + destination) / 2
			local rotation = math.deg(math.atan2(destination.Y - origin.Y, destination.X - origin.X))
			local length = (origin - destination).Magnitude

			local lineFrame = Lines[obj][1]
			local stroke = Lines[obj][2]

			lineFrame.Position = UDim2.new(0, midpoint.X, 0, midpoint.Y)
			lineFrame.Size = UDim2.new(0, length, 0, 1)
			lineFrame.Rotation = rotation
			lineFrame.BackgroundColor3 = highlight.FillColor
			stroke.Color = highlight.FillColor
			lineFrame.Visible = true
		end
	end
end)

--// EXTENDED CONFIG FUNCTIONS //--

function Library:SetColorTable(Name, Color)
	Colors[Name] = Color
	if Labels[Name] then
		Labels[Name].TextColor3 = Color
	end
end

function Library:SetFadeTime(Number)
	Library.FadeTime = Number
end

function Library:SetTextTransparency(Number)
	Library.TextTransparency = Number
	for _, label in pairs(Labels) do
		label.TextTransparency = Number
	end
end

function Library:SetTextSize(Number)
	Library.TextSize = Number
	for _, label in pairs(Labels) do
		label.TextSize = Number
	end
end

function Library:SetTextOutlineTransparency(Number)
	Library.TextOutlineTransparency = Number
	for _, label in pairs(Labels) do
		label.TextStrokeTransparency = Number
	end
end

function Library:SetFillTransparency(Number)
	Library.FillTransparency = Number
	for _, highlight in pairs(Highlights) do
		highlight.FillTransparency = Number
	end
end

function Library:SetOutlineTransparency(Number)
	Library.OutlineTransparency = Number
	for _, highlight in pairs(Highlights) do
		highlight.OutlineTransparency = Number
	end
end

function Library:SetOutlineColor(Color)
	Library.OutlineColor = Color
end

function Library:SetFont(Font)
	Library.Font = Font
	for _, label in pairs(Labels) do
		label.Font = Font
	end
end

function Library:SetRainbow(Value)
	Library.Rainbow = Value
end

function Library:SetShowDistance(Value)
	Library.ShowDistance = Value
end

function Library:SetMatchColors(Value)
	Library.MatchColors = Value
end

function Library:SetTracers(Value)
	Library.Tracers = Value
	TracersFrame.Visible = Value
end

function Library:SetTracerOrigin(Value)
	Library.TracerOrigin = Value
end

function Library:SetDistanceSizeRatio(Value)
	Library.DistanceSizeRatio = Value
end

function Library:SetTracerSize(Value)
	Library.TracerThickness = 0.75 * Value
end

function Library:UpdateObjectText(Object, Text)
	if Labels[Object] then
		Texts[Object] = Text
		Labels[Object].Text = Text
	end
end

function Library:UpdateObjectColor(Object, Color)
	Colors[Object] = Color
	if Labels[Object] then
		Labels[Object].TextColor3 = Color
	end
	if Highlights[Object] then
		Highlights[Object].FillColor = Color
	end
end

function Library:GenerateRandomString()
	local chars = "0123456789abcdef"
	local function segment()
		local result = {}
		for i = 1, math.random(9, 11) do
			table.insert(result, chars:sub(math.random(1, #chars), math.random(1, #chars)))
		end
		return table.concat(result)
	end
	return segment() .. "-" .. segment() .. "-" .. segment() .. "-" .. segment() .. "-" .. segment() .. "-" .. segment()
end

-- 🌈 Rainbow Color Update
RunService.RenderStepped:Connect(function(delta)
	RainbowTable.Step += delta
	if RainbowTable.Step >= 1 / 60 then
		RainbowTable.Step = 0
		RainbowTable.Hue += 1 / 400
		if RainbowTable.Hue > 1 then RainbowTable.Hue = 0 end
		RainbowTable.Color = Color3.fromHSV(RainbowTable.Hue, 0.8, 1)
	end
end)

-- 🧼 Unload Function
function Library:Unload()
	Library.Unloaded = true
	for obj in pairs(Objects) do
		Library:RemoveESP(obj)
	end
	ScreenGui.Enabled = false
end

return Library
