local Library = {

	ObjectsFolder = Instance.new("Folder"),
	ScreenGui = Instance.new("ScreenGui"),
	OtherGui = Instance.new("ScreenGui"),
	HighlightsFolder = Instance.new("Folder"),
	BillboardsFolder = Instance.new("Folder"),
	TracersFrame = Instance.new("Frame"),
	Highlights = {},
	Labels = {},
	Elements = {},
	ElementsEnabled = {},
	Frames = {},
	TotalObjects = {},
	TransparencyEnabled = {},
	Connections = {},
	Billboards = {},
	ColorTable = {},
	TextTable = {},
	Lines = {},
	Font = Enum.Font.Oswald,
	ConnectionsTable = {},
	Objects = {},
	TracerTable = {},
	HighlightedObjects = {},
	RemoveIfNotVisible = true,
	Rainbow = false,
	UseBillboards = false,
	Tracers = false,
	Bold = false,
	Unloaded = false,
	ShowDistance = false,
	MatchColors = true,
	TextTransparency = 0,
	TracerOrigin = "Bottom",
	FillTransparency = 0.75,
	OutlineTransparency = 0,
	TextOffset = 0,
	TextOutlineTransparency = 0,
	FadeTime = 0,
	TracerThickness = 0.85,
	TextSize = 20,
	DistanceSizeRatio = 1,
	OutlineColor = Color3.fromRGB(255,255,255)
}

local RainbowTable = {
	HueSetup = 0,
	Hue = 0,
	Step = 0,
	Color = Color3.new(),
	Enabled = false,


}



ObjectsFolder = Library.ObjectsFolder
HttpService = game:GetService("HttpService")
HighlightedObjects = Library.HighlightedObjects
Highlights = Library.Highlights
ConnectionsTable = Library.ConnectionsTable
Objects = Library.Objects
TotalObjects = Library.TotalObjects
Billboards = Library.Billboards
Frames = Library.Frames
ScreenGui = Library.ScreenGui
HighlightsFolder = Library.HighlightsFolder
Labels = Library.Labels
Connections = Library.Connections
OtherGui = Library.OtherGui 
Elements = Library.Elements
TextTable = Library.TextTable
Players = game:GetService("Players")
CoreGui = (identifyexecutor ~= nil and game:GetService("CoreGui") or Players.LocalPlayer.PlayerGui)

RunService = game:GetService("RunService")
TweenService = game:GetService("TweenService")
GetHUI = (gethui ~= nil and gethui()) or (CoreGui);
ColorTable = Library.ColorTable
ScreenGui.Parent = GetHUI
OtherGui.Parent = ScreenGui
TracersFrame = Library.TracersFrame
HighlightsFolder.Parent = ScreenGui
BillboardsFolder = Library.BillboardsFolder
BillboardsFolder.Parent = ScreenGui

ScreenGui.ResetOnSpawn = false

TracersFrame.Size = UDim2.new(1,0,1,0)
TracersFrame.BackgroundTransparency = 1

TracersFrame.Parent = ScreenGui



-- Functions --

function Library:GenerateRandomString()

	local Characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890{}[]<>/#@?!()"
	local RandomString = ""


	local function GenerateSegment()

		local Result = {}
		local RandomNumber = math.random(9,11)
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


if Library.Unloaded == true then return end
function Library:AddESP(Parameters)
	local Object = Parameters.Object
	
	if Library.ElementsEnabled[Object] == true or Library.Unloaded == true then return end





	Library.TransparencyEnabled[Object] = false



	local MainPart = nil
	if Parameters.BasePart then
		MainPart = Parameters.BasePart
	end

	local Highlight = nil
	local ObjectTable = {Object}
	TextTable[Object] = Parameters.Text

	local TextFrame = Instance.new("BillboardGui")
	TextFrame.Enabled = false
	TextFrame.Adornee = Object
	TextFrame.Name = Library:GenerateRandomString()
	TextFrame.Size = UDim2.new(0,250,0,250)
	TextFrame.Parent = BillboardsFolder
	TextFrame.AlwaysOnTop = true
	local TextLabel = Instance.new("TextLabel")
	TextLabel.Name = Library:GenerateRandomString()
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = Parameters.Text
	TextLabel.TextTransparency = 1
	TextLabel.TextStrokeTransparency = Library.TextOutlineTransparency
	TextLabel.Size = UDim2.new(1,0,1,0)
	TextLabel.Font = Library.Font
	TextLabel.TextSize = Library.TextSize
	TextLabel.RichText = true
	TextLabel.Parent = TextFrame
	TextLabel.TextColor3 = Parameters.Color

	Labels[Object] = TextLabel
	Objects[Object] = ObjectTable
	TotalObjects[Object] = Object


	Library.Lines[Object] = {}
	Library.ElementsEnabled[Object] = true





	Labels[Object] = TextLabel











	Frames[Object] = TextFrame
	Labels[Object] = TextLabel

	Objects[Object] = Object
	ColorTable[Object] = Parameters.Color 

	if TextLabel then
		local Tween = TweenService:Create(TextLabel,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{TextTransparency = Library.TextTransparency})
		Tween:Play()
		Tween.Completed:Connect(function()
			Library.TransparencyEnabled[Object] = true
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
function Library:UpdateObjectColor(Object,Color)
	ColorTable[Object] = Color
	if Labels[Object] then
		Labels[Object].TextColor3 = Color
	end

end

function Library:SetOutlineColor(Color)
	Library.OutlineColor = Color
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
end

function Library:SetTracerOrigin(Value)
	Library.TracerOrigin = Value
end

function Library:SetDistanceSizeRatio(Value)
	Library.DistanceSizeRatio = Value
end

function Library:SetTracerSize(Value)
	Library.TracerThickness = 0.85 * Value
end


function removeObjectFromTables(object)
	for index, obj in pairs(TotalObjects) do

		if obj == object then
			print("Removed " .. obj.Name .. "from table")
			TotalObjects[object] = nil

			break
		end

	end
end


function Library:RemoveESP(Object)
	if Library.Unloaded == true or Library.ElementsEnabled[Object] ~= true then return end

	Library.ElementsEnabled[Object] = false





	local Value = Instance.new("Frame", game.ReplicatedStorage)
	Value.BackgroundTransparency = 0
	Value.Name = Library:GenerateRandomString()


	local TextFrame = Frames[Object]






	local TextLabel = Labels[Object]

	if TextLabel then
		TweenService:Create(TextLabel,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{TextTransparency = 1}):Play()

	end

	if Library.Lines[Object] ~= nil then
		if Library.Lines[Object][1] ~= nil  then
			TweenService:Create(Library.Lines[Object][1],TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{BackgroundTransparency = 1}):Play()
		end
		if Library.Lines[Object][2] ~= nil  then
			TweenService:Create(Library.Lines[Object][2],TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{Transparency = 1}):Play()
		end

	end

	local Highlight
	if Highlights[Object] then

		TweenService:Create(Highlights[Object],TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{FillTransparency = 1}):Play()
		TweenService:Create(Highlights[Object],TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{OutlineTransparency = 1}):Play()
		Highlight = Highlights[Object]

	end

	if Library.TracerTable[Object] ~= nil then
		Library.TracerTable[Object]:Destroy()

	end

	if Object.Parent == nil then
		if Library.ElementsEnabled[Object] == false then

			if Frames[Object] then
				Frames[Object]:Destroy()
				Frames[Object] = nil
			end
			Objects[Object] = nil



			if Highlight then
				Highlight:Destroy()
				Highlights[Object] = nil

			end

			removeObjectFromTables(Object)

			if Library.Lines[Object] ~= nil then
				if Library.Lines[Object][1] ~= nil  then
					Library.Lines[Object][1]:Destroy()
				end
				if Library.Lines[Object][2] ~= nil  then
					Library.Lines[Object][2]:Destroy()
				end
				Library.Lines[Object] = {}
			end

			if Library.TracerTable[Object] ~= nil then
				Library.TracerTable[Object]:Destroy()

			end





			Value:Destroy()
		else
			if Highlight then
				TweenService:Create(Highlight,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{FillTransparency = Library.FillTransparency}):Play()
				TweenService:Create(Highlight,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{OutlineTransparency = Library.OutlineTransparency}):Play()
			end

		end

	else
		local DestroyTween = TweenService:Create(Value,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{BackgroundTransparency = 1})
		DestroyTween:Play()





		DestroyTween.Completed:Connect(function()
			if Library.ElementsEnabled[Object] == false then

				if Frames[Object] then
					Frames[Object]:Destroy()
					Frames[Object] = nil
				end



				if Highlight then
					Highlight:Destroy()
					Highlights[Object] = nil

				end

				removeObjectFromTables(Object)

				if Library.Lines[Object] ~= nil then
					if Library.Lines[Object][1] ~= nil  then
						Library.Lines[Object][1]:Destroy()
					end
					if Library.Lines[Object][2] ~= nil  then
						Library.Lines[Object][2]:Destroy()
					end
					Library.Lines[Object] = {}
				end

				if Library.TracerTable[Object] ~= nil then
					Library.TracerTable[Object]:Destroy()

				end





				Value:Destroy()
			else
				if Highlight then
					TweenService:Create(Highlight,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{FillTransparency = Library.FillTransparency}):Play()
					TweenService:Create(Highlight,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{OutlineTransparency = Library.OutlineTransparency}):Play()
				end

			end
		end)
	end
end

local ElementsCooldown = false

ElementsConnection = RunService.Heartbeat:Connect(function()
	if ElementsCooldown == false then

		ElementsCooldown = true

	task.wait(0.01)
	
		for i,Object in pairs(TotalObjects) do
			if Objects[Object] ~= nil then
				local pos

				local TextFrame = Frames[Object] or Instance.new("Frame")
				local TextLabel = Labels[Object] or Instance.new("TextLabel")
				local Highlight = Highlights[Object]

				if Object:IsA("BasePart") then 
					pos =  Object.Position 
				elseif Object:IsA("Model") then 

					pos = Object.WorldPivot.Position 
					if Object.PrimaryPart ~= nil then 
						pos = Object.PrimaryPart.Position 
					else 


					end
				end

				if pos ~= nil then


					local NewVector, OnScreen = game.Workspace.CurrentCamera:WorldToScreenPoint(pos)
					TextFrame.Enabled = OnScreen
					if OnScreen == false then 
						
						if Library.Lines[Object][1] ~= nil then
							Library.Lines[Object][1]:Destroy()
						end
						if Library.Lines[Object][2] ~= nil then
							Library.Lines[Object][2]:Destroy()
						end

						if Library.Lines[Object] ~= nil then
							Library.Lines[Object] = {}
						end

						if Highlight then
							Highlight:Destroy()
							Highlights[Object] = nil



						end

					elseif OnScreen == true  then

						

						

						if Library.Rainbow == true then
							TextLabel.TextColor3 = RainbowTable.Color
						else
							TextLabel.TextColor3 = ColorTable[Object] or Color3.fromRGB(255,255,255)
						end








						if Library.Rainbow == true and Highlight ~= nil then
							Highlight.FillColor = RainbowTable.Color

							if Library.MatchColors == true then
								Highlight.OutlineColor = Highlight.FillColor
							else
								Highlight.OutlineColor = Library.OutlineColor
							end

						elseif Library.Rainbow == false and Highlight ~= nil then
							Highlight.FillColor = ColorTable[Object] or Color3.fromRGB(255,255,255)

							if Library.MatchColors == true then
								Highlight.OutlineColor = Highlight.FillColor
							else
								Highlight.OutlineColor = Library.OutlineColor
							end
							TextLabel.TextColor3 = ColorTable[Object] or Color3.fromRGB(255,255,255)
						end

						if Library.Bold == true then
							TextLabel.FontFace.Weight = Enum.FontWeight.Bold
						else
							TextLabel.FontFace.Weight = Enum.FontWeight.Regular
						end






						local function GetLineOrigin()

							if Library.TracerOrigin == "Center" then
								local mousePos = game:GetService("UserInputService"):GetMouseLocation();
								return Vector2.new(game.Workspace.CurrentCamera.ViewportSize.X/2,game.Workspace.CurrentCamera.ViewportSize.Y/2.25)

							elseif Library.TracerOrigin == "Top" then
								return Vector2.new(game.Workspace.CurrentCamera.ViewportSize.X/2, -game.Workspace.CurrentCamera.ViewportSize.Y/18)	
							elseif Library.TracerOrigin == "Mouse" then
								return Vector2.new(game.Players.LocalPlayer:GetMouse().X,game.Players.LocalPlayer:GetMouse().Y)

							else
								if game.UserInputService.TouchEnabled and not game.UserInputService.KeyboardEnabled then
									return Vector2.new(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y*0.94)
								else
									return Vector2.new(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y*0.9475)
								end
							end
						end
						local function Setline(Line, Width, ColorToSet, Origin, Destination, Border)
							if Highlight and Origin ~= nil and Line then
								local Position = (Origin + Destination) / 2
								Line.Position = UDim2.new(0, Position.X, 0, Position.Y)
								local Length = (Origin - Destination).Magnitude

								Line.Size = UDim2.new(0, Length, 0, Width)
								Line.Rotation = math.deg(math.atan2(Destination.Y - Origin.Y, Destination.X - Origin.X))
								Line.BackgroundColor3 = Highlight.FillColor
								Line.BorderColor3 = Highlight.FillColor
								Line.BorderSizePixel = 0


								Border.Color = Highlight.FillColor
								Border.Thickness = Library.TracerThickness

							end
						end


						if Library.ShowDistance == true then
							local TextRatio = math.round(Library.TextSize * Library.DistanceSizeRatio)
							local Distance = math.round(Players.LocalPlayer:DistanceFromCharacter(pos))
							local DistanceText = '[' .. Distance .. ']'
							local Text = TextTable[Object]
							TextLabel.Text = Text .. '\n<font size="' .. TextRatio .. '">' .. DistanceText .. '</font>'

						else
							TextLabel.Text = TextTable[Object]
						end

						
						local Targets = {}
						local Character = Object

					


						
						if OnScreen then
							table.insert(Targets, {Vector2.new(NewVector.X, NewVector.Y), ColorTable[Object]})



						end




						if	Library.Lines[Object][1] == nil and OnScreen and Library.ElementsEnabled[Object] == true then
							local NewLine = Instance.new("Frame")
							NewLine.Name = Library:GenerateRandomString()
							NewLine.AnchorPoint = Vector2.new(.5, .5)
							NewLine.Parent = TracersFrame


							local Border = Instance.new("UIStroke")
							Border.Parent = NewLine
							Border.Transparency = 0
							Border.Thickness = Library.TracerThickness
							Border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
							Border.Name = Library:GenerateRandomString()

							Library.TracerTable[Object] = NewLine




							Library.Lines[Object] = {NewLine, Border}
						end


						local TargetData = Targets[1]
						if not TargetData and Library.Lines[Object][1] ~= nil then
							Library.Lines[Object][1]:Destroy()
							Library.Lines[Object][2]:Destroy()

							Library.Lines[Object] = {}

						end
						if TargetData ~= nil then
							if Library.Tracers == true then
							local LineOrigin = GetLineOrigin()
							Setline(Library.Lines[Object][1], 0, ColorTable[Object], LineOrigin, TargetData[1], Library.Lines[Object][2])
							end
						end
























					end





					if OnScreen == true then


						if Highlights[Object] == nil and Library.ElementsEnabled[Object] == true then
							local NewHighlight = Instance.new("Highlight")
							NewHighlight.FillTransparency = 1
							NewHighlight.OutlineTransparency = 1
							NewHighlight.Name = Library:GenerateRandomString()
							NewHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
							if Library.TransparencyEnabled[Object] == true then
								NewHighlight.FillTransparency = Library.FillTransparency
								NewHighlight.OutlineTransparency = Library.OutlineTransparency
							else
								TweenService:Create(NewHighlight,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{FillTransparency = Library.FillTransparency}):Play()
								TweenService:Create(NewHighlight,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{OutlineTransparency = Library.OutlineTransparency}):Play()
							end
							NewHighlight.FillColor = ColorTable[Object] or Color3.fromRGB(255,255,255)
							NewHighlight.OutlineColor = ColorTable[Object] or Color3.fromRGB(255,255,255)
							NewHighlight.Parent = HighlightsFolder
							NewHighlight.Adornee = Object
							Highlight = NewHighlight
							Highlights[Object] = NewHighlight

						end

					end
				end
			end
			
		end

		ElementsCooldown = false
	end
end)

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

ConnectionsTable.TracerConnection = RunService.RenderStepped:Connect(function()
	TracersFrame.Visible = Library.Tracers
end)




function Library:Unload()
	for i,Object in pairs(Library.Objects) do

		Library:RemoveESP(Object)
	end

	for i,Connection in pairs(ConnectionsTable) do
		Connection:Disconnect()
	end

	ElementsConnection:Disconnect()



	ScreenGui.Enabled = false
	Library.Unloaded = true


end
-- Finishing Touches --

ObjectsFolder.Name = Library:GenerateRandomString()
ScreenGui.Name = Library:GenerateRandomString()
OtherGui.Name = Library:GenerateRandomString()
HighlightsFolder.Name = Library:GenerateRandomString()
TracersFrame.Name = Library:GenerateRandomString()
BillboardsFolder.Name = Library:GenerateRandomString()
if getgenv ~= nil then
	getgenv().ESPLibrary = Library
end

return Library
