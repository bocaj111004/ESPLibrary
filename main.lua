
-- Variables --

local Library = {
	MainFolder = Instance.new("Folder"),
	ObjectsFolder = Instance.new("Folder"),
	ScreenGui = Instance.new("ScreenGui"),
	OtherGui = Instance.new("ScreenGui"),
	HighlightsFolder = Instance.new("Folder"),
	BillboardsFolder = Instance.new("Folder"),
	Highlights = {},
	Labels = {},
	Elements = {},
	Frames = {},
	Connections = {},
	Billboards = {},
	ColorTable = {},
	Font = Enum.Font.Oswald,
	ConnectionsTable = {},
	Objects = {},
	TracerTable = {},
	HighlightedObjects = {},
	RemoveIfNotVisible = true,
	Rainbow = false,
	UseBillboards = true,
	Tracers = false,
	MatchColors = false,
	TextTransparency = 0,
	FillTransparency = 0.75,
	OutlineTransparency = 0,
	FadeTime = 0,
	TextSize = 20,
	OutlineColor = Color3.fromRGB(255,255,255)
}

local RainbowTable = {
	HueSetup = 0,
	Hue = 0,
	Step = 0,
	Color = Color3.new(),
	Enabled = false,


}


MainFolder = Library.MainFolder
ObjectsFolder = Library.ObjectsFolder
HttpService = game:GetService("HttpService")
HighlightedObjects = Library.HighlightedObjects
Highlights = Library.Highlights
Camera = workspace.CurrentCamera
ConnectionsTable = Library.ConnectionsTable
Objects = Library.Objects
Billboards = Library.Billboards
Frames = Library.Frames
ScreenGui = Library.ScreenGui
HighlightsFolder = Library.HighlightsFolder
BillboardsFolder = Library.BillboardsFolder
Labels = Library.Labels
Connections = Library.Connections
OtherGui = Library.OtherGui 
Elements = Library.Elements
CoreGui = game:GetService("CoreGui")
Players = game:GetService("Players")
RunService = game:GetService("RunService")
TweenService = game:GetService("TweenService")
ProtectGui = protectgui or (function() end);
ColorTable = Library.ColorTable
ScreenGui.Parent = MainFolder
OtherGui.Parent = ScreenGui
HighlightsFolder.Parent = MainFolder
BillboardsFolder.Parent = MainFolder
MainFolder.Parent = CoreGui

pcall(ProtectGui,ScreenGui)
pcall(ProtectGui,OtherGui)

-- Functions --

function Library:GenerateRandomString()
	local Characters = "abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	
	local RandomString = ""


	local function GenerateSegment()

		local Result = {}
		local RandomNumber = math.random(6,11)
		for i = 1, RandomNumber do

			local RandomIndex = math.random(1, #Characters)
			table.insert(Result, Characters:sub(RandomIndex, RandomIndex))
		end
		return table.concat(Result)
	end
	local Segment1 = GenerateSegment()
	local Segment2 = GenerateSegment()
	local Segment3 = GenerateSegment()
	local Segment4 = GenerateSegment()
	local Segment5 = GenerateSegment()
	local Segment6 = GenerateSegment()
	RandomString = Segment1 .. Segment2 .. Segment3 .. Segment4 .. Segment5 .. Segment6
	return RandomString
end

function Library:AddESP(Parameters)
	local Object = Parameters.Object







	local MainPart = nil
	if Parameters.BasePart then
		MainPart = Parameters.BasePart
	end

local ObjectTable = {}
	local Highlight = Instance.new("Highlight")
	Highlight.Name = Library:GenerateRandomString()
	Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	Highlight.FillTransparency = 1
	Highlight.OutlineTransparency = 1
	Highlight.FillColor = Parameters.Color
	Highlight.OutlineColor = Parameters.Color
	Highlight.Parent = HighlightsFolder
	Highlight.Adornee = Object
	local TextFrame = Instance.new("Frame")
	TextFrame.Name = Library:GenerateRandomString()
	TextFrame.BackgroundTransparency = 1
	TextFrame.Size = UDim2.new(1,0,1,0)
	TextFrame.AnchorPoint = Vector2.new(0.5,0.5)
	TextFrame.Parent = ScreenGui
	local TextLabel = Instance.new("TextLabel")
	TextLabel.Name = Library:GenerateRandomString()
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = Parameters.Text
	TextLabel.TextTransparency = 1
	TextLabel.TextStrokeTransparency = 0
	TextLabel.Size = UDim2.new(1,0,1,0)
	TextLabel.Font = Library.Font
	TextLabel.TextSize = Library.TextSize
	TextLabel.Parent = TextFrame
	TextLabel.TextColor3 = Parameters.Color
	local BillboardGui = Instance.new("BillboardGui")
	BillboardGui.Name = Library:GenerateRandomString()
	BillboardGui.Parent = BillboardsFolder
	BillboardGui.Adornee = Object
	BillboardGui.Size = UDim2.new(200,0,50,0)
	BillboardGui.AlwaysOnTop = true

	Highlights[Object] = Highlight
	Billboards[Object] = BillboardGui
	Labels[Object] = TextLabel
	Objects[Object] = ObjectTable
	if Library.UseBillboards == true then
		TextLabel.Parent = BillboardGui
	else
		TextLabel.Parent = TextFrame
	end
	local Lines = {}

	local Camera = workspace.CurrentCamera
	local function GetLineOrigin()

		if Library.TracerOrigin == "Center" then
			local mousePos = game:GetService("UserInputService"):GetMouseLocation();
			return Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2.25)

		elseif Library.TracerOrigin == "Top" then
			return Vector2.new(Camera.ViewportSize.X/2, -Camera.ViewportSize.Y/18)	
		elseif Library.TracerOrigin == "Mouse" then
			return Vector2.new(game.Players.LocalPlayer:GetMouse().X,game.Players.LocalPlayer:GetMouse().Y)

		else
			if game.UserInputService.TouchEnabled and not game.UserInputService.KeyboardEnabled then
				return Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y*0.94)
			else
				return Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y*0.9475)
			end
		end
	end
	local function Setline(Line, Width, ColorToSet, Origin, Destination)
		local Position = (Origin + Destination) / 2
		Line.Position = UDim2.new(0, Position.X, 0, Position.Y)
		local Length = (Origin - Destination).Magnitude
		Line.Name = Library:GenerateRandomString()
		Line.Size = UDim2.new(0, Length, 0, Width)
		Line.Rotation = math.deg(math.atan2(Destination.Y - Origin.Y, Destination.X - Origin.X))
		Line.BackgroundColor3 = Highlight.FillColor
		Line.BorderColor3 = Highlight.FillColor
		Line.BorderSizePixel = 0

		if Line:FindFirstChild("UIStroke") then
			Line.UIStroke.Color = Highlight.FillColor
			Line.UIStroke.Thickness = 0.75
		end
	end
	local Connection = RunService.RenderStepped:Connect(function()

		if Library.Rainbow == true and Highlight then
			Highlight.FillColor = RainbowTable.Color
			if Library.MatchColors == true then
				Highlight.OutlineColor = ColorTable[Object]
			else
				Highlight.OutlineColor = Library.OutlineColor
			end
			TextLabel.TextColor3 = RainbowTable.Color
		elseif Highlight then
			Highlight.FillColor = ColorTable[Object]
			if Library.MatchColors == true then
			Highlight.OutlineColor = ColorTable[Object]
			else
				Highlight.OutlineColor = Library.OutlineColor
			end
			TextLabel.TextColor3 = ColorTable[Object]
		end
		
		if Library.Tracers == true then
			
			
			local pos
			if Object:IsA("Model") then
				if Object.PrimaryPart then
					pos = Object.PrimaryPart.Position
				else
					pos = Object.WorldPivot.Position
					
				end
			else
				if Object then
			pos = Object.Position
				end
			end


			local vector, onScreen = game.Workspace.CurrentCamera:WorldToScreenPoint(pos)
			local Targets = {}
			local Character = Object
			if not Character then return end
			local LineOrigin = GetLineOrigin()
			
				local ScreenPoint, OnScreen = game.Workspace.CurrentCamera:WorldToScreenPoint(pos)
TextLabel.Visible = OnScreen
				if OnScreen then
					table.insert(Targets, {Vector2.new(ScreenPoint.X, ScreenPoint.Y), ColorTable[Object]})
					if not Highlights[Object] then
					local NewHighlight = Instance.new("Highlight")
					NewHighlight.Name = Library:GenerateRandomString()
					NewHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					NewHighlight.FillTransparency = 1
					NewHighlight.OutlineTransparency = 1
					NewHighlight.FillColor = Parameters.Color
					NewHighlight.OutlineColor = Parameters.Color
					NewHighlight.Parent = HighlightsFolder
					NewHighlight.Adornee = Object
					Highlight = NewHighlight
					Highlights[Object] = NewHighlight
					end
				else
				if Highlights[Object] then
				Highlights[Object]:Destroy()
				Highlights[Object] = nil
				end
				end

				if #Targets > #Lines then

					local NewLine = Instance.new("Frame")
					NewLine.Name = "Snapline"
					NewLine.AnchorPoint = Vector2.new(.5, .5)
					NewLine.Parent = ScreenGui


					local Border = Instance.new("UIStroke")
					Border.Parent = NewLine
					Border.Transparency = 1
					Border.Thickness = 0.75
					Border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					Library.TracerTable[Object] = NewLine
					task.wait()		
					if Library.Tracers == true  then
						game:GetService("TweenService"):Create(Border,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{Transparency = 0}):Play()
					end


					table.insert(Lines, NewLine)
				end
				for i, Line in pairs(Lines) do
					local TargetData = Targets[i]
					if not TargetData then
						Line:Destroy()
						table.remove(Lines, i)
						continue
					end
				Setline(Line, 0, ColorTable[Object], LineOrigin, TargetData[1])




				end
			
		elseif Library.Tracers == false then

			for i,line in pairs(Lines) do


				line:Destroy()

			end
		end	

		if Library.UseBillboards == false then
			local Position = Vector3.new(0,0,0)







			task.wait()


			if Object:IsA("Model") then
				if Object.PrimaryPart then
					local NewVector, VisibleCheck = Camera:WorldToScreenPoint(Object.PrimaryPart.Position)
					local UIPosiiton = UDim2.new(NewVector.X/OtherGui.AbsoluteSize.X,0,NewVector.Y/OtherGui.AbsoluteSize.Y,0)

					TextFrame.Position = UIPosiiton
					TextFrame.Visible = VisibleCheck
				end
			else
				if Object then
					local NewVector, VisibleCheck = Camera:WorldToScreenPoint(Object.Position)
					local UIPosiiton = UDim2.new(NewVector.X/OtherGui.AbsoluteSize.X,0,NewVector.Y/OtherGui.AbsoluteSize.Y,0)


					TextFrame.Position = UIPosiiton
					TextFrame.Visible = VisibleCheck
				end
			end




		end
	end)
	table.insert(Connections,Connection)




	Highlights[Object] = Highlight
	Frames[Object] = TextFrame
	Labels[Object] = TextLabel
	ConnectionsTable[Object] = Connection
	Objects[Object] = ObjectTable
	ColorTable[Object] = Parameters.Color 

	TweenService:Create(TextLabel,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{TextTransparency = Library.TextTransparency}):Play()
	TweenService:Create(Highlight,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{FillTransparency = Library.FillTransparency}):Play()
	TweenService:Create(Highlight,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{OutlineTransparency = Library.OutlineTransparency}):Play()




	table.insert(Elements,Highlight)
	table.insert(Elements,TextFrame)
	table.insert(Elements,TextLabel)
	table.insert(Highlights,Highlight)
	table.insert(Labels,TextLabel)

	Object:GetPropertyChangedSignal("Parent"):Connect(function()
		Library:RemoveESP(Object)
		
	end)
	if Object:IsA("Model") then
		Object.PrimaryPart:GetPropertyChangedSignal("Parent"):Connect(function()
			Library:RemoveESP(Object)

		end)
	end
end


function Library:SetColorTable(Name,Color)
	ColorTable[Name] = Color
end

function Library:SetFadeTime(Number)
	Library.FadeTime = Number
end

function Library:SetTextTransparency(Number)
	Library.TextTransparency = Number
	for i,Label in pairs(Labels) do
		Label.TextTransparency = Number
	end
end

function Library:SetFillTransparency(Number)
	Library.FillTransparency = Number
	for i,Highlight in pairs(Highlights) do
		if Highlight:IsA("Highlight") then
			Highlight.FillTransparency = Number
		end
	end
end

function Library:SetOutlineTransparency(Number)
	Library.OutlineTransparency = Number
	for i,Highlight in pairs(Highlights) do
		if Highlight:IsA("Highlight") then
			Highlight.OutlineTransparency = Number
		end
	end
end

function Library:SetTextSize(Number)
	Library.TextSize = Number
	for i,Label in pairs(Labels) do
		Label.TextSize = Number
	end
end
function Library:SetFont(Font)
	Library.Font = Font
	for i,Label in pairs(Labels) do
		Label.FOnt = Font
	end
end

function Library:UpdateObjectText(Object,Text)
	if Labels[Object] then
		Labels[Object].Text = Text
	end
end

function Library:SetOutlineColor(Color)
	Library.OutlineColor = Color
end




function Library:RemoveESP(Object)

	

	local Highlight = Highlights[Object]
	local TextFrame = Frames[Object]
	local BillboardGui = Billboards[Object]
	local TextLabel = Labels[Object]
	TweenService:Create(Highlight,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{FillTransparency = 1}):Play()
	TweenService:Create(Highlight,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{OutlineTransparency = 1}):Play()
	TweenService:Create(TextLabel,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{TextTransparency = 1}):Play()
	task.wait(Library.FadeTime)
	Highlight:Destroy()
	TextLabel:Destroy()
	if Library.TracerTable[Object] then
		Library.TracerTable[Object]:Destroy()
	end
	if TextFrame then
		TextFrame:Destroy()
	end
	if BillboardGui then
		BillboardGui:Destroy()
	end
	task.wait(Library.FadeTime)
	ConnectionsTable[Object]:Disconnect()
	ConnectionsTable[Object] = nil
end




ConnectionsTable.RainbowConnection = RunService.RenderStepped:Connect(function(Delta)

	RainbowTable.Step = RainbowTable.Step + Delta

	if RainbowTable.Step >= (1 / 60) then
		RainbowTable.Step = 0

		RainbowTable.HueSetup = RainbowTable.HueSetup + (1 / 400);
		if RainbowTable.HueSetup > 1 then RainbowTable.HueSetup = 0; end;
		RainbowTable.Hue = RainbowTable.HueSetup;
		RainbowTable.Color = Color3.fromHSV(RainbowTable.Hue, 0.8, 1);
		

	end
end)




function Library:Unload()
	for i,Element in pairs(Elements) do

		Element:Destroy()

	end
	for i,Element in pairs(Library.TracerTable) do

		Element:Destroy()

	end
	for i,Connection in pairs(ConnectionsTable) do
		Connection:Disconnect()
	end
	ScreenGui:Destroy()
	OtherGui:Destroy()
	Library = nil
	getgenv().ESPLibrary = nil
end
-- Finishing Touches --

ObjectsFolder.Name = Library:GenerateRandomString()
MainFolder.Name = Library:GenerateRandomString()
ScreenGui.Name = Library:GenerateRandomString()
OtherGui.Name = Library:GenerateRandomString()
HighlightsFolder.Name = Library:GenerateRandomString()
BillboardsFolder.Name = Library:GenerateRandomString()
getgenv().ESPLibrary = Library



