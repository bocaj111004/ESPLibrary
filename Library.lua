local v0 = {ObjectsFolder=Instance.new("Folder"),ScreenGui=Instance.new("ScreenGui"),HighlightsFolder=Instance.new("Folder"),BillboardsFolder=Instance.new("Folder"),TracersFrame=Instance.new("Frame"),ArrowsFrame=Instance.new("Frame"),Highlights={},Labels={},Elements={},ElementsEnabled={},Frames={},TotalObjects={},TransparencyEnabled={},Connections={},Billboards={},ColorTable={},TextTable={},Lines={},ArrowsTable={},Font=Enum.Font.Oswald,ConnectionsTable={},Objects={},ConnectionsManager={},TracerTable={},HighlightNames={},HighlightedObjects={},RemoveIfNotVisible=true,Rainbow=false,UseBillboards=false,Tracers=false,Bold=false,Unloaded=false,ShowDistance=false,MatchColors=true,Arrows=false,TextTransparency=0,TracerOrigin="Bottom",FillTransparency=0.75,OutlineTransparency=0,TextOffset=0,TextOutlineTransparency=0,FadeTime=0,TracerSize=0.5,ArrowRadius=200,TextSize=20,DistanceSizeRatio=1,OutlineColor=Color3.fromRGB(255, 255, 255),RainbowColor=Color3.fromRGB(255, 255, 255)};
local v1 = {HueSetup=0,Hue=0,Step=0,Color=Color3.new(),Enabled=false};
ObjectsFolder = v0.ObjectsFolder;
HttpService = game:GetService("HttpService");
HighlightedObjects = v0.HighlightedObjects;
Highlights = v0.Highlights;
ConnectionsTable = v0.ConnectionsTable;
Objects = v0.Objects;
TotalObjects = v0.TotalObjects;
Billboards = v0.Billboards;
Frames = v0.Frames;
ScreenGui = v0.ScreenGui;
ArrowsTable = v0.ArrowsTable;
HighlightsFolder = v0.HighlightsFolder;
Labels = v0.Labels;
Connections = v0.Connections;
Elements = v0.Elements;
TextTable = v0.TextTable;
Players = game:GetService("Players");
CoreGui = ((identifyexecutor ~= nil) and game:GetService("CoreGui")) or Players.LocalPlayer.PlayerGui;
HttpService = game:GetService("HttpService");
RunService = game:GetService("RunService");
TweenService = game:GetService("TweenService");
GetHUI = (CoreGui:FindFirstChild("RobloxGui")) or CoreGui;
ColorTable = v0.ColorTable;
ScreenGui.Parent = GetHUI;
TracersFrame = v0.TracersFrame;
ArrowsFrame = v0.ArrowsFrame;
HighlightsFolder.Parent = ScreenGui;
BillboardsFolder = v0.BillboardsFolder;
BillboardsFolder.Parent = ScreenGui;
ScreenGui.ResetOnSpawn = false;
ScreenGui.IgnoreGuiInset = true;
TracersFrame.Size = UDim2.new(1, 0, 1, 0);
TracersFrame.BackgroundTransparency = 1;
TracersFrame.Parent = ScreenGui;
ArrowsFrame.Size = UDim2.new(1, 0, 1, 0);
ArrowsFrame.BackgroundTransparency = 1;
ArrowsFrame.Parent = ScreenGui;
TracersFrame.Visible = false;
ArrowsFrame.Visible = false;
Camera = workspace.CurrentCamera;
local v35 = Instance.new("ImageLabel");
v35.Image = "rbxassetid://2418686949";
v35.Size = UDim2.new(0, 72, 0, 72);
v35.AnchorPoint = Vector2.new(0.5, 0.5);
v35.BackgroundTransparency = 1;
v35.ImageTransparency = 1;
local v41 = Instance.new("UIAspectRatioConstraint");
v41.Parent = v35;
v41.AspectRatio = 0.75;
v41.Name = "Constraint";
v0.GenerateRandomString = function(v77)
	local v78 = "";
	local v79 = "";
	v78 = v78 .. "abcdefabcdef";
	v78 = v78 .. "ghijklmnopqrstuvwxyzghijklmnopqrstuvwxyz";
	v78 = v78 .. "123456789123456789";
	v78 = v78 .. "!$%&*(){}[]:;@'~#?/><.,=+|_-`";
	local function v80()
		local v238 = {};
		local v239 = math.random(6, 6);
		for v265 = 1, v239 do
			local v266 = math.random(1, #v78);
			local v267 = v78:sub(v266, v266);
			local v268 = v267;
			local v269 = math.random(1, 2);
			if (v269 == 1) then
				v268 = string.lower(v267);
			else
				v268 = string.upper(v267);
			end
			table.insert(v238, v268);
		end
		return table.concat(v238);
	end
	local v81 = v80();
	local v82 = v80();
	local v83 = v80();
	local v84 = v80();
	local v85 = v80();
	v79 = v81 .. v82 .. v83 .. v84 .. v85;
	return v79;
end;
if (v0.Unloaded == true) then
	return;
end
v0.AddESP = function(v86, v87)
	local v88 = v87.Object;
	if ((v0.ElementsEnabled[v88] == true) or (v0.Unloaded == true)) then
		return;
	end
	if (not v88:IsA("BasePart") and not v88:IsA("Model")) then
		return;
	end
	v0.TransparencyEnabled[v88] = false;
	if Highlights[v88] then
		Highlights[v88]:Destroy();
		Highlights[v88] = nil;
	end
	local v90 = nil;
	if v87.BasePart then
		v90 = v87.BasePart;
	end
	local v91 = Instance.new("Highlight");
	v91.FillTransparency = 1;
	v91.OutlineTransparency = 1;
	v91.Name = v0.HighlightNames[v88] or v0:GenerateRandomString();
	v91.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
	v91.Parent = HighlightsFolder;
	v91.Adornee = v88;
	Highlights[v88] = v91;
	local v100 = {v88};
	TextTable[v88] = v87.Text;
	local v103 = Instance.new("BillboardGui");
	v103.Enabled = false;
	v103.Name = v0:GenerateRandomString();
	v103.Size = UDim2.fromScale(1, 1);
	v103.Parent = BillboardsFolder;
	v103.AlwaysOnTop = true;
	v103.Adornee = v88;
	local v110 = Instance.new("TextLabel");
	v110.Name = v0:GenerateRandomString();
	v110.BackgroundTransparency = 1;
	v110.Text = v87.Text;
	v110.TextTransparency = 1;
	v110.TextStrokeTransparency = v0.TextOutlineTransparency;
	v110.Size = UDim2.new(1, 0, 1, 0);
	v110.Font = v0.Font;
	v110.TextSize = v0.TextSize;
	v110.RichText = true;
	v110.Parent = v103;
	v110.TextColor3 = v87.Color;
	Labels[v88] = v110;
	Objects[v88] = v100;
	v0.ElementsEnabled[v88] = true;
	Labels[v88] = v110;
	v0.HighlightNames[v88] = v0:GenerateRandomString();
	if (v0.ConnectionsTable[v88] == nil) then
		v0.ConnectionsManager[v88] = {};
	end
	local v130 = v0.ConnectionsManager[v88];
	if v91 then
		TweenService:Create(v91, TweenInfo.new(v0.FadeTime, Enum.EasingStyle.Quad), {FillTransparency=v0.FillTransparency}):Play();
		TweenService:Create(v91, TweenInfo.new(v0.FadeTime, Enum.EasingStyle.Quad), {OutlineTransparency=v0.OutlineTransparency}):Play();
	end
	Frames[v88] = v103;
	Labels[v88] = v110;
	Objects[v88] = v88;
	ColorTable[v88] = v87.Color;
	local v133 = Instance.new("Frame");
	v133.Size = UDim2.new(0, 0, 0, 0);
	v133.BackgroundTransparency = 1;
	v133.AnchorPoint = Vector2.new(0.5, 0.5);
	v133.Parent = TracersFrame;
	v133.Name = v0:GenerateRandomString();
	local v139 = Instance.new("UIStroke");
	v139.Thickness = v0.TracerSize;
	v139.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
	v139.Parent = v133;
	v139.Transparency = 1;
	v139.Name = v0:GenerateRandomString();
	TweenService:Create(v133, TweenInfo.new(v0.FadeTime, Enum.EasingStyle.Quad), {BackgroundTransparency=0}):Play();
	TweenService:Create(v139, TweenInfo.new(v0.FadeTime, Enum.EasingStyle.Quad), {Transparency=0}):Play();
	v0.Lines[v88] = {v133,v139};
	if v110 then
		local v273 = TweenService:Create(v110, TweenInfo.new(v0.FadeTime, Enum.EasingStyle.Quad), {TextTransparency=v0.TextTransparency});
		v273:Play();
		TweenService:Create(v110, TweenInfo.new(v0.FadeTime, Enum.EasingStyle.Quad), {TextStrokeTransparency=v0.TextOutlineTransparency}):Play();
		local v274 = v273.Completed:Connect(function()
			v0.TransparencyEnabled[v88] = true;
		end);
		table.insert(v130, v274);
	end
	table.insert(Elements, v103);
	table.insert(TotalObjects, v88);
	local v148 = v88:GetPropertyChangedSignal("Parent"):Connect(function()
		v0:RemoveESP(v88);
	end);
	table.insert(v130, v148);
	if (v88.Parent ~= nil) then
		local v275 = v88.Parent:GetPropertyChangedSignal("Parent"):Connect(function()
			v0:RemoveESP(v88);
		end);
		table.insert(v130, v275);
	end
	if (v88:IsA("Model") and v88.PrimaryPart) then
		local v276 = v88.PrimaryPart:GetPropertyChangedSignal("Parent"):Connect(function()
			v0:RemoveESP(v88);
		end);
		table.insert(v130, v276);
	end
end;
v0.SetColorTable = function(v149, v150, v151)
	ColorTable[v150] = v151;
end;
v0.SetFadeTime = function(v153, v154)
	v0.FadeTime = v154;
end;
v0.SetTextTransparency = function(v156, v157)
	v0.TextTransparency = v157;
	for v240, v241 in pairs(Labels) do
		v241.TextTransparency = v157;
	end
end;
v0.SetFillTransparency = function(v159, v160)
	v0.FillTransparency = v160;
	for v243, v244 in pairs(Highlights) do
		if v244:IsA("Highlight") then
			v244.FillTransparency = v160;
		end
	end
end;
v0.SetOutlineTransparency = function(v162, v163)
	v0.OutlineTransparency = v163;
	for v245, v246 in pairs(Highlights) do
		if v246:IsA("Highlight") then
			v246.OutlineTransparency = v163;
		end
	end
end;
v0.SetTextSize = function(v165, v166)
	v0.TextSize = v166;
	for v247, v248 in pairs(Labels) do
		v248.TextSize = v166;
	end
end;
v0.SetTextOutlineTransparency = function(v168, v169)
	v0.TextOutlineTransparency = v169;
	for v250, v251 in pairs(Labels) do
		v251.TextStrokeTransparency = v169;
	end
end;
v0.SetFont = function(v171, v172)
	v0.Font = v172;
	for v253, v254 in pairs(Labels) do
		v254.Font = v172;
	end
end;
v0.UpdateObjectText = function(v174, v175, v176)
	if Labels[v175] then
		TextTable[v175] = v176;
	end
end;
v0.UpdateObjectColor = function(v177, v178, v179)
	ColorTable[v178] = v179;
	if Labels[v178] then
		Labels[v178].TextColor3 = v179;
	end
end;
v0.SetOutlineColor = function(v181, v182)
	v0.OutlineColor = v182;
end;
v0.SetRainbow = function(v184, v185)
	v0.Rainbow = v185;
end;
v0.SetShowDistance = function(v187, v188)
	v0.ShowDistance = v188;
end;
v0.SetMatchColors = function(v190, v191)
	v0.MatchColors = v191;
end;
v0.SetTracers = function(v193, v194)
	v0.Tracers = v194;
	TracersFrame.Visible = v194;
end;
v0.SetArrows = function(v197, v198)
	v0.Arrows = v198;
	ArrowsFrame.Visible = v198;
end;
v0.SetArrowRadius = function(v201, v202)
	v0.ArrowRadius = v202;
end;
v0.SetTracerOrigin = function(v204, v205)
	v0.TracerOrigin = v205;
end;
v0.SetDistanceSizeRatio = function(v207, v208)
	v0.DistanceSizeRatio = v208;
end;
v0.SetTracerSize = function(v210, v211)
	v0.TracerSize = 0.5 * v211;
end;
function removeObjectFromTables(v213)
	for v256, v257 in pairs(TotalObjects) do
		if (v257 == v213) then
			table.remove(TotalObjects, v256);
			break;
		end
	end
end
v0.RemoveESP = function(v214, v215)
	if ((v0.Unloaded == true) or (v0.ElementsEnabled[v215] ~= true)) then
		return;
	end
	v0.ElementsEnabled[v215] = false;
	v0.TransparencyEnabled[v215] = false;
	local v218 = Instance.new("Frame", game.ReplicatedStorage);
	v218.BackgroundTransparency = 0;
	v218.Name = v0:GenerateRandomString();
	game:GetService("Debris"):AddItem(v218, v0.FadeTime + 0.5);
	local v221 = Frames[v215];
	local v222 = v0.ConnectionsManager[v215];
	for v258, v259 in pairs(v222) do
		if (v259 ~= nil) then
			v259:Disconnect();
		end
	end
	local v223 = Labels[v215];
	if v223 then
		TweenService:Create(v223, TweenInfo.new(v0.FadeTime, Enum.EasingStyle.Quad), {TextTransparency=1}):Play();
	end
	if (v0.Lines[v215] ~= nil) then
		if (v0.Lines[v215][1] ~= nil) then
			TweenService:Create(v0.Lines[v215][1], TweenInfo.new(v0.FadeTime, Enum.EasingStyle.Quad), {BackgroundTransparency=1}):Play();
		end
		if (v0.Lines[v215][2] ~= nil) then
			TweenService:Create(v0.Lines[v215][2], TweenInfo.new(v0.FadeTime, Enum.EasingStyle.Quad), {Transparency=1}):Play();
		end
	end
	local v224;
	if Highlights[v215] then
		TweenService:Create(Highlights[v215], TweenInfo.new(v0.FadeTime, Enum.EasingStyle.Quad), {FillTransparency=1}):Play();
		TweenService:Create(Highlights[v215], TweenInfo.new(v0.FadeTime, Enum.EasingStyle.Quad), {OutlineTransparency=1}):Play();
		v224 = Highlights[v215];
	end
	if (v0.Lines[v215][2] ~= nil) then
		TweenService:Create(v0.Lines[v215][2], TweenInfo.new(v0.FadeTime, Enum.EasingStyle.Quad), {Transparency=1}):Play();
	end
	if (ArrowsTable[v215] ~= nil) then
		TweenService:Create(ArrowsTable[v215], TweenInfo.new(v0.FadeTime, Enum.EasingStyle.Quad), {ImageTransparency=1}):Play();
	end
	if (v215.Parent == nil) then
		if (v0.ElementsEnabled[v215] == false) then
			if Frames[v215] then
				Frames[v215]:Destroy();
				Frames[v215] = nil;
			end
			Objects[v215] = nil;
			if v224 then
				v224:Destroy();
				Highlights[v215] = nil;
			end
			removeObjectFromTables(v215);
			if ArrowsTable[v215] then
				ArrowsTable[v215]:Destroy();
				ArrowsTable[v215] = nil;
			end
			if Connections[v215] then
				Connections[v215]:Disconnect();
			end
			if (v0.Lines[v215] ~= nil) then
				if (v0.Lines[v215][1] ~= nil) then
					v0.Lines[v215][1]:Destroy();
				end
				if (v0.Lines[v215][2] ~= nil) then
					v0.Lines[v215][2]:Destroy();
				end
				v0.Lines[v215] = {};
			end
			if (v0.TracerTable[v215] ~= nil) then
				v0.TracerTable[v215]:Destroy();
			end
			v218:Destroy();
		elseif v224 then
			TweenService:Create(v224, TweenInfo.new(v0.FadeTime, Enum.EasingStyle.Quad), {FillTransparency=v0.FillTransparency}):Play();
			TweenService:Create(v224, TweenInfo.new(v0.FadeTime, Enum.EasingStyle.Quad), {OutlineTransparency=v0.OutlineTransparency}):Play();
		end
	else
		local v280 = TweenService:Create(v218, TweenInfo.new(v0.FadeTime, Enum.EasingStyle.Quad), {BackgroundTransparency=1});
		v280:Play();
		local v281 = v280.Completed:Connect(function()
			if (v0.ElementsEnabled[v215] == false) then
				if Frames[v215] then
					Frames[v215]:Destroy();
					Frames[v215] = nil;
				end
				removeObjectFromTables(v215);
				if Connections[v215] then
					Connections[v215]:Disconnect();
				end
				if ArrowsTable[v215] then
					ArrowsTable[v215]:Destroy();
					ArrowsTable[v215] = nil;
				end
				if v224 then
					v224:Destroy();
					Highlights[v215] = nil;
				end
				if (v0.Lines[v215] ~= nil) then
					if (v0.Lines[v215][1] ~= nil) then
						v0.Lines[v215][1]:Destroy();
					end
					if (v0.Lines[v215][2] ~= nil) then
						v0.Lines[v215][2]:Destroy();
					end
					v0.Lines[v215] = {};
				end
				if (v0.TracerTable[v215] ~= nil) then
					v0.TracerTable[v215]:Destroy();
				end
				v218:Destroy();
			elseif v224 then
				TweenService:Create(v224, TweenInfo.new(v0.FadeTime, Enum.EasingStyle.Quad), {FillTransparency=v0.FillTransparency}):Play();
				TweenService:Create(v224, TweenInfo.new(v0.FadeTime, Enum.EasingStyle.Quad), {OutlineTransparency=v0.OutlineTransparency}):Play();
			end
		end);
		table.insert(v222, v281);
	end
end;
ConnectionsTable.RainbowConnection = RunService.RenderStepped:Connect(function(v225)
	v1.Step = v1.Step + v225;
	if (v1.Step >= (1 / 60)) then
		v1.Step = 0;
		v1.HueSetup = v1.HueSetup + (1 / 400);
		if (v1.HueSetup > 1) then
			v1.HueSetup = 0;
		end
		v1.Hue = v1.HueSetup;
		v1.Color = Color3.fromHSV(v1.Hue, 0.8, 1);
		v0.RainbowColor = Color3.fromHSV(v1.Hue, 0.8, 1);
	end
end);
CameraConnection = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	Camera = workspace.CurrentCamera;
end);
local function v69(v228, v229)
	local v230 = Camera.ViewportSize.X;
	local v231 = Camera.ViewportSize.Y;
	local v232, v233 = Camera:WorldToViewportPoint(v228:GetPivot().Position);
	local v234 = Vector2.new(v230 / 2, v231 / 2);
	if (not v233 and (v0.Arrows == true)) then
		local v287 = (Vector2.new(v232.X, v232.Y) - v234).Unit;
		v287 = Vector2.new(v287.X, -v287.Y);
		local v288 = (math.min(v230, v231) / 2) - (500 - v0.ArrowRadius);
		local v289 = v234 + (v287 * v288);
		v229.Position = UDim2.new(0, v289.X, 0, v289.Y);
		v229.Rotation = math.deg(math.atan2(v287.Y, v287.X));
		v229.Visible = true;
	else
		v229.Visible = false;
	end
end
task.spawn(function()
	while task.wait(0.01) do
		if (Camera ~= workspace.CurrentCamera) then
			return;
		end
		if v0.Unloaded then
			break;
		end
		for v294, v295 in pairs(TotalObjects) do
			local v296 = v295;
			local v297;
			v297 = v296:GetPivot().Position;
			if v297 then
				local v304, v305 = Camera:WorldToViewportPoint(v297);
				local v306 = Frames[v296];
				local v307 = Labels[v296];
				local v308 = Highlights[v296];
				if v0.Lines[v296][1] then
					v0.Lines[v296][1].Visible = v305;
				end
				if v306 then
					v306.Enabled = v305;
				end
				if not v305 then
					if v308 then
						v308:Destroy();
						Highlights[v296] = nil;
						v308 = nil;
					end
				end
				if ((v0.ElementsEnabled[v296] == true) and v305) then
					if not v308 then
						v308 = Instance.new("Highlight");
						v308.FillTransparency = 1;
						v308.OutlineTransparency = 1;
						v308.Name = v0.HighlightNames[v296] or v0:GenerateRandomString();
						v308.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
						v308.Parent = HighlightsFolder;
						v308.Adornee = v296;
						Highlights[v296] = v308;
					end
				end
				v307.TextColor3 = (v0.Rainbow and v1.Color) or ColorTable[v296] or Color3.fromRGB(255, 255, 255);
				if v308 then
					local v331 = math.round((Camera.CFrame.Position - v297).Magnitude);
					local v332 = (v0.ShowDistance and ("\n" .. '<font size="' .. math.round(v0.TextSize * v0.DistanceSizeRatio) .. '">[' .. v331 .. "]</font>")) or "";
					v307.Text = TextTable[v296] .. v332;
					v308.Enabled = true;
					v308.FillColor = (v0.Rainbow and v1.Color) or ColorTable[v296] or Color3.fromRGB(255, 255, 255);
					v308.OutlineColor = (v0.MatchColors and v308.FillColor) or v0.OutlineColor;
					v308.FillColor = (v0.Rainbow and v1.Color) or ColorTable[v296] or Color3.fromRGB(255, 255, 255);
					if (v0.TransparencyEnabled[v296] == true) then
						v308.FillTransparency = v0.FillTransparency;
						v308.OutlineTransparency = v0.OutlineTransparency;
						v307.TextTransparency = v0.TextTransparency;
						v307.TextStrokeTransparency = v0.TextOutlineTransparency;
					end
				end
				local v310 = v0.Lines[v296][1];
				local v311 = v0.Lines[v296][2];
				local v312 = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y * 1);
				if (v310 and v308 and (v0.Tracers == true) and v305) then
					if (v0.TracerOrigin == "Center") then
						local v373 = game:GetService("UserInputService"):GetMouseLocation();
						v312 = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2);
					elseif (v0.TracerOrigin == "Top") then
						v312 = Vector2.new(Camera.ViewportSize.X / 2, 0);
					elseif (v0.TracerOrigin == "Mouse") then
						v312 = Vector2.new(game.Players.LocalPlayer:GetMouse().X, game:GetService("UserInputService"):GetMouseLocation().Y);
					end
					local v337 = Vector2.new(v304.X, v304.Y);
					local v338 = (v312 + v337) / 2;
					local v339 = math.deg(math.atan2(v337.Y - v312.Y, v337.X - v312.X));
					local v340 = (v312 - v337).Magnitude;
					v310.Position = UDim2.new(0, v338.X, 0, v338.Y);
					v310.Size = UDim2.new(0, v340, 0, 1);
					v310.Rotation = v339;
					v310.BackgroundColor3 = v308.FillColor;
					v310.BorderSizePixel = 0;
					v311.Color = v308.FillColor;
					v311.Thickness = v0.TracerSize;
					v310.Visible = true;
				end
				local function v313(v315)
					local v316 = Camera.ViewportSize;
					local v317 = Vector2.new(v316.X / 2, v316.Y / 2);
					local v318 = (v315 - Camera.CFrame.Position).Unit;
					local v319 = Camera.CFrame.LookVector;
					local v320 = Vector2.new(v304.X, v304.Y) - v317;
					local v321 = v319:Dot(v318);
					if (v321 < 0) then
						v320 = -v320;
					end
					local v322 = math.atan2(v320.Y, v320.X);
					local v323 = (math.min(v316.X, v316.Y) / 2) - (400 - v0.ArrowRadius);
					local v324 = v317 + (v320.Unit * v323);
					return v324, math.deg(v322);
				end
				local v314 = v295;
				if (v314 and v314:IsDescendantOf(workspace) and (v0.Arrows == true)) then
					local v351 = ArrowsTable[v314] or nil;
					if ((v351 == nil) and (v0.ElementsEnabled[v314] == true)) then
						v351 = v35:Clone();
						v351.Parent = ArrowsFrame;
						v351.Name = v0:GenerateRandomString();
						v351:WaitForChild("Constraint").Name = v0:GenerateRandomString();
						ArrowsTable[v314] = v351;
						TweenService:Create(v351, TweenInfo.new(v0.FadeTime, Enum.EasingStyle.Quad), {ImageTransparency=0}):Play();
					elseif (v0.ElementsEnabled[v314] == true) then
						if (v305 and (v304.Z > 0)) then
							ArrowsTable[v314].Visible = false;
						else
							local v379, v380 = v313(v314:GetPivot().Position);
							ArrowsTable[v314].Position = UDim2.new(0, v379.X, 0, v379.Y);
							ArrowsTable[v314].Rotation = v380;
							ArrowsTable[v314].Visible = true;
							ArrowsTable[v314].ImageColor3 = ((v0.Rainbow == true) and v0.RainbowColor) or ColorTable[v314];
						end
					end
				end
			end
		end
	end
end);
v0.Unload = function(v235)
	for v260, v261 in pairs(v0.Objects) do
		v0:RemoveESP(v261);
	end
	for v262, v263 in pairs(ConnectionsTable) do
		v263:Disconnect();
	end
	CameraConnection:Disconnect();
	ScreenGui.Enabled = false;
	v0.Unloaded = true;
end;
ObjectsFolder.Name = v0:GenerateRandomString();
ScreenGui.Name = v0:GenerateRandomString();
HighlightsFolder.Name = v0:GenerateRandomString();
TracersFrame.Name = v0:GenerateRandomString();
ArrowsFrame.Name = v0:GenerateRandomString();
BillboardsFolder.Name = v0:GenerateRandomString();
if (getgenv ~= nil) then
	getgenv().ESPLibrary = v0;
end
return v0;
