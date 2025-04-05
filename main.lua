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
	TextTable = {},
	Font = Enum.Font.Oswald,
	ConnectionsTable = {},
	Objects = {},
	TracerTable = {},
	HighlightedObjects = {},
	RemoveIfNotVisible = true,
	Rainbow = false,
	UseBillboards = true,
	Tracers = false,
	Bold = false,
	ShowDistance = false,
	MatchColors = true,
	TextTransparency = 0,
	TracerOrigin = "Bottom",
	FillTransparency = 0.75,
	OutlineTransparency = 0,
	TextOutlineTransparency = 0,
	FadeTime = 0,
	TracerThickness = 0.85,
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
TextTable = Library.TextTable
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
	local TransparencyEnabled = false
	if Objects[Object] ~= nil then return end
	if ConnectionsTable[Object] == nil then





		local MainPart = nil
		if Parameters.BasePart then
			MainPart = Parameters.BasePart
		end

		local Highlight
		local ObjectTable = {}
		TextTable[Object] = Parameters.Text

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
		TextLabel.TextStrokeTransparency = Library.TextOutlineTransparency
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
			if Highlight then
				local Position = (Origin + Destination) / 2
				Line.Position = UDim2.new(0, Position.X, 0, Position.Y)
				local Length = (Origin - Destination).Magnitude

				Line.Size = UDim2.new(0, Length, 0, Width)
				Line.Rotation = math.deg(math.atan2(Destination.Y - Origin.Y, Destination.X - Origin.X))
				Line.BackgroundColor3 = Highlight.FillColor
				Line.BorderColor3 = Highlight.FillColor
				Line.BorderSizePixel = 0

				if Line:FindFirstChild("UIStroke") then
					Line.UIStroke.Color = Highlight.FillColor
					Line.UIStroke.Thickness = Library.TracerThickness
				end
			end
		end
		local ConnectionCooldown = false
		local Connection = RunService.RenderStepped:Connect(function()
			Camera = workspace.CurrentCamera
			if Camera == nil then return end
			if Library.Rainbow == true and Highlight ~= nil then
				Highlight.FillColor = RainbowTable.Color
				if Library.MatchColors == true then
					Highlight.OutlineColor = Highlight.FillColor
				else
					Highlight.OutlineColor = Library.OutlineColor
				end
				TextLabel.TextColor3 = RainbowTable.Color
			elseif Library.Rainbow == false and Highlight ~= nil then
				Highlight.FillColor = ColorTable[Object]
				if Library.MatchColors == true then
					Highlight.OutlineColor = Highlight.FillColor
				else
					Highlight.OutlineColor = Library.OutlineColor
				end
				TextLabel.TextColor3 = ColorTable[Object]
			end

			if Library.Bold == true then
				TextLabel.FontFace.Weight = Enum.FontWeight.Bold
			else
				TextLabel.FontFace.Weight = Enum.FontWeight.Regular
			end



			task.wait()

			local pos

			if Object:IsA("Model") then

				if Object.PrimaryPart ~= nil then

					pos = Object.PrimaryPart.Position
				else

					pos = Object.WorldPivot.Position

				end
			else

				if Object then

					pos = Object.Position
				end
			end


			if Library.ShowDistance == true then
				TextLabel.Text = TextTable[Object] .. "\n[" .. math.round(Players.LocalPlayer:DistanceFromCharacter(pos)) .. "]"
			else
				TextLabel.Text = TextTable[Object]
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



			end

			if Library.Tracers == true then
				if #Targets > #Lines then

					local NewLine = Instance.new("Frame")
					NewLine.Name = Library:GenerateRandomString()
					NewLine.AnchorPoint = Vector2.new(.5, .5)
					NewLine.Parent = ScreenGui


					local Border = Instance.new("UIStroke")
					Border.Parent = NewLine
					Border.Transparency = 1
					Border.Thickness = Library.TracerThickness
					Border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					Library.TracerTable[Object] = NewLine

					if Library.Tracers == true  then
						game:GetService("TweenService"):Create(Border,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{Transparency = 0}):Play()
					end


					table.insert(Lines, NewLine)
				end
				if ConnectionCooldown == false then
					for i, Line in pairs(Lines) do
						local TargetData = Targets[i]
						if not TargetData then
							Line:Destroy()
							table.remove(Lines, i)

						end
						Setline(Line, 0, ColorTable[Object], LineOrigin, TargetData[1])
					end




				end

			elseif Library.Tracers == false then
				if ConnectionCooldown == false then

					for i,line in pairs(Lines) do


						line:Destroy()

					end
				end
			end	

			if Library.UseBillboards == false then
				local Position = Vector3.new(0,0,0)










				if Object:IsA("Model") then
					if Object.PrimaryPart then
						local NewVector, VisibleCheck = Camera:WorldToScreenPoint(Object.PrimaryPart.Position)
						local UIPosition = UDim2.new(NewVector.X/OtherGui.AbsoluteSize.X,0,NewVector.Y/OtherGui.AbsoluteSize.Y,0)

						TextFrame.Position = UIPosition
						TextFrame.Visible = VisibleCheck
						if ConnectionCooldown == false then
							if VisibleCheck == false then
								if Highlights[Object] then
									Highlights[Object]:Destroy()
									Highlights[Object] = nil
									Labels[Object] = TextLabel
								end
							else

								if Highlights[Object] == nil then
									local NewHighlight = Instance.new("Highlight")
									NewHighlight.FillTransparency = 1
									NewHighlight.OutlineTransparency = 1
									NewHighlight.Name = Library:GenerateRandomString()
									NewHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
									if TransparencyEnabled == true then
										NewHighlight.FillTransparency = Library.FillTransparency
										NewHighlight.OutlineTransparency = Library.OutlineTransparency
									else
										TweenService:Create(NewHighlight,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{FillTransparency = Library.FillTransparency}):Play()
										TweenService:Create(NewHighlight,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{OutlineTransparency = Library.OutlineTransparency}):Play()
									end
									NewHighlight.FillColor = Parameters.Color
									NewHighlight.OutlineColor = Parameters.Color
									NewHighlight.Parent = HighlightsFolder
									NewHighlight.Adornee = Object
									Highlight = NewHighlight
									Highlights[Object] = NewHighlight
									Labels[Object] = TextLabel
								end
							end
						end
					end
				else
					if Object then
						local NewVector, VisibleCheck = Camera:WorldToScreenPoint(Object.Position)
						local UIPosition = UDim2.new(NewVector.X/OtherGui.AbsoluteSize.X,0,NewVector.Y/OtherGui.AbsoluteSize.Y,0)


						TextFrame.Position = UIPosition
						TextFrame.Visible =  VisibleCheck
						if ConnectionCooldown == false then
							if VisibleCheck == false then
								if Highlights[Object] then
									Highlights[Object]:Destroy()
									Highlights[Object] = nil
									Labels[Object] = TextLabel
								end
							else

								if Highlights[Object] == nil then
									local NewHighlight = Instance.new("Highlight")
									NewHighlight.FillTransparency = 1
									NewHighlight.OutlineTransparency = 1
									NewHighlight.Name = Library:GenerateRandomString()
									NewHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
									if TransparencyEnabled == true then
										NewHighlight.FillTransparency = Library.FillTransparency
										NewHighlight.OutlineTransparency = Library.OutlineTransparency
									else
										TweenService:Create(NewHighlight,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{FillTransparency = Library.FillTransparency}):Play()
										TweenService:Create(NewHighlight,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{OutlineTransparency = Library.OutlineTransparency}):Play()
									end
									NewHighlight.FillColor = Parameters.Color
									NewHighlight.OutlineColor = Parameters.Color
									NewHighlight.Parent = HighlightsFolder
									NewHighlight.Adornee = Object
									Highlight = NewHighlight
									Highlights[Object] = NewHighlight
									Labels[Object] = TextLabel
								end
							end

						end
					end
				end


				ConnectionCooldown = true
				task.wait(0.1)
				ConnectionCooldown = false

			end
		end)
		table.insert(Connections,Connection)




		Highlights[Object] = Highlight
		Frames[Object] = TextFrame
		Labels[Object] = TextLabel
		ConnectionsTable[Object] = Connection
		Objects[Object] = ObjectTable
		ColorTable[Object] = Parameters.Color 

		if TextLabel then
			local Tween = TweenService:Create(TextLabel,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{TextTransparency = Library.TextTransparency})
			Tween:Play()
			Tween.Completed:Connect(function()
				TransparencyEnabled = true
			end)
		end




		table.insert(Elements,TextFrame)




		Object:GetPropertyChangedSignal("Parent"):Connect(function()
			Library:RemoveESP(Object)

		end)
		if Object.Parent ~= nil then
			Object.Parent:GetPropertyChangedSignal("Parent"):Connect(function()
				Library:RemoveESP(Object)

			end)
		end
		if Object:IsA("Model") and Object.PrimaryPart then
			Object.PrimaryPart:GetPropertyChangedSignal("Parent"):Connect(function()
				Library:RemoveESP(Object)

			end)
		end
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
function Library:SetTextOutlineTransparency(Number)
	Library.TextOutlineTransparency = Number
	for i,Label in pairs(Labels) do
		Label.TextStrokeTransparency = Number
	end
end
function Library:SetFont(Font)
	Library.Font = Font
	for i,Label in pairs(Labels) do
		Label.Font = Font
	end
end

function Library:UpdateObjectText(Object,Text)
	if Labels[Object] then
		TextTable[Object] = Text
	end
end

function Library:SetOutlineColor(Color)
	Library.OutlineColor = Color
end




function Library:RemoveESP(Object)
	if Objects[Object] == nil then return end
	if ConnectionsTable[Object] ~= nil then

		local Highlight = Highlights[Object]
		local TextFrame = Frames[Object]
		local BillboardGui = Billboards[Object]
		local TextLabel = Labels[Object]
		if Library.TracerTable[Object] ~= nil then
			Library.TracerTable[Object]:Destroy()
		end
		Objects[Object] = nil

		if Highlight and TextLabel then
			TweenService:Create(Highlight,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{FillTransparency = 1}):Play()
			TweenService:Create(Highlight,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{OutlineTransparency = 1}):Play()
			TweenService:Create(TextLabel,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{TextTransparency = 1}):Play()
			task.wait(Library.FadeTime)	
		end



		if TextFrame then
			TextFrame:Destroy()
		end
		if BillboardGui then
			BillboardGui:Destroy()
		end

		if ConnectionsTable[Object] and Objects[Object] == nil then
			ConnectionsTable[Object]:Disconnect()
			ConnectionsTable[Object] = nil
		end
		if Highlight and TextLabel then
			Highlight:Destroy()
			TextLabel:Destroy()
		end
	end
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

return Library
