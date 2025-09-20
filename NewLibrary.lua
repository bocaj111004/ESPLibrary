
local Library = {

	ObjectsFolder = Instance.new("Folder"),
	ScreenGui = Instance.new("ScreenGui"),
	HighlightsFolder = Instance.new("Folder"),
	BillboardsFolder = Instance.new("Folder"),
	TracersFrame = Instance.new("Frame"),
	ArrowsFrame = Instance.new("Frame"),
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
	ArrowsTable = {},
	Font = Enum.Font.Oswald,
	ConnectionsTable = {},
	Objects = {},
	ConnectionsManager = {},
	TracerTable = {},
	HighlightNames = {},
	HighlightedObjects = {},
	RemoveIfNotVisible = true,
	Rainbow = false,
	UseBillboards = false,
	Tracers = false,
	Bold = false,
	Unloaded = false,
	ShowDistance = false,
	MatchColors = true,
	Arrows = false,
	TextTransparency = 0,
	TracerOrigin = "Bottom",
	FillTransparency = 0.75,
	OutlineTransparency = 0,
	TextOffset = 0,
	TextOutlineTransparency = 0,
	FadeTime = 0,
	TracerSize = 0.5,
	ArrowRadius = 200,
	TextSize = 20,
	DistanceSizeRatio = 1,
	OutlineColor = Color3.fromRGB(255,255,255),
	RainbowColor = Color3.fromRGB(255,255,255),
	ConnectionName = "ConnectionName"
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
ArrowsTable = Library.ArrowsTable
HighlightsFolder = Library.HighlightsFolder
Labels = Library.Labels
Connections = Library.Connections
Elements = Library.Elements
TextTable = Library.TextTable
Players = game:GetService("Players")
CoreGui = (identifyexecutor ~= nil and game:GetService("CoreGui") or Players.LocalPlayer.PlayerGui)
HttpService = game:GetService("HttpService")
RunService = game:GetService("RunService")
TweenService = game:GetService("TweenService")
GetHUI = (CoreGui:FindFirstChild("RobloxGui") or CoreGui);
ColorTable = Library.ColorTable
ScreenGui.Parent = GetHUI
TracersFrame = Library.TracersFrame
ArrowsFrame = Library.ArrowsFrame
HighlightsFolder.Parent = ScreenGui
BillboardsFolder = Library.BillboardsFolder
BillboardsFolder.Parent = ScreenGui


ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

TracersFrame.Size = UDim2.new(1,0,1,0)
TracersFrame.BackgroundTransparency = 1

TracersFrame.Parent = ScreenGui

ArrowsFrame.Size = UDim2.new(1,0,1,0)
ArrowsFrame.BackgroundTransparency = 1
ArrowsFrame.Parent = ScreenGui

TracersFrame.Visible = false
ArrowsFrame.Visible = false

Camera = workspace.CurrentCamera

local arrowTemplate = Instance.new("ImageLabel")
arrowTemplate.Image = "rbxassetid://2418687610"
arrowTemplate.Size = UDim2.new(0, 72,0, 72)
arrowTemplate.AnchorPoint = Vector2.new(0.5, 0.5)
arrowTemplate.BackgroundTransparency = 1
arrowTemplate.ImageTransparency = 1

local Constraint = Instance.new("UIAspectRatioConstraint")
Constraint.Parent = arrowTemplate
Constraint.AspectRatio = 0.75
Constraint.Name = "Constraint"



-- Functions --

function Library:GenerateRandomString()

	--"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890{}[]<>/#@?!()"

	local Characters = ""
	local RandomString = ""

	
		Characters = Characters .. "abcdefabcdef"
	
			Characters = Characters .. "ghijklmnopqrstuvwxyzghijklmnopqrstuvwxyz"
		
	

	
		Characters = Characters .. "123456789123456789"
	

	
		Characters = Characters .. "!$%&*(){}[]:;@'~#?/><.,=+|_-`"
	




	local function GenerateSegment()

		local Result = {}
		local RandomNumber = math.random(6,6)
		for i = 1, RandomNumber do

			local RandomIndex = math.random(1, #Characters)
			local RandomCharacter = Characters:sub(RandomIndex, RandomIndex)

			local FinishedCharacter = RandomCharacter

			local UpperIndex = math.random(1,2)



			
				if UpperIndex == 1 then
					FinishedCharacter = string.lower(RandomCharacter)
				else
					FinishedCharacter = string.upper(RandomCharacter)
				end

			

			table.insert(Result, FinishedCharacter)
		end
		return table.concat(Result)
	end

	local Segment1 = GenerateSegment()
	local Segment2 = GenerateSegment() 
	local Segment3 = GenerateSegment() 
	local Segment4 = GenerateSegment()
	local Segment5 = GenerateSegment()
	RandomString = Segment1 .. Segment2 .. Segment3 .. Segment4 .. Segment5
	return RandomString

end


if Library.Unloaded == true then return end
function Library:AddESP(Parameters)
	local Object = Parameters.Object

	if Library.ElementsEnabled[Object] == true or Library.Unloaded == true then return end

	if not Object:IsA("BasePart") and not Object:IsA("Model") then
		return
	end





	Library.TransparencyEnabled[Object] = false



	if Highlights[Object] then
		Highlights[Object]:Destroy()
		Highlights[Object] = nil
	end



	local MainPart = nil
	if Parameters.BasePart then
		MainPart = Parameters.BasePart
	end

	local highlight = Instance.new("Highlight")
	highlight.FillTransparency = 1
	highlight.OutlineTransparency = 1
	highlight.Name = Library.HighlightNames[Object] or Library:GenerateRandomString()
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = HighlightsFolder
	highlight.Adornee = Object
	Highlights[Object] = highlight
	local ObjectTable = {Object}
	TextTable[Object] = Parameters.Text

	local TextFrame = Instance.new("Frame")
	TextFrame.Visible = false
	TextFrame.Name = Library:GenerateRandomString()
	TextFrame.Size = UDim2.fromScale(1,1)
	TextFrame.Parent = BillboardsFolder
	TextFrame.BackgroundTransparency = 1
	TextFrame.AnchorPoint = Vector2.new(0.5,0.5)
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




	Library.ElementsEnabled[Object] = true





	Labels[Object] = TextLabel

	Library.HighlightNames[Object] = Library:GenerateRandomString()

	if Library.ConnectionsTable[Object] == nil then
		Library.ConnectionsManager[Object] = {}
	end


	local Manager = Library.ConnectionsManager[Object]

	if highlight then
		TweenService:Create(highlight,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{FillTransparency = Library.FillTransparency}):Play()
		TweenService:Create(highlight,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{OutlineTransparency = Library.OutlineTransparency}):Play()
	end







	Frames[Object] = TextFrame
	Labels[Object] = TextLabel

	Objects[Object] = Object
	ColorTable[Object] = Parameters.Color 

	local lineFrame = Instance.new("Frame")
	lineFrame.Size = UDim2.new(0,0,0,0)
	lineFrame.BackgroundTransparency = 1
	lineFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	lineFrame.Parent = TracersFrame
	lineFrame.Name = Library:GenerateRandomString()
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = Library.TracerSize
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = lineFrame
	stroke.Transparency = 1
	stroke.Name = Library:GenerateRandomString()

	TweenService:Create(lineFrame,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{BackgroundTransparency = 0}):Play()


	TweenService:Create(stroke,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{Transparency = 0}):Play()



	Library.Lines[Object] = {lineFrame, stroke}




	if TextLabel then
		local Tween = TweenService:Create(TextLabel,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{TextTransparency = Library.TextTransparency})
		Tween:Play()
		TweenService:Create(TextLabel,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{TextStrokeTransparency = Library.TextOutlineTransparency}):Play()
		local TweenConnection = Tween.Completed:Connect(function()
			Library.TransparencyEnabled[Object] = true

		end)
		table.insert(Manager, TweenConnection)
	end






	table.insert(Elements,TextFrame)
	table.insert(TotalObjects, Object)




	local Destroying1 = Object:GetPropertyChangedSignal("Parent"):Connect(function()
		Library:RemoveESP(Object)

	end)
	table.insert(Manager, Destroying1)
	if Object.Parent ~= nil then
		local Destroying2 = Object.Parent:GetPropertyChangedSignal("Parent"):Connect(function()
			Library:RemoveESP(Object)



		end)
		table.insert(Manager, Destroying2)
	end
	if Object:IsA("Model") and Object.PrimaryPart then
		local Destroying3 = Object.PrimaryPart:GetPropertyChangedSignal("Parent"):Connect(function()
			Library:RemoveESP(Object)

		end)
		table.insert(Manager, Destroying3)
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
	TracersFrame.Visible = Value
end

function Library:SetArrows(Value)
	Library.Arrows = Value
	ArrowsFrame.Visible = Value
end

function Library:SetArrowRadius(Value)
	Library.ArrowRadius = Value
end

function Library:SetTracerOrigin(Value)
	Library.TracerOrigin = Value
end

function Library:SetDistanceSizeRatio(Value)
	Library.DistanceSizeRatio = Value
end

function Library:SetTracerSize(Value)
	Library.TracerSize = 0.5 * Value
end




function removeObjectFromTables(object)
	for index, obj in pairs(TotalObjects) do

		if obj == object then

			table.remove(TotalObjects, index)

			break
		end

	end
end


function Library:RemoveESP(Object)
	if Library.Unloaded == true or Library.ElementsEnabled[Object] ~= true then return end

	Library.ElementsEnabled[Object] = false


	Library.TransparencyEnabled[Object] = false




	local Value = Instance.new("Frame", game.ReplicatedStorage)
	Value.BackgroundTransparency = 0
	Value.Name = Library:GenerateRandomString()

	game:GetService("Debris"):AddItem(Value, Library.FadeTime + 0.5)


	local TextFrame = Frames[Object]

	local Manager = Library.ConnectionsManager[Object]
	for i,Connection in pairs(Manager) do
		if Connection ~= nil then
			Connection:Disconnect()
		end
	end



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

	if Library.Lines[Object][2] ~= nil then
		TweenService:Create(Library.Lines[Object][2] ,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{Transparency = 1}):Play()

	end

	if ArrowsTable[Object] ~= nil then
		TweenService:Create(ArrowsTable[Object] ,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{ImageTransparency = 1}):Play()

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

			if ArrowsTable[Object] then
				ArrowsTable[Object]:Destroy()
				ArrowsTable[Object] = nil
			end

			if Connections[Object] then
				Connections[Object]:Disconnect()
			end

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





		local DestroyTween1 = DestroyTween.Completed:Connect(function()
			if Library.ElementsEnabled[Object] == false then

				if Frames[Object] then
					Frames[Object]:Destroy()
					Frames[Object] = nil
				end

				removeObjectFromTables(Object)
				if Connections[Object] then
					Connections[Object]:Disconnect()
				end

				if ArrowsTable[Object] then
					ArrowsTable[Object]:Destroy()
					ArrowsTable[Object] = nil
				end



				if Highlight then
					Highlight:Destroy()
					Highlights[Object] = nil

				end




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
		table.insert(Manager, DestroyTween1)
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
		Library.RainbowColor = Color3.fromHSV(RainbowTable.Hue, 0.8, 1);

	end
end)

CameraConnection = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	Camera = workspace.CurrentCamera
end)



Library.ConnectionName = Library:GenerateRandomString()

task.spawn(function()
	RunService:BindToRenderStep(Library.ConnectionName, Enum.RenderPriority.Camera.Value, function()

		if Library.Unloaded or Camera ~= workspace.CurrentCamera then
			return
		end
	
	
	
	
	
	for i,Object in pairs(TotalObjects) do


	local object = Object


	local pos

	pos = object:GetPivot().Position


	if pos then

		local screenPoint, onScreen = Camera:WorldToViewportPoint(pos)

		local frame = Frames[object]
		local label = Labels[object]
		local highlight = Highlights[object]

		if Library.Lines[object][1] then
			Library.Lines[object][1].Visible = (onScreen)
		end

		if frame then frame.Visible = onScreen end
		if not onScreen then
			-- Hide tracers/highlights without destroying
			if highlight then highlight:Destroy() Highlights[object] = nil highlight = nil end


		else
			
			frame.Position = UDim2.new(0,screenPoint.X,0,screenPoint.Y)
		end



		
		
		if Library.ElementsEnabled[object] == true and onScreen then
			
			if not highlight then

				highlight = Instance.new("Highlight")
				highlight.FillTransparency = 1
				highlight.OutlineTransparency = 1
				highlight.Name = Library.HighlightNames[object] or Library:GenerateRandomString()
				highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				highlight.Parent = HighlightsFolder
				highlight.Adornee = object
				Highlights[object] = highlight
			end
		end



		label.TextColor3 = Library.Rainbow and RainbowTable.Color or ColorTable[object] or Color3.fromRGB(255,255,255)

		if highlight then

					local distance = math.round((Camera.CFrame.Position - pos).Magnitude)
					local distanceText = Library.ShowDistance and ("\n" .. '<font size="' .. math.round(Library.TextSize * Library.DistanceSizeRatio) .. '">[' .. distance .. ']</font>') or ""
					label.Text = TextTable[object] .. distanceText
			highlight.Enabled = true
			highlight.FillColor = Library.Rainbow and RainbowTable.Color or ColorTable[object] or Color3.fromRGB(255,255,255)
			highlight.OutlineColor = Library.MatchColors and highlight.FillColor or Library.OutlineColor
					highlight.FillColor = Library.Rainbow and RainbowTable.Color or ColorTable[object] or Color3.fromRGB(255,255,255)
			if Library.TransparencyEnabled[object] == true then
				highlight.FillTransparency = Library.FillTransparency
				highlight.OutlineTransparency = Library.OutlineTransparency
				label.TextTransparency = Library.TextTransparency
				label.TextStrokeTransparency = Library.TextOutlineTransparency
			end
		end

		local lineFrame = Library.Lines[object][1]
		local stroke = Library.Lines[object][2]
		local origin = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y * 1)

		




		
		
		

		if lineFrame and highlight and Library.Tracers == true and onScreen then
					if Library.TracerOrigin == "Center" then
						local mousePos = game:GetService("UserInputService"):GetMouseLocation();
						origin = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)

					elseif Library.TracerOrigin == "Top" then
						origin = Vector2.new(Camera.ViewportSize.X/2, 0)	
					elseif Library.TracerOrigin == "Mouse" then

						origin = Vector2.new(game.Players.LocalPlayer:GetMouse().X,game:GetService("UserInputService"):GetMouseLocation().Y)


					end
			local destination = Vector2.new(screenPoint.X, screenPoint.Y)
			local position = (origin + destination) / 2
			local rotation = math.deg(math.atan2(destination.Y - origin.Y, destination.X - origin.X))
			local length = (origin - destination).Magnitude

			lineFrame.Position = UDim2.new(0, position.X, 0, position.Y)
			lineFrame.Size = UDim2.new(0, length, 0, 1)
			lineFrame.Rotation = rotation
			lineFrame.BackgroundColor3 = highlight.FillColor
			lineFrame.BorderSizePixel = 0
			stroke.Color = highlight.FillColor
			stroke.Thickness = Library.TracerSize
			lineFrame.Visible = true
		end

		local function getArrowData(objPos)
			local screenSize = Camera.ViewportSize
			local screenCenter = Vector2.new(screenSize.X / 2, screenSize.Y / 2)
			

			local toObj = (objPos - Camera.CFrame.Position).Unit
			local camForward = Camera.CFrame.LookVector
			

			local dir = Vector2.new(screenPoint.X, screenPoint.Y) - screenCenter
			
					local dot = camForward:Dot(toObj)

			

					if dot < 0 then
						dir = -dir
						
					end

			
			local angle = math.atan2(dir.Y, dir.X)
			local radius = math.min(screenSize.X, screenSize.Y) / 2 - (400 - Library.ArrowRadius)
			local arrowPos = screenCenter + dir.Unit * radius

			return arrowPos, math.deg(angle)
		end

		local obj = Object

		if obj and Library.Arrows == true then
			local arrow = ArrowsTable[obj] or nil
			if arrow == nil and Library.ElementsEnabled[obj] == true then
				arrow = arrowTemplate:Clone()
				arrow.Parent = ArrowsFrame
				arrow.Name = Library:GenerateRandomString()

				
					arrow:WaitForChild("Constraint").Name = Library:GenerateRandomString()
				



				ArrowsTable[obj] = arrow


				TweenService:Create(arrow ,TweenInfo.new(Library.FadeTime,Enum.EasingStyle.Quad),{ImageTransparency = 0}):Play()


			elseif Library.ElementsEnabled[obj] == true then
				
				if onScreen and screenPoint.Z > 0 then
					ArrowsTable[obj].Visible = false
				else
					local arrowPos, angle = getArrowData(obj:GetPivot().Position)
					ArrowsTable[obj].Position = UDim2.new(0, arrowPos.X, 0, arrowPos.Y)
					ArrowsTable[obj].Rotation = angle - 180
					ArrowsTable[obj].Visible = true
					
							ArrowsTable[obj].ImageColor3 = (Library.Rainbow == true and Library.RainbowColor or ColorTable[obj])
					
						
					end


				end
			end
		end
	
	end
	end)
end)






function Library:Unload()
	for i,Object in pairs(Library.Objects) do

		Library:RemoveESP(Object)
	end

	for i,Connection in pairs(ConnectionsTable) do
		Connection:Disconnect()
	end


	CameraConnection:Disconnect()
	
	RunService:UnbindFromRenderStep(Library.ConnectionName)



	ScreenGui.Enabled = false
	Library.Unloaded = true


end
-- Finishing Touches --

ObjectsFolder.Name = Library:GenerateRandomString()
ScreenGui.Name = Library:GenerateRandomString()
HighlightsFolder.Name = Library:GenerateRandomString()
TracersFrame.Name = Library:GenerateRandomString()
ArrowsFrame.Name = Library:GenerateRandomString()
BillboardsFolder.Name = Library:GenerateRandomString()
if getgenv ~= nil then
	getgenv().ESPLibrary = Library
end

return Library
