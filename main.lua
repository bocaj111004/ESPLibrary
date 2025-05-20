local LoadingTime = tick()
local LoadingCooldown = false
local FOVTweenTime = 0
local ScriptName = "Jacob's Epic Script"



-- Variables --



Players = game:GetService("Players")
local Player = Players.LocalPlayer

if Player:GetAttribute("Alive") == false then
	game:GetService("StarterGui"):SetCore("SendNotification",{
		Title = ScriptName, -- Required
		Text = "The script cannot be executed while you are dead."
	})

	return
end


if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("MainUI") or not game.Workspace.CurrentRooms:FindFirstChildOfClass("Model") then

	
	game:GetService("StarterGui"):SetCore("SendNotification",{
		Title = ScriptName, -- Required
			Text = "The game has not fully loaded yet. Please wait for the game to fully load before re-executing."
	})

	return

else

	
end

if getgenv().JSHUB ~= true then
	getgenv().JSHUB = true
	
	game:GetService("StarterGui"):SetCore("SendNotification",{
		Title = ScriptName, -- Required
		Text = "The script is now loading!\nPlease wait."
	})
	


	local repo = 'https://raw.githubusercontent.com/bocaj111004/Linora/refs/heads/main/'

	local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/bocaj111004/ESPLibrary/refs/heads/main/main.lua"))()
	local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
	local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
	local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Functions = {}

ReplicatedStorage = game:GetService("ReplicatedStorage")
RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local PathfindingService = game:GetService("PathfindingService")
local PathfindingFolder = Instance.new("Folder")
PathfindingFolder.Name = ESPLibrary:GenerateRandomString()
PathfindingFolder.Parent = game.Workspace
local scriptlink = 'https://raw.githubusercontent.com/bocaj111004/Scripts/refs/heads/main/DoorsScriptTest.lua'

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Name = ESPLibrary:GenerateRandomString()
ImageLabel.Image = "http://www.roblox.com/asset/?id=14562122532"
ImageLabel.Parent = ReplicatedStorage
game:GetService("Debris"):AddItem(ImageLabel, 10)


local RemotesFolder
if ReplicatedStorage:FindFirstChild("RemotesFolder") then
	RemotesFolder = ReplicatedStorage:FindFirstChild("RemotesFolder")
elseif ReplicatedStorage:FindFirstChild("EntityInfo") then
	RemotesFolder = ReplicatedStorage:FindFirstChild("EntityInfo")
else
	RemotesFolder = ReplicatedStorage:FindFirstChild("Bricks")
end
local ChatNotifyMonsters = false
local MonsterChatNotify = "has spawned. Find a hiding spot!"
local function ChatNotify(Text)
	local textchannel = game:GetService("TextChatService"):WaitForChild("TextChannels"):WaitForChild("RBXGeneral") 
	local message = Text
	textchannel:SendAsync(message)
end
function GetNearestAssetWithCondition(condition)
	local nearestDistance = math.huge
	local nearest
	for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
		if not room:FindFirstChild("Assets") then continue end

		for _, asset in pairs(room.Assets:GetChildren()) do
			if condition(asset) and Player:DistanceFromCharacter(asset.PrimaryPart.Position) < nearestDistance then
				nearestDistance = Player:DistanceFromCharacter(asset.PrimaryPart.Position)
				nearest = asset
			end
		end
	end

	return nearest
end

local Connections = {}

local notifvolume = 3
EntityCounter = 0
GlitchCounter = 0

notif = true
NotifyType = "Linora"
pingid = "4590657391"
monsternotif = false
DeletingSeek = false
tracerthickness = 1




local function forcefireproximityprompt(Obj)
	if Obj:IsA("ProximityPrompt") and Obj.Parent ~= nil and Obj.Name ~= "HintPrompt" then 



		fireproximityprompt(Obj, 0)


	end
end
function GetPadlockCode(paper)
	if paper:FindFirstChild("UI") then
		local code = {}

		for _, image in pairs(paper.UI:GetChildren()) do
			if image:IsA("ImageLabel") and tonumber(image.Name) then
				code[image.ImageRectOffset.X .. image.ImageRectOffset.Y] = {tonumber(image.Name), "_"}
			end
		end

		for _, image in pairs(game.Players.LocalPlayer.PlayerGui.PermUI.Hints:GetChildren()) do
			if image.Name == "Icon" then
				if code[image.ImageRectOffset.X .. image.ImageRectOffset.Y] then
					code[image.ImageRectOffset.X .. image.ImageRectOffset.Y][2] = image.TextLabel.Text
				end
			end
		end

		local normalizedCode = {}
		for _, num in pairs(code) do
			normalizedCode[num[1]] = num[2]
		end

		return table.concat(normalizedCode)
	end

	return "_____"
end
function DoorsNotify(unsafeOptions)
	assert(typeof(unsafeOptions) == "table", "Expected a table as options argument but got " .. typeof(unsafeOptions))


	local options = {
		Title = unsafeOptions.Title,
		Description = unsafeOptions.Description,
		Reason = unsafeOptions.Reason,
		NotificationType = unsafeOptions.NotificationType,
		Image = unsafeOptions.Image,
		Color = nil,
		Time = unsafeOptions.Time,

		TweenDuration = 0.8
	}

	if options.NotificationType == nil then
		options.NotificationType = "NOTIFICATION"
	end
	local achievement = game.Players.LocalPlayer.PlayerGui.MainUI["AchievementsHolder"].Achievement:Clone()
	achievement.Size = UDim2.new(0, 0, 0, 0)
	achievement.Frame.Position = UDim2.new(1.1, 0, 0, 0)
	achievement.Name = "LiveAchievement"
	achievement.Visible = true

	achievement.Frame.TextLabel.Text = options.NotificationType

	if options.NotificationType == "WARNING" then
		achievement.Frame.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
		achievement.Frame.UIStroke.Color = Color3.fromRGB(255, 0, 0)
		achievement.Frame.Glow.ImageColor3 = Color3.fromRGB(255, 0, 0)
	end


	achievement.Frame.Details.Desc.Text = tostring(options.Description)
	achievement.Frame.Details.Title.Text = tostring(options.Title)
	achievement.Frame.Details.Reason.Text = tostring(options.Reason or "")

	achievement.Frame.ImageLabel.BackgroundTransparency = 0
	if options.Image ~= nil then
		if options.Image:match("rbxthumb://") or options.Image:match("rbxassetid://") then
			achievement.Frame.ImageLabel.Image = tostring(options.Image or "rbxassetid://0")
		else
			achievement.Frame.ImageLabel.Image = options.Image
		end
	else
		achievement.Frame.ImageLabel.Image = "rbxassetid://6023426923"
	end
	achievement.Parent = game.Players.LocalPlayer.PlayerGui.MainUI["AchievementsHolder"]
	achievement.Sound.SoundId = "rbxassetid://10469938989"

	achievement.Sound.Volume = 1

	if notif == true then
		achievement.Sound:Play()
	end

	task.spawn(function()
		achievement:TweenSize(UDim2.new(1, 0, 0.2, 0), "In", "Quad", options.TweenDuration, true)

		task.wait(0.8)

		achievement.Frame:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.5, true)

		game:GetService("TweenService"):Create(achievement.Frame.Glow, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In),{
			ImageTransparency = 1
		}):Play()

		if options.Time ~= nil then
			if typeof(options.Time) == "number" then
				task.wait(options.Time)
			elseif typeof(options.Time) == "Instance" then
				options.Time.Destroying:Wait()
			end
		else
			task.wait(10)
		end

		achievement.Frame:TweenPosition(UDim2.new(1.1, 0, 0, 0), "In", "Quad", 0.5, true)
		task.wait(0.5)
		achievement:TweenSize(UDim2.new(1, 0, -0.1, 0), "InOut", "Quad", 0.5, true)
		task.wait(0.5)
		achievement:Destroy()
	end)
end
OtherLinora = false


local ReplicatedStorage = game:GetService("ReplicatedStorage")





local RequireCheck = false
if getgc  then
	local gctable = getgc(true)

	for i,v in pairs(getgc(true)) do
		if type(v) == 'table' then
			RequireCheck = true
		end
	end
end





local Main_Game = nil

if RequireCheck == true then
		Main_Game = require(game.Players.LocalPlayer.PlayerGui:WaitForChild("MainUI").Initiator.Main_Game)
end




	

	Library.ScreenGui.DisplayOrder = 999999

local Toggles = Library.Toggles
local Options = Library.Options




local function DisableJeff(jeff)
	jeff:WaitForChild("Humanoid")

	Player.Character:WaitForChild("Collision").Anchored = true



	for i, v in pairs(jeff:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanTouch = false
			v.CanCollide = false
		end
	end
	jeff.Humanoid.Health = 0
	jeff.Humanoid.MaxHealth = 0
	task.wait(0.25)
	Player.Character:WaitForChild("Collision").Anchored = false


end
local function Notify(notifytable)
	local reason = nil
	if notifytable.Reason then
		reason = " "..notifytable.Reason
	else
		reason = ""
	end
	if NotifyType == "Linora" then
		if Library.NotifySide == "Left" then
			Library:Notify(notifytable.Title .. " | "..notifytable.Description .. reason,notifytable.Time or 10)
		else
			Library:Notify(notifytable.Description .. reason .. " | "..notifytable.Title,notifytable.Time or 10)
		end

	elseif NotifyType == "Doors" then
		DoorsNotify(notifytable)

	end
end
local function Sound()
	if notif == true and NotifyType ~= "Doors" then

		local achievement = game.Players.LocalPlayer.PlayerGui.MainUI["AchievementsHolder"].Achievement:Clone()
		achievement.Parent = game.Players.LocalPlayer.PlayerGui.MainUI["AchievementsHolder"]
		local sound = achievement.Sound


		sound.Volume = notifvolume

		sound.SoundId = "rbxassetid://"..pingid


		sound:Play()

		game:GetService("Debris"):AddItem(achievement,15)

	end
end
Library.NotifySide = "Left"



	local flytoggle = false




	local BreakerSolving = false
	function SolveBreakerBox()
		if game.Workspace.CurrentRooms:FindFirstChild("100") then

			if BreakerSolving == true then return end
			BreakerSolving = true
			Notify({
				Title = "ROOM 100",
				Description = "Interact with the breaker box.",
				Reason = "The breaker box will be automatically solved."
			})
			Sound()


			repeat task.wait(0.1)
				RemotesFolder.EBF:FireServer()
			until not workspace.CurrentRooms["100"]:FindFirstChild("DoorToBreakDown")
		end


	end
	local Entities = {"RushMoving","AmbushMoving","A60","A120","BackdoorRush","Eyes", "BackdoorLookman", "GlitchRush", "GlitchAmbush"}
	local ColorTable = {}
	local EntityShortNames = {
		["RushMoving"] = "Rush",
		["AmbushMoving"] = "Ambush",
		["A60"] = "A-60",
		["A120"] = "A-120",
		["BackdoorRush"] = "Blitz",
		["Eyes"] = "Eyes",
		["BackdoorLookman"] = "Lookman",
		["Lookman"] = "Eyes",
		["GloombatSwarm"] = "Gloombat Swarm",
		["Jeff"] = "Jeff",
		["Halt"] = "Halt",
		["GlitchRush"] = "Glitched Rush",
		["GlitchAmbush"] = "Glitched Ambush"
	}
	local EntityAlliases = {
		["RushMoving"] = "Rush",
		["AmbushMoving"] = "Ambush",
		["A60"] = "A-60",
		["A120"] = "A-120",
		["BackdoorRush"] = "Blitz",
		["Eyes"] = "Eyes",
		["BackdoorLookman"] = "Lookman",
		["Lookman"] = "Eyes",
		["Gloombats"] = "Gloombat Swarm",
		["Halt"] = "Halt",
		["Jeff"] = "Jeff",
		["Giggle"] = "Giggle",
		["GlitchRush"] = "Glitched Rush",
		["GlitchAmbush"] = "Glitched Ambush",
	}
	local EntityNotifers = {
		["Rush"] = false,
		["Ambush"] = false,
		["Eyes"] = false,
		["Blitz"] = false,
		["A-60"] = false,
		["A-120"] = false
	}
	local EntityIcons = {
		["RushMoving"] = "rbxassetid://10716032262",
		["AmbushMoving"] = "rbxassetid://10110576663",
		["A60"] = "rbxassetid://12571092295",
		["A120"] = "rbxassetid://12711591665",
		["BackdoorRush"] = "rbxassetid://16602023490",
		["Eyes"] = "rbxassetid://10183704772",
		["Lookman"] = "rbxassetid://10183704772",
		["BackdoorLookman"] = "rbxassetid://16764872677",
		["GloombatSwarm"] = "rbxassetid://79221203116470",
		["Halt"] = "rbxassetid://11331795398",
		["Jeff"] = "rbxassetid://94479432156278",
		["Giggle"] = "rbxassetid://76353443801508",
		["GlitchRush"] = "rbxassetid://73859273102919",
		["GlitchAmbush"] = "rbxassetid://88369678433359"
	}
	local EntityChatNotifyMessages = {
		["RushMoving"] = "Rush has spawned!",
		["AmbushMoving"] = "Ambush has spawned!",
		["A60"] = "A-60 has spawned!",
		["A120"] = "A-120 has spawned!",
		["BackdoorRush"] = "Blitz has spawned!",
		["Halt"] = "Halt will spawn in the next room!",
		["GloombatSwarm"] = "Gloombats will be in the next room, turn off all light sources!",
		["Jeff"] = "Jeff has spawned!",
		["Eyes"] = "Eyes has spawned. Don't look at it!",
		["BackdoorLookman"] = "Lookman has spawned. Don't look at it!"
	}
	local EntityList = {"RushMoving","AmbushMoving","Eyes","A60","A120","BackdoorRush","Jeff","GloombatSwarm","Halt","BackdoorLookman"}	
	local Closets = {"Wardrobe","Rooms_Locker","Rooms_Locker_Fridge","Backdoor_Wardrobe","Locker_Large","Toolshed", "Double_Bed", "Dumpster", "CircularVent"}
	local Items = {"Lighter",
		"Flashlight",
		"Lockpick",
		"Vitamins",
		"Bandage",
		"StarVial",
		"StarBottle",
		"StarJug",
		"Shakelight",
		"Straplight",
		"Bulklight",
		"Battery",
		"Candle",
		"Crucifix",
		"CrucifixWall",
		"Glowsticks",
		"SkeletonKey",
		"Candy",
		"ShieldMini",
		"ShieldBig",
		"BandagePack",
		"BatteryPack",
		"RiftCandle",
		"Shakelight",
		"LaserPointer",
		"HolyGrenade",
		"Shears",
		"Straplight",
		"Smoothie",
		"Cheese",
		"Bread",
		"AlarmClock",
		"RiftSmoothie",
		"GweenSoda",
		"GlitchCube"

	}
	local Items2 = {"Lighter",
		"Flashlight",
		"Lockpick",
		"Vitamins",
		"Bandage",
		"StarVial",
		"StarBottle",
		"StarJug",
		"Shakelight",
		"Straplight",
		"BigLight",
		"Battery",
		"Candle",
		"Crucifix",
		"CrucifixWall",
		"Glowsticks",
		"SkeletonKey",
		"Candy",
		"ShieldMini",
		"ShieldBig",
		"BandagePack",
		"BatteryPack",
		"RiftCandle",
		"Shakelight",
		"LaserPointer",
		"HolyGrenade",
		"Shears",
		"Straplight",
		"Smoothie",
		"Cheese",
		"Bulklight",
		"Bread",
		"AlarmClock",
		"RiftSmoothie",
		"GweenSoda",
		"GlitchCube"

	}

	local ItemNames = {                                  
		["Lighter"] = "Lighter",
		["Flashlight"] = "Flashlight",
		["Lockpick"] = "Lockpicks",
		["Vitamins"] = "Vitamins",
		["Bandage"] = "Bandage",
		["StarVial"] = "Vial of Starlight",
		["StarBottle"] = "Bottle of Starlight",
		["StarJug"] = "Barrel of Starlight",
		["Shakelight"] = "Gummy Flashlight",
		["Straplight"] = "Straplight",
		["Bulklight"] = "Spotlight",
		["Battery"] = "Battery",
		["Candle"] = "Candle",
		["Crucifix"] = "Crucifix",
		["CrucifixWall"] = "Crucifix",
		["Glowsticks"] = "Glowstick",
		["SkeletonKey"] = "Skeleton Key",
		["Candy"] = "Candy",
		["ShieldMini"] = "Mini Shield Potion",
		["ShieldBig"] = "Big Shield Potion",
		["BandagePack"] = "Bandage Pack",
		["BatteryPack"] = "Battery Pack",
		["RiftCandle"] = "Moonlight Candle",
		["LaserPointer"] = "Laser Pointer",
		["HolyGrenade"] = "Hold Hand Grenade",
		["Shears"] = "Shears",
		["Smoothie"] = "Smoohie",
		["Cheese"] = "Cheese",
		["Bread"] = "Bread",
		["AlarmClock"] = "Alarm Clock",
		["RiftSmoothie"] = "Moonlight Smoothie",
		["GweenSoda"] = "Gween Soda",
		["GlitchCube"] = "Glitch Fragment"
	}
	local SpeedBypassEnabled = false
	local SpeedBypassing = false

	local bypassdelay = 0.21
	local Character = Player.Character
	local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
	local Humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	local Collision = game.Players.LocalPlayer.Character:WaitForChild("Collision")
	local MainWeld = Collision:WaitForChild("Weld")
	local CollisionCrouch = Collision:FindFirstChild("CollisionCrouch") or nil
	local CollisionClone = Collision:Clone()

	CollisionClone.Parent = game.Players.LocalPlayer.Character
	CollisionClone.Name = ESPLibrary:GenerateRandomString()
	CollisionClone.Massless = true
	CollisionClone.CanQuery = false
	CollisionClone.CanCollide = false
	CollisionClone.Position = HumanoidRootPart.Position*Vector3.new(0,0,3)

	local CollisionClone2 = Collision:Clone()
	CollisionClone2.Parent = Character
	CollisionClone2.Name = ESPLibrary:GenerateRandomString()
	CollisionClone2.Massless = true
	CollisionClone2.CanQuery = false
	CollisionClone2.CanCollide = false


	if CollisionClone:FindFirstChild("CollisionCrouch") then
		CollisionClone.CollisionCrouch:Destroy()
	end
	if CollisionClone2:FindFirstChild("CollisionCrouch") then
		CollisionClone2.CollisionCrouch:Destroy()
	end
	function SpeedBypass()
		if SpeedBypassing == true or not CollisionClone then return end
		SpeedBypassing = true

		task.spawn(function()
			while Humanoid and CollisionClone do
				if CollisionClone and Humanoid.WalkSpeed > 21 or CollisionClone and  flytoggle == true then
					
				end
				
					CollisionClone.Massless = true
					
					task.wait(0.15)
				
					CollisionClone.Massless = false
				
				task.wait(bypassdelay)
			end

			SpeedBypassing = false
			if CollisionClone then
				CollisionClone.Massless = true
			end
		end)
	end



	tracerorigin = "Bottom"
	SpeedBoostType = "SpeedBoost"
	MinesAnticheatBypassActive = false
	SpeedBoostEnabled = false
	doorcolor = Color3.fromRGB(0, 170, 255)
	ThirdPersonX = 0
	ThirdPersonY = 0.5
	ThirdPersonZ = 5
	espfadetime = 0.5
	espstrokethickness = 0
	entitycolor = Color3.fromRGB(255,0,0)
	bananapeelcolor = Color3.fromRGB(255,0,0)
	DoorsDifference = 0
	EntityESPShape = "Dynamic"
	EntityOutline = true
	DupeESP = false
	playercolor = Color3.fromRGB(255,255,255)
	local bookcolor = Color3.fromRGB(0,255,255)
	local breakercolor = Color3.fromRGB(0,255,255)
	local textoffset = Vector3.new(0,0,0)
	local itemcolor = Color3.fromRGB(0,255,255)
	local generatorcolor = Color3.fromRGB(255,170,0)
	local snarecolor = Color3.fromRGB(255,0,0)
	local closetcolor = Color3.fromRGB(0, 255, 0)
	local keycolor = Color3.fromRGB(0,255,255)
	local levercolor = Color3.fromRGB(255,170,0)
	local goldcolor = Color3.fromRGB(255,255,0)
	local fusecolor = Color3.fromRGB(0,255,255)
	local rainbow = false
	local FogEnd = 0
	local FogEnd2 = game:GetService("Lighting").FogEnd
	if game.Lighting:FindFirstChild("Fog") then
		FogEnd = game:GetService("Lighting"):WaitForChild("Fog").Density
	end
	local Color = Color3.fromRGB(255,255,255)
	local ft = 0.6
	local BypassSeek = false
	local ot = 0
	if not game.Players.LocalPlayer.PlayerGui:WaitForChild("MainUI",99999).Initiator:FindFirstChild("Main_Game") then

		Notify({
			Title = "Error",
			Description = "There was an error while loading the script",
		})	
		Sound()
		getgenv().JSHUB = false
	else
		local Modules = game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules
		local EntityModules = game.ReplicatedStorage.ClientModules.EntityModules
		local Screech = Modules:FindFirstChild("Screech") or Modules:FindFirstChild("Screech_")
		local Halt = EntityModules.Shade
		local Dread = Instance.new("Folder")
		if Modules:FindFirstChild("Dread") then
			Dread = Modules.Dread
		end
		local Timothy = Modules.SpiderJumpscare
		local Glitch = EntityModules.Glitch
		local Void
		if game:GetService("ReplicatedStorage").ClientModules.EntityModules:FindFirstChild("Void") then
			Void = game:GetService("ReplicatedStorage").ClientModules.EntityModules.Void
		end
		local A90
		if Modules:FindFirstChild("A90") then
			A90 = Modules.A90
		end
		local tt = 0
		local oc = "White"
		local CurrentRoom = 0
		local MotorReplication = RemotesFolder.MotorReplication
		local highlight = false
		local BillboardsFolder = Instance.new("Folder")
		local Floor = game.ReplicatedStorage.GameData.Floor.Value
		BillboardsFolder.Parent = game.CoreGui
		BillboardsFolder.Name = "yay"
		for i,room in pairs(game.Workspace.CurrentRooms:GetChildren()) do
			CurrentRoom = (tonumber(room.Name) - 1)
		end
	
		local function togglenoclip(value)

			noclip = value



		end
		if Floor == "Backdoor" then
			DoorsDifference = -51
		elseif Floor == "Mines" then
			DoorsDifference = 100
		end
		local tracers = false
		local SpeedBoost = 0

		local OldHotel = false
		if RemotesFolder.Name == "Bricks" then
			OldHotel = true
		end


		TIMEOUT  = 0.6
		RAY_LENGTH = 2
		SPEED      = 1.25
		MAX_FORCE  = 1e32

		-- State
		bypassActive = false
		bv = nil 
		timer = nil

		-- Raycast filter (ignore your own character)
		local rayParams = RaycastParams.new()
		rayParams.FilterType = Enum.RaycastFilterType.Exclude

		local function refreshFilter()
			local char = game.Players.LocalPlayer.Character
			if char then
				rayParams.FilterDescendantsInstances = {char}
			end
		end

		local function clearBV()
			if bv and bv.Parent then
				bv:Destroy()
			end
			bv = nil
			timer = nil
			-- NOTE: we no longer touch fakecollision here—leave it at whatever state it is
		end

		local function onStep()
			if not bypassActive then clearBV() return end
			local char = Player.Character
			local hrp  = HumanoidRootPart
			if not hrp then return end

		
				-- create or maintain BodyVelocity
				if not bv then
					bv = Instance.new("BodyVelocity")
					bv.Name     = "NoclipBypassBV"
					bv.MaxForce = Vector3.new(MAX_FORCE, MAX_FORCE, MAX_FORCE)
					bv.Parent   = hrp
				end
				bv.Velocity = hrp.CFrame.LookVector * SPEED
				timer = TIMEOUT

				-- continuously lock fakecollision to non-massless while validHit persists

				
			  
			
		end

		local Jumpscares = game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener:FindFirstChild("Jumpscares") or nil

		local ito = false

		Ambience = Color3.fromRGB(255,255,255)
		local AA = false
		NotifyEyes = false
		AntiScreech = false
		godmodefools = false
		Figure = nil
		AutoLibraryUnlockDistance = 35
		local RemoveFigure = false
		local RemoveHideVignette = false
		local GeneratorESP = false
		JumpBoost = 0
		local DoorReach = false
		local AntiSeekObstructions = false
		local NotifyA120 = false
		local WatermarkGui = Instance.new("ScreenGui")
		WatermarkGui.Parent = game.CoreGui
		WatermarkGui.ResetOnSpawn = false
		local Watermark = Instance.new("TextLabel")
		Watermark.Parent = WatermarkGui
		Watermark.Size = UDim2.new(1,0,0.4,0)
		Watermark.Position = UDim2.new(0,0,0.6,0)

		Watermark.Font = Enum.Font.Oswald
		Watermark.TextColor3 = Color3.fromRGB(255,255,255)
		Watermark.Visible = false
		Watermark.BackgroundTransparency = 1
		Watermark.Text = ""
		Watermark.TextScaled = true
		Watermark.TextTransparency = 0.9
		local Watermark2 = Instance.new("TextLabel")
		Watermark2.Parent = WatermarkGui
		Watermark2.Size = UDim2.new(1,0,0.035,0)
		Watermark2.Position = UDim2.new(0,0,-0.05,0)
		Watermark2.TextStrokeTransparency = 0
		Watermark2.Font = Enum.Font.Oswald
		Watermark2.TextColor3 = Color3.fromRGB(255,255,255)
		Watermark2.BackgroundTransparency = 1
		Watermark2.Text = ""
		Watermark2.TextScaled = true
		Watermark2.TextTransparency = 0
		Watermark.TextStrokeTransparency = 0
		OriginalAmbience = game.Lighting.Ambient
	
		EnableFOV = false
		AntiEyes = false
		FigureESP = false
		TransparentCloset = false
		TransparentClosetNumber = 0.75
		FuseESP = false
		anchorcolor = Color3.fromRGB(255,170,0)
		AnchorESP = false
		laddercolor = Color3.fromRGB(255, 255, 255)
		chestcolor = Color3.fromRGB(255,255,0)
		grumblecolor = Color3.fromRGB(255, 0, 0)
		louiecolor = Color3.fromRGB(0,255,255)
		jeffcolor = Color3.fromRGB(255,0,0)
		figurecolor = Color3.fromRGB(255,0,0)
		fusecolor = Color3.fromRGB(0,255,255)
		generatorcolor = Color3.fromRGB(255,170,0)
		timelevercolor = Color3.fromRGB(255,170,0)
		dupecolor = Color3.fromRGB(255,0,0)
		gigglecolor = Color3.fromRGB(255,0,0)
		Ladders = false
		ReachDistance = 1
		autoplay = false
		ToolSpamSelf = false
		ToolSpamAll = false
		local AntiFH = false
		local AntiSnare = false
		local AntiDupe = false
		local NotifyTimeLevers = false

		local SnareESP = false
		local GrumbleESP = false
		local keycarddupe = false
		local godmodelocker = nil
		local MinesBypass = false
		local EntityESP = false
		local AntiLookman = false
		local AntiVacuum = false
		local fb = false
		local autoplaypart
		local ToolSpam = false
		local ItemESP = false
		local godmode = false
		local TimerLevers = false
		local AutoLibrary = false

		local AutoBreaker = false
		local keycardduped = false
		local flyspeed = 3
		local godmodenotif = false
		local keycardtable = {"NormalKeyCard", "RidgeKeyCard"}
		local spectate = false
		local antilag = false
		local speakers = false
		local rev = false
		local maxinteract = false
		VacuumESP = false
		local flyvelocity
		local NA = false
		local gold = false

		fov = 70
		local fovmultiplier = 1
		local interact = false
		local playingagain = false
		local PathfindingFolder = Instance.new("Folder")
		PathfindingFolder.Name = "PathfindingNodes"
		PathfindingFolder.Parent = game.Workspace





		local ObjectsTable = {
			Doors = {},
			Keys = {},
			Snares = {},
			Levers = {},
			Gold = {},
			Items = {},
			Closets = {},
			Chests = {},
			Giggles = {},
			Entities = {},
			Grumbes = {},
			Fuses = {},
			Players = {},
			Ladders = {},
			TimeLevers = {},
			Anchors = {},
			Books = {},
			Breakers = {},
			Figures = {},
			Dupe = {},
			Jeffs = {},
			Bananas = {},
			Generators = {},
		

		}

		local function removeObjectFromTables(object)
			for tableName, objectList in pairs(ObjectsTable) do
				for index, obj in ipairs(objectList) do
					if obj == object then
						table.remove(objectList, index)
						print("Removed object from table: " .. tableName)
						break
					end
				end
			end
		end

		-- Set up a listener to detect when objects are removed
		for _, tableList in pairs(ObjectsTable) do
			for _, object in ipairs(tableList) do
				if object:IsA("Instance") then
					object.Destroying:Connect(function()
						removeObjectFromTables(object)
					end)
				end
			end
		end

		local allowedInstances = {
			"Lava",
			"GoldPile",
			"KeyObtain",
			"FuseObtain",
			"MinesGenerator",
			"JeffTheKiller",
			"Snare",
			"FakeDoor",
			"DoorFake",
			"SideroomSpace",
			"ChestBox",
			"ChestBoxLocked",
			"Chest_Vine",
			"Toolbox",
			"Toolbox_Locked",
			"Wardrobe",
			"Toolshed",
			"Toolshed_Small",
			"Bed",
			"MinesAnchor",
			"Double_Bed",
			"DoubleBed",
			"RetroWardrobe",
			"Backdoor_Wardrobe",
			"Rooms_Locker",
			"Rooms_Locker_Fridge",
			"Locker_Large",
			"MinesAnchor",
			"FigureRig",
			"FigureRagdoll",
			"Figure",
			"TimerLever",
			"Seek_Arm",
			"AmbushMoving",
			"RushMoving",
			"ScaryWall",
			"Ladder",
			"CircularVent",
			"Dumpster",
			"SquareGrate",
			"Eyes",
			"Halt",
			"A60",
			"TriggerEventCollision",
			"A120",
			"GrumbleRig",
			"GiggleCeiling",
			"MinesGateButton",
			"ElectricalKeyObtain",
			"LiveHintBook",
			"LiveBreakerPolePickup",
			"LeverForGate",
			"GloomPile",
			"MovingDoor",
			"Collision",
			"Door"
		}
		
		-- Hook into new objects being added for future-proofing
		game.Workspace.CurrentRooms.DescendantRemoving:Connect(function(inst)
			if not table.find(allowedInstances,inst.Name) and not inst:IsA("ProximityPrompt") and not table.find(Items2,inst.Name) then return end
			removeObjectFromTables(inst)
		end)


		local vps = game.Workspace.CurrentCamera.ViewportSize

		local function PlayAgain()
			if playingagain == false then
				playingagain = true
				Notify({Title = "Teleporting",Description = "Teleporting in 3 seconds..."})
				Sound()
				RemotesFolder.PlayAgain:FireServer()

			else
				Notify({Title = "Teleporting", Description = "Teleporting in 3 seconds..."})
				Sound()
			end

		end
		local Connection1 = game["Run Service"].RenderStepped:Connect(function()

			if fb == true and OldHotel == true or fb == true and Floor == "Fools" then

				game.Lighting.Ambient = Color3.fromRGB(255,255,255)
			elseif fb == false and OldHotel == true or fb == false and Floor == "Fools" then
				game.Lighting.Ambient = Color3.fromRGB(0,0,0)

			end

			if game.Workspace.Camera:FindFirstChild("Screech") and AntiScreech == true then
				game.Workspace.Camera.Screech:Destroy()
			end


			if AntiEyes == true and game.Workspace:FindFirstChild("Eyes") or AntiEyes == true and game.Workspace:FindFirstChild("Lookman") then
			end



		end)

		local textgui = Instance.new("ScreenGui")
		textgui.Parent = game.CoreGui
		textgui.Name = "Text"
		local tracergui = Instance.new("ScreenGui")
		tracergui.Parent = game.CoreGui
		tracergui.Name = "Tracers"

		ESPLibrary:SetTextSize(20)
ESPLibrary:SetFont(Enum.Font.Oswald)
ESPLibrary:SetFadeTime(0)
		ESPLibrary:SetFillTransparency(0.65)
		ESPLibrary.ShowDistance = true
		ESPLibrary.MainFolder = true
		ESPLibrary.UseBillboards = false



		--// Linoria \\--


		--// Variables \\--

		if Floor == "Mines" then

			type tPathfind = {
				esp: boolean,
				room_number: number, -- the room number
				real: table,
				fake: table,
				destroyed: boolean -- if the pathfind was destroyed for the Teleport
			}

			type tGroupTrack = {
				nodes: table,
				hasStart: boolean,
				hasEnd: boolean,
			}

			--@Internal nodes sorted by @GetNodes or @Pathfind
			type tSortedNodes = {
				real: table,
				fake: table,
				room: number,
			}

			local function tGroupTrackNew(startNode: Part | nil): tGroupTrack
				local create: tGroupTrack = {
					nodes = startNode and {startNode} or {},
					hasStart = false,
					hasEnd   = false,
				}
				return create
			end

			--@Internal funtion
			local previousNode = nil
			local function changeNodeColor(node: Model, color: Color3): Model
				if color == nil then
					node.Color = Color3.fromRGB(255,255,255)
					node.Transparency = 1
					node.Size = Vector3.new(1.0, 1.0, 1.0)
					return
				end
				
				if previousNode ~= nil then
				local trace = Instance.new("Beam")
				trace.Name = ESPLibrary:GenerateRandomString()
				trace.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, color),
					ColorSequenceKeypoint.new(1, color)
				})
				trace.FaceCamera = true
				trace.Width0 = 0.3
				trace.Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 0),
					NumberSequenceKeypoint.new(1, 0)
				})
				
				trace.Width1 = 0.3
				trace.Brightness = 10
				trace.LightInfluence = 0
				trace.LightEmission = 0
				trace.Enabled = true
				trace.Parent = workspace.Terrain

				local att0 = Instance.new("Attachment")
				att0.Name = ESPLibrary:GenerateRandomString()
				att0.Parent = workspace.Terrain
				att0.Position = previousNode.Position

				local att1 = Instance.new("Attachment")
				att1.Name = ESPLibrary:GenerateRandomString()
				att1.Parent = workspace.Terrain
				att1.Position = node.Position

				trace.Attachment0 = att0
				trace.Attachment1 = att1
				
				end
				previousNode = node
				
				return node
			end

			--@Internal function
			--@Return #boolean. True if the pathfind algorithm was ran.
			local function HasAlreadyPathfind(nodesFolder: Folder): boolean
				local hasPathfind = nodesFolder:GetAttribute("_mspaint_nodes_pathfind")
				return hasPathfind
			end

			--@Internal function
			local function HasNodesToPathfind(room: Model)
				local roomNumber = tonumber(room.Name)
				--Make room number restrictions to avoid useless mapping.
			
				local result = (room:GetAttribute("Chase"))

				return result
			end

			--@Internal funtion
			local function sortNodes(nodes: table, reversed: boolean) -- Sort nodes by their number
				table.sort(nodes, function(a, b)
					local Anumber, _ = (a.Name):gsub("[^%d+]", "")
					local Bnumber, _ = (b.Name):gsub("[^%d+]", "")
					if reversed then
						return tonumber(Anumber) > tonumber(Bnumber) --example: 100 to 0
					end
					return tonumber(Anumber) < tonumber(Bnumber) --example: 0 to 100
				end)
				return nodes
			end

			--@Internal function
			--@Return #table with a sorted array of real and fake nodes and the room number. 
			--@Return #nil if there's no Nodes to be processed
			local function PathfindGetNodes(room: Model): tSortedNodes | nil

				if not HasNodesToPathfind(room) then return end

				local Nodes = {
					real = {},
					fake = {}
				}
				local nodeArray = room:WaitForChild("RunnerNodes", 5.0)
				if (nodeArray == nil) then 

					return
				end

				if not HasAlreadyPathfind(nodeArray) then 

					Functions.Pathfind(room, true)
					return 
				end



				for _, node: Part in ipairs(nodeArray:GetChildren()) do
					--check for real nodes

					local realNumber = node:GetAttribute("_mspaint_real_node")
					if realNumber then table.insert(Nodes.real, node) continue end
					--check for fake nodes
					local fakeNumber = node:GetAttribute("_mspaint_fake_node")
					if fakeNumber then table.insert(Nodes.fake, node) end
				end

				--If there's no nodes, return the empty table
				if #Nodes.real <= 0 and #Nodes.fake <= 0 then 

					return
				end

				local sortedReal = sortNodes(Nodes.real)
				local sortedFake = sortNodes(Nodes.fake)

				local nodesList = {
					real = sortedReal,
					fake = sortedFake,
					roomNumber = tonumber(room.Name)
				}

				return nodesList
			end

			--@Internal function
			--@Return nil. __Set the node attribute.__ Can only be called after the __@Pathfind function is completed.__
			local function PathfindSetNodes(nodes: table, nameAttribute: string)

				for i, node: Part in ipairs(nodes) do
					node:SetAttribute(nameAttribute, i)
				end
			end

			local WhitelistConfig = {
				[45] = {firstKeep = 3, lastKeep = 2},
				[46] = {firstKeep = 2, lastKeep = 2},
				[47] = {firstKeep = 2, lastKeep = 2},
				[48] = {firstKeep = 2, lastKeep = 2},
				[49] = {firstKeep = 2, lastKeep = 4},
			}

			--@Internal function
			local function NodeDestroy(nodesList: tSortedNodes)
				if not nodesList then return end


				local roomConfig = WhitelistConfig[nodesList.roomNumber]

				local _firstKeep = roomConfig.firstKeep
				local _lastKeep  = roomConfig.lastKeep

				local _removeTotal = #nodesList.real - (_firstKeep + _lastKeep) --remove nodes that arent in the first or last
				for idx=1, _removeTotal do
					local node = nodesList.real[_firstKeep + 1]
					--changeNodeColor(node, MinecartPathNodeColor.Orange) --debug only
					node:Destroy()
					table.remove(nodesList.real, _firstKeep + 1)
				end

				--Destroy all the fake nodes
				for _, node in ipairs(nodesList.fake) do
					node:Destroy()
					table.remove(nodesList.fake, 1)
				end


			end

			--@Internal function
			--@Return #boolean. True if the pathfind algorithm was ran.
			local function HasAlreadyDestroyed(room: Model): boolean

				local nodesFolder = room:WaitForChild("RunnerNodes", 5.0)
				if (nodesFolder == nil) then 

					return
				end
				local result = nodesFolder:GetAttribute("_mspaint_player_teleported") ~= nil

				return result
			end

			--The Minecart Teleport Function, this will be called with @NodeDestroy.
--[[
    Use "_mspaint_player_teleported" to track the status of the Teleport meaning that:
    _mspaint_player_teleported = nil   ==> Node not destroyed
    _mspaint_player_teleported = false ==> Node destroyed
    _mspaint_player_teleported = true ==> Nodes was destroyed + Player sucessfully teleported.
]]



			--External function to be called.
			function Functions.DrawNodes(room: Model)
				local nodesList = PathfindGetNodes(room)
				if not nodesList then return end

				local espRealColor =  Options.MinecartNodeColor.Value
				local espFakeColor =  Color3.fromRGB(255,0,0)

				--[ESP] Draw the real path
				for _, realNode in ipairs(nodesList.real) do
					changeNodeColor(realNode, espRealColor)
				end
				for _, fakeNode in ipairs(nodesList.fake) do
					--changeNodeColor(fakeNode, espFakeColor)
				end

				--[ESP] Draw the fake path
				-- for idx, fakeNode in ipairs(nodesList.fake) do
				--     changeNodeColor(fakeNode, MinecartPathNodeColor.Red)
				-- end
			end


			--@Return nil. Map the nodes in the __RunnerNodes__ and call features functions (@DrawNode; @Teleport).
			function Functions.Pathfind(room: Model, forcePathfind: boolean)
				if not HasNodesToPathfind(room) then return end

				if not forcePathfind then
					--wait until SendRunnerNodes is trigged
					local pathTimeout = tick() + 5
					repeat task.wait()
					until #Functions.pathfindQueue > 0 or tick() > pathTimeout
					pcall(table.remove, Functions.pathfindQueue, 1)
				end

				local nodesFolder = room:FindFirstChild("RunnerNodes")
				if (nodesFolder == nil) then return end

				local nodes = nodesFolder:GetChildren()

				local numOfNodes = #nodes
				if numOfNodes <= 0 then return end 

				if HasAlreadyPathfind(nodesFolder) then return end


    --[[
        Pathfind is a computational expensive process to make, 
        however we don't have node loops, 
        so we can ignore a few verifications.
        If you want to understand how this is working, search for "Pathfiding Algorithms"

        The shortest explanation i can give is that, this is a custom pathfinding to find "gaps" between
        nodes and creating "path" groups. With the groups estabilished we can make the correct validations.

        -Bacalhauz
    ]]
				--Distance weights [DO NOT EDIT, unless something breaks...]
				local _shortW = 4
				local _longW = 24

				local doorModel = room:WaitForChild("Door", 5) -- Will be used to find the correct last node.

				local _startNode = nodes[1]
				local _lastNode = nil --we need to find this node.

				local _gpID = 1
				local stackNode = {} --Group all track groups here.
				stackNode[_gpID] = tGroupTrackNew()

				--Ensure sort all nodes properly (reversed)
				nodes = sortNodes(nodes, true)

				local _last = 1
				for i=_last+1, numOfNodes, 1 do
					local nodeA: Part = nodes[_last]
					local nodeB: Part = _lastNode and nodes[i] or doorModel

					local distance = (nodeA:GetPivot().Position - nodeB:GetPivot().Position).Magnitude

					local isEndNode = distance <= _shortW
					local isNodeNear = (distance > _shortW and distance <= _longW)

					local _currNodeTask = "Track"
					if isNodeNear or isEndNode then
						if not _lastNode then -- this will only be true, once.
							_currNodeTask = "End"
							_lastNode = nodeA
						end
					else
						_currNodeTask = "Fake"
					end

					--check if group is diff, ignore "End" or "Start" tasks
					if  (_currNodeTask == "Fake" or _currNodeTask == "End") and _lastNode then
						_gpID += 1
						stackNode[_gpID] = tGroupTrackNew()
						if _currNodeTask == "End" then
							stackNode[_gpID].hasEnd = true
						end
					end
					table.insert(stackNode[_gpID].nodes, nodeA)

					--Use this to debug the nodeTask


					_last = i
					--_lastNodeTask = _currNodeTask
				end
				stackNode[_gpID].hasStart = true --after the reversed path finding, the last group has the start node.
				table.insert(stackNode[_gpID].nodes, _startNode)
				--if we only have one group, means that there's no fake path.
				local hasMoreThanOneGroup = _gpID > 1

				local _closestNodes = {} --unwanted nodes if any
				local hasIncorrectPath = false -- if this is true, we're cooked. No path for you ):
				if hasMoreThanOneGroup then

					for _gpI, v: tGroupTrack in ipairs(stackNode) do
						_closestNodes[_gpI] = {}


						if _gpI <= 1 then continue end


						--Sort table for the normal flow, A -> B (was B -> A before)
						v.nodes = sortNodes(v.nodes, false)

						--Finally, perform the clean up by removing wrong nodes when a "distance jump" is found
						local _gplast = 1
						local hasNodeJump = false
						for _gpS=_gplast+1, #v.nodes, 1 do
							local nodeA: Part = v.nodes[_gplast]
							local nodeB: Part = v.nodes[_gpS]

							local distance = (nodeA:GetPivot().Position - nodeB:GetPivot().Position).Magnitude

							hasNodeJump = (distance >= _longW)
							if not hasNodeJump then _gplast = _gpS continue end


							--Ok, we found a node jump, now we need to know what should be the closest node
							--table.remove(v.nodes, _gpS)

							local nodeSearchPath = nodeB

							--Search again with the nodeSearchPath
							local closestDistance = math.huge

							local _gpFlast = #v.nodes
							for i=_gpFlast-1, 1, -1 do

								local fnode = v.nodes[_gpFlast]
								local Sdistance = (nodeSearchPath:GetPivot().Position - fnode:GetPivot().Position).Magnitude
								_gpFlast = i

								if Sdistance == 0.00 then continue end --node is self


								if Sdistance <= closestDistance then
									closestDistance = Sdistance
									table.insert(_closestNodes[_gpI], fnode)
									table.remove(v.nodes, _gpFlast+1)
									continue
								end
								break
							end
							--table.insert(v.nodes, _gpS, nodeSearchPath)

							local _FoundAmount = #_closestNodes[_gpI]
							if _FoundAmount > 1 then 

							else
								warn(string.format("[TrackGroup] Group %s ERROR: Unable to find closest node, path is likely broken.", _gpI))
								hasIncorrectPath = true
							end
							break
						end
						if not hasNodeJump then

						end
					end

					for _gpI, v: tGroupTrack in ipairs(stackNode) do

					end
				end

				if hasIncorrectPath then return end

				--finally, draw the correct path. gg
				local realNodes = {} --our precious nodes finally here :pray:
				local fakeNodes = {} --we hate you but ok
				for _gpFI, v: tGroupTrack in ipairs(stackNode) do
					local finalWrongNode = false
					if _gpFI == 1 and hasMoreThanOneGroup then
						finalWrongNode = true 
					end

					for _, vfinal in ipairs(v.nodes) do
						if finalWrongNode then
							table.insert(fakeNodes, vfinal)
							continue
						end
						table.insert(realNodes, vfinal)
					end

					--Draw wrong path calculated on DeepPath.
					for _, nfinal in ipairs(_closestNodes[_gpFI]) do
						table.insert(fakeNodes, nfinal)
					end
				end
				--our result is stored in the part itself in order.

				local nodesList: tSortedNodes = {
					real = sortNodes(realNodes, false),
					fake = sortNodes(fakeNodes, false)
				}

				nodesFolder:SetAttribute("_mspaint_nodes_pathfind", true)
				PathfindSetNodes(nodesList.real, "_mspaint_real_node")
				PathfindSetNodes(nodesList.fake, "_mspaint_fake_node")
				--Call any feature that requires the pathfind nodes--

				Functions.DrawNodes(room)
			end

		end




		function RemoveESP(inst)
			inst:SetAttribute("CurrentESP",false)



		end


		if game.Workspace.CurrentRooms:FindFirstChild("0") and not game.Workspace.CurrentRooms:FindFirstChild("2") then
			Player:SetAttribute("CurrentRoom","0")
		end

		local function esp(Target,TracerTarget,Text, ColorText, shoulddestroy, instanthighlight)

			local connections = {}
			local destroying = false
			local waittable = {"Door","KeyObtain"}
			local transparencyenabled = false



			if ESPLibrary.ColorTable[Target] == nil then
				ESPLibrary.ColorTable[Target] = ColorText
			end

			if Target:GetAttribute("ESP") ~= true then


















				connections.ParentConnection = Target:GetPropertyChangedSignal("Parent"):Connect(function()
					Target:SetAttribute("ESP",false)

				end)



				local Connection1 = Player:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
					if not Player:GetAttribute("CurrentRoom") or not Target:GetAttribute("ParentRoom") then return end
					if Target ~= nil and Target.Parent ~= nil then
						if Target:GetAttribute("CurrentESP") ~= true  then

							ESPLibrary:AddESP({
								Object = Target,
								Text = Text,
								Color = ESPLibrary.ColorTable[Target]
							})
						end


						if not Player:GetAttribute("CurrentRoom") or not Target:GetAttribute("ParentRoom") then return end
						if shoulddestroy == true and tonumber(Target:GetAttribute("ParentRoom")) == tonumber(Player:GetAttribute("CurrentRoom")) and Target:GetAttribute("ESP") == true or shoulddestroy == true and tonumber(Target:GetAttribute("ParentRoom")) == tonumber(Player:GetAttribute("CurrentRoom"))+1 and Target:GetAttribute("ESP") == true then
							if ESPLibrary.Objects[Target] == nil then
								ESPLibrary:AddESP({
									Object = Target,
									Text = Text,
									Color = ESPLibrary.ColorTable[Target]
								})
							end

						elseif shoulddestroy == true and tonumber(Target:GetAttribute("ParentRoom")) > tonumber(Player:GetAttribute("CurrentRoom"))+1 or shoulddestroy == true and tonumber(Target:GetAttribute("ParentRoom")) < tonumber(Player:GetAttribute("CurrentRoom")) or Target:GetAttribute("ESP") ~= true then




							if ESPLibrary.Objects[Target] ~= nil then
								ESPLibrary:RemoveESP(Target)
							end
						end





					end


					if Target == nil or Target.Parent == nil or Target:IsA("Model") and Target.PrimaryPart == nil then
						Target:SetAttribute("CurrentESP",false)
					end



				end)
				connections.Connection2 = Target:GetAttributeChangedSignal("ESP"):Connect(function()
					if not Player:GetAttribute("CurrentRoom") or not Target:GetAttribute("ParentRoom") then return end
					if Target ~= nil and Target.Parent ~= nil then
						if Target:GetAttribute("CurrentESP") ~= true  then

							ESPLibrary:AddESP({
								Object = Target,
								Text = Text,
								Color = ColorText
							})
						end

						if not Player:GetAttribute("CurrentRoom") or not Target:GetAttribute("ParentRoom") then return end
						if shoulddestroy == true and tonumber(Target:GetAttribute("ParentRoom")) == tonumber(Player:GetAttribute("CurrentRoom")) and Target:GetAttribute("ESP") == true or shoulddestroy == true and tonumber(Target:GetAttribute("ParentRoom")) == tonumber(Player:GetAttribute("CurrentRoom"))+1 and Target:GetAttribute("ESP") == true then
							if ESPLibrary.Objects[Target] == nil then
								ESPLibrary:AddESP({
									Object = Target,
									Text = Text,
									Color = ColorText
								})
							end

						elseif shoulddestroy == true and tonumber(Target:GetAttribute("ParentRoom")) < tonumber(Player:GetAttribute("CurrentRoom")) or Target:GetAttribute("ESP") ~= true then




							if ESPLibrary.Objects[Target] ~= nil then
								ESPLibrary:RemoveESP(Target)
							end
						end





					end


					if Target == nil or Target.Parent == nil or Target:IsA("Model") and Target.PrimaryPart == nil then
						Target:SetAttribute("CurrentESP",false)
					end



				end)
			end

			connections.CurrentConnection = Target:GetAttributeChangedSignal("CurrentESP"):Connect(function()
				if Target:GetAttribute("CurrentESP") == false then
					Target:SetAttribute("ESP",false)

					ESPLibrary:RemoveESP(Target)
				end

			end)
			connections.DestroyConnection = Target.Destroying:Connect(function()



				ESPLibrary:RemoveESP(Target)
				Connection1:Disconnect()
				connections.DestroyConnection:Disconnect()
				connections.Connection2:Disconnect()
				connections.CurrentConnection:Disconnect()
				connections.ParentConnection:Disconnect()



			end)
			task.wait(0.1)
			Target:SetAttribute("ESP", true)
			Target:SetAttribute("ESP",true)
			Target:SetAttribute("CurrentESP", true)






		end



		function DisableDupe(Model)
			if Model.Name == "FakeDoor" and AntiDupe == true or Model.Name == "DoorFake" and AntiDupe == true or Model.Name == "SideroomSpace" and AntiVacuum == true then

				for i,part in pairs(Model:GetDescendants()) do

					if part:IsA("ProximityPrompt") or part.Name == "TouchInterest" then
						part:Destroy()

					elseif part:IsA("Part") then

						part.CanTouch = false










					end


				end
			end
		end
		function ApplyDupeESP(Model)
			if Model:IsDescendantOf(workspace) then
				if Model.Name == "DoorFake" or Model.Name == "FakeDoor" then
					if Model:FindFirstChild("Door") then
						esp(Model.Door,Model.Door,"Dupe",dupecolor,true,false)
						Model:GetAttributeChangedSignal("ESP"):Connect(function()
							if Model:GetAttribute("ESP") == false then
								Model.Door:SetAttribute("ESP",false)
							end
						end)

					end

				elseif Model.Name == "SideroomSpace" then
					local model = Instance.new("Model")
					model.Parent = Model
					local humanoid = Instance.new("Humanoid")
					humanoid.Parent = model
					local part = Instance.new("Part")
					part.Parent = model
					part.Name = "Door"
					part.Transparency = 0.99
					part.CanCollide = false
					part.CFrame = Model.Collision.CFrame*CFrame.new(0,0,3)
					part.Anchored = true
					part.Size = Vector3.new(Model.Collision.Size.X,20,10)

					part.Color = Color3.fromRGB(255,0,0)
					part.Material = Enum.Material.ForceField
					esp(part,part,"Vacuum",dupecolor,true,false)

					Model.Destroying:Wait()
					part:SetAttribute("ESP",false)

				end
			end
		end
		local NotifierConnection
		if OldHotel == true or Floor == "Fools" then
			NotifierConnection = game.Workspace.ChildAdded:Connect(function(child)
				if child:IsA("Model") then
					task.wait(0.25)	
					if Player:GetAttribute("Alive") == false then
						Player:SetAttribute("CurrentRoom", child.Name)
					end
					local mainpart = nil

					if child.Name == "Lookman" then
						child.Name = "Eyes"
					end


					mainpart = child.PrimaryPart or child:FindFirstChild("RushNew") or child:FindFirstChild("Core")


					local EntityText = EntityAlliases[child.Name] 

					if child.Name == "RushMoving" and mainpart.Name ~= "RushNew" then
						EntityText = mainpart.Name
					end

					if child:IsA("Model") then



						if child:IsA("Model") then
							if child:IsDescendantOf(workspace) then
								if table.find(Entities,child.Name) and Player:DistanceFromCharacter(mainpart.Position) < 10000  then
									EntityCounter += 1
									
									if Options.ChatNotifyMonsters.Value[EntityShortNames[child.Name]] then
										if child.Name == "RushMoving" then
											local Text = EntityChatNotifyMessages[child.Name]
											if mainpart.Name ~= "RushNew" then
												Text = mainpart.Name .. string.split(EntityChatNotifyMessages[child.Name], "Rush")[2]
											end
											ChatNotify(Text)
											else
											ChatNotify(EntityChatNotifyMessages[child.Name])	
											end
									
									end
									if child.Name == "Eyes" or child.Name == "BackdoorLookman" then
										if Options.NotifyMonsters.Value[EntityShortNames[child.Name]] then
											Notify({Title = "ENTITIES", Description = EntityAlliases[child.Name] .. " has spawned.",Reason = "Don't look at it!",Image = EntityIcons[child.Name],NotificationType = "WARNING",Time = child})
											Sound()	
											
										end

									else
										if Options.NotifyMonsters.Value[EntityShortNames[child.Name]] then
											if godmode == true and child.Name == "RushMoving" then

												if mainpart.Name == "RushNew" or OldHotel == true then
													Notify({Title =  "ENTITIES", Description =  EntityAlliases[child.Name] .." has spawned.",Reason = "Please wait for it to despawn before proceeding.",Image = EntityIcons[child.Name],NotificationType = "WARNING",Time = child})
												else
													Notify({Title =  "ENTITIES", Description =  mainpart.Name .." has spawned.",Reason = "Please wait for it to despawn before proceeding.",Image = mainpart:WaitForChild("Attachment").ParticleEmitter.Texture,NotificationType = "WARNING",Time = child})

												end
											elseif godmode == true and child.Name == "AmbushMoving" then
									
										
												Notify({Title =  "ENTITIES", Description =  EntityAlliases[child.Name] .." has spawned.",Reason = "Please wait for it to despawn before proceeding.",Image = EntityIcons[child.Name],NotificationType = "WARNING",Time = child})
									
									
											elseif godmode == false and child.Name == "RushMoving" then

												if mainpart.Name == "RushNew" or OldHotel == true then
													Notify({Title =  "ENTITIES", Description =  EntityAlliases[child.Name] .." has spawned.",Reason = "Find a hiding spot!",Image = EntityIcons[child.Name],NotificationType = "WARNING",Time = child})
												else
													Notify({Title =  "ENTITIES", Description =  mainpart.Name .." has spawned.",Reason = "Find a hiding spot!",Image = mainpart:WaitForChild("Attachment").ParticleEmitter.Texture,NotificationType = "WARNING",Time = child})
												end	

											elseif godmode == false and child.Name == "AmbushMoving" then
												

													Notify({Title =  "ENTITIES", Description =  EntityAlliases[child.Name] .." has spawned.",Reason = "Find a hiding spot!",Image = EntityIcons[child.Name],NotificationType = "WARNING",Time = child})
												
												
											elseif godmode == true and child.Name == "A120" then
												Notify({Title =  "ENTITIES", Description = EntityAlliases[child.Name] .." has spawned. Hide!",Reason = "Godmode doesn't work for A-120.",Image = EntityIcons[child.Name],NotificationType = "WARNING",Time = child})	
											elseif godmode == true then
												Notify({Title =  "ENTITIES", Description = EntityAlliases[child.Name] .." has spawned. Don't worry.",Reason = "You have godmode enabled!",Image = EntityIcons[child.Name],NotificationType = "WARNING",Time = child})
											elseif godmode == false then
												Notify({Title =  "ENTITIES", Description = EntityAlliases[child.Name] .." has spawned.",Reason = "Find a hiding spot!",Image = EntityIcons[child.Name],NotificationType = "WARNING",Time = child})
											end
											Sound()
											
										end
									end


							

										local model = Instance.new("Model")
										model.Parent = workspace
										model.Name = ESPLibrary:GenerateRandomString()
										local hum = Instance.new("Humanoid")
										hum.Parent = model
										hum.Name = ESPLibrary:GenerateRandomString()
										local part = Instance.new("Part")
										part.Name = ESPLibrary:GenerateRandomString()
										part.CFrame = mainpart.CFrame
										part.Parent = model
										part.CanCollide = false
										part.Transparency = 0.99
										part.Massless = true
										part.Color = Color3.fromRGB(255,0,0)
										part.Size = Vector3.new(11,11,11)
										if child.Name == "Eyes" or child.Name == "BackdoorLookman" then
											part.Size = Vector3.new(9,9,9)
										end


										part.Orientation = Vector3.new(0,0,0)
										local mesh = Instance.new("SpecialMesh")
										mesh.Parent = part
										local pos = part.Position

										local oldpos = pos





										local weld = Instance.new("WeldConstraint")
										weld.Parent = child
										weld.Part0 = part
										weld.Part1 = mainpart
										weld.Enabled = true
									table.insert(ObjectsTable.Entities, part)
								
										if child.Name == "Eyes" then
										if EntityESP == true then
											ESPLibrary:AddESP({
												Object = part,
												Text = EntityAlliases[child.Name],
												Color = entitycolor
											}
											)
											end
											part:SetAttribute("ESPText", EntityAlliases[child.Name])
											child.Destroying:Connect(function()
												ESPLibrary:RemoveESP(part)
												task.wait(5)
												model:Destroy()
											end)
										elseif child.Name == "BackdoorLookman" then
										if EntityESP == true then
											ESPLibrary:AddESP({
												Object = part,
												Text = EntityAlliases[child.Name],
												Color = entitycolor
											}
											)
											end
											part:SetAttribute("ESPText", EntityAlliases[child.Name])
											child.Destroying:Connect(function()
												ESPLibrary:RemoveESP(part)
												task.wait(5)
												model:Destroy()
											end)
										else
										if EntityESP == true then
											ESPLibrary:AddESP({
												Object = part,
												Text = EntityText,
												Color = entitycolor
											}
											
											)
											end
											part:SetAttribute("ESPText", EntityText)
										end
										child.Destroying:Connect(function()
											ESPLibrary:RemoveESP(part)
											task.wait(5)
											model:Destroy()
										end)

										
									end
								end
							end
						
					end
				end
			end)
		else
			NotifierConnection = game.Workspace.ChildAdded:Connect(function(child)
				task.wait(0.1)
				local mainpart
				if child:IsA("Model") then
					mainpart = child.PrimaryPart




					if child:IsA("Model") then
						if child:IsDescendantOf(workspace) then
							if table.find(Entities,child.Name) and Floor ~= "Fools" and OldHotel == false or table.find(Entities,child.Name) and Player:DistanceFromCharacter(mainpart.Position) < 10000 and Floor == "Fools" or table.find(Entities,child.Name) and Player:DistanceFromCharacter(mainpart.Position) < 10000 and OldHotel == true then
								EntityCounter += 1
								if Options.ChatNotifyMonsters.Value[EntityShortNames[child.Name]] then
									ChatNotify(EntityChatNotifyMessages[child.Name])
								end
								if child.Name == "Eyes" or child.Name == "BackdoorLookman" then
									if Options.NotifyMonsters.Value[EntityShortNames[child.Name]] then
										Notify({Title = "ENTITIES", Description = EntityAlliases[child.Name] .. " has spawned.",Reason = "Don't look at it!",Image = EntityIcons[child.Name],NotificationType = "WARNING",Time = child})
										Sound()	
										
									end

								else
									if Options.NotifyMonsters.Value[EntityShortNames[child.Name]] then
										if godmode == true and OldHotel == true and child.Name == "RushMoving" then
											Notify({Title =  "ENTITIES", Description =  EntityAlliases[child.Name] .." has spawned. Don't be too close.",Reason = "He can kill you while going down.",Image = EntityIcons[child.Name],NotificationType = "WARNING",Time = child})
										
										
										elseif godmode == true and child.Name == "A120" then
											Notify({Title =  "ENTITIES", Description = EntityAlliases[child.Name] .." has spawned. Hide!",Reason = "Godmode doesn't work for A-120.",Image = EntityIcons[child.Name],NotificationType = "WARNING",Time = child})	
										elseif godmode == true and Floor == "Fools" and child.Name == "AmbushMoving" then
											Notify({Title =  "ENTITIES", Description = EntityAlliases[child.Name] .." has spawned.",Reason = "Because of a godmode failsafe, you will not be able to continue until Ambush leaves.",Image = EntityIcons[child.Name],NotificationType = "WARNING",Time = child})
										elseif godmode == true then
											Notify({Title =  "ENTITIES", Description = EntityAlliases[child.Name] .." has spawned. Don't worry.",Reason = "You have godmode enabled!",Image = EntityIcons[child.Name],NotificationType = "WARNING",Time = child})
										elseif godmode == false then
											Notify({Title =  "ENTITIES", Description = EntityAlliases[child.Name] .." has spawned.",Reason = "Find a hiding spot!",Image = EntityIcons[child.Name],NotificationType = "WARNING",Time = child})
										end
										Sound()
										
									end
								end




									local model = Instance.new("Model")
									model.Parent = workspace
									model.Name = ESPLibrary:GenerateRandomString()
									local hum = Instance.new("Humanoid")
									hum.Parent = model
									hum.Name = ESPLibrary:GenerateRandomString()
									local part = Instance.new("Part")
									part.Name = ESPLibrary:GenerateRandomString()
									part.CFrame = mainpart.CFrame
									part.Parent = model
									part.CanCollide = false
									part.Transparency = 0.99
									part.Massless = true
									part.Color = Color3.fromRGB(255,0,0)
									part.Size = Vector3.new(11,11,11)
									if child.Name == "Eyes" or child.Name == "BackdoorLookman" then
										part.Size = Vector3.new(9,9,9)
									end


									part.Orientation = Vector3.new(0,0,0)
									local mesh = Instance.new("SpecialMesh")
									mesh.Parent = part
									local pos = part.Position

									local oldpos = pos





									local weld = Instance.new("WeldConstraint")
									weld.Parent = child
									weld.Part0 = part
									weld.Part1 = mainpart
									weld.Enabled = true
								table.insert(ObjectsTable.Entities, part)
							
									if child.Name == "Eyes" then
									if EntityESP == true then
										ESPLibrary:AddESP({
											Object = part,
											Text = EntityAlliases[child.Name],
											Color = entitycolor
										}
										)
										end
										part:SetAttribute("ESPText", EntityAlliases[child.Name])
										child.Destroying:Connect(function()
											ESPLibrary:RemoveESP(part)
											task.wait(5)
											model:Destroy()
										end)
									elseif child.Name == "BackdoorLookman" then
									if EntityESP == true then
										ESPLibrary:AddESP({
											Object = part,
											Text = EntityAlliases[child.Name],
											Color = entitycolor
										}
										
										)
										end
										part:SetAttribute("ESPText", EntityAlliases[child.Name])
										child.Destroying:Connect(function()
											ESPLibrary:RemoveESP(part)
											task.wait(5)
											model:Destroy()
										end)
									else
									if EntityESP == true then
										ESPLibrary:AddESP({
											Object = part,
											Text = EntityAlliases[child.Name],
											Color = entitycolor
										}
										)
										end
										part:SetAttribute("ESPText", EntityAlliases[child.Name])
									end
									child.Destroying:Connect(function()
										ESPLibrary:RemoveESP(part)
										task.wait(5)
										model:Destroy()
									end)

									
end
								
							end
							
						end
					
				end
			end)	
		end
		function touch(x)
			
			if x then
				if x then
					x.Transparency = 0				
					game:GetService("TweenService"):Create(x, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {CFrame = Collision.CFrame}):Play()


				end
				if firetouchinterest then
					task.spawn(function()
						firetouchinterest(x, Collision, 1)
						task.wait()
						firetouchinterest(x, Collision, 0)
					end)
				end
				
				
			end
		end
		function DeleteSeek(inst)
			if Floor == "Fools" or OldHotel == true then
				
				if DeletingSeek == false then
					DeletingSeek = true
				

						

if firetouchinterest then
				while #inst:GetChildren() > 0 do
					for i,e in pairs(inst:GetChildren()) do

									touch(e)
									
									
									
							
							
							
							
							

								
								

									
					end
					task.wait()
				end
				end
					
					
					
					if #inst:GetChildren() == 0 then

						if DeletingSeek == true then
							DeletingSeek = false
							Notify({
								Title = "No Seek",
								Description = "Seek has been disabled.",
							})
							Sound()

						end

						



					else
							if DeletingSeek == true then
								DeletingSeek = false
								
								Notify({
									Title = "No Seek",
									Description = "Failed to disable seek.",
									Reason = "Seek has been disabled but only for you.",
									
								})
								Sound()

							end
							inst:ClearAllChildren()
															
						end

				
		
				end

					





				
			end
		end
		local function GetRoom(inst)
			local Text = nil
			for i,room in pairs(game.Workspace:FindFirstChild("CurrentRooms"):GetChildren()) do
				if inst:IsDescendantOf(room) then
					Text = room.Name


				end

			end

			return Text
		end
		local function GetInstanceUseable(inst)
			local UseableClasses = {"Part","Model","MeshPart","ProximityPrompt"}
			local Useable = false
			for i,room in pairs(game.Workspace:FindFirstChild("CurrentRooms"):GetChildren()) do
				if inst:IsDescendantOf(room) and room:FindFirstChild("Parts") then
					if inst:IsDescendantOf(room:WaitForChild("Parts")) then
						return table.find(UseableClasses,inst.ClassName)
					end
				end
			end
		end
		local function DisableSeekFools()
			if Floor == "Fools" or OldHotel == true then
				if Floor == "Fools" then
					game.Workspace.CurrentRooms.ChildAdded:Wait()
				end
				task.wait(0.25)	
				if CurrentRoom > 15 then
					Notify({Title = "No Seek",Description = "Disabling Seek..."})
					Collision.Anchored = true
					task.wait(0.25)
					Notify({Title = "No Seek",Description = "Seek is now disabled!"})

					Sound()
					Collision.Anchored = false
					if Floor == "Fools" or OldHotel == true then
						for i,collision in pairs(game.Workspace:GetDescendants()) do
							if collision.Name == "TriggerEventCollision" and collision:IsDescendantOf(workspace) and collision:FindFirstChild("Collision") then

								collision:Destroy()

							end
						end
					end
				end
			end
		end
		local fly = {
			enabled = false,
			flyBody = Instance.new("BodyVelocity"),

		}

		fly.flyBody.Velocity = Vector3.zero
		fly.flyBody.MaxForce = Vector3.one * 9e9

		local keys = false
		local books = false
		local levers = false
		local doors = false
		local closets = false



		local Window = Library:CreateWindow({

			Title = ScriptName,
			Center = true,
			AutoShow = false,
			TabPadding = 3,
			MenuFadeTime = 0
		})
		local Tabs = {
			-- Creates a new tab titled Main
			Main = Window:AddTab('Main'),
			Exploits = Window:AddTab('Exploits'),
			Visuals = Window:AddTab('Visuals'),
		Floor = Window:AddTab('Floor'),
		Misc = Window:AddTab('Miscellaneous'),





		




			UISettings = Window:AddTab('UI Settings'),







		}
		
		




		 UISettings = Tabs["UISettings"]


		OldPhysics = HumanoidRootPart.CustomPhysicalProperties


 
		 ESPTab = Tabs.Visuals:AddLeftTabbox('ESP')
		 

		 
		 MainLeftTab = Tabs.Main:AddLeftTabbox('Character/Player')
		
		
		


		ESP = ESPTab:AddTab('ESP')
		ESPSettings = ESPTab:AddTab('Settings')
		 LeftGroupBox = MainLeftTab:AddTab('Character')
		 PlayerGroupbox = MainLeftTab:AddTab('Player')

	
		 LeftGroupBox2 = Tabs.Exploits:AddRightGroupbox('Bypass')
		 VisualsLeftTab = Tabs.Visuals:AddLeftTabbox('Visuals')

 VisualsRightTab = Tabs.Visuals:AddRightTabbox('Notifiers')


		LeftGroupBox6 = VisualsRightTab:AddTab('Self Notify')


		LeftGroupBox9 = VisualsLeftTab:AddTab('Camera')
		 VisualsRemove = VisualsLeftTab:AddTab('Effects')

		 Anti = Tabs.Exploits:AddLeftGroupbox('Anti-Entity')
		


		 Automation = Tabs.Main:AddRightGroupbox('Automation')
		 ExtraVisualsTab = Tabs.Visuals:AddRightGroupbox('Content Creaton')

		ChatNotifyMessagesTab = VisualsRightTab:AddTab('Chat Notify')


	
		 AudioGroupbox = Tabs.Misc:AddLeftGroupbox('Remove')


		 LeftGroupBox11 = Tabs.Misc:AddRightGroupbox('Scripts')
		 Items = Tabs.Exploits:AddLeftGroupbox('Client-Sided Items')
		 LeftGroupBox4 = Tabs.Misc:AddRightGroupbox('Quick Functions')

	
		
		ChatNotifyMessagesTab:AddDropdown('ChatNotifyMonsters', {
			Values = {"Rush","Ambush","Blitz","Eyes","Lookman","Jeff The Killer","A-60","A-120","Giggle","Gloombat Swarm","Halt"},
			Default = 0, -- number index of the value / string
			Multi = true, -- true / false, allows multiple choices to be selected

			Text = 'Chat Notify Entities',
			Tooltip = 'Select which Entities should notify in the chat when they spawn', -- Information shown when you hover over the dropdown


		})
		ChatNotifyMessagesTab:AddDivider()

		AudioGroupbox:AddToggle('RemoveFootstepSounds',{
			Text = "Remove Footstep Sounds",
			Default = false,
			Tooltip = 'Makes all walking sounds silent.'
		})
		AudioGroupbox:AddToggle('RemoveInteractingSounds',{
			Text = "Remove Interacting Sounds",
			Default = false,
			Tooltip = 'Makes all interacting sounds silent.',
			Callback = function(Value)
				game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.PromptService.Triggered.Volume = (Value and 0 or 0.04)
				game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.PromptService.Holding.Volume = (Value and 0 or 0.1)
				game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.Reminder.Caption.Volume = (Value and 0 or 0.1)
			end,
		})
		AudioGroupbox:AddToggle('RemoveDamageSounds',{
			Text = "Remove Damage Sounds",
			Default = false,
			Tooltip = 'Makes all damage sounds silent.',
			Callback = function(Value)
				game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.Health.Hit.Volume = (Value and 0 or 0.5)
				game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.Health.HitShield.Volume = (Value and 0 or 0.2)
				game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.Health.Ringing.SoundId = (Value and "" or "rbxassetid://1517024660")
			end,
		})
		AudioGroupbox:AddToggle('RemoveGoldVisual',{
			Text = "Remove Gold Visual",
			Default = false,
			Tooltip = 'Removes the effects for collecting gold.',
			Callback = function(Value)
				game:GetService("Players").LocalPlayer.PlayerGui.TopbarUI.Gold.Sound.Volume = (Value and 0 or 0.15)

			end,
		})

		Items:AddDropdown('SelectItem', {
			Values = {'Flashlight','Gummy Flashlight','Shears (On Anything)'},
			Default = 0, -- number index of the value / string
			Multi = false, -- true / false, allows multiple choices to be selected

			Text = 'Select Item',
			Tooltip = 'Select the item you want to get.', -- Information shown when you hover over the dropdown

			Callback = function(Value)

			end
		})
		Items:AddDivider()

		Items:AddButton({
			Text = 'Give Item',
			Func = function()
				local Value = Options.SelectItem.Value
				if Value == "Shears (On Anything)" then
					loadstring(game:HttpGet("https://raw.githubusercontent.com/MrNeRD0/Doors-Hack/main/shears_done.lua"))()
				elseif Value == "Flashlight" then
					local Modules = game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules






					local RunService = game:GetService("RunService")

					local shears = game:GetObjects("rbxassetid://13468481018")[1]
					local attachments = {}
					shears.CanBeDropped = false


					shears:FindFirstChild("Animations"):Destroy()


					shears.Parent = game.Players.LocalPlayer.Backpack
					shears.Handle:WaitForChild("Switch").Name = "Switch_"
					shears.Handle:WaitForChild("ShadowMaker").Decal.Color3 = Color3.fromRGB(0,0,0)
					shears.Handle:WaitForChild("Neon").Attachment.SurfaceLight.Range = 60
					shears.Handle:WaitForChild("Neon").Attachment.SurfaceLight.Angle = 55
					shears.Handle:WaitForChild("Neon").Attachment.SurfaceLight.Brightness = 3
					shears.Handle:WaitForChild("Neon").Attachment.SurfaceLight.Color = Color3.fromRGB(255, 201, 153)
					shears.Handle:WaitForChild("Neon").LightAttach.SurfaceLight.Range = 60
					shears.Handle:WaitForChild("Neon").LightAttach.SurfaceLight.Angle = 34
					shears.Handle:WaitForChild("Neon").LightAttach.SurfaceLight.Brightness = 3
					shears.Handle:WaitForChild("Neon").LightAttach.SurfaceLight.Color = Color3.fromRGB(189, 149, 113)


					local EndAttachment = Instance.new("Attachment")
					EndAttachment.Name = "EndAttachment"
					EndAttachment.Parent = shears:WaitForChild("Handle").Neon
					EndAttachment.CFrame = CFrame.new(0, 0, -8.66573334, 1, 0, 0, 0, 1, 0, 0, 0, 1)
					local Beam = Instance.new("Beam")
					Beam.Parent = shears:WaitForChild("Handle").Neon
					shears:WaitForChild("Handle").Neon.LightAttach.SurfaceLight.Color = Color3.fromRGB(235, 171, 124)




					local color = Color3.fromRGB(235, 171, 124)

					-- Create a ColorSequence using just this color for both Keypoints
					local colorSequence = ColorSequence.new({
						ColorSequenceKeypoint.new(0,Color3.fromRGB(235, 171, 124)),
						ColorSequenceKeypoint.new(0.5,Color3.fromRGB(235, 171, 124)),
						ColorSequenceKeypoint.new(1,Color3.fromRGB(235, 171, 124))
					})
					Beam.LightEmission = 1
					Beam.LightInfluence = 0
					Beam.Brightness = 0
					Beam.Texture = "rbxassetid://15149007027"
					Beam.TextureLength = 14
					Beam.TextureMode = Enum.TextureMode.Static
					Beam.TextureSpeed = 0
					Beam.Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 1),
						NumberSequenceKeypoint.new(0.5, 0.047956),
						NumberSequenceKeypoint.new(0.75, 0),
						NumberSequenceKeypoint.new(1, 1),

					})

					Beam.Attachment0 = shears:WaitForChild("Handle").Neon.LightAttach
					Beam.Attachment1 = EndAttachment
					Beam.Width0 = 1
					Beam.Width1 = 20
					Beam.CurveSize0 = 0
					Beam.CurveSize1 = 0
					Beam.FaceCamera = true
					Beam.Segments = 20
					Beam.ZOffset = 0


					shears:SetAttribute("LightSourceBeam",true)
					shears:SetAttribute("LightSourceStrong",true)
					shears:SetAttribute("Enabled",false)
					shears:SetAttribute("Interactable",true)
					shears:SetAttribute("LightSource",true)
					shears:SetAttribute("Durability",nil)
					shears:SetAttribute("DurabilityMax",nil)
					shears:SetAttribute("NamePlural","Shakelights")
					shears:SetAttribute("NameSingular","Shakelight")
					shears:SetAttribute("ToolOffset",Vector3.new(0, 0.20000000298023224, -0.20000000298023224))
					local newCFrame = CFrame.new(-0.094802849, -0.00991820451, 0.0960054174, 0, 0, -1, -1, 0, 0, 0, 1, 0)

					shears.Grip = newCFrame
					shears.WorldPivot = CFrame.new(249.886551, 1.53111672, -16.8949146, -0.765167952, 0.00742102973, 0.64378804, -0.000446901657, 0.999927223, -0.0120574543, -0.643830597, -0.00951368641, -0.765108943)
					shears.Name = "Flashlight"
					local Animations_Folder = Instance.new("Folder")
					Animations_Folder.Name = "Animations"
					Animations_Folder.Parent = shears
					local Shake_Animation = Instance.new("Animation")
					Shake_Animation.AnimationId = "rbxassetid://15386224888"
					Shake_Animation.Parent = Animations_Folder
					local Idle_Animation = Instance.new("Animation")
					Idle_Animation.AnimationId = "rbxassetid://11372556429"
					Idle_Animation.Parent = Animations_Folder
					local Equip_Animation = Instance.new("Animation")
					Equip_Animation.AnimationId = "rbxassetid://15386368619"
					Equip_Animation.Parent = Animations_Folder
					local Shake_Sound = Instance.new("Sound")
					Shake_Sound.Name = "Shake_Sound"
					Shake_Sound.Parent = shears
					Shake_Sound.Volume = 1
					Shake_Sound.SoundId = "rbxassetid://9114481260"
					Shake_Sound.PlaybackSpeed = 0.9
					local Shaking = false
					shears.TextureId = "rbxassetid://16680616231"

					local Animator = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator")
					local anim2 = Animator:LoadAnimation(Idle_Animation)
					anim2.Priority = Enum.AnimationPriority.Action3

					local anim3 = Animator:LoadAnimation(Equip_Animation)
					anim3.Priority = Enum.AnimationPriority.Action3
					anim3:Play()

					local anim = Animator:LoadAnimation(Shake_Animation)	
					local enabled = false
					shears.Activated:Connect(function()
						if Shaking == false and shears.Parent == game.Players.LocalPlayer.Character then





							anim.Priority = Enum.AnimationPriority.Action4

							anim:Stop()
							Shaking = true
							task.wait()
							anim:Play()

							Shake_Sound:Play()
							enabled = not enabled
							if enabled == true then
								if Modules:FindFirstChild("Screech") then
									Modules.Screech.Name = "Screech_"
								end	
							else

								if Modules:FindFirstChild("Screech_") then
									if AntiScreech == false then
										Modules["Screech_"].Name = "Screech"
									end
								end
							end

							task.wait(0.25)

							Shaking = false


						end

					end)
					local connection = RunService.RenderStepped:Connect(function()
						for i,attach in pairs(attachments) do
							attach.Enabled = enabled
						end
						if enabled == true then

							Shake_Sound.PlaybackSpeed = 1

						else

							Shake_Sound.PlaybackSpeed = 0.7

						end
					end)
					shears.Equipped:Connect(function()
						anim3:Play()
						anim2:Play()

					end)
					shears.Unequipped:Connect(function()
						anim2:Stop()
						enabled = false
						if Modules:FindFirstChild("Screech_") then
							if AntiScreech == false then
								Modules["Screech_"].Name = "Screech"
							end
						end

					end)	
					task.wait(0.1)
					for i,attach in pairs(shears:GetDescendants()) do
						if attach:IsA("SpotLight") or attach:IsA("PointLight") or attach:IsA("SurfaceLight") or attach:IsA("ParticleEmitter") and attach.Name == "Shiny"  then
							table.insert(attachments,attach)
							if attach:IsA("ParticleEmitter") then


								if attach.Name == "Shiny" then
									attach.Texture = "rbxassetid://15148942452"
									attach.Rate = 20
									attach.Lifetime = NumberRange.new(0.3,0.3)
									attach.LightEmission = 0.1
									attach.Size = NumberSequence.new({
										NumberSequenceKeypoint.new(0,1.3),
										NumberSequenceKeypoint.new(0.5,1.3),
										NumberSequenceKeypoint.new(1,1.3)
									})
									attach.Transparency = NumberSequence.new({
										NumberSequenceKeypoint.new(0, 1),

										NumberSequenceKeypoint.new(0.5, 0),
										NumberSequenceKeypoint.new(1, 1)
									})
								end



							end

						end

					end
					shears.Destroying:Wait()
					connection:Disconnect()
				elseif Value == "Bulklight" then
					local Modules = game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules
					local shears = game:GetObjects("rbxassetid://81989292919242")[1]
					local attachments = {}
					shears.CanBeDropped = false

					shears.Parent = game.Players.LocalPlayer.Backpack
					shears:FindFirstChild("Animations"):Destroy()
					for i,attach in pairs(shears:GetDescendants()) do
						if attach:IsA("SpotLight") or attach:IsA("PointLight") or attach:IsA("SurfaceLight") then
							table.insert(attachments,attach)
						end

					end


					shears:SetAttribute("LightSourceBeam",true)
					shears:SetAttribute("LightSourceStrong",true)
					shears:SetAttribute("Enabled",false)
					shears:SetAttribute("Interactable",true)
					shears:SetAttribute("LightSource",true)
					shears:SetAttribute("ToolGripOffset",Vector3.new(0, 0, 1.5))

					shears:SetAttribute("NamePlural","Shakelights")
					shears:SetAttribute("NameSingular","Shakelight")



					shears.Handle.Orientation = Vector3.new(0,0,0)
					local newCFrame = CFrame.new(-0, -1.5, 1.5, 1, 0, -0, 0, 0, 1, 0, -1, 0)

					shears.Grip = newCFrame
					shears.WorldPivot = CFrame.new(-46.6105042, 277.06485, 317.182953, 0, 0, 1, 0, 1, -0, -1, 0, 0)
					shears.Name = "Flashlight"

					local Animations_Folder = Instance.new("Folder")
					Animations_Folder.Name = "Animations"
					Animations_Folder.Parent = shears
					local Shake_Animation = Instance.new("Animation")
					Shake_Animation.AnimationId = "rbxassetid://15686338453"
					Shake_Animation.Parent = Animations_Folder
					local Idle_Animation = Instance.new("Animation")
					Idle_Animation.AnimationId = "rbxassetid://15764585564"
					Idle_Animation.Parent = Animations_Folder
					local Idle_Animation_2 = Instance.new("Animation")
					Idle_Animation_2.AnimationId = "rbxassetid://15764034159"
					Idle_Animation_2.Parent = Animations_Folder

					local Equip_Animation = Instance.new("Animation")
					Equip_Animation.AnimationId = "rbxassetid://15386368619"
					Equip_Animation.Parent = Animations_Folder
					local Shake_Sound = Instance.new("Sound")
					Shake_Sound.Name = "Shake_Sound"
					Shake_Sound.Parent = shears
					Shake_Sound.Volume = 1
					Shake_Sound.SoundId = "rbxassetid://9114481260"
					Shake_Sound.PlaybackSpeed = 0.9
					local Shaking = false
					shears.TextureId = "rbxassetid://15399271835"

					local Animator = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator")
					local anim2 = Animator:LoadAnimation(Idle_Animation)
					anim2.Priority = Enum.AnimationPriority.Action4
					local anim4 = Animator:LoadAnimation(Idle_Animation_2)
					anim4.Priority = Enum.AnimationPriority.Action4


					local anim3 = Animator:LoadAnimation(Equip_Animation)
					anim3.Priority = Enum.AnimationPriority.Action3


					local anim = Animator:LoadAnimation(Shake_Animation)	
					local enabled = false
					shears.Activated:Connect(function()
						if Shaking == false and shears.Parent == game.Players.LocalPlayer.Character then





							anim.Priority = Enum.AnimationPriority.Action4

							anim:Stop()
							Shaking = true
							task.wait()
							anim:Play()

							Shake_Sound:Play()
							enabled = not enabled
							if enabled == true then
								if Modules:FindFirstChild("Screech") then
									Modules.Screech.Name = "Screech_"
								end	
							else

								if Modules:FindFirstChild("Screech_") then
									if AntiScreech == false then
										Modules["Screech_"].Name = "Screech"
									end
								end
							end

							task.wait(0.5)

							Shaking = false


						end

					end)
					local connection = RunService.RenderStepped:Connect(function()
						if enabled == true then
							anim2:Play()
							anim4:Stop()
							for i,light in pairs(attachments) do
								light.Enabled = true
							end
							shears.Handle.ShadowMaker.Decal.Transparency = 0
							Shake_Sound.PlaybackSpeed = 0.95

						else
							if shears.Parent == Character then
								anim4:Play()
							end
							anim2:Stop()

							for i,light in pairs(attachments) do
								light.Enabled = false
							end
							shears.Handle.ShadowMaker.Decal.Transparency = 1
							Shake_Sound.PlaybackSpeed = 0.7

						end
					end)
					shears.Equipped:Connect(function()



					end)
					shears.Unequipped:Connect(function()
						anim2:Stop()
						anim4:Stop()
						enabled = false
						if Modules:FindFirstChild("Screech_") then
							if AntiScreech == false then
								Modules["Screech_"].Name = "Screech"
							end
						end

					end)	
					shears.Destroying:Wait()
					connection:Disconnect()

				elseif Value == "Gummy Flashlight" then
					local Modules = game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules
					local shears = game:GetObjects("rbxassetid://12794355024")[1]
					shears.CanBeDropped = false
					shears.Parent = game.Players.LocalPlayer.Backpack
					shears:WaitForChild("Handle").SpotLight.Brightness = 2
					shears:WaitForChild("Handle").SpotLight.Range = 75
					shears:WaitForChild("Handle").SpotLight.Angle = 50
					shears:SetAttribute("LightSourceBeam",true)
					shears:SetAttribute("LightSourceStrong",true)
					shears:SetAttribute("Enabled",false)
					shears:SetAttribute("Interactable",true)
					shears:SetAttribute("LightSource",true)
					shears:SetAttribute("NamePlural","Shakelights")
					shears:SetAttribute("NameSingular","Shakelight")
					local newCFrame = CFrame.new(0.00991821289, -0.17137143, 0.0771455616, 1, 0, 0, 0, 0, -1, 0, 1, 0)

					shears.Grip = newCFrame
					shears.WorldPivot = CFrame.new(249.886551, 1.53111672, -16.8949146, -0.765167952, 0.00742102973, 0.64378804, -0.000446901657, 0.999927223, -0.0120574543, -0.643830597, -0.00951368641, -0.765108943)
					shears.Name = "Shakelight"
					local Animations_Folder = Instance.new("Folder")
					Animations_Folder.Name = "Animations"
					Animations_Folder.Parent = shears
					local Shake_Animation = Instance.new("Animation")
					Shake_Animation.AnimationId = "rbxassetid://12001275923"
					Shake_Animation.Parent = Animations_Folder
					local Idle_Animation = Instance.new("Animation")
					Idle_Animation.AnimationId = "rbxassetid://11372556429"
					Idle_Animation.Parent = Animations_Folder
					local Equip_Animation = Instance.new("Animation")
					Equip_Animation.AnimationId = "rbxassetid://15386368619"
					Equip_Animation.Parent = Animations_Folder
					local Shake_Sound = Instance.new("Sound")
					Shake_Sound.Name = "Shake_Sound"
					Shake_Sound.Parent = shears
					Shake_Sound.SoundId = "rbxassetid://11374330092"
					Shake_Sound.PlaybackSpeed = 0.9
					Shake_Sound.Volume = 1
					local Shaking = false

					shears.TextureId = "rbxassetid://11373085609"

					local Animator = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator")
					local anim2 = Animator:LoadAnimation(Idle_Animation)
					anim2.Priority = Enum.AnimationPriority.Action3

					local anim3 = Animator:LoadAnimation(Equip_Animation)
					anim3.Priority = Enum.AnimationPriority.Action3
					anim3:Play()

					local anim = Animator:LoadAnimation(Shake_Animation)	

					shears.Activated:Connect(function()
						if Shaking == false and shears.Parent == game.Players.LocalPlayer.Character then





							anim.Priority = Enum.AnimationPriority.Action4

							anim:Stop()
							Shaking = true
							task.wait()
							anim:Play()

							Shake_Sound:Play()

							task.wait(0.25)

							Shaking = false


						end

					end)
					shears.Equipped:Connect(function()
						anim3:Play()
						anim2:Play()
						if Modules:FindFirstChild("Screech") then
							Modules.Screech.Name = "Screech_"
						end
					end)
					shears.Unequipped:Connect(function()
						anim2:Stop()
						if Modules:FindFirstChild("Screech_") then
							if AntiScreech == false then
								Modules["Screech_"].Name = "Screech"
							end
						end
					end)



				end	
			end,
			DoubleClick = false,
			Tooltip = 'Get the selected item.'
		})

		local function AddRetroTab()
local RetroGroupbox = Tabs.Floor:AddRightGroupbox('Retro Mode')
			RetroGroupbox:AddToggle('AntiLava',{
				Text = "Anti-Killbricks",
				Default = false,
				Tooltip = 'Prevents the killbricks from Retro Mode from hurting you.',
			})
			Toggles.AntiLava:OnChanged(function(value)
				for i,room in pairs(game.Workspace.CurrentRooms:GetChildren()) do
					for i,part in pairs(room:GetDescendants()) do
						if part.Name == "Lava" then
							part.CanTouch = not value
						elseif part.Name == "ScaryWall" then
							for i,part2 in pairs(part:GetDescendants()) do
								if part2:IsA("BasePart") then
									part2.CanTouch = not value
									part2.CanCollide = not value
								end
							end
						end
					end
				end
			end)
			RetroGroupbox:AddToggle('AntiBloxxers',{
				Text = "Anti-Drakobloxxer",
				Default = false,
				"Prevents you from being hit by drakobloxxers."
			})
			Toggles.AntiBloxxers:OnChanged(function(value)
				for i,room in pairs(game.Workspace.CurrentRooms:GetChildren()) do
					for i,part in pairs(room:GetDescendants()) do
						
						if part.Name == "Drakobloxxer" then
							for i,part2 in pairs(part:GetDescendants()) do
								if part2:IsA("BasePart") then
									part2.CanTouch = not value
									part2.CanCollide = not value
								end
							end
						end
					end
				end
			end)
		end


		function AddBackdoorTab()
local BackdoorGroupbox = Tabs.Floor:AddRightGroupbox('The Backdoor')
			BackdoorGroupbox:AddToggle('AntiLookman', {
				Text = 'Anti-Lookman',
				Default = false, -- Default value (true / false)
				Tooltip = "Allows you to look into The Lookman's eyes without taking damage.", -- Information shown when you hover over the toggle

				Callback = function(Value)

					AntiLookman = Value

				end
			})
			BackdoorGroupbox:AddToggle('AntiVacuum', {
				Text = 'Anti-Vacuum',
				Default = false, -- Default value (true / false)
				Tooltip = 'Prevents Vacuum from sucking you out into the void.', -- Information shown when you hover over the toggle

				Callback = function(Value)

					AntiVacuum = Value
					if Value == true then
						for i,e in pairs(game.Workspace:GetDescendants()) do
							if e.Name == "SideroomSpace" then
								DisableDupe(e)
							end


						end
					end

				end
			})
			
		end
		local AntiJeff = false

		local function AddBeforePlusTab()
			local BeforePlusGroupbox = Tabs.Floor:AddRightGroupbox('Hotel-')

			

			

			BeforePlusGroupbox:AddToggle('BypassSeekBeforePlus', {
				Text = 'Remove Seek Chases',
				Tooltip = 'Deletes the seek triggers, preventsing seek from spawning.',
				Default = false, -- Default value (true / false)
				
				Callback = function(Value)
					BypassSeek = Value
					if Value == true then

						for i,inst in pairs(game.Workspace:GetDescendants()) do
							if inst.Name == "TriggerEventCollision" and OldHotel == true then



								DeletingSeek(inst)


							end
						end


					end
				end,
			})
			
			BeforePlusGroupbox:AddToggle('InfiniteRevivesBeforePlus', {
				Text = 'Infinite Revives',
				Default = false, -- Default value (true / false)
				Tooltip = 'Instantly revive upon dying', -- Information shown when you hover over the toggle
				

			})
			
			end
		
		local function AddFoolsTab()
local FoolsGroupbox = Tabs.Floor:AddRightGroupbox('SUPER HARD MODE!!!')

			FoolsGroupbox:AddToggle("AntiBananaPeel",{Text = "Anti-Banana", Default = false,Tooltip = 'Prevents Banana Peels tripping you over.'})

			FoolsGroupbox:AddToggle("AntiJeff",{Text = "Anti-Jeff",Default = false,Tooltip = 'Prevents Jeff The Killer hurting you.',
				Callback = function(Value)
					AntiJeff = Value	
				end,
			})
			
			FoolsGroupbox:AddDivider()
			
			FoolsGroupbox:AddToggle('BypassSeekFools', {
				Text = 'Remove Seek Chases',
				Tooltip = 'Deletes the seek triggers, preventsing seek from spawning.',
				Default = false, -- Default value (true / false)
				
				Callback = function(Value)
					BypassSeek = Value
					if Value == true then

						for i,inst in pairs(game.Workspace:GetDescendants()) do
							if inst.Name == "TriggerEventCollision" and Floor == "Fools" then



								DeletingSeek(inst)


							end
						end


					end
				end,
			})
			
			FoolsGroupbox:AddToggle('InfiniteRevivesFools', {
				Text = 'Infinite Revives',
				Default = false, -- Default value (true / false)
				Tooltip = 'Instantly revive upon dying', -- Information shown when you hover over the toggle
				

			})

			





		



			if Floor == "Fools" or OldHotel == true then
				Toggles.AntiBananaPeel:OnChanged(function(value)
					for _, peel in pairs(workspace:GetChildren()) do
						if peel.Name == "BananaPeel" then
							peel.CanTouch = not value
							peel:GetPropertyChangedSignal("CanTouch"):Connect(function()
								if peel.CanTouch == true and Toggles.AntiBananaPeel.Value then
									peel.CanTouch = false
								end
							end)
						end
					end
				end)

				Toggles.AntiJeff:OnChanged(function(value)
					for _, jeff in pairs(workspace:GetChildren()) do
						if jeff:IsA("Model") and jeff.Name == "JeffTheKiller" then
							task.spawn(function()
								repeat task.wait() until Library.Unloaded
								jeff:FindFirstChildOfClass("Humanoid").Health = 0
							end)
							for i, v in pairs(jeff:GetDescendants()) do
								if v:IsA("BasePart") then
									v.CanTouch = not value
								end
							end
						end
					end
				end)

			end


		end

		function AddRoomsTab()
local RoomsGroupbox = Tabs.Floor:AddLeftGroupbox('The Rooms')
			RoomsGroupbox:AddToggle('AntiA90', {
				Text = 'Remove A-90',
				Default = false, -- Default value (true / false)
				Tooltip = 'Prevents A-90 from spawning.', -- Information shown when you hover over the toggle

				Callback = function(Value)
					if A90 then
						if Value == true then
							A90.Name = "_A90"
						else
							A90.Name = "A90"
						end
					end
				end
			})
			
			RoomsGroupbox:AddDivider()

			RoomsGroupbox:AddToggle("AutoRooms", {
				Text = "Auto A-1000",
				Default = false,
				Tooltip = 'Automatically complete The Rooms',


			})


			RoomsGroupbox:AddToggle("AutoRoomsDebug", { 
				Text = "Show Debug Info",
				Tooltip = 'Show extra information about Auto A-1000',
				Default = false
			})

			RoomsGroupbox:AddToggle("ShowAutoRoomsPathNodes", { 
				Text = "Show Pathfinding Nodes",
				Tooltip = 'Visualises where the player will automatically move to.',
				Default = false

			})
			RoomsGroupbox:AddToggle("AutoRoomsIgnoreA60",{Text = "Ignore A-60",Default = false,Tooltip = 'Auto A-1000 will not hide from the entity A-60.', Callback = function(Value)if Value == true then if game.ReplicatedStorage.GameData.Floor.Value == "Rooms" then if SpeedBypassEnabled == true then Options.WS:SetMax(15) if SpeedBoost > 15 then Options.WS:SetValue(15) end Notify({Title = "Ignore A-60",Description = "Godmode has automatically enabled and max walkspeed has been set to 20.",Reason = "This is to avoid lagging back."}) Sound() end
					end	
				elseif Value == false then
					if SpeedBypassEnabled == true then
						Options.WS:SetMax(100)		
					end



				end  end})


			if game.ReplicatedStorage.GameData.Floor.Value == "Rooms" then
				Toggles.AntiA90:OnChanged(function(value)

					if Toggles.AutoRooms.Value and not value then
						Notify({
							Title = "Auto A-1000",
							Description = "No A-90 is required for Auto A-1000 to work!",
							Reason = "No A-90 has been enabled",
							Sound()
						})

						Toggles.AntiA90:SetValue(true)

					end



				end)

				local function GetAutoRoomsPathfindingGoal()
					local entity = (workspace:FindFirstChild("A60") or workspace:FindFirstChild("A120"))
					if entity and entity.PrimaryPart.Position.Y > -10 then
						if entity.Name == "A120" or entity.Name == "A60" and not Toggles.AutoRoomsIgnoreA60.Value then
							local GoalLocker = GetNearestAssetWithCondition(function(asset)
								return asset.Name == "Rooms_Locker" and not asset.HiddenPlayer.Value and asset.PrimaryPart.Position.Y > -10 or asset.Name == "Rooms_Locker_Fridge" and not asset.HiddenPlayer.Value and asset.PrimaryPart.Position.Y > -10
							end)

							return GoalLocker.PrimaryPart
						end
					end
					return workspace.CurrentRooms[CurrentRoom].RoomExit
				end


				local _internal_mspaint_pathfinding_block = Instance.new("Folder", game.Workspace) do
					_internal_mspaint_pathfinding_block.Name = "pathfinding_block"
				end

				Toggles.ShowAutoRoomsPathNodes:OnChanged(function(value)
					for _, node in pairs(PathfindingFolder:GetChildren()) do
						node.Transparency = value and 0 or 1
					end

				end)

				local A1000Connection = game["Run Service"].RenderStepped:Connect(function()
					if not Toggles.AutoRooms.Value then return end

					local entity = (workspace:FindFirstChild("A60") or workspace:FindFirstChild("A120"))

					local isEntitySpawned = (entity and entity.PrimaryPart.Position.Y > -10)
					if isEntitySpawned and not game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored then
						if entity.Name == "A120" or entity.Name == "A60" and not Toggles.AutoRoomsIgnoreA60.Value then
							local pathfindingGoal = GetAutoRoomsPathfindingGoal()

							if pathfindingGoal.Parent:FindFirstChild("HidePrompt") then
								forcefireproximityprompt(pathfindingGoal.Parent.HidePrompt)
								if game.Players.LocalPlayer.Character:GetAttribute("Hiding") ~= true and game.Players.LocalPlayer:DistanceFromCharacter(pathfindingGoal.Position) < 5 then
									local pos = CFrame.new(pathfindingGoal.Position)*CFrame.new(0,0,2)
									game.Workspace.CurrentCamera.CFrame = pos
								end
							end

						end
					elseif not isEntitySpawned and game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored or entity and entity.Name == "A60" and Toggles.AutoRoomsIgnoreA60.Value  then

						for i = 1, 10 do
							game.ReplicatedStorage.RemotesFolder.CamLock:FireServer()
						end
					end
				end)

				Toggles.AutoRooms:OnChanged(function(value)
					local hasResetFailsafe = false

					local function nodeCleanup()
						PathfindingFolder:ClearAllChildren()
						_internal_mspaint_pathfinding_block:ClearAllChildren()
						hasResetFailsafe = true
					end
					local function moveToCleanup()
						if game.Players.LocalPlayer.Character.Humanoid then
							game.Players.LocalPlayer.Character.Humanoid:Move(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
							game.Players.LocalPlayer.Character.Humanoid.WalkToPart = nil
							game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = game.Players.LocalPlayer.Character.RootPart.Position
						end
						nodeCleanup()
					end

					if value then
						Toggles.AntiA90:SetValue(true)
						local lastRoomValue = 0

						local function createNewBlockedPoint(point)
							local block = Instance.new("Part", _internal_mspaint_pathfinding_block)
							local pathMod = Instance.new("PathfindingModifier", block)
							pathMod.Label = "pathBlock"


							block.Name = ESPLibrary:GenerateRandomString()
							block.Shape = Enum.PartType.Block

							local sizeY = 10

							block.Size = Vector3.new(1, sizeY, 1)
							block.Color = Color3.fromRGB(255, 130, 30)
							block.Material = Enum.Material.Neon
							block.Position = point.Position + Vector3.new(0, sizeY / 2, 0)
							block.Anchored = true
							block.CanCollide = false
							block.Transparency = Toggles.ShowAutoRoomsPathNodes.Value and 1 or 1
						end

						local function doAutoRooms()
							local pathfindingGoal = GetAutoRoomsPathfindingGoal()

							if CurrentRoom ~= lastRoomValue then
								_internal_mspaint_pathfinding_block:ClearAllChildren()
								lastRoomValue = CurrentRoom
							end



							local path = game:GetService("PathfindingService"):CreatePath({
								AgentCanJump = false,
								AgentCanClimb = false,
								WaypointSpacing = 5,
								AgentRadius = 1,
								Costs = {
									_ms_pathBlock = 8 --cost will increase the more stuck you get.
								}
							})

							path:ComputeAsync(HumanoidRootPart.Position - Vector3.new(0, 2.5, 0), pathfindingGoal.Position)
							local waypoints = path:GetWaypoints()
							local waypointAmount = #waypoints

							if path.Status == Enum.PathStatus.Success then
								hasResetFailsafe = true
								task.spawn(function()
									task.wait(0.1)
									hasResetFailsafe = false
									if game.Players.LocalPlayer.Character.Humanoid and game.Players.LocalPlayer.Character.Collision then
										local checkFloor = game.Players.LocalPlayer.Character.Humanoid.FloorMaterial
										local isStuck = checkFloor == Enum.Material.Air or checkFloor == Enum.Material.Concrete
										if isStuck then
											repeat task.wait()
												Collision.CanCollide = false
												Collision.CollisionCrouch.CanCollide = not (godmode)
											until not isStuck or hasResetFailsafe
											Collision.CanCollide = not (godmode)
										end
										hasResetFailsafe = true
									end
								end)
								if Toggles.AutoRoomsDebug.Value then
									local desc = "Attempting to move to " .. pathfindingGoal.Parent.Name
									if tonumber(pathfindingGoal.Parent.Name) then
										desc = "Attempting to move to the Next Door [A-"..tostring(tonumber(pathfindingGoal.Parent.Name) + 1).."]" 
									end
									Notify({
										Title = "Auto A-1000 Debug",
										Description = desc,
									})
									Sound()
								end
								PathfindingFolder:ClearAllChildren()

								for i, waypoint in pairs(waypoints) do
									local node = Instance.new("Part", PathfindingFolder) do
										node.Name = ESPLibrary:GenerateRandomString()
										node.Size = Vector3.new(1, 1, 1)
										node.Orientation = Vector3.new(0,0,90)
										node:SetAttribute("Number",i)
										node.Position = waypoint.Position-Vector3.new(0,0.4,0)
										node.Anchored = true
										node.Material = Enum.Material.Neon
										node.CanCollide = false
										node.Shape = Enum.PartType.Cylinder
										node.Color = Color3.fromRGB(255,170,0)
										node.Transparency = Toggles.ShowAutoRoomsPathNodes.Value and 0 or 1
									end
								end

								local lastWaypoint = nil
								for i, waypoint in pairs(waypoints) do
									local moveToFinished = false
									local recalculate = false
									local waypointConnection = game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:Connect(function() moveToFinished = true end)
									if not moveToFinished or not Toggles.AutoRooms.Value then
										game.Players.LocalPlayer.Character.Humanoid:MoveTo(waypoint.Position)

										local entity = (workspace:FindFirstChild("A120"))
										local isEntitySpawned = (entity and entity.PrimaryPart.Position.Y > -10)
										local entity2 = (workspace:FindFirstChild("A60"))

										local isEntitySpawned2 = (entity and entity.PrimaryPart.Position.Y > -10 and not Toggles.AutoRoomsIgnoreA60.Value)

										if isEntitySpawned and not game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored and pathfindingGoal.Parent.Name ~= "Rooms_Locker" and pathfindingGoal.Parent.Name ~= "Rooms_Locker_Fridge" or isEntitySpawned2 and not game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored and pathfindingGoal.Parent.Name ~= "Rooms_Locker" and pathfindingGoal.Parent.Name ~= "Rooms_Locker_Fridge" then
											waypointConnection:Disconnect()

											if not Toggles.AutoRooms.Value then
												nodeCleanup()
												break
											else

											end

											break
										end

										task.delay(1.5, function()
											if moveToFinished then return end
											if (not Toggles.AutoRooms.Value) then return moveToCleanup() end

											repeat task.wait(0.25) until (not game.Players.LocalPlayer.Character:GetAttribute("Hiding") and not game.Players.LocalPlayer.Character.PrimaryPart.Anchored)
											if Toggles.AutoRoomsDebug.Value then

											end
											recalculate = true
											if lastWaypoint == nil and waypointAmount > 1 then
												waypoint = waypoints[i+1]
											else
												waypoint = waypoints[i-1]
											end

											createNewBlockedPoint(waypoint)
										end)
									end

									repeat task.wait() until moveToFinished or not Toggles.AutoRooms.Value or recalculate
									lastWaypoint = waypoint

									waypointConnection:Disconnect()

									if not Toggles.AutoRooms.Value then
										nodeCleanup()
										break
									else

									end

									if recalculate then break end
								end
							else
								if Toggles.AutoRoomsDebug.Value then
									Notify({
										Title = "Auto A-1000 Debug",
										Description = "Pathfinding failed with status " .. tostring(path.Status)   
									}, Toggles.AutoRoomsDebug.Value)
									Sound()

									Character:PivotTo(Character:GetPivot() + workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1) * -10)

									Humanoid.HipHeight = 0
									task.wait()
									Humanoid.HipHeight = 3



								end
							end
						end
						while Toggles.AutoRooms.Value and not Library.Unloaded do
							if CurrentRoom == 1000 then
								Notify({
									Title = "Auto Rooms",
									Description = "You have reached A-1000",

								})

								break
							end

							doAutoRooms()
						end

					end
				end)
			end
		end
		function AddMinesTab()


local MinesGroupbox = Tabs.Floor:AddLeftGroupbox('The Mines')


			MinesGroupbox:AddToggle("AntiGiggle", {
				Text = "Anti-Giggle",
				Default = false,
				Tooltip = 'Prevents Giggle from attacking you.',
				Callback = function(value)
					for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
						for _, giggle in pairs(room:GetChildren()) do
							if giggle.Name == "GiggleCeiling" then
								giggle:WaitForChild("Hitbox", 5).CanTouch = not value
							end
						end
					end
				end,
			})

			MinesGroupbox:AddToggle("AntiGloomEgg", {
				Text = "Anti-Egg",
				Default = false,
				Tooltip = 'Allows you to step on Gloombat Eggs without them breaking.'
			})





			MinesGroupbox:AddToggle("AntiSeekFlood", {
				Text = "Anti-Seek Boss",
				Default = false,
				Tooltip = 'Prevents Dam Seek from hurting you.'
			})



			
			
			
			
			
			

			

		


			MinesGroupbox:AddDivider()


			MinesGroupbox:AddToggle("TheMinesAnticheatBypass", {
				Text = "Anticheat Bypass",
				Default = false,
				Tooltip = 'Allows you to bypass the anticheat by climbing a ladder.',
				
			})

			MinesGroupbox:AddToggle("ShowMinecartNodes",{
				Text = "Show Seek Path",
				Default = false,
				Tooltip = 'Creates a visual path to follow for the mines seek chases.',
				
			}):AddColorPicker('MinecartNodeColor', {
				Default = Color3.fromRGB(0,255,0), -- Bright green
				Title = 'Grumbles', -- Optional. Allows you to have a custom color picker title (when you open it)
				Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

				Callback = function(Value)
					for i,inst in pairs(workspace.Terrain:GetChildren()) do
						if inst:IsA("Beam") then
							inst.Color  = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Value),
								ColorSequenceKeypoint.new(1, Value)
							})
						end
					end
				end
			})
			MinesGroupbox:AddToggle("RemoveMinesEcho",{
				Text = "Remove Echo",
				Default = false,
				Tooltip = "Removes the echo effect on all sounds in the mines.",
				
			})

			if Floor == "Mines" then
				Toggles.TheMinesAnticheatBypass:OnChanged(function(value)
					
					for i,inst in pairs(ObjectsTable.Ladders) do
						if inst.Name == "Ladder" and inst:FindFirstChild("Main") then
							if value then
							esp(inst,inst.Main,"Ladder", laddercolor,true,false)
							else
								inst:SetAttribute("ESP", false)
							end



						end
					end
					MinesBypass = value
					if value then



						Notify({
							Title = "Anticheat bypass",
							Description = "Climb on a ladder to bypass the anticheat.",


						})
						Sound()
					else
						RemotesFolder:WaitForChild("ClimbLadder"):FireServer()

						-- Ladder ESP


					end
				end)
				Toggles.ShowMinecartNodes:OnChanged(function(value)

					if value then



						for i,Room in pairs(workspace:WaitForChild("CurrentRooms"):GetChildren()) do
						local Connection
								Connection = workspace:WaitForChild("CurrentRooms").ChildAdded:Connect(function()
								Functions.Pathfind(Room, true)
								Connection:Disconnect()
								end)
							
						end
					else
						workspace.Terrain:ClearAllChildren()


					end
				end)
				

				Toggles.AntiGloomEgg:OnChanged(function(value)
					for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
						for _, gloomPile in pairs(room:GetChildren()) do
							if gloomPile.Name == "GloomPile" then
								for _, gloomEgg in pairs(gloomPile:GetDescendants()) do
									if gloomEgg.Name == "Egg" then
										gloomEgg.CanTouch = not value
									end
								end
							end
						end
					end
				end)


				local Bridges = {}
				Toggles.AntiSeekObstructions:OnChanged(function(value)
					if value then
						for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
							if not room:FindFirstChild("Parts") then continue end

							for _, bridge in pairs(room.Parts:GetChildren()) do
								if bridge.Name == "Bridge" then
									for _, barrier in pairs(bridge:GetChildren()) do
										if not (barrier.Name == "PlayerBarrier" and barrier.Size.Y == 2.75 and (barrier.Rotation.X == 0 or barrier.Rotation.X == 180)) then continue end

										local clone = barrier:Clone()
										clone.CFrame = clone.CFrame * CFrame.new(0, 0, -5)
										clone.Color = Color3.new(0, 0.666667, 1)
										clone.Name = ESPLibrary:GenerateRandomString()
										clone.Size = Vector3.new(clone.Size.X, clone.Size.Y, 11)
										clone.Transparency = 0.5
										clone.Parent = bridge
										table.insert(Bridges, clone)
									end
								end
							end
						end
					else
						for _, bridge in pairs(Bridges) do
							bridge:Destroy()
						end
					end
				end)
				local Pipes = {}


				Toggles.AntiGiggle:OnChanged(function(value)
					for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
						for _, giggle in pairs(room:GetChildren()) do
							if giggle.Name == "GiggleCeiling" then
								giggle:WaitForChild("Hitbox", 5).CanTouch = not value
							end
						end
					end
				end)
				Toggles.AntiSeekFlood:OnChanged(function(value)
					local room = workspace.CurrentRooms:FindFirstChild("100")

					if room and room:FindFirstChild("_DamHandler") then
						local seekFlood = room._DamHandler:FindFirstChild("SeekFloodline")
						if seekFlood then
							seekFlood.CanCollide = value
						end
					end
				end)
				Toggles.RemoveMinesEcho:OnChanged(function(Value)
					SoundService.AmbientReverb = (Value and Enum.ReverbType.Room or Enum.ReverbType.Cave)
				end)

				game.Workspace.CurrentRooms.ChildAdded:Connect(function(child)

					if Floor == "Mines" then

						game.Workspace.CurrentRooms.ChildAdded:Wait()
						if Toggles.ShowMinecartNodes.Value then
							Functions.Pathfind(child, true)
						end
					end

					if child.Name == "100" and child:FindFirstChild("_DamHandler") then
						local seekFlood = child._DamHandler:FindFirstChild("SeekFloodline")
						if seekFlood then
							seekFlood.CanCollide = Toggles.AntiSeekFlood.Value
						end
					end
					if Toggles.AntiGloomEgg.Value then
						for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
							for _, gloomPile in pairs(room:GetChildren()) do
								if gloomPile.Name == "GloomPile" then
									for _, gloomEgg in pairs(gloomPile:GetDescendants()) do
										if gloomEgg.Name == "Egg" then
											gloomEgg.CanTouch = not Toggles.AntiGloomEgg.Value
										end
									end
								end
							end
						end
					end
					game.Workspace.CurrentRooms.ChildAdded:Wait()
					for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
						for _, giggle in pairs(room:GetChildren()) do
							if giggle.Name == "GiggleCeiling" then
								giggle:WaitForChild("Hitbox", 5).CanTouch = not Toggles.AntiGiggle.Value
							end
						end
					end

					if Toggles.AntiGloomEgg.Value then
						for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
							for _, gloomPile in pairs(room:GetChildren()) do
								if gloomPile.Name == "GloomPile" then
									for _, gloomEgg in pairs(gloomPile:GetDescendants()) do
										if gloomEgg.Name == "Egg" then
											gloomEgg.CanTouch = not Toggles.AntiGloomEgg.Value
										end
									end
								end
							end
						end
					end
					if Toggles.AntiSeekObstructions.Value then
						for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
							if not room:FindFirstChild("Parts") then continue end

							for _, bridge in pairs(room.Parts:GetChildren()) do
								if bridge.Name == "Bridge" then
									for _, barrier in pairs(bridge:GetChildren()) do
										if not (barrier.Name == "PlayerBarrier" and barrier.Size.Y == 2.75 and (barrier.Rotation.X == 0 or barrier.Rotation.X == 180)) then continue end

										local clone = barrier:Clone()
										clone.CFrame = clone.CFrame * CFrame.new(0, 0, -5)
										clone.Color = Color3.new(0, 0.666667, 1)
										clone.Name = ESPLibrary:GenerateRandomString()
										clone.Size = Vector3.new(clone.Size.X, clone.Size.Y, 11)
										clone.Transparency = 0.5

										clone.Parent = bridge

										table.insert(Bridges, clone)
									end
								end
							end
						end
					else
						for _, bridge in pairs(Bridges) do
							bridge:Destroy()
						end
					end
					local room = workspace.CurrentRooms:FindFirstChild("100")

					if room then
						local seekFlood = room._DamHandler
						if seekFlood then
							for i,part in pairs(seekFlood:GetDescendants()) do


							end
						end
					end
				end)
			end










		end





		local Resetting = false

		LeftGroupBox4:AddButton({
			Text = 'Kill Character',
			Func = function()
				if RemotesFolder:FindFirstChild("Underwater") then
					if Resetting == false then
						RemotesFolder.Underwater:FireServer(true)
						Notify({Title = "Resetting", Description = "You should die in the next 20 seconds.", Reason = "Click the button again to cancel."})
						Sound()
						Resetting = true
					else
						RemotesFolder.Underwater:FireServer(false)
						Notify({Title = "Resetting", Description = "Kill Character has been cancelled."})
						Sound()
						Resetting = false
					end
				end
			end,
			DoubleClick = false,
			Tooltip = 'Kills your character.'
		})
		LeftGroupBox4:AddButton({
			Text = 'Play Again',
			Func = function()
				PlayAgain()
			end,
			DoubleClick = true,
			Tooltip = 'Join a new match'
		})
		LeftGroupBox4:AddButton({
			Text = 'Return To Lobby',
			Func = function()
				RemotesFolder.Lobby:FireServer()
			end,
			DoubleClick = true,
			Tooltip = 'Return to the Main Lobby'
		})



		LeftGroupBox11:AddButton({
			Text = 'Infinite Yield',
			Func = function()
				loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
			end,
			DoubleClick = false,
			Tooltip = 'Executes the Infinite Yield Admin Script'
		})
		LeftGroupBox11:AddButton({
			Text = 'Dex Explorer',
			Func = function()
				loadstring(game:HttpGet('https://pastebin.com/raw/vmNjF3fZ'))()
			end,
			DoubleClick = false,
			Tooltip = 'Executes the Dex Explorer Script'
		})

		





		
		

		Anti:AddToggle('AntiEyes', {
			Text = 'Anti-Eyes',
			Default = false, -- Default value (true / false)
			Tooltip = 'Allows you to look at The Eyes without taking damage.', -- Information shown when you hover over the toggle

			Callback = function(Value)
				AntiEyes = Value
			end
		})
		Anti:AddToggle('AntiScreech', {
			Text = 'Anti-Screech',
			Default = false, -- Default value (true / false)
			Tooltip = 'Prevent Screech from spawning', -- Information shown when you hover over the toggle

			Callback = function(Value)
				AntiScreech = Value
				if Value == true then
					Screech.Name = "Screech_"
					for i, Child in pairs(workspace.CurrentCamera:GetChildren()) do
						if Child.Name == "GlitchScreech" and Toggles.AntiScreech.Value then
							Child:Destroy()
						end
					end
				else
					Screech.Name = "Screech"
				end
			end
		})
		Anti:AddToggle('AntiSeekObstructions', {
			Text = 'Anti-Seek Obstrctions',
			Default = false, -- Default value (true / false)
			Tooltip = "Prevents Seek's Arms and the fallen chaneliers in Seek\nchases [Floor 1] from hurting you", -- Information shown when you hover over the toggle

			Callback = function(Value)
				AntiSeekObstructions = Value
				for i,e in pairs(game.Workspace:GetDescendants()) do
					if e.Name == "Seek_Arm" then
						for i,a in pairs(e.Parent:GetDescendants()) do
							if a:IsA("BasePart") then
								a.CanTouch = not Value
							end
						end
					end
				end
			end
		})
		Anti:AddToggle('AntiHalt', {
			Text = 'Anti-Halt',
			Default = false, -- Default value (true / false)
			Tooltip = 'Removed Halt from the Halt Room.', -- Information shown when you hover over the toggle

			Callback = function(Value)
				if Value == true then
					Halt.Name = "Shade_"
				else
					Halt.Name = "Shade"
				end
			end
		})

		
		Anti:AddToggle('AntiDread', {
			Text = 'Anti-Dread',
			Default = false, -- Default value (true / false)
			Tooltip = 'Prevents dread from spawning, allowing you to say in rooms\nfor as long as you want.', -- Information shown when you hover over the toggle
			Callback = function(Value)
				if Value == true then
					Dread.Name = "Dread_"
				else
					Dread.Name = "Dread"
				end
			end
		})
		Anti:AddToggle('AntiSnare', {
			Text = 'Anti-Snare',
			Default = false, -- Default value (true / false)
			Tooltip = 'Allows you to step on Snares without triggering them', -- Information shown when you hover over the toggle

			Callback = function(Value)
				AntiSnare = Value
				if Value == true then

					for i,room in pairs(game.Workspace.CurrentRooms:GetChildren()) do
						if room:FindFirstChild("Assets") then
							for i,e in pairs(room.Assets:GetChildren()) do
								if e.Name == "Snare" then




									e:WaitForChild("Hitbox").CanTouch = not Value













								end
							end
						end
					end
				end
			end
		})

		Anti:AddToggle('AntiDupe', {
			Text = 'Anti-Dupe',
			Default = false, -- Default value (true / false)
			Tooltip = 'Prevents you from opening Dupe [Fake] doors.', -- Information shown when you hover over the toggle

			Callback = function(Value)
				AntiDupe = Value
				if Value == true then
					for i,e in pairs(ObjectsTable.Dupe) do
						if e.Name == "DoorFake" or e.Name == "FakeDoor" then
							DisableDupe(e)
						end


					end
				end
			end
		})
		
		Anti:AddDivider()
		
		Anti:AddToggle("GodmodeFigure", {Text = "Anti-Figure",Default = false,Risky = true, Tooltip = 'Allows you to touch Figure without him killing you.\nWARNING: Might cause you to die at door 100, use at your own risk'})

		
		Toggles.GodmodeFigure:OnChanged(function(value)

			if value then 






				for _, figure in pairs(workspace.CurrentRooms:GetDescendants()) do
					if figure:IsA("Model") and figure.Name == "Figure" or figure:IsA("Model") and figure.Name == "FigureRig" or figure:IsA("Model") and figure.Name == "FigureRagdoll" then
						for i, v in pairs(figure:GetDescendants()) do
							if v:IsA("BasePart") then
								if not v:GetAttribute("Clip") then v:SetAttribute("Clip", v.CanCollide) end

								v.CanTouch = not value
								v.CanCollide = value
							end
						end

					end
				end
			end


		end)
		
		
		VisualsRemove:AddToggle('NoFog', {
			Text = 'Remove Fog',
			Default = false, -- Default value (true / false)
			Tooltip = "Removes any fog that is present to improve visibility", -- Information shown when you hover over the toggle

			Callback = function(Value)
				if Value == true then
					game:GetService("Lighting"):WaitForChild("Fog").Density = 0
				else
					game:GetService("Lighting"):WaitForChild("Fog").Density = FogEnd
				end
			end
		})

		VisualsRemove:AddToggle('RemoveJumpscares', {
			Text = 'Remove Jumpscares',
			Default = false, -- Default value (true / false)
			Tooltip = "Removes all Entity's jumpscares.", -- Information shown when you hover over the toggle

			Callback = function(Value)
				if Jumpscares then
					Jumpscares.Name = (Value and "Jumpscares_" or "Jumpscares")
				end
			end
		})
		VisualsRemove:AddDivider()
		VisualsRemove:AddToggle('NoHidingVegnette', {
			Text = 'No Hiding Vigenette',
			Default = false, -- Default value (true / false)
			Tooltip = 'Removes the Hiding screen effect', -- Information shown when you hover over the toggle

			Callback = function(Value)
				RemoveHideVignette = Value
			end
		})
		VisualsRemove:AddToggle('AntiGlitch', {
			Text = 'No Glitch Jumpscare',
			Default = false, -- Default value (true / false)
			Tooltip = "Removes Glitch's Screen Effects", -- Information shown when you hover over the toggle

			Callback = function(Value)
				if Value == true then
					Glitch.Name = "Glitch_"
				else
					Glitch.Name = "Glitch"
				end
			end
		})
		VisualsRemove:AddToggle('AntiVoid', {
			Text = 'No Void Jumpscare',
			Default = false, -- Default value (true / false)
			Tooltip = "Removes Void's Screen Effects", -- Information shown when you hover over the toggle

			Callback = function(Value)
				if Void then
					if Value == true then
						Void.Name = "Void_"
					else
						Void.Name = "Void"
					end
				end
			end
		})
		VisualsRemove:AddToggle('AntiTimothy', {
			Text = 'No Timothy Jumpscare',
			Default = false, -- Default value (true / false)
			Tooltip = "Removes Timothy the Spider's jumpscare", -- Information shown when you hover over the toggle

			Callback = function(Value)
				if Value == true then
					Timothy.Name = "SpiderJumpscare_"
				else
					Timothy.Name = "SpiderJumpscare"
				end
			end
		})



		LeftGroupBox6:AddDropdown('NotifyMonsters', {
			Values = {"Rush","Ambush","Blitz","Eyes","Lookman","Jeff The Killer","A-60","A-120","Giggle","Gloombat Swarm","Halt", "Glitched Rush", "Glitched Ambush"},
			Default = 0, -- number index of the value / string
			Multi = true, -- true / false, allows multiple choices to be selected

			Text = 'Notify Entities',
			Tooltip = 'Select which Entities should notify you when they spawn', -- Information shown when you hover over the dropdown


		})
		LeftGroupBox6:AddDivider()
		LeftGroupBox6:AddToggle('notif', {
			Text = 'Play Sound',
			Default = true, -- Default value (true / false)
			Tooltip = 'Play a ping sound, alerting you to notifications', -- Information shown when you hover over the toggle

			Callback = function(Value)
				notif = Value
			end
		});
		local pingtype = "New"

		LeftGroupBox6:AddDropdown('Dropdown9', {
			Values = {'New','Old','Custom'},
			Default = 2, -- number index of the value / string
			Multi = false, -- true / false, allows multiple choices to be selected

			Text = 'Ping Sound',
			Tooltip = 'Select the ping sound', -- Information shown when you hover over the dropdown

			Callback = function(Value)
				pingtype = Value
				if Value == "New" then
					pingid = 4590662766
				elseif Value == "Old" then
					pingid = 4590657391
				else
					pingid = pingidcustom
				end
			end
		})
		LeftGroupBox6:AddDivider()



		LeftGroupBox6:AddInput('PingID', {
			Default = '',
			Numeric = true, -- true / false, only allows numbers
			Finished = false, -- true / false, only calls callback when you press enter

			Text = 'Custom Sound ID',
			Tooltip = 'Set a custom ping sound ID', -- Information shown when you hover over the textbox

			Placeholder = 'Enter Sound ID Here', -- placeholder text when the box is empty
			-- MaxLength is also an option which is the max length of the text

			Callback = function(Value)
				pingidcustom = Value
				if pingtype == "Custom" then
					pingid = pingidcustom
				end
			end
		})
		LeftGroupBox6:AddSlider('AlertVolume', {
			Text = 'Sound Volume',
			Default = 3.0,
			Min = 0.5,
			Max = 5.0,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				notifvolume = Value

			end
		})

		LeftGroupBox6:AddDropdown('Dropdown1', {
			Values = {'Linora','Doors'},
			Default = 1, -- number index of the value / string
			Multi = false, -- true / false, allows multiple choices to be selected

			Text = 'Notification Style',
			Tooltip = 'Select how the notifications should appear', -- Information shown when you hover over the dropdown

			Callback = function(Value)
				NotifyType = Value
			end
		})
		LeftGroupBox6:AddDropdown('Dropdown2', {
			Values = {'Left','Right'},
			Default = (if Library.IsMobile then 2 else 1), -- number index of the value / string
			Multi = false, -- true / false, allows multiple choices to be selected

			Text = 'Linora Notification Side',
			Tooltip = "Select which side notifications should appear on, if the notification style is set to 'Linora'.", -- Information shown when you hover over the dropdown

			Callback = function(Value)
				Library.NotifySide = Value
			end
		})
		LeftGroupBox6:AddButton({
			Text = 'Test Notification',
			Func = function()
				Notify({Title = "Test Notification",Description = "This is a test notification."})
				Sound()
			end,
			DoubleClick = false,
			Tooltip = 'Send a notifcation to test your settings'
		})



		LeftGroupBox:AddSlider('WS', {
			Text = 'Speed Boost',
			Default = 0,
			Min = 0,
			Max = 6,
			Rounding = 0,
			Compact = false,

			Callback = function(Value)
				SpeedBoost = Value


			end
		})
		LeftGroupBox:AddToggle('SpeedBoostEnabled', {
			Text = 'Enable Speed Boost',
			Default = false, -- Default value (true / false)
			Tooltip = 'Toggles whether the script should edit your walkspeed', -- Information shown when you hover over the toggle

			Callback = function(Value)
				SpeedBoostEnabled = Value
			end

		})
		LeftGroupBox:AddDivider()
		LeftGroupBox:AddToggle('Noclip', {
			Text = 'Noclip',
			Default = false, -- Default value (true / false)
			Tooltip = 'Disables collisions, allowing you to walk through objects', -- Information shown when you hover over the toggle

			Callback = function(Value)
				togglenoclip(Value)
			end

		}):AddKeyPicker('Keybind3', {


			Default = 'N', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
			SyncToggleState = true,


			-- You can define custom Modes but I have never had a use for it.
			Mode = 'Toggle', -- Modes: Always, Toggle, Hold

			Text = 'Noclip', -- Text to display in the keybind menu
			NoUI = false, -- Set to true if you want to hide from the Keybind menu,

			-- Occurs when the keybind is clicked, Value is `true`/`false`
			Callback = function(Value)



			end,

			-- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
			ChangedCallback = function(New)
			end
		})
		LeftGroupBox:AddToggle('NoAccell', {
			Text = 'No Acceleration',
			Default = false, -- Default value (true / false)
			Tooltip = 'Prevents your character from sliding due to high walkspeed.', -- Information shown when you hover over the toggle

			Callback = function(Value)
				NA = Value

				for i,part in pairs(Character:GetDescendants()) do
					if part:IsA("BasePart") then

						if Value == true then
							part.CustomPhysicalProperties = CustomPhysicalProperties
						else
							part.CustomPhysicalProperties = OldPhysics
						end
					end
				end
			end
		})

		Automation:AddToggle('AA', {
			Text = 'Auto Interact',
			Default = false, -- Default value (true / false)
			Tooltip = 'Automatically trigger prompts.', -- Information shown when you hover over the toggle

			Callback = function(Value)

				AA = Value

			end
		}):AddKeyPicker('AutoInteractKeybind', {


			Default = 'R', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
			SyncToggleState = true,


			-- You can define custom Modes but I have never had a use for it.
			Mode = (Library.IsMobile and 'Toggle' or 'Hold'), -- Modes: Always, Toggle, Hold

			Text = 'Auto Interact', -- Text to display in the keybind menu
			NoUI = false, -- Set to true if you want to hide from the Keybind menu,

			-- Occurs when the keybind is clicked, Value is `true`/`false`
			Callback = function(Value)

			end,

			-- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
			ChangedCallback = function(New)
			end
		})

		Automation:AddSlider('AutoInteractDelay', {
			Text = 'Auto Interact Delay',
			Default = 0.1,
			Min = 0,
			Max = 0.5,
			Rounding = 2,
			Compact = false,


		})

		Automation:AddDropdown("AutoInteractIgnoreList", 
			{ Values = {'Gold','Locked Items','Doors','Paintings'}, 
				Default = 0, 
				Multi = true, 
				Text = "Ignore List", 

			})
		Automation:AddDivider()
		Automation:AddToggle('AutoBreaker', {
			Text = 'Auto Breaker Puzzle',
			Default = false, -- Default value (true / false)
			Tooltip = "Automatically solves the Breaker Minigame", -- Information shown when you hover over the toggle

			Callback = function(Value)
				AutoBreaker = Value
				if Value == true and CurrentRoom == 100 then
					for i,e in pairs(game.Workspace:GetDescendants()) do
						if e.Name == "ElevatorBreaker" then
							SolveBreakerBox(e)
						end
					end
				end
			end
		})

		Automation:AddToggle('AutoPaintings', {
			Text = 'Auto Paintings',
			Default = false, -- Default value (true / false)
			Tooltip = 'Automatically put paintings in the correct places.', -- Information shown when you hover over the toggle


		}):AddKeyPicker('AutoPaintingsKey', {


			Default = 'Q', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
			SyncToggleState = true,


			-- You can define custom Modes but I have never had a use for it.
			Mode = 'Toggle', -- Modes: Always, Toggle, Hold

			Text = 'Auto Paintings', -- Text to display in the keybind menu
			NoUI = false, -- Set to true if you want to hide from the Keybind menu,

			-- Occurs when the keybind is clicked, Value is `true`/`false`
			Callback = function(Value)

			end,

			-- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
			ChangedCallback = function(New)
			end
		})
		Automation:AddToggle('AutoLibrary', {
			Text = 'Auto Library Code',
			Default = false, -- Default value (true / false)
			Tooltip = "Automatically solves the code for door 50", -- Information shown when you hover over the toggle

			Callback = function(Value)
				AutoLibrary = Value
			end
		})
		Automation:AddToggle('AutoUnlockPadlock', {
			Text = 'Auto Unlock Padlock',
			Default = false, -- Default value (true / false)
			Tooltip = "Automatically unlock the library padlock when closer than the provided distance.", -- Information shown when you hover over the toggle


		})
		Automation:AddSlider('AutoUnlockPadlockDistance', {
			Text = 'Unlock Distance',
			Default = 35,
			Min = 10,
			Max = 75,
			Rounding = 0,
			Compact = false,

			Callback = function(Value)
				AutoLibraryUnlockDistance = Value

			end
		})
		Automation:AddDivider()


		LeftGroupBox9:AddToggle('ToggleAmbience', {
			Text = 'Ambience',
			Default = false, -- Default value (true / false)
			Tooltip = 'Enables the Ambience Color to be the selected Color', -- Information shown when you hover over the toggle
			Callback = function(Value)
				fb = Value
			end,
		}):AddColorPicker('Ambience',{
			Default = Color3.fromRGB(255,255,255),
			Title = "Ambience",
			Transparency = 0,
			Callback = function(Value)
				Ambience = Value
			end,
		})



		LeftGroupBox9:AddDivider()
		LeftGroupBox9:AddSlider('FOV', {
			Text = 'FOV',
			Default = 70,
			Min = 70,
			Max = 120,
			Rounding = 0,
			Compact = false,

			Callback = function(value)

				fov = value


			end
		})

		local FOVTween = nil
		LeftGroupBox9:AddToggle("EnableFOV",{
			Text = "Enable FOV",
			Default = false,
			Tooltip = 'Enables the Field Of View changer',
			Callback = function(Value)
				task.wait(0.05)
				if FOVTween then
					FOVTween:Pause()
					FOVTweenTime = 1
				end
				if RequireCheck == false then
					if Value == true then

						FOVTweenTime = 1

						local Tween = game:GetService("TweenService"):Create(game.Workspace.CurrentCamera,TweenInfo.new((fov/160),Enum.EasingStyle.Quad),{FieldOfView = fov})
						game.Workspace.CurrentCamera.FieldOfView = 70
						FOVTween = Tween
						Tween:Play()
						Tween.Completed:Connect(function()



						end)
					else


					end
				else
					if Value == true then
						Main_Game.fovtarget = fov
					else
						Main_Game.fovtarget = 70
					end
				end
				EnableFOV = Value
			end,
		})
		LeftGroupBox2:AddToggle('SpeedBypass', {
			Text = 'Speed Bypass',
			Default = false, -- Default value (true / false)
			Tooltip = 'Bypasses the Speed Anticheat, allowing you to walk muchfaster',
			Callback = function(Value)
				SpeedBypassEnabled = Value
				if Value == true then
					if not Toggles.AutoRoomsIgnoreA60.Value or Floor ~= "Rooms" then
						Options.WS:SetMax(100)
					end
					

				else
					Options.WS:SetMax(6)
					if SpeedBoost > 6 then
						Options.WS:SetValue(6)
					end
					task.wait(0.25)
					CollisionClone.Massless = true


				end
			end,
		})
		LeftGroupBox2:AddSlider('BypassCooldown', {
			Text = 'Speed Bypass Delay',
			Default = 0.23,
			Min = 0.19,
			Max = 0.25,
			Rounding = 3,
			Compact = false,

			Callback = function(Value)
				bypassdelay = Value

			end
		})
		LeftGroupBox2:AddDivider()
		LeftGroupBox2:AddToggle('Toggle250', {
			Text = 'Godmode',
			Default = false, -- Default value (true / false)
			Tooltip = 'Prevents Entities like Rush from killing you\nWARNING: Do not use fly or noclip while using godmode.', -- Information shown when you hover over the toggle

			Callback = function(Value)

				godmode = Value


				if Value == false then


					task.wait(0.1)
					Collision.Position = HumanoidRootPart.Position Vector3.new(0, 0, 0)
				end
			end



		}):AddKeyPicker('Keybind3', {


			Default = 'G', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
			SyncToggleState = true,


			-- You can define custom Modes but I have never had a use for it.
			Mode = 'Toggle', -- Modes: Always, Toggle, Hold

			Text = 'Godmode', -- Text to display in the keybind menu
			NoUI = false, -- Set to true if you want to hide from the Keybind menu,

			-- Occurs when the keybind is clicked, Value is `true`/`false`
			Callback = function(Value)


			end,

			-- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
			ChangedCallback = function(New)
			end
		})
		GodmodeOffset = 2.1
		LeftGroupBox2:AddSlider('GodmodeOffset', {
			Text = 'Godmode Offset',
			Default = 2.1,
			Min = 2,
			Max = 3,
			Rounding = 2,
			Compact = false,
			Callback = function(Value)
				GodmodeOffset = Value
			end,

			
		})
		LeftGroupBox2:AddDivider()
		LeftGroupBox2:AddToggle('ACM', {
			Text = 'Anticheat Manipulation',
			Default = false, -- Default value (true / false)
			Tooltip = 'Flings your character forwards, tricking the anticheat into teleporting you slightly forwards.', -- Information shown when you hover over the toggle
			Diabled = not RemotesFolder:FindFirstChild("Crouch"),
			Callback = function(Value)


			end

		}):AddKeyPicker('AnticheatManipulation', {


			Default = 'V', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
			SyncToggleState = true,


			-- You can define custom Modes but I have never had a use for it.
			Mode = (Library.IsMobile and 'Toggle' or 'Hold'), -- Modes: Always, Toggle, Hold

			Text = 'Anticheat Manipulation', -- Text to display in the keybind menu
			NoUI = false, -- Set to true if you want to hide from the Keybind menu,

			-- Occurs when the keybind is clicked, Value is `true`/`false`
			Callback = function(Value)


			end,

			-- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
			ChangedCallback = function(New)
			end
		})









		OldPhysics = HumanoidRootPart.CustomPhysicalProperties

		local NAC = Player.CharacterAdded:Connect(function(NewCharacter)
			if Toggles.NoAccell.Value then
				for i,part in pairs(NewCharacter:GetDescendants()) do
					if part:IsA("BasePart") then


						part.CustomPhysicalProperties = CustomPhysicalProperties

					end
				end
			end
		end)

		
		
		LeftGroupBox:AddToggle('Jump', {
			Text = 'Enable Jump',
			Default = false, -- Default value (true / false)
			Tooltip = 'Allows your character to jump.', -- Information shown when you hover over the toggle
			Disabled = not RemotesFolder:FindFirstChild("Crouch"),
			Callback = function(Value)
				game.Players.LocalPlayer.Character:SetAttribute("CanJump",Value)
				JumpBoost = 5 + Options.JumpBoost.Value
			end
		})
		LeftGroupBox:AddSlider('JumpBoost', {
			Text = 'Jump Boost',
			Default = 0,
			Min = 0,
			Max = 50,
			Rounding = 0,
			Compact = false,

			Callback = function(Value)
				JumpBoost = 5 + Value


			end
		})

LeftGroupBox:AddDivider()
	


		LeftGroupBox2:AddToggle('AntiFH', {
			Text = 'Crouch Spoof',
			Default = false, -- Default value (true / false)
			Tooltip = 'Makes the game think you are always crouching [Useful for Figure].', -- Information shown when you hover over the toggle
			Disabled = not RemotesFolder:FindFirstChild("Crouch"),
			Callback = function(Value)
				AntiFH = Value
			end
		})
		



		
		LeftGroupBox9:AddDivider()
		LeftGroupBox9:AddToggle('Toggle50', {
			Text = 'Third Person',
			Default = false, -- Default value (true / false)
			Tooltip = 'Zooms your camera out to be able to see your Character', -- Information shown when you hover over the toggle

			Callback = function(Value)
				thirdp = Value
			end
		}):AddKeyPicker('Keybind5', {


			Default = 'T', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
			SyncToggleState = true,


			-- You can define custom Modes but I have never had a use for it.
			Mode = 'Toggle', -- Modes: Always, Toggle, Hold

			Text = 'Third Person', -- Text to display in the keybind menu
			NoUI = false, -- Set to true if you want to hide from the Keybind menu,

			-- Occurs when the keybind is clicked, Value is `true`/`false`
			Callback = function(Value)
				thirdp = Value

			end,

			-- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
			ChangedCallback = function(New)
			end
		})
		LeftGroupBox9:AddSlider('TPX', {
			Text = 'Offset X',
			Default = 0,
			Min = -10,
			Max = 10,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				ThirdPersonX = Value

			end
		})
		LeftGroupBox9:AddSlider('TPY', {
			Text = 'Offset Y',
			Default = 0,
			Min = -10,
			Max = 10,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				ThirdPersonY = Value

			end
		})
		LeftGroupBox9:AddSlider('TPZ', {
			Text = 'Offset Z',
			Default = 5,
			Min = -10,
			Max = 10,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				ThirdPersonZ = Value

			end
		})
		
		LeftGroupBox:AddToggle('Toggle111', {
			Text = 'Fly',
			Default = false, -- Default value (true / false)
			Tooltip = 'Fly freely around the map', -- Information shown when you hover over the toggle

			Callback = function(Value)
				flytoggle = Value
				if flytoggle == true then
				
				fly.enabled = Value
					fly.flyBody.Parent = Collision

				else
					fly.flyBody.Parent = nil

				end
			end
		}):AddKeyPicker('Keybind9', {


			Default = 'F', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
			SyncToggleState = true,


			-- You can define custom Modes but I have never had a use for it.
			Mode = 'Toggle', -- Modes: Always, Toggle, Hold

			Text = 'Fly', -- Text to display in the keybind menu
			NoUI = false, -- Set to true if you want to hide from the Keybind menu,

			-- Occurs when the keybind is clicked, Value is `true`/`false`
			Callback = function(Value)
				flytoggle = Value
				if Value == true then 
					game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
				else
					game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
				end
			end,

			-- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
			ChangedCallback = function(New)
			end
		})
		LeftGroupBox:AddSlider('Slider9', {
			Text = 'Fly Speed',
			Default = 3,
			Min = 1,
			Max = 15,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				flyspeed = Value

			end
		})
		PlayerGroupbox:AddToggle('Toggle7', {
			Text = 'Instant Interact',
			Default = false, -- Default value (true / false)
			Tooltip = 'Make all prompts instant.', -- Information shown when you hover over the toggle

			Callback = function(Value)
				interact = Value
			end
		})


		PlayerGroupbox:AddToggle('Toggle9', {
			Text = 'Prompt Clip',
			Default = false, -- Default value (true / false)
			Tooltip = 'Allows you to trigger prompts through walls.', -- Information shown when you hover over the toggle

			Callback = function(Value)
				ito = Value
			end
		})
		PlayerGroupbox:AddToggle('Toggle8', {
			Text = 'Prompt Reach',
			Default = false, -- Default value (true / false)
			Tooltip = 'Allows prompts to be triggered from further away', -- Information shown when you hover over the toggle

			Callback = function(Value)
				maxinteract = Value
			end
		})
		PlayerGroupbox:AddSlider('ReachDistance', {
			Text = 'Prompt Reach Multiplier',
			Default = 1,
			Min = 1,
			Max = 2,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				ReachDistance = Value


			end
		})

		PlayerGroupbox:AddDivider()
		PlayerGroupbox:AddToggle('DoorReach', {
			Text = 'Door Reach',
			Default = false, -- Default value (true / false)
			Tooltip = 'Open Doors from much further away', -- Information shown when you hover over the toggle

			Callback = function(Value)
				DoorReach = Value
			end
		})
		PlayerGroupbox:AddSlider("DoorReachMultiplier",{
			Text = "Door Reach Multiplier",
			Default = 1,
			Min = 1,
			Max = 3,
			Rounding = 1,
		})
		PlayerGroupbox:AddDivider()
		PlayerGroupbox:AddToggle('TransparentCloset', {
			Text = 'Transparent Closets',
			Default = false, -- Default value (true / false)
			Tooltip = 'Makes the current Hiding Spot transparent', -- Information shown when you hover over the toggle

			Callback = function(Value)
				TransparentCloset = Value
			end
		})
		PlayerGroupbox:AddSlider("HidingTransparency",{
			Text = "Hiding Transparency",
			Default = 0.5,
			Min = 0,
			Max = 1,
			Rounding = 2,
			Callback = function(Value)
				TransparentClosetNumber = Value
			end,
		})

		LeftGroupBox2:AddToggle('ForwardTeleport', {
			Text = 'Forward Teleport',
			Default = false, -- Default value (true / false)
			Tooltip = 'Glides your character forwards, bypass the noclip anticheat.', -- Information shown when you hover over the toggle

			Callback = function(Value)


			end

		}):AddKeyPicker('ForwardTeleportKey', {


			Default = 'B', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
			SyncToggleState = true,


			-- You can define custom Modes but I have never had a use for it.
			Mode = (Library.IsMobile and 'Toggle' or 'Hold'), -- Modes: Always, Toggle, Hold

			Text = 'Forward Teleport', -- Text to display in the keybind menu
			NoUI = false, -- Set to true if you want to hide from the Keybind menu,

			-- Occurs when the keybind is clicked, Value is `true`/`false`
			Callback = function(Value)


			end,

			-- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
			ChangedCallback = function(New)

			end
		})


		ESP:AddToggle('EssentialsESP', {
			Text = 'Objectives',
			Default = false, -- Default value (true / false)
			Tooltip = 'Highlight all essential items (such as keys) that spawn', -- Information shown when you hover over the toggle

			Callback = function(Value)
				keys = Value
				task.wait()
				if Value == true then

					for i,inst in pairs(ObjectsTable.Keys) do
						if inst.Name == "KeyObtain" then


							esp(inst,inst,"Door Key", keycolor,true,false)

						end
						
						if inst.Name == "MinesAnchor" and inst:FindFirstChild("Sign") then
							esp(inst,inst.PrimaryPart,"Anchor".. " "..inst.Sign.TextLabel.Text, keycolor,false,false)



						end
						
						if inst.Name == "LiveBreakerPolePickup" then
							
								esp(inst,inst.Base,"Breaker", keycolor,true,false)
							


end


						
						if inst.Name == "LiveHintBook" then
							
						
								esp(inst,inst.Base,"Book", keycolor,true,false)
							




						end
						
						if inst.Name == "TimerLever" and inst:FindFirstChild("Main") then
							esp(inst,inst,"Time Lever", keycolor,true,false)
						end
						
						if inst.Name == "ElectricalKeyObtain" then

							esp(inst,inst,"Electrical Key", keycolor,true,false)

						end
						
						if inst.Name == "MinesGenerator" then

							esp(inst,inst.GeneratorMain,"Generator", keycolor,true,false)
						elseif inst.Name == "MinesGateButton" then
							esp(inst,inst.MainPart,"Gate Button", keycolor,true,false)
						elseif inst.Name == "WaterPump" then
							esp(inst,inst.MainPart,"Water Pump", keycolor,true,false)








						end
						
						if inst.Name == "LeverForGate" and inst:FindFirstChild("Main") then
							esp(inst,inst.Main,"Gate Lever", keycolor,true,false)
						end
						
						if inst.Name == "FuseObtain" then

							esp(inst,inst.Hitbox,"Fuse", keycolor,true,false)
							inst:WaitForChild("ModulePrompt"):GetAttributeChangedSignal("Interactions"):Connect(function()
								inst:SetAttribute("ESP",false)
							end)








						end


					end




				end
				if Value == false then

					for i,inst in pairs(ObjectsTable.Keys) do
						
							inst:SetAttribute("ESP", false)

						
					end
				end

			end
		})
		ESP:AddToggle('DoorESP', {
			Text = 'Doors',
			Default = false, -- Default value (true / false)
			Tooltip = 'Highlight all Doors', -- Information shown when you hover over the toggle

			Callback = function(Value)
				doors = Value
				task.wait()
				if Value == true then

					for i,inst in pairs(ObjectsTable.Doors) do
						if inst.Name == "Door" and inst:FindFirstChild("Door") then
							local knob = inst.Door:FindFirstChild("Knob") or inst.Door
							if inst.Parent.Name == "49" and Floor == "Hotel" or inst.Parent.Name == "49" and Floor == "Fools" or inst.Parent.Name == "50" and Floor == "Hotel" or inst.Parent.Name == "50" and Floor == "Fools" then

								if inst.Parent:GetAttribute("RequiresKey") == true then
									esp(inst,inst.Hidden,"Locked Door", doorcolor,true,false)
								else
									esp(inst,inst.Hidden,"Door", doorcolor,true,false)
								end
							else

								if inst.Parent:GetAttribute("RequiresKey") == true then

									esp(inst.Door,knob,"Locked Door", doorcolor,true,false)
								else
									esp(inst.Door,knob,"Door", doorcolor,true,false)
								end
							end


						end
					end




				end

				if Value == false then
					for i,inst in pairs(ObjectsTable.Doors) do

						
							inst:WaitForChild("Door"):SetAttribute("ESP",false)
						



					end
				end
			end

		})
		ESP:AddToggle('ClosetESP', {
			Text = 'Hiding Places',
			Default = false, -- Default value (true / false)
			Tooltip = 'Highlight all Hiding Spots', -- Information shown when you hover over the toggle

			Callback = function(Value)
				closets = Value
				task.wait()
				if Value == true then

					for i,inst in pairs(ObjectsTable.Closets) do
						if inst.Name == "Wardrobe" and inst:FindFirstChild("Main") then
							esp(inst,inst.Main,"Closet", closetcolor,true,false)
						end

						if inst.Name == "Toolshed" and inst:FindFirstChild("Main") then
							esp(inst,inst.Main,"Closet", closetcolor,true,false)
						end


						if inst.Name == "Backdoor_Wardrobe" and inst:FindFirstChild("Main") then
							esp(inst,inst.Main,"Closet", closetcolor,true,false)
						end

						if inst.Name == "RetroWardrobe" and inst:FindFirstChild("Main") and closets == true
						then
							esp(inst,inst.Main,"Closet", closetcolor,true,false)
						end
						if inst.Name == "CircularVent"
						then

							if closets == true then
								esp(inst,inst,"Pipe", closetcolor,true,false)
							end

						end

						if inst.Name == "Dumpster"
						then

							if closets == true then
								esp(inst,inst,"Dumpster", closetcolor,true,false)
							end

						end
						if inst.Name == "Bed" and inst:FindFirstChild("Main") and closets == true
						then
							esp(inst,inst.Main,"Bed", closetcolor,true,false)
						end
						if inst.Name == "Double_Bed" and closets == true
						then
							esp(inst,inst,"Double Bed", closetcolor,true,false)
						end
						if inst.Name == "Rooms_Locker" and inst:FindFirstChild("Base") then
							esp(inst,inst.Base,"Locker", closetcolor,true,false)
						end
						if inst.Name == "Rooms_Locker_Fridge" and inst:FindFirstChild("Base") then
							esp(inst,inst.Base,"Locker", closetcolor,true,false)
						end


						if inst.Name == "Locker_Large" and inst:FindFirstChild("Main") then
							esp(inst,inst.Main,"Locker", closetcolor,true,false)
						end
					end
				end




				if Value == false then

					for i,inst in pairs(ObjectsTable.Closets) do

						inst:SetAttribute("ESP", false)


					end
				end
			end

		})
		
		ESP:AddToggle('PlayerESP', {
			Text = 'Players',
			Default = false, -- Default value (true / false)
			Tooltip = 'Highlights other Players', -- Information shown when you hover over the toggle

			Callback = function(Value)

				

				for i,inst in pairs(ObjectsTable.Players) do
					
						if Value then
							ESPLibrary:AddESP({
								Object = inst.Character,
								Text = inst.Name,
								Color = playercolor
							})
							inst:GetAttributeChangedSignal("Alive"):Connect(function()
								ESPLibrary:RemoveESP(inst.Character)
							end)
						else
							ESPLibrary:RemoveESP(inst)
						end
					
				
					

				end
				
			end
		})
		ESP:AddToggle('ChestESP', {
			Text = 'Chests',
			Default = false, -- Default value (true / false)
			Tooltip = 'Highlights Chests', -- Information shown when you hover over the 

			Callback = function(Value)
				task.wait()
				if Value == true then

					for i,inst in pairs(ObjectsTable.Chests) do
						if inst.Name == "ChestBox" and Toggles.ChestESP.Value or inst.Name == "ChestBoxLocked" and Toggles.ChestESP.Value then
							local Text = "Chest"
							if inst:GetAttribute("Locked") == true then
								Text = "Locked Chest"
							end
							esp(inst,inst,Text, chestcolor,true,false)



						end
						if inst.Name == "Toolbox" and Toggles.ChestESP.Value or inst.Name == "Toolbox_Locked" and Toggles.ChestESP.Value then
							local Text = "Toolbox"
							if inst:GetAttribute("Locked") == true then
								Text = "Locked Toolbox"
							end
							esp(inst,inst,Text, chestcolor,true,false)



						end
						if inst.Name == "Chest_Vine" then

							local Text = "Vine Chest"

							if Toggles.ChestESP.Value then
								esp(inst,inst,Text, chestcolor,true,false)
							end


						end
						if inst.Name == "Locker_Small_Locked" then






							local Text = "Locked Item Locker"

							if Toggles.ChestESP.Value then
								esp(inst,inst,Text, chestcolor,true,false)
							end


						end
					end


				end
				if Value == false then

					for i,inst in pairs(ObjectsTable.Chests) do
						if inst.Name == "ChestBox" or inst.Name == "ChestBoxLocked" or inst.Name == "Toolbox" or inst.Name == "Toolbox_Locked" or inst.Name == "Chest_Vine"  or inst.Name == "Locker_Small_Locked" then
							inst:SetAttribute("ESP", false)

						end
					end
				end
			end
		})
		
		ESP:AddToggle('ItemESP', {
			Text = 'Items',
			Default = false, -- Default value (true / false)
			Tooltip = 'Highlights all Items that spawn', -- Information shown when you hover over the toggle

			Callback = function(Value)
				ItemESP = Value
				task.wait()
				if Value == true then

					for i,inst in pairs(ObjectsTable.Items) do
						print(inst.Name)
						if table.find(Items2,inst.Name) and inst:FindFirstChild("Main") then

							if inst.Parent.Name == "Drops" then
								ESPLibrary:AddESP({
									Object = inst,
									Text = ItemNames[inst.Name],
									Color = itemcolor
								})
							else

								esp(inst,inst,ItemNames[inst.Name],itemcolor, true, false)
							end
						end
						if inst.Name == "LibraryHintPaper" then
							esp(inst,inst.Handle,"Library Paper",itemcolor,false,false)
						end
						if inst.Name == "Toolshed_Small" then
							esp(inst,inst,"Toolshed",itemcolor,true,false)
						end
					end



				end
				if Value == false then

					for i,inst in pairs(ObjectsTable.Items) do
						if table.find(Items2,inst.Name) or inst.Name == "LibraryHintPaper" or inst.Name == "Toolshed_Small" then
							inst:SetAttribute("ESP", false)
						end
					end

				end
			end
		})
		
		ESP:AddToggle('GoldESP', {
			Text = 'Gold',
			Default = false, -- Default value (true / false)
			Tooltip = 'Highlights all Gold [Currency] that spawns.', -- Information shown when you hover over the toggle

			Callback = function(Value)
				gold = Value
				task.wait()
				if Value == true then

					for i,inst in pairs(ObjectsTable.Gold) do
						if inst.Name == "GoldPile" then
						
							esp(inst,inst,inst:GetAttribute("GoldValue") .. " Gold", goldcolor,false,false)
						end
					end


				end
				if Value == false then

					for i,inst in pairs(ObjectsTable.Gold) do
						if inst.Name == "GoldPile" then
							inst:SetAttribute("ESP", false)
						end
					end

				end
			end 
		})
		ESP:AddToggle('DupeESP', {
			Text = 'Fake Doors',
			Default = false, -- Default value (true / false)
			Tooltip = 'Highlights all fake doors that spawn', -- Information shown when you hover over the toggle

			Callback = function(Value)
				DupeESP = Value
				task.wait()
				if Value == true then

					for i,door in pairs(ObjectsTable.Dupe) do
						if door.Parent.Name == "FakeDoor" or door.Parent.Name == "DoorFake" then
							ApplyDupeESP(door.Parent)
						elseif door.Name == "SideroomSpace" then
							ApplyDupeESP(door)
						end

					end
				end
				if Value == false then

					for i,inst in pairs(ObjectsTable.Dupe) do
						if inst.Parent.Name == "FakeDoor" or inst.Parent.Name == "DoorFake" or inst.Name == "SideroomSpace" then
							inst:SetAttribute("ESP", false)
						end
					end

				end
			end
		})
		
		
		ESP:AddToggle('EntityESP', {
			Text = 'Entities',
			Default = false, -- Default value (true / false)
			Tooltip = 'Highlights all Entities that spawn.', -- Information shown when you hover over the toggle

			Callback = function(Value)
				EntityESP = Value
				if Value == true then
				for i,inst in pairs(ObjectsTable.Entities) do
					
						if inst:GetAttribute("ESPText") then
							ESPLibrary:AddESP({
								Object = inst,
								Text = inst:GetAttribute("ESPText"),
								Color = entitycolor
							})
						end
						
						if inst.Name == "FigureRig" and inst:FindFirstChild("Torso") or inst.Name == "Figure" and inst:FindFirstChild("Torso") then
							esp(inst,inst.Torso,"Figure", entitycolor,true,false)
						end
						
						if inst.Name == "GrumbleRig" and inst:FindFirstChild("Root") then
							esp(inst,inst.Root,"Grumble", entitycolor,false,false)
						end
						
						
						
						
						
						if inst.Name == "GiggleCeiling" then
							esp(inst,inst,"Giggle",entitycolor,true,false)


						end
						
						if inst.Name == "Snare" then
							
							if RemotesFolder.Name == "RemotesFolder" then
							inst:WaitForChild("Snare").Roots.Transparency = 1
							inst:WaitForChild("Snare").SnareBase.Transparency = 1
							inst:WaitForChild("Void").Transparency = 0	
							inst:WaitForChild("Void").Color = Color3.fromRGB(76, 67, 55)
end
							esp(inst,inst,"Snare", entitycolor,true,false)
						end
					
					end
				
else
	for i,inst in pairs(ObjectsTable.Entities) do
						if inst:GetAttribute("ESPText") then
							ESPLibrary:RemoveESP(inst)
						end
		inst:SetAttribute("ESP", false)
		
	end
	end

			end
		})

		




		Toggles.DoorESP:AddColorPicker('ColorPicker1', {
			Default = doorcolor, -- Bright green
			Title = 'Doors', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				doorcolor = Value

				for i,inst in pairs(ObjectsTable.Doors) do
					ESPLibrary:UpdateObjectColor(inst:FindFirstChild("Door"),Value)
				end
			end
		})
		Toggles.ClosetESP:AddColorPicker('ColorPicker2', {
			Default = closetcolor, -- Bright green
			Title = 'Closets', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				closetcolor = Value
				for i,inst in pairs(ObjectsTable.Closets) do
					ESPLibrary:UpdateObjectColor(inst,Value)
				end
			end
		})
		Toggles.EssentialsESP:AddColorPicker('KeyColor', {
			Default = keycolor, -- Bright green
			Title = 'Keys', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				keycolor = Value
				for i,inst in pairs(ObjectsTable.Keys) do
					ESPLibrary:UpdateObjectColor(inst,Value)
				end
			end
		})
		
		Toggles.PlayerESP:AddColorPicker('PlayerESPColor', {
			Default = playercolor, -- Bright green
			Title = 'Players', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				playercolor = Value
				for i,inst in pairs(ObjectsTable.Players) do
			
					ESPLibrary:UpdateObjectColor(inst,Value)
					
				end
			end
		})
		Toggles.ItemESP:AddColorPicker('ColorPickerItems', {
			Default = itemcolor, -- Bright green
			Title = 'Items', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				itemcolor = Value
				for i,inst in pairs(ObjectsTable.Items) do
					ESPLibrary:UpdateObjectColor(inst,Value)
				end
			end
		})
		
		
		Toggles.GoldESP:AddColorPicker('ColorPicker6', {
			Default = goldcolor, -- Bright green
			Title = 'Gold', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				goldcolor = Value
				for i,inst in pairs(ObjectsTable.Gold) do
					ESPLibrary:UpdateObjectColor(inst,Value)
				end
			end
		})
		Toggles.DupeESP:AddColorPicker('DupeESPColor', {
			Default = dupecolor, -- Bright green
			Title = 'Fake Doors', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				dupecolor = Value
				for i,inst in pairs(ObjectsTable.Dupe) do
					ESPLibrary:UpdateObjectColor(inst,Value)
				end
			end
		})
		Toggles.EntityESP:AddColorPicker('ColorPicker7', {
			Default = entitycolor, -- Bright green
			Title = 'Entities', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				entitycolor = Value
				for i,inst in pairs(ObjectsTable.Entities) do
					ESPLibrary:UpdateObjectColor(inst, Value)
				end
			end
		})
		Toggles.ChestESP:AddColorPicker('ChestColorPicker', {
			Default = chestcolor, -- Bright green
			Title = 'Chests', -- Optional. Allows you to have a custom color picker title (when you open it)
			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

			Callback = function(Value)
				chestcolor = Value
				for i,inst in pairs(ObjectsTable.Chests) do
					ESPLibrary:UpdateObjectColor(inst,Value)
				end
			end
		})
		

		ESPSettings:AddToggle('Toggle21', {
			Text = 'Rainbow ESP',
			Default = false, -- Default value (true / false)
			Tooltip = 'Makes all ESP highlights have a rainbow effect.', -- Information shown when you hover over the toggle

			Callback = function(Value)
				ESPLibrary:SetRainbow(Value)
			end
		})
		ESPSettings:AddDivider()
		ESPSettings:AddSlider('Slider3', {
			Text = 'Fill Transparency',
			Default = 0.65,
			Min = 0,
			Max = 1,
			Rounding = 2,
			Compact = false,

			Callback = function(Value)
				ESPLibrary:SetFillTransparency(Value)

			end
		})
		ESPSettings:AddSlider('Slider4', {
			Text = 'Outline Transparency',
			Default = 0,
			Min = 0,
			Max = 1,
			Rounding = 2,
			Compact = false,

			Callback = function(Value)
				ESPLibrary:SetOutlineTransparency(Value)

			end
		})
		ESPSettings:AddSlider('Slider5', {
			Text = 'Text Transparency',
			Default = 0,
			Min = 0,
			Max = 1,
			Rounding = 2,
			Compact = false,

			Callback = function(Value)
				ESPLibrary:SetTextTransparency(Value)

			end
		})

		ESPSettings:AddSlider('ESPFadeTime', {
			Text = 'Fade Time',
			Default = 0,
			Min = 0,
			Max = 2,
			Rounding = 2,
			Compact = false,

			Callback = function(Value)
				ESPLibrary:SetFadeTime(Value)

			end
		})
		ESPSettings:AddSlider('TextOffset', {
			Text = 'Text Offset',
			Default = 0,
			Min = -3,
			Max = 3,
			Rounding = 1,
			Compact = false,

			Callback = function(Value)
				ESPLibrary.TextOffset = Value

			end
		})
		ESPSettings:AddSlider('Slider5', {
			Text = 'Text Size',
			Default = 20,
			Min = 1,
			Max = 100,
			Rounding = 0,
			Compact = false,

			Callback = function(Value)
				ESPLibrary:SetTextSize(Value)

			end
		})
		ESPSettings:AddSlider('ESPStrokeTransparency', {
			Text = 'Text Outline Transparency',
			Default = 0,
			Min = 0,
			Max = 1,
			Rounding = 2,
			Compact = false,

			Callback = function(Value)
				ESPLibrary:SetTextOutlineTransparency(Value)

			end
		})

		ESPSettings:AddDropdown("ESPFont", { Values = { "Arial", "SourceSans", "Highway", "Fantasy","FredokaOne", "Gotham", "DenkOne", "JosefinSans", "Nunito", "Oswald", "RobotoCondensed", "Sarpanch", "Ubuntu" }, Default = 10, Multi = false, Text = "Text Font", Callback = function(Value) ESPLibrary:SetFont(Value) end})
		ESPSettings:AddDivider()
		ESPSettings:AddToggle('SyncColors', {
			Text = 'Match Colors',
			Default = true, -- Default value (true / false)
			Tooltip = 'Makes all ESP highlights Outline Color match their\n Fill Color.', -- Information shown when you hover over the toggle

			Callback = function(Value)
				ESPLibrary:SetMatchColors(Value)
			end
		})
		ESPLibrary:SetFont(Options.ESPFont.Value)
		ESPSettings:AddToggle('ShowDistance', {
			Text = 'Show Distance',
			Default = false, -- Default value (true / false)
			Tooltip = 'Shows the distance [in studs] that the object\nis away from the Player', -- Information shown when you hover over the toggle

			Callback = function(Value)
				ESPLibrary:SetShowDistance(Value)
			end
		})
		ESPSettings:AddDivider()
		ESPSettings:AddToggle('EnableTracers', {
			Text = 'Enable Tracers',
			Default = false, -- Default value (true / false)
			Tooltip = 'Shows a line on screen that points to the object', -- Information shown when you hover over the toggle

			Callback = function(Value)
				ESPLibrary:SetTracers(Value)
			end
		})
		ESPSettings:AddDropdown("TracerOrigin", {
			Values = {'Bottom','Top','Center','Mouse'},
			Default = 1,
			Multi = false,
			Text = "Tracer Origin",
			Callback = function(Value) 
				ESPLibrary:SetTracerOrigin(Value)
			end
		})






		ExtraVisualsTab:AddToggle("WatermarkToggle",{
			Text = "Enable Watermark",
			Default = false,
			Tooltip = 'Allows you to have Custom Text always visible on the Screen',
			Callback = function(value)
				Watermark.Visible = value
			end,
		})
		ExtraVisualsTab:AddInput('WatermarkText', {
			Default = '',
			Numeric = false, -- true / false, only allows numbers
			Finished = true, -- true / false, only calls callback when you press enter

			Text = 'Watermark Text',
			Tooltip = 'Select the Text for the Watermark', -- Information shown when you hover over the textbox

			Placeholder = 'Enter Text Here', -- placeholder text when the box is empty
			-- MaxLength is also an option which is the max length of the text

			Callback = function(Value)
				Watermark.Text = Value
			end
		})

		LeftGroupBox2:AddButton({
			Text = 'Unlock Golden Rift',
			Func = function()
				local Room = game.Workspace.CurrentRooms:FindFirstChild("100") or game.Workspace.CurrentRooms:FindFirstChild("200")
				if Floor ~= "Fools" and OldHotel == false then
					if Room then
						Room:WaitForChild("Assets").RiftSpawn.Rift.StarCenter.StarRiftPrompt.Enabled = true
						Room:WaitForChild("Assets").RiftSpawn.Rift.StarCenter.ParticlesIn.Core.Enabled = true
						Room:WaitForChild("Assets").RiftSpawn.Rift.StarCenter.ParticlesIn.RainbowShards.Enabled = true
						Room:WaitForChild("Assets").RiftSpawn.Rift.StarCenter.ParticlesIn.Triangles.Enabled = true
						Room:WaitForChild("Assets").RiftSpawn.Rift.StarCenter.ParticlesIn.ZoomParticle.Enabled = true
						Room:WaitForChild("Assets").RiftSpawn.Rift.StarCenter.ParticlesIn.Core.TimeScale = 0.1
						Room:WaitForChild("Assets").RiftSpawn.Rift.StarCenter.ParticlesIn.RainbowShards.TimeScale = 0.1
						Room:WaitForChild("Assets").RiftSpawn.Rift.StarCenter.ParticlesIn.Triangles.TimeScale = 0.1
						Room:WaitForChild("Assets").RiftSpawn.Rift.StarCenter.ParticlesIn.ZoomParticle.TimeScale = 0.1
						Notify({Title = "Golden Rift Bypass",Description = "Successfully unlocked the Golden Rift."})
						Sound()
					else
						Notify({Title = "Golden Rift Bypass",Description = "You must be in room 100 or 200 to do this."})
						Sound()
					end
				else
					Notify({Title = "Golden Rift Bypass",Description = "The Golden Rift is only in the new hotel."})
					Sound()
				end
			end,
			DoubleClick = false,
			Tooltip = 'Unlocks the Golden Rift in the Rift Room [Room 100/200].'
		})
		LeftGroupBox2:AddButton({
			Text = 'Get Glitch Fragment',
			Func = function()
				local active = true

				Notify({Title = "Glitch Fragment Bypass",Description = "Attempting to spawn a glitch fragment.",Reason = "This will take a while."})
				Sound()

				while Player:GetAttribute("GlitchLevel") < 5 do
					task.wait()
					if active == true then
						if active == true then
							Character:PivotTo(CFrame.new(666,666,666) * (Character:GetPivot() + workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 1, 1) * -250))


							task.wait(0.5)	
						end
						if active == true then

							task.wait(0.5)

							if tonumber(Player:GetAttribute("GlitchLevel")) >= 5 then
								active = false
								Notify({Title = "Glitch Fragment Bypass",Description = "A glitch fragment should spawn in the next drawer you open!"})
								Sound()



								break



							end
						end
					end
				end


			end,
			DoubleClick = false,
			Tooltip = 'Repeatedly spawns Glitch in order to spawn a Glitch Fragment.'
		})

		-- Movement
		for i,message in pairs(EntityList) do
			ChatNotifyMessagesTab:AddInput(message .. "ChatNotifyMessage", {
				Default = EntityChatNotifyMessages[message],
				Numeric = false, -- true / false, only allows numbers
				Finished = true, -- true / false, only calls callback when you press enter

				Text = EntityShortNames[message],
				Tooltip = 'The Message to send in the Chat when '..message.. ' spawns.', -- Information shown when you hover over the textbox

				Placeholder = 'Enter Message Here', -- placeholder text when the box is empty
				-- MaxLength is also an option which is the max length of the text

				Callback = function(Value)
					EntityChatNotifyMessages[message] = Value
					local message2 = game:GetService("Chat"):FilterStringForBroadcast(Value, game.Players.LocalPlayer)
					if string.find(message2,"#") then
						Notify({Title = "WARNING",Description = "The entered chat message has been moderated and will not be visible to others.",Reason = "Please enter a different message."})
						Sound()
					end

				end
			})
		end
		if RequireCheck == true then
			VisualsRemove:AddDivider()
			VisualsRemove:AddToggle('NoCameraShake',{
				Default = false,
				Tooltip = 'Prevents the camera from shaking',
				Text = "No Camera Shake"
			})
			VisualsRemove:AddToggle('NoCameraBobbing',{
				Default = false,
				Tooltip = 'Prevents the camera from bobbing',
				Text = "No Camera Bobbing"
			})
		end


		-- UI Settings

		TimeInRun = 0
		if not game.Workspace.CurrentRooms:FindFirstChild("2") then
			game.Workspace.CurrentRooms.ChildAdded:Connect(function(child)
				if child.Name == "2" then
					while task.wait(1) do
						TimeInRun += 1
					end
				end

			end)
		else
			while task.wait(1) do
				TimeInRun += 1
			end
		end

		Player:GetAttributeChangedSignal("GlitchLevel"):Connect(function()
			Player:SetAttribute("CurrentRoom",CurrentRoom)
			if tonumber(Player:GetAttribute("GlitchLevel")) ~= 0 then
				GlitchCounter += 1
			end
		end)




		Library:SetWatermarkVisibility(false)

		-- Example of dynamically-updating watermark with common traits (fps and ping)
		local FrameTimer = tick()
		local FrameCounter = 0;
		local FPS = 60;
		local function formatTime(seconds)
			local hours = math.floor(seconds / 3600) -- Calculate full hours
			seconds = seconds % 3600 -- Remainder after removing hours
			local minutes = math.floor(seconds / 60) -- Calculate full minutes
			seconds = seconds % 60 -- Remainder is the remaining seconds

			-- Format the string
			local formattedTime = string.format("%02d:%02d:%02d", hours, minutes, seconds)
			return formattedTime
		end

		-- Example usage


		local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
			FrameCounter += 1;

			if (tick() - FrameTimer) >= 1 then
				FPS = FrameCounter;
				FrameTimer = tick();
				FrameCounter = 0;
			end;

			Library:SetWatermark((ScriptName..' | FPS: '..FPS..' | Ping: '..game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue()..' ms'))

			Library:SetWatermarkVisibility(false)
		end);

		Library.KeybindFrame.Visible = false; -- todo: add a function for this

		Library:OnUnload(function()
			WatermarkConnection:Disconnect()

			print('Unloaded!')
			Library.Unloaded = true
		end)
		Library.ToggleKeybind = Options.MenuKeybind

		Library.ShowCustomCursor = true
		NotifyType = "Linora"

		task.wait()

		if RequireCheck == false then
			Notify({Title = "WARNING",Description = "Your exploit does not support the require() function.",Reason = "Unsupported features will be hidden."})
			Sound()
		end


		







		SpeedBypass()
		local promptsnum = 1

		local firstenabled = false




		-- Table of all instance names used in the script
		
		local Connection5 = game.Workspace.DescendantAdded:Connect(function(inst)
			task.wait(0.15)
			if not table.find(allowedInstances,inst.Name) and not inst:IsA("ProximityPrompt") and not table.find(Items2,inst.Name) then return end
			inst:SetAttribute("ParentRoom",GetRoom(inst))

			if inst:GetAttribute("ParentRoom") or inst.Parent ~= nil and inst.Parent.Name == "Drops" or inst:IsA("ProximityPrompt") then

				if inst.Name == "KeyObtain"   then
					inst:WaitForChild("Hitbox", 5)
					table.insert(ObjectsTable.Keys,inst)
					if keys == true then
						esp(inst,inst,"Door Key", keycolor,true,false)

					end


				end

				task.wait()


				if inst.Name == "Snare" then
					table.insert(ObjectsTable.Entities,inst)

					inst:WaitForChild("Hitbox",99999)
					if AntiSnare == true then
						inst.Hitbox.CanTouch = false
						if inst.Hitbox:FindFirstChild("TouchInterest") then
							inst.Hitbox.TouchInterest:Destroy()
						end
					end
					if Toggles.EntityESP.Value and RemotesFolder.Name == "RemotesFolder" then
						inst:WaitForChild("Snare"):WaitForChild("Roots").Transparency = 1
						inst:WaitForChild("Snare"):WaitForChild("SnareBase").Transparency = 1
						inst:WaitForChild("Void").Transparency = 0	
						inst:WaitForChild("Void").Color = Color3.fromRGB(76, 67, 55)

						esp(inst,inst,"Snare", entitycolor,true,false)

					end

				end



				if inst.Name == "JeffTheKiller" then
					table.insert(ObjectsTable.Jeffs,inst)
					if Toggles.AntiJeff.Value then
						DisableJeff(inst)
					end



				end

				task.wait()



				if inst:FindFirstChild("HiddenPlayer") then
					RoomName = inst:GetAttribute("ParentRoom")
					local parts = {}
					local parts2 = inst:GetDescendants()
					if inst.Name == "DoubleBed" then
						parts2 = inst.Parent:GetDescendants()
					end
					for i,part in pairs(parts2) do
						if part:IsA("BasePart") then
							if part.Transparency == 0 then
								table.insert(parts,part)
							end
						end

					end




					inst:FindFirstChild("HiddenPlayer"):GetPropertyChangedSignal("Value"):Connect(function()

						if inst:FindFirstChild("HiddenPlayer") then
							if inst.HiddenPlayer.Value == Character and TransparentCloset == true then
								for i,e in pairs(parts) do
									e.Transparency = TransparentClosetNumber

								end

							else
								for i,e in pairs(parts) do
									e.Transparency = 0

								end
							end
						end


					end)


				end

				if inst:IsA("ProximityPrompt") then
					local connections = {}
					RoomName = inst:GetAttribute("ParentRoom")
					local ConnectionCooldown = false
					connections.connection = game["Run Service"].RenderStepped:Connect(function()
						if inst ~= nil and inst:IsDescendantOf(workspace) and ConnectionCooldown == false then
							ConnectionCooldown = true
							if inst:GetAttribute("OldHoldTime") == nil then
								inst:SetAttribute("OldHoldTime",inst.HoldDuration)
							end
							if inst:GetAttribute("PromptClip") == nil then
								inst:SetAttribute("PromptClip",inst.RequiresLineOfSight)
							end
							if interact == true then
								inst.HoldDuration = 0
							else
								inst.HoldDuration = inst:GetAttribute("OldHoldTime")
							end
							if inst:GetAttribute("OldDistance") == nil then
								inst:SetAttribute("OldDistance",inst.MaxActivationDistance)
							end
							if maxinteract == true then
								inst.MaxActivationDistance = inst:GetAttribute("OldDistance") * ReachDistance
							else
								inst.MaxActivationDistance = inst:GetAttribute("OldDistance")
							end
							if ito == true then
								inst.RequiresLineOfSight = false
							else
								inst.RequiresLineOfSight = inst:GetAttribute("PromptClip")
							end


							local ParentObject = inst.Parent

							local ParentDistance = 0
							if ParentObject:IsA("Model") then
								ParentDistance = Player:DistanceFromCharacter(ParentObject.WorldPivot.Position)
							elseif ParentObject:IsA("BasePart") then
								ParentDistance = Player:DistanceFromCharacter(ParentObject.Position)
							end

							if Toggles.AA.Value or Options.AutoInteractKeybind:GetState() == true then

								if inst.Parent.Name ~= "KeyObtainFake" and not string.find(inst.Parent.Parent.Name,"Fake") and not string.find(inst.Name,"RiftPrompt") and inst.Name ~= "HidePrompt" and ParentDistance < inst:GetAttribute("OldDistance") * Options.ReachDistance.Value then

									if inst.Name == "PropPrompt" and not Options.AutoInteractIgnoreList.Value["Paintings"] then

										forcefireproximityprompt(inst)

									elseif inst.Name ~= "PropPrompt" and inst.Name ~= "HintPrompt" then
										if inst.Parent:GetAttribute("Locked") and inst.Parent:GetAttribute("Locked") == true and not Options.AutoInteractIgnoreList.Value["Locked Items"] or inst.Parent:GetAttribute("Locked") and inst.Parent:GetAttribute("Locked") == false or not inst.Parent:GetAttribute("Locked") then
											if inst.Name == "UnlockPrompt" and not Options.AutoInteractIgnoreList.Value["Doors"] or inst.Name ~= "UnlockPrompt"  then
												if inst.Parent.Name == "GoldPile" and Options.AutoInteractIgnoreList.Value["Gold"] then
													inst.Enabled = false

												else
													forcefireproximityprompt(inst)
												end
											end
										end
									end



								end

							end

							task.wait(Options.AutoInteractDelay.Value)
							ConnectionCooldown = false
						end

					end)
					inst.Destroying:Connect(function()
						connections.connection:Disconnect()
					end)



				end
				task.wait()
				if inst.Name == "DoorFake"   then
					if AntiDupe == true then
						DisableDupe(inst)
					end
					if DupeESP == true then
						ApplyDupeESP(inst)

					end



				end
				task.wait()

				if table.find(Items2,inst.Name) and inst:FindFirstChild("Main") then

					table.insert(ObjectsTable.Items,inst)
					if ItemESP == true then
						if inst.Parent.Name == "Drops" then
							ESPLibrary:AddESP({
								Object = inst,
								Text = ItemNames[inst.Name],
								Color = itemcolor
							})
						else

							esp(inst,inst,ItemNames[inst.Name],itemcolor, true, false)
						end
					end
				end	
				task.wait()





				if inst.Name == "Toolshed_Small" then
					table.insert(ObjectsTable.Items,inst)
					if ItemESP == true then
						esp(inst,inst,"Toolshed",itemcolor,true,false)	
					end
				end	



				task.wait()
				if inst.Name == "LibraryHintPaper" then
					table.insert(ObjectsTable.Items,inst)
					if ItemESP == true then
						esp(inst,inst,"Library Paper",itemcolor,true,false)	
					end
				end	
				task.wait()

				if inst.Name == "GiggleCeiling" and Toggles.AntiGiggle.Value then
					inst:WaitForChild("Hitbox", 5).CanTouch = false



				end
				task.wait()

				if inst.Name == "Locker_Small_Locked" then
					table.insert(ObjectsTable.Chests, inst)
					local Text = "Locked Item Locker"

					if Toggles.ChestESP.Value then
						esp(inst,inst,Text, chestcolor,true,false)
					end


				end

				task.wait()
				if inst.Name == "Lava" and Toggles.AntiLava.Value then
					inst.CanTouch = false
				end
				task.wait()
				if inst.Name == "ScaryWall" and Toggles.AntiLava.Value then
					for i,part in pairs(inst:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanTouch = false
							part.CanCollide = false
						end
					end
				end
				task.wait()
				if inst:IsA("Model") and inst.Name == "Figure" and Toggles.GodmodeFigure.Value or inst:IsA("Model") and inst.Name == "FigureRagdoll" and Toggles.GodmodeFigure.Value then
					for i, v in pairs(inst:GetDescendants()) do
						if v:IsA("BasePart") then
							if not v:GetAttribute("Clip") then v:SetAttribute("Clip", v.CanCollide) end

							v.CanTouch = false
							v.CanCollide = true
						end
					end	
				end
				task.wait()
				if inst.Name == "GloomPile" then
					for _, gloomEgg in pairs(inst:GetDescendants()) do
						if gloomEgg.Name == "Egg" then
							gloomEgg.CanTouch = not Toggles.AntiGloomEgg.Value
						end
					end

				end
				task.wait()
				if inst.Name == "DoorFake" or inst.Name == "FakeDoor" then
					if inst:FindFirstChild("Door") then
						table.insert(ObjectsTable.Dupe,inst.Door)
						if AntiDupe == true then
							DisableDupe(inst)
						end
					end
				end
				task.wait()
				if inst.Name == "TriggerEventCollision" then

					if Toggles.BypassSeekFools.Value and Floor == "Fools" or Toggles.BypassSeekBeforePlus.Value and OldHotel == true then

						DeleteSeek(inst)
					end	
				end
				task.wait()
				if inst.Name == "SideroomSpace" and AntiVacuum == true then
					DisableDupe(inst)

				end
				task.wait()
				if inst.Name == "GoldPile"  then
					table.insert(ObjectsTable.Gold,inst)
					if gold == true then
						esp(inst,inst,inst:GetAttribute("GoldValue") .. " Gold", goldcolor,true,false)
					end
					task.wait()

				end
				task.wait()
				if inst.Name == "Ladder" and inst.PrimaryPart ~= nil
				then
					table.insert(ObjectsTable.Ladders,inst)
					if MinesBypass == true then
						esp(inst,inst.PrimaryPart,"Ladder", laddercolor,true,false)
					end
					if MinesBypass == true then








						-- Ladder ESP

					else
						if workspace:FindFirstChild("_internal_mspaint_acbypassprogress") then workspace:FindFirstChild("_internal_mspaint_acbypassprogress"):Destroy() end



						local Bypassed = true
						if Bypassed == true then
							RemotesFolder.ClimbLadder:FireServer()
							Bypassed = false


						end
					end





				end
				task.wait()







				if inst.Name == "ChestBox" and inst:FindFirstChild("Main") or inst.Name == "ChestBoxLocked" and inst:FindFirstChild("Main") then
					table.insert(ObjectsTable.Chests,inst)
					local Text = "Chest"
					if inst:GetAttribute("Locked") == true then
						Text = "Locked Chest"
					end

					if Toggles.ChestESP.Value then
						esp(inst,inst.Main,Text, chestcolor,true,false)
					end


				end

				task.wait()

				if inst.Name == "Chest_Vine" and inst:FindFirstChild("Main") then
					table.insert(ObjectsTable.Chests,inst)
					local Text = "Vine Chest"


					if Toggles.ChestESP.Value then
						esp(inst,inst.Main,Text, chestcolor,true,false)
					end


				end

				task.wait()

				if inst.Name == "Toolbox" or inst.Name == "Toolbox_Locked"then
					table.insert(ObjectsTable.Chests,inst)
					local Text = "Toolbox"
					if inst:GetAttribute("Locked") == true then
						Text = "Locked Toolbox"
					end
					if Toggles.ChestESP.Value then
						esp(inst,inst,Text, chestcolor,true,false)
					end


				end

				task.wait()

				if inst.Name == "Locker_Small_Locked" then
					table.insert(ObjectsTable.Chests, inst)
					local Text = "Locked Item Locker"


					if Toggles.ChestESP.Value then
						esp(inst,inst,Text, chestcolor,true,false)
					end


				end
				task.wait()


				if inst.Name == "Door" and inst:FindFirstChild("ClientOpen") then
					table.insert(ObjectsTable.Doors,inst)
					
					local Connection = RunService.RenderStepped:Connect(function()
						local Event = inst:WaitForChild("ClientOpen")
						if Toggles.DoorReach.Value and Player:DistanceFromCharacter(inst:FindFirstChild("Door").Position) < 10 * Options.DoorReachMultiplier.Value then
							Event:FireServer()
						end
					end)
					
					inst:FindFirstChild("Door").Destroying:Connect(function()
						Connection:Disconnect()
					end)

					if doors == true then

						if inst.Name == "Door" and inst:FindFirstChild("Door") then
							local CurrentRoom = tonumber(inst:GetAttribute("ParentRoom"))-1

							local knob = inst.Door:FindFirstChild("Knob") or inst.Door
							if inst.Parent.Name == "49" and Floor == "Hotel" or inst.Parent.Name == "49" and Floor == "Fools" or inst.Parent.Name == "50" and Floor == "Hotel" or inst.Parent.Name == "50" and Floor == "Fools" then

								if inst.Parent:GetAttribute("RequiresKey") == true then
									esp(inst,inst.Hidden,"Locked Door", doorcolor,true,true)
								else
									esp(inst,inst.Hidden,"Door", doorcolor,true,true)
								end
							else

								if inst.Parent:GetAttribute("RequiresKey") == true then

									esp(inst.Door,knob,"Locked Door", doorcolor,true,true)
								else
									esp(inst.Door,knob,"Door", doorcolor,true,true)
								end
							end

						end


					end


				end
				task.wait()
				if inst.Name == "LeverForGate" and inst:FindFirstChild("Main")

				then
					table.insert(ObjectsTable.Keys,inst)
					if Toggles.EssentialsESP.Value then
						esp(inst,inst,"Gate Lever", keycolor,true,false)
					end


				end
				task.wait()
				if inst.Name == "Wardrobe" and inst:FindFirstChild("Main")
				then
					table.insert(ObjectsTable.Closets,inst)
					if closets == true then
						esp(inst,inst.Main,"Closet", closetcolor,true,false)
					end

				end
				task.wait()
				if inst.Name == "Toolshed" and inst:FindFirstChild("Main")
				then
					table.insert(ObjectsTable.Closets,inst)
					if closets == true then
						esp(inst,inst.Main,"Closet", closetcolor,true,false)	
					end
				end
				task.wait()
				if inst.Name == "Rooms_Locker" and inst:FindFirstChild("Base")


				then
					table.insert(ObjectsTable.Closets,inst)
					if closets == true then
						esp(inst,inst.Base,"Locker", closetcolor,true,false)
					end
				end

				task.wait()
				
				if inst.Name == "Drakobloxxer" then
					for i,part2 in pairs(inst:GetDescendants()) do
						if part2:IsA("BasePart") then
							part2.CanTouch = not Toggles.AntiBloxxer.Value
							part2.CanCollide = not Toggles.AntiBloxxer.Value
						end
					end
				end
				
				task.wait()
				if inst.Name == "Rooms_Locker_Fridge" and inst:FindFirstChild("Base")
				then
					table.insert(ObjectsTable.Closets,inst)
					if closets == true then
						esp(inst,inst.Base,"Fridge Locker", closetcolor,true,false)
					end

				end
				task.wait()
				if inst.Name == "Locker_Large" and inst:FindFirstChild("Main")
				then
					table.insert(ObjectsTable.Closets,inst)
					if closets == true then
						esp(inst,inst.Main,"Locker", closetcolor,true,false)
					end

				end

				if inst.Name == "CircularVent"
				then
					table.insert(ObjectsTable.Closets,inst)
					if closets == true then
						esp(inst,inst,"Pipe", closetcolor,true,false)
					end

				end
				if inst.Name == "Dumpster"
				then
					table.insert(ObjectsTable.Closets,inst)
					if closets == true then
						esp(inst,inst,"Dumpster", closetcolor,true,false)
					end

				end
				task.wait()
				if inst.Name == "MinesAnchor" and inst:FindFirstChild("Sign") then
					table.insert(ObjectsTable.Keys,inst)
					if Toggles.EssentialsESP.Value then
						esp(inst,inst.PrimaryPart,"Anchor".. " "..inst.Sign.TextLabel.Text, keycolor,false,false)
					end
				end
				task.wait()
				if inst.Name == "DoorFake" and AntiDupe == true or inst.Name == "FakeDoor" and AntiDupe == true  then
					DisableDupe(inst)	
				end
				task.wait()
				if inst.Name == "SideroomSpace" then
					table.insert(ObjectsTable.Dupe,inst)
					if AntiVacuum == true then
						DisableDupe(inst)
					end
					if DupeESP == true then
						ApplyDupeESP(inst)
					end
				end
				task.wait()
				if inst.Name == "RetroWardrobe" and inst:FindFirstChild("Main")
				then
					table.insert(ObjectsTable.Closets,inst)
					if closets == true then
						esp(inst,inst.Main,"Closet", closetcolor,true,false)
					end
				end
				task.wait()
				if inst.Name == "Double_Bed" 
				then
					table.insert(ObjectsTable.Closets,inst)
					if closets == true then
						esp(inst,inst,"Double Bed", closetcolor,true,false)	
					end
				end
				task.wait()
				if inst.Name == "Bed" and inst:FindFirstChild("Main")
				then
					table.insert(ObjectsTable.Closets,inst)
					if closets == true then
						esp(inst,inst.Main,"Bed", closetcolor,true,false)	
					end
				end
				task.wait()
				if inst.Name == "Backdoor_Wardrobe" and inst:FindFirstChild("Main")  then
					table.insert(ObjectsTable.Closets,inst)	
					if closets == true then
						esp(inst,inst.Main,"Closet", closetcolor,true,false)
					end

				end
				task.wait()
				if inst.Name == "ElectricalKeyObtain"   then
					table.insert(ObjectsTable.Keys,inst)
					if inst:FindFirstChild("Hitbox") and keys == true then
						if inst.Hitbox:FindFirstChild("Key") then
							esp(inst,inst.Hitbox.Key,"Electrical Key", keycolor,true,false)
						elseif inst.Hitbox:FindFirstChild("KeyHitbox") then
							esp(inst,inst.Hitbox.KeyHitbox,"Electrical Key", keycolor,true,false)
						end
					end
				end
				task.wait()
				if inst.Name == "FuseObtain" then
					table.insert(ObjectsTable.Keys,inst)
					if inst:FindFirstChild("Hitbox") and Toggles.EssentialsESP.Value then

						esp(inst,inst.Hitbox,"Fuse", keycolor,true,false)
						inst:WaitForChild("ModulePrompt"):GetAttributeChangedSignal("Interactions"):Connect(function()
							inst:SetAttribute("ESP",false)
						end)


					end

				end

				task.wait()
				if inst.Name == "Seek_Arm" and AntiSeekObstructions == true then
					if inst.Name == "Seek_Arm" then
						for i,a in pairs(inst.Parent.Parent:GetDescendants()) do
							if a:IsA("BasePart") and a.Parent.Name ~= "Door" then
								a.CanTouch = false
							end
						end
					end

				end
				task.wait()

				if inst.Name == "MinesGenerator"  then
					table.insert(ObjectsTable.Keys,inst)
					if Toggles.EssentialsESP then
						esp(inst,inst:WaitForChild("GeneratorMain"),"Generator", keycolor,true,false)
					end
				end
				task.wait()
				if inst.Name == "GiggleCeiling" then
					table.insert(ObjectsTable.Entities,inst)
					if Toggles.EntityESP.Value then
						esp(inst,inst,"Giggle",entitycolor,true,false)
					end
					if Options.NotifyMonsters.Value["Giggle"] then
						Notify({Title = "ENTITIES",Description = EntityAlliases["Giggle"] .. " has spawned.",Reason = "Make sure not to walk under it!",NotificationType = "WARNING",Image = EntityIcons["Giggle"]})
						Sound()
					end
				end	
				task.wait()
				if inst.Name == "MinesGateButton"  then
					table.insert(ObjectsTable.Keys,inst)
					if Toggles.EssentialsESP.Value then
						esp(inst,inst.MainPart,"Gate Button", keycolor,true,false)
					end


				end
				if inst.Name == "WaterPump"  then
					table.insert(ObjectsTable.Keys,inst)
					if Toggles.EssentialsESP.Value then
						esp(inst,inst.MainPart,"Water Pump", keycolor,true,false)
					end


				end
				task.wait()





				if inst.Name == "GrumbleRig" and inst:FindFirstChild("Root")  then
					table.insert(ObjectsTable.Entities,inst)
					if Toggles.EntityESP.Value then
						esp(inst,inst.Root,"Grumble", entitycolor,false,false)
					end

				end
				task.wait()
				if inst.Name == "LiveHintBook" then
					table.insert(ObjectsTable.Keys,inst)
					if Toggles.EssentialsESP.Value then
						esp(inst,inst.Base,"Book", keycolor,true,false)
					end




				end
				task.wait()
				if inst.Name == "Seek_Arm" or inst.Name == "ChandelierObstruction" then
					if AntiSeekObstructions == true then
						for i,a in pairs(inst:GetDescendants()) do
							if a:IsA("BasePart") then
								a.CanTouch = false
							end
						end
					end

				end	
				task.wait()
				if inst.Name == "FigureRig" and inst:FindFirstChild("Torso") or inst.Name == "Figure" and inst:FindFirstChild("Torso") or inst.Name == "FigureRagdoll" and inst:FindFirstChild("Torso") then
					table.insert(ObjectsTable.Entities,inst)
					Figure = inst
					if Toggles.EntityESP.Value then
						esp(inst,inst.Torso,"Figure", entitycolor,true,false)
					end





				end
				task.wait()
				if inst.Name == "LiveBreakerPolePickup" then
					table.insert(ObjectsTable.Keys,inst)
					if Toggles.EssentialsESP.Value then
						esp(inst,inst.Base,"Breaker", keycolor,true,false)
					end





				end
				task.wait()

				task.wait(0.15)
				if inst.Name == "TimerLever" and inst:FindFirstChild("Main") then

					if inst:FindFirstChild("Main") then
						table.insert(ObjectsTable.Keys,inst)
						if Toggles.Essentials.ESP.Value then
							esp(inst,inst:WaitForChild("Main"),"Time Lever", keycolor,true,false)
							inst.Main.Destroying:Wait()
							inst:SetAttribute("ESP",false)



						end



					end


				end



			end


		end)

		
		local SpeedBypassConnection = Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
			if Humanoid.WalkSpeed > 21 then
				SpeedBypass()
			end
		end)














		for i,inst in pairs(game.Workspace:GetDescendants()) do
			if table.find(allowedInstances,inst.Name) or inst:IsA("ProximityPrompt") or table.find(Items2,inst.Name) or inst:IsDescendantOf(workspace) and inst.Parent.Name == "Drops" then


				inst:SetAttribute("ParentRoom",GetRoom(inst))

				if inst:IsA("ProximityPrompt") then
					local connections = {}
					RoomName = inst:GetAttribute("ParentRoom")
					local ConnectionCooldown = false
					connections.connection = game["Run Service"].RenderStepped:Connect(function()
						if inst ~= nil and inst:IsDescendantOf(workspace) and ConnectionCooldown == false then
							ConnectionCooldown = true
							if inst:GetAttribute("OldHoldTime") == nil then
								inst:SetAttribute("OldHoldTime",inst.HoldDuration)
							end
							if inst:GetAttribute("PromptClip") == nil then
								inst:SetAttribute("PromptClip",inst.RequiresLineOfSight)
							end
							if interact == true then
								inst.HoldDuration = 0
							else
								inst.HoldDuration = inst:GetAttribute("OldHoldTime")
							end
							if inst:GetAttribute("OldDistance") == nil then
								inst:SetAttribute("OldDistance",inst.MaxActivationDistance)
							end
							if maxinteract == true then
								inst.MaxActivationDistance = inst:GetAttribute("OldDistance") * ReachDistance
							else
								inst.MaxActivationDistance = inst:GetAttribute("OldDistance")
							end
							if ito == true then
								inst.RequiresLineOfSight = false
							else
								inst.RequiresLineOfSight = inst:GetAttribute("PromptClip")
							end


							local ParentObject = inst.Parent

							local ParentDistance = 0
							if ParentObject:IsA("Model") then
								ParentDistance = Player:DistanceFromCharacter(ParentObject.WorldPivot.Position)
							elseif ParentObject:IsA("BasePart") then
								ParentDistance = Player:DistanceFromCharacter(ParentObject.Position)
							end

							if Toggles.AA.Value or Options.AutoInteractKeybind:GetState() == true then

								if inst.Parent.Name ~= "KeyObtainFake" and not string.find(inst.Parent.Parent.Name,"Fake") and not string.find(inst.Name,"RiftPrompt") and inst.Name ~= "HidePrompt" and ParentDistance < inst:GetAttribute("OldDistance") *  Options.ReachDistance.Value then

									if inst.Name == "PropPrompt" and not Options.AutoInteractIgnoreList.Value["Paintings"] then

										forcefireproximityprompt(inst)

									elseif inst.Name ~= "PropPrompt" and inst.Name ~= "HintPrompt" then
										if inst.Parent:GetAttribute("Locked") and inst.Parent:GetAttribute("Locked") == true and not Options.AutoInteractIgnoreList.Value["Locked Items"] or inst.Parent:GetAttribute("Locked") and inst.Parent:GetAttribute("Locked") == false or not inst.Parent:GetAttribute("Locked") then
											if inst.Name == "UnlockPrompt" and not Options.AutoInteractIgnoreList.Value["Doors"] or inst.Name ~= "UnlockPrompt"  then
												if inst.Parent.Name == "GoldPile" and Options.AutoInteractIgnoreList.Value["Gold"] then
													inst.Enabled = false

												else
													forcefireproximityprompt(inst)
												end
											end
										end
									end



								end

							end

							task.wait(Options.AutoInteractDelay.Value)
							ConnectionCooldown = false
						end

					end)
					inst.Destroying:Connect(function()
						connections.connection:Disconnect()
					end)




				end

				if inst:GetAttribute("ParentRoom") then


					if inst.Name == "Snare" then
						table.insert(ObjectsTable.Entities,inst)

						
					end


					if inst:FindFirstChild("HiddenPlayer") then
						RoomName = inst:GetAttribute("ParentRoom")
						local parts = {}
						local parts2 = inst:GetDescendants()
						if inst.Name == "DoubleBed" then
							parts2 = inst.Parent:GetDescendants()
						end
						for i,part in pairs(parts2) do
							if part:IsA("BasePart") then
								if part.Transparency == 0 then
									table.insert(parts,part)
								end
							end

						end




						inst:FindFirstChild("HiddenPlayer"):GetPropertyChangedSignal("Value"):Connect(function()

							if inst:FindFirstChild("HiddenPlayer") then
								if inst.HiddenPlayer.Value == Character and TransparentCloset == true then
									for i,e in pairs(parts) do
										e.Transparency = TransparentClosetNumber

									end

								else
									for i,e in pairs(parts) do
										e.Transparency = 0

									end
								end
							end


						end)


					end




					if inst.Name == "DoorFake" and AntiDupe == true or inst.Name == "FakeDoor" and AntiDupe == true  then
						DisableDupe(inst)



					end


					if table.find(Items2,inst.Name) and inst:FindFirstChild("Main") then
						table.insert(ObjectsTable.Items,inst)
						
					end	

					if inst.Name == "Toolshed_Small" then
						table.insert(ObjectsTable.Items,inst)
						end


					if inst.Name == "KeyObtain"   then
						table.insert(ObjectsTable.Keys,inst)

						


					end

					if inst.Name == "LibraryHintPaper" then
						table.insert(ObjectsTable.Items,inst)
						
					end	


					if inst.Name == "GiggleCeiling" and Toggles.AntiGiggle.Value then
						inst:WaitForChild("Hitbox", 5).CanTouch = false



					end

					if inst.Name == "Lava" and Toggles.AntiLava.Value then
						inst.CanTouch = false
					end

					if inst.Name == "ScaryWall" and Toggles.AntiLava.Value then
						for i,part in pairs(inst:GetDescendants()) do
							if part:IsA("BasePart") then
								part.CanTouch = false
								part.CanCollide = false
							end
						end
					end

					if inst:IsA("Model") and inst.Name == "Figure" and Toggles.GodmodeFigure.Value or inst:IsA("Model") and inst.Name == "FigureRagdoll" and Toggles.GodmodeFigure.Value then
						for i, v in pairs(inst:GetDescendants()) do
							if v:IsA("BasePart") then
								if not v:GetAttribute("Clip") then v:SetAttribute("Clip", v.CanCollide) end

								v.CanTouch = false
								v.CanCollide = true
							end
						end	

					end

					if inst.Name == "GloomPile" then
						for _, gloomEgg in pairs(inst:GetDescendants()) do
							if gloomEgg.Name == "Egg" then
								gloomEgg.CanTouch = not Toggles.AntiGloomEgg.Value
							end
						end

					end

					if inst.Name == "DoorFake" and AntiDupe == true or inst.Name == "FakeDoor" and AntiDupe == true  then
						DisableDupe(inst)

					end


					if inst.Name == "Door" and inst:FindFirstChild("ClientOpen") then

						table.insert(ObjectsTable.Doors,inst)
						
						local Connection = RunService.RenderStepped:Connect(function()
							local Event = inst:WaitForChild("ClientOpen")
							if Toggles.DoorReach.Value and Player:DistanceFromCharacter(inst:FindFirstChild("Door").Position) < 10 * Options.DoorReachMultiplier.Value then
								Event:FireServer()
							end
						end)

						inst:FindFirstChild("Door").Destroying:Connect(function()
							Connection:Disconnect()
						end)


					end
					
					if inst.Name == "TriggerEventCollision" then

						if BypassSeek == true then

							DisableSeekFools()
						end	
					end

					if inst.Name == "SideroomSpace" and AntiVacuum == true then
						DisableDupe(inst)

					end

					if inst.Name == "GoldPile" then
						table.insert(ObjectsTable.Gold,inst)
						




					end

					if inst.Name == "Ladder" and inst.PrimaryPart ~= nil
					then
						table.insert(ObjectsTable.Ladders,inst)
						
						if MinesBypass == true then








							-- Ladder ESP

						else
							if workspace:FindFirstChild("_internal_mspaint_acbypassprogress") then workspace:FindFirstChild("_internal_mspaint_acbypassprogress"):Destroy() end



							local Bypassed = true
							if Bypassed == true then
								RemotesFolder.ClimbLadder:FireServer()
								Bypassed = false


							end
						end





					end








					if inst.Name == "ChestBox" and inst:FindFirstChild("Main") or inst.Name == "ChestBoxLocked" and inst:FindFirstChild("Main") then
						table.insert(ObjectsTable.Chests,inst)
						


					end

					if inst.Name == "Chest_Vine" and inst:FindFirstChild("Main") then
						table.insert(ObjectsTable.Chests,inst)
						


					end

					if inst.Name == "Toolbox" or inst.Name == "Toolbox_Locked"then
						table.insert(ObjectsTable.Chests,inst)
						


					end

					if inst.Name == "Locker_Small_Locked" then
						table.insert(ObjectsTable.Chests, inst)
						


					end




					if inst.Name == "LeverForGate" and inst:FindFirstChild("Main")
					then
						table.insert(ObjectsTable.Keys,inst)

						


					end





					if inst.Name == "Wardrobe" and inst:FindFirstChild("Main")
					then
						table.insert(ObjectsTable.Closets,inst)
						

					end
					if inst.Name == "DoubleBed"
					then
						table.insert(ObjectsTable.Closets,inst)
						

					end

					if inst.Name == "Toolshed" and inst:FindFirstChild("Main")
					then
						table.insert(ObjectsTable.Closets,inst)
						
					end

					if inst.Name == "Rooms_Locker" and inst:FindFirstChild("Base")


					then
						table.insert(ObjectsTable.Closets,inst)
						
					end

					if inst.Name == "Rooms_Locker_Fridge" and inst:FindFirstChild("Base")
					then
						table.insert(ObjectsTable.Closets,inst)
						

					end

					if inst.Name == "Locker_Large" and inst:FindFirstChild("Main")
					then
						table.insert(ObjectsTable.Closets,inst)
					

					end

					if inst.Name == "MinesAnchor" and inst:FindFirstChild("Sign") then
						table.insert(ObjectsTable.Keys,inst)
						
					end

					if inst.Name == "DoorFake" and AntiDupe == true or inst.Name == "FakeDoor" and AntiDupe == true  then
						DisableDupe(inst)	
					end

					if inst.Name == "SideroomSpace" then
						table.insert(ObjectsTable.Dupe,inst)
						if AntiVacuum == true then
							DisableDupe(inst)
						end
						if DupeESP == true then
							ApplyDupeESP(inst)
						end
					end

					if inst.Name == "RetroWardrobe" and inst:FindFirstChild("Main")
					then
						table.insert(ObjectsTable.Closets,inst)
						
					end

					if inst.Name == "Bed" and inst:FindFirstChild("Main")
					then
						table.insert(ObjectsTable.Closets,inst)
						
					end

					if inst.Name == "Backdoor_Wardrobe" and inst:FindFirstChild("Main")  then
						table.insert(ObjectsTable.Closets,inst)	
						

					end

					if inst.Name == "ElectricalKeyObtain"   then
						table.insert(ObjectsTable.Keys,inst)
						
					end

					if inst.Name == "FuseObtain" then
						table.insert(ObjectsTable.Keys,inst)
						

					end

					if inst.Name == "Seek_Arm" and AntiSeekObstructions == true then
						if inst.Name == "Seek_Arm" then
							for i,a in pairs(inst.Parent.Parent:GetDescendants()) do
								if a:IsA("BasePart") and a.Parent.Name ~= "Door" then
									a.CanTouch = false
								end
							end
						end

					end



					if inst.Name == "CircularVent"
					then
						table.insert(ObjectsTable.Closets,inst)
						

					end

					if inst.Name == "Double_Bed" 
					then
						table.insert(ObjectsTable.Closets,inst)
						
					end

					if inst.Name == "Dumpster"
					then
						table.insert(ObjectsTable.Closets,inst)
						

					end

					if inst.Name == "MinesGenerator"  then
						table.insert(ObjectsTable.Keys,inst)
						
					end
					if inst.Name == "WaterPump"  then
						table.insert(ObjectsTable.Keys,inst)

					end

					if inst.Name == "GiggleCeiling" then
						table.insert(ObjectsTable.Entities,inst)
						
						if Options.NotifyMonsters.Value["Giggle"] then
							Notify({Title = "ENTITIES",Description = EntityAlliases["Giggle"] .. " has spawned.",Reason = "Make sure not to walk under it!",NotificationType = "WARNING",Image = EntityIcons["Giggle"]})
							Sound()
						end
					end	

					if inst.Name == "MinesGateButton"  then
						table.insert(ObjectsTable.Keys,inst)
						


					end





					if inst.Name == "GrumbleRig" and inst:FindFirstChild("Root")  then
						table.insert(ObjectsTable.Entities,inst)
						

					end

					if inst.Name == "LiveHintBook" then
						table.insert(ObjectsTable.Keys,inst)
						




					end

					if inst.Name == "Seek_Arm" or inst.Name == "ChandelierObstruction" then
						if AntiSeekObstructions == true then
							for i,a in pairs(inst:GetDescendants()) do
								if a:IsA("BasePart") then
									a.CanTouch = false
								end
							end
						end

					end	

					if inst.Name == "FigureRig" and inst:FindFirstChild("Torso") or inst.Name == "Figure" and inst:FindFirstChild("Torso") or inst.Name == "FigureRagdoll" and inst:FindFirstChild("Torso") then
						table.insert(ObjectsTable.Entities,inst)
						Figure = inst
						





					end

					if inst.Name == "TimerLever" and inst:FindFirstChild("Main") then
						table.insert(ObjectsTable.Keys,inst)

						


					end

					if inst.Name == "LiveBreakerPolePickup" then
						table.insert(ObjectsTable.Keys,inst)
						





					end

					



				end

			end

		end

		
		local SpeedBypassConnection = Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
			if Humanoid.WalkSpeed > 21 then
				SpeedBypass()
			end
		end)










		local CharacterInstanceAddedConnection = Character.DescendantAdded:Connect(function(inst)
			if inst:IsA("Sound") and inst.Name == "Sound" then
				inst.Volume = (Toggles.RemoveFootstepSounds.Value and 0 or inst.Volume)
			end	
		end)


	








		local count = 0
		local active1 = true

		
for i,NewPlayer in pairs(Players:GetPlayers()) do
			local inst = NewPlayer.Character
			if inst ~= Character then
				table.insert(ObjectsTable.Players, inst)
				
			end
end
		
		
		
		workspace.ChildAdded:Connect(function(child)
			local inst = child
			if tonumber(child.Name) then
			CurrentRoom = (tonumber(child.Name) - 1)
			end
			if child:GetAttribute("RawName") and string.find(child:GetAttribute("RawName"), "Halt") or child:GetAttribute("Shade") then
				if Options.ChatNotifyMonsters.Value["Halt"] then
					ChatNotify(EntityChatNotifyMessages["Halt"])
				end
				if Options.NotifyMonsters.Value["Halt"] then
					Notify({Title = "ENTITIES",Description = EntityAlliases["Halt"] .. " will spawn in the next room.",NotificationType = "WARNING",Image = EntityIcons["Halt"]})
					Sound()

				end
				game.Workspace.CurrentRooms.ChildAdded:Wait()
				EntityCounter += 1
			end
			
			if child.Name == "51" then
				Player:SetAttribute("CurrentRoom","50")
				CurrentRoom = 50
			end
			if inst.Name == "JeffTheKiller" then
				if Options.NotifyMonsters.Value["Jeff The Killer"] then
					Notify({Title = "ENTITIES",Description = EntityAlliases["Jeff"] .. " spawned.",NotificationType = "WARNING",Time = inst,Image = EntityIcons["Jeff"]})
					Sound()
					if Options.ChatNotifyMonsters.Value["Jeff The Killer"] then
						ChatNotify(EntityChatNotifyMessages["Jeff"])
					end
				end

				if AntiJeff == true then
					DisableJeff(inst)
				end
			end
			if inst.Name == "GloombatSwarm" then
				EntityCounter += 1
				if Options.ChatNotifyMonsters.Value["Gloombat Swarm"] then
					ChatNotify(EntityChatNotifyMessages["GloombatSwarm"])
				end
				if Options.NotifyMonsters.Value["Gloombat Swarm"] then
					Notify({Title = "ENTITIES",Description = "A "..EntityAlliases["Gloombats"].." has spawned.",Reason = "Turn off lights for the next few rooms.",NotificationType = "WARNING",Time = inst,Image = EntityIcons["GloombatSwarm"]})
					Sound()

				end
			end


			

			if inst.Name == "BananaPeel" then
				task.wait(0.1)
				inst:SetAttribute("ParentRoom",tostring(CurrentRoom+1))
				if Toggles.AntiBananaPeel.Value then
					inst.CanTouch = false
					inst:GetPropertyChangedSignal("CanTouch"):Connect(function()
						if inst.CanTouch == true then
							inst.CanTouch = false
						end
					end)
				end





				if Toggles.BananaESP.Value
				then

					esp(inst,inst,"Banana", bananapeelcolor,true,false)	

				end

			end
			if child.Name == "JeffTheKiller" and Toggles.AntiJeff.Value then
				DisableJeff(child)	
			end
			

			if child.Name == "100" then
				Player:SetAttribute("CurrentRoom","100")
			end


			if CurrentRoom == 50 or CurrentRoom == 100 then
				if Toggles.GodmodeFigure.Value or Toggles.GodmodeFigure2.Value then
					for _, figure in pairs(workspace.CurrentRooms:GetDescendants()) do
						if figure:IsA("Model") and figure.Name == "Figure" or figure:IsA("Model") and figure.Name == "FigureRagdoll"  then

							for i, v in pairs(figure:GetDescendants()) do
								if v:IsA("BasePart") then
									v:SetNetworkOwner(Player)
									if OldHotel == true then
										game:GetService("TweenService"):Create(v,TweenInfo.new(5),{CFrame = CFrame.new(99999,99999,99999)}):Play()
									end
									if not v:GetAttribute("Clip") then v:SetAttribute("Clip", v.CanCollide) end

									v.CanTouch = false
									v.CanCollide = false
								end
							end


						end

					end
				end
			end






		end)



		local SCCooldown = false
		local SpeedConnection = RunService.RenderStepped:Connect(function()

			if Character ~= nil then
				if SCCooldown == false then
					SCCooldown = true
					local CrouchNerf = 0




					if Collision and Collision.CollisionGroup == "PlayerCrouching" then
						CrouchNerf = 5
					else
						CrouchNerf = 0

					end
					if SpeedBoostEnabled == true then
						RunService.Heartbeat:Wait()
						if not CollisionClone or Character:GetAttribute("SpeedBoostExtra") == nil then return end
						local num = 15 + (Character:GetAttribute("SpeedBoost") + Character:GetAttribute("SpeedBoostBehind") + Character:GetAttribute("SpeedBoostExtra") + SpeedBoost - CrouchNerf)
						Humanoid.WalkSpeed = num

					end

					task.wait()
					SCCooldown = false
				end
			end
		end)



		local FigureConnection = RunService.RenderStepped:Connect(function()
			if Figure ~= nil and CollisionClone ~= nil then
				if Toggles.GodmodeFigure.Value then
					if CurrentRoom == 50 or CurrentRoom == 100 then

						Collision.CanTouch = false


					else
						Collision.CanTouch = true
					end

				else
					Collision.CanTouch = true
				end
			end
		end)

		local Humanoid = Character:WaitForChild("Humanoid")
		Humanoid.Died:Connect(function()
			
			if Floor == "Fools" and Toggles.InfiniteRevivesFools.Value or OldHotel == true or Toggles.InfiniteRevivesBeforePlus.Value then
					task.wait(1)
					RemotesFolder.Revive:FireServer()
					task.wait(3)
					if CollisionClone == nil then
						RemotesFolder.Revive:FireServer()
					end
				end
			
		end)
		Player.CharacterAdded:Connect(function(Character)
			local Humanoid = Character:FindFirstChild("Humanoid")
			if Humanoid then
			Humanoid.Died:Connect(function()
				if Floor == "Fools" and Toggles.InfiniteRevivesFools.Value or OldHotel == true or Toggles.InfiniteRevivesBeforePlus.Value then
					task.wait(1)
					RemotesFolder.Revive:FireServer()
					task.wait(3)
						if CollisionClone == nil then
							RemotesFolder.Revive:FireServer()
						end
				end
			end)
			end
		end)


		local lb = game.Lighting.Ambient
		local solved = false


		local AnticheatBypassConnection = Character:GetAttributeChangedSignal("Climbing"):Connect(function()
			if MinesBypass == true  then
				if Character:GetAttribute("Climbing") == true then
					task.wait()
					Character:SetAttribute("Climbing",false)

					Notify({Title = "Anticheat Bypass", Description = "Successfully bypassed the Anticheat!", Reason = "It will only last until the next cutscene!"})
					MinesAnticheatBypassActive = true
					Sound()
				
				end
			end
		end)
		local AutoLibrarySolved = false
		local AutoPadlockConnection = game["Run Service"].RenderStepped:Connect(function()
			local room = game.Workspace.CurrentRooms:FindFirstChild("50")
			if AutoLibrary == true and AutoLibrarySolved == false and room and room.Door:FindFirstChild("Padlock") then
				local child = Character:FindFirstChild("LibraryHintPaper") or game.Players.LocalPlayer.Backpack:FindFirstChild("LibraryHintPaper") or Character:FindFirstChild("LibraryHintPaperHard") or game.Players.LocalPlayer.Backpack:FindFirstChild("LibraryHintPaperHard")
				if child ~= nil then
					local code = GetPadlockCode(child)
					local output, count = string.gsub(code, "_", "_")
					local padlock = workspace:FindFirstChild("Padlock", true)
					local part
					for i,e in pairs(padlock:GetDescendants()) do
						if e:IsA("BasePart") then
							part = e
						end
					end

					if solved == false and not tonumber(code) then
						if string.len(output) < 2 then
							if Floor == "Fools" then
								output = "__________"	
							else
								output = "_____"
							end
						end

					end				
					if tonumber(code) and string.len(output) == 5 and solved == false and Floor ~= "Fools" or tonumber(code) and string.len(output) == 10 and Floor == "Fools" and solved == false then
						AutoLibrarySolved = true
						solved = true
						Notify({Title = "Auto Library",Description = "The Library code is '".. output.."'.",Time = room.Door.Padlock})
						Sound()

						local r = game["Run Service"].RenderStepped:Connect(function()
							if tonumber(code) and game.Players.LocalPlayer:DistanceFromCharacter(part.Position) <= AutoLibraryUnlockDistance and Toggles.AutoUnlockPadlock.Value then

								RemotesFolder.PL:FireServer(code)
							end
						end)
						game.Workspace.CurrentRooms.ChildAdded:Wait()
						r:Disconnect()


					end
				end

			end


		end)





		local GoldConnection = game:GetService("Players").LocalPlayer.PlayerGui.PermUI.ChildAdded:Connect(function(inst)
			if inst.Name == "GoldLive" and Toggles.RemoveGoldVisual.Value then
				inst:Destroy()
			end
		end)


		local ncrp = RaycastParams.new()
		ncrp.FilterType = Enum.RaycastFilterType.Exclude
		local Bypassing = true
		local acmcooldown = false
		noclipbypassing = false
		AvoidingFigure = false
		if RequireCheck == true then
			Toggles.NoCameraBobbing:OnChanged(function()

				Main_Game.spring.Speed = (Toggles.NoCameraBobbing.Value and 9e9 or 8)

			end)
		end

		for i,Obj2 in pairs(Character:GetDescendants()) do
			
				if Obj2:IsA("BasePart") and Obj2.Name ~= "Collision" then
					if Floor == "Fools" or OldHotel == true then
						Obj2.CanTouch = not AvoidingFigure
					end
				end
			

			if Obj2.Name == "Handle"and string.find(Obj2.Parent.ClassName, "Accessory") or Obj2.Name == "Head" then
				if Obj2:IsA("BasePart") then
			
					local Connection = RunService.RenderStepped:Connect(function()
						if Obj2 then
							Obj2.Transparency = (thirdp and 0 or 1)
							Obj2.LocalTransparencyModifier = (thirdp and 0 or 1)
						end
					end)
					Obj2.Destroying:Connect(function()
						Connection:Disconnect()
					end)
				end
			end
		end
		
		local MainConnectionCooldown = false

		local MainConnection = game["Run Service"].RenderStepped:Connect(function()
			if not CollisionClone or Character:GetAttribute("SpeedBoostExtra") == nil or game.Workspace.CurrentCamera.CameraSubject ~= Humanoid then return end
			if AntiFH == true then
				if RemotesFolder:FindFirstChild("Crouch") then
					RemotesFolder.Crouch:FireServer(true)
				end	
			else
				if RemotesFolder:FindFirstChild("Crouch") then
					RemotesFolder.Crouch:FireServer(Collision.CollisionGroup == "PlayerCrouching" and true or false)
				end
			end

			local function u2()



				if Character:WaitForChild("Humanoid").MoveDirection == Vector3.new(0, 0, 0) then

					return Character:WaitForChild("Humanoid").MoveDirection

				else


				end
				local v12 = (game.Workspace.CurrentCamera.CFrame * CFrame.new((CFrame.new(game.Workspace.CurrentCamera.CFrame.p, game.Workspace.CurrentCamera.CFrame.p + Vector3.new(game.Workspace.CurrentCamera.CFrame.lookVector.x, 0, game.Workspace.CurrentCamera.CFrame.lookVector.z)):VectorToObjectSpace(Humanoid.MoveDirection)))).p - game.Workspace.CurrentCamera.CFrame.p;
				if v12 == Vector3.new() then
					return v12
				end
				return v12.unit
			end





			if Toggles.ForwardTeleport.Value or Options.ForwardTeleportKey:GetState() == true then
				bypassActive = true
			end
			if not Toggles.ForwardTeleport.Value and Options.ForwardTeleportKey:GetState() == false then
				bypassActive = false
			end


			

			if thirdp == true then


				game.Workspace.CurrentCamera.CFrame = game.Workspace.CurrentCamera.CFrame * CFrame.new(ThirdPersonX,ThirdPersonY,ThirdPersonZ)
			end
			if EnableFOV == true then	

				if RequireCheck == true then
					Main_Game.fovtarget = fov
					if Humanoid.WalkSpeed > 15 + SpeedBoost then
						game.Workspace.CurrentCamera.FieldOfView = fov
					end
				else
					if game.Workspace.CurrentCamera.FieldOfView == fov or Floor == "Fools" or OldHotel == true then
						FOVTweenTime = 0
					end
					if FOVTweenTime == 0 then

						game.Workspace.CurrentCamera.FieldOfView = fov
					end
				end


			end
			if workspace:FindFirstChild("Eyes") and AntiEyes == true then
				if Floor == "Fools" or OldHotel == true then
					RemotesFolder.MotorReplication:FireServer(0, -650, 0, false)
				end
			end


			if game.Workspace:FindFirstChild("Eyes") and Floor ~= "Fools" and OldHotel == false and AntiEyes == true or game.Workspace:FindFirstChild("BackdoorLookman") and AntiLookman == true then



				RemotesFolder.MotorReplication:FireServer(-650)


			end

			if fb == true  then
				local lighting = game:GetService("Lighting")
				game:GetService("TweenService"):Create(lighting,TweenInfo.new(1,Enum.EasingStyle.Exponential),{Ambient = Ambience}):Play()
			elseif Floor == "Fools" or OldHotel == true then
				local lighting = game:GetService("Lighting")
				game:GetService("TweenService"):Create(lighting,TweenInfo.new(1,Enum.EasingStyle.Exponential),{Ambient = OriginalAmbience}):Play()

			end
			if fly.enabled == true then
				local velocity = Vector3.zero

				velocity = u2()


				fly.flyBody.Velocity = velocity * (flyspeed * 10)



			end



			if Toggles.AutoEatCandies and Toggles.AutoEatCandies.Value then
				if Player.Backpack:FindFirstChild("Candy") then
					local CharacterCandy = Character:FindFirstChild("Candy")
					local Candy = Player.Backpack:FindFirstChild("Candy")
					if CharacterCandy then
						if CharacterCandy:GetAttribute("CandyID") == "CandyCurious" and Options.AutoEatCandiesIgnoreList.Value["Volatile Starlight"] or CharacterCandy:GetAttribute("CandyID") == "CandyRed" and Options.AutoEatCandiesIgnoreList.Value["Can-Die"] then
							if Candy:GetAttribute("CandyID") == "CandyCurious" and not Options.AutoEatCandiesIgnoreList.Value["Volatile Starlight"] or Candy:GetAttribute("CandyID") == "CandyRed" and not Options.AutoEatCandiesIgnoreList.Value["Can-Die"] then
								Humanoid:EquipTool(Candy)
							elseif Candy:GetAttribute("CandyID") ~= "CandyCurious" and Candy:GetAttribute("CandyID") ~= "CandyRed" then
								Humanoid:EquipTool(Candy)
							end
						end
					elseif not CharacterCandy then
						if Candy:GetAttribute("CandyID") == "CandyCurious" and not Options.AutoEatCandiesIgnoreList.Value["Volatile Starlight"] or Candy:GetAttribute("CandyID") == "CandyRed" and not Options.AutoEatCandiesIgnoreList.Value["Can-Die"] then
							Humanoid:EquipTool(Candy)
						elseif Candy:GetAttribute("CandyID") ~= "CandyCurious" and Candy:GetAttribute("CandyID") ~= "CandyRed" then
							Humanoid:EquipTool(Candy)
						else
							Candy.Name = "Candy_"
							task.wait(1)
							Candy.Name = "Candy"
						end			

					end
				end
				if Character:FindFirstChild("Candy") then
					local Candy = Character:FindFirstChild("Candy")
					if Candy then
						if Candy:GetAttribute("CandyID") == "CandyCurious" and not Options.AutoEatCandiesIgnoreList.Value["Volatile Starlight"] or Candy:GetAttribute("CandyID") == "CandyRed" and not Options.AutoEatCandiesIgnoreList.Value["Can-Die"] then
							Candy:WaitForChild("Remote"):FireServer()
						elseif Candy:GetAttribute("CandyID") ~= "CandyCurious" and Candy:GetAttribute("CandyID") ~= "CandyRed" then
							Candy:WaitForChild("Remote"):FireServer()
						end
					end
				end
			end



			if RemoveHideVignette == true and OldHotel == false then
				if Player.PlayerGui:FindFirstChild("MainUI") then
					Player.PlayerGui.MainUI.MainFrame.HideVignette.Visible = false
				end
			end


			Humanoid.JumpHeight = JumpBoost
			if godmode == true then
				if CollisionClone2 then
					if Floor ~= "Fools" and OldHotel == false then 



						if AvoidingFigure == false then
							RemotesFolder.Crouch:FireServer(true)

							CollisionClone.CanCollide = false	
							Collision.Position = HumanoidRootPart.Position-Vector3.new(0,GodmodeOffset,0)

							CollisionClone.Position = HumanoidRootPart.Position
						end
					end
				else








				end
			else

				CollisionClone2.Position = HumanoidRootPart.Position

			end

			CollisionClone2.Position = HumanoidRootPart.Position



			if Floor == "Fools" or OldHotel == true then
				if game.Workspace:FindFirstChild("AmbushMoving") and godmode == true or AvoidingFigure == true or game.Workspace:FindFirstChild("RushMoving") and godmode == true then

					Collision.Position = HumanoidRootPart.Position + Vector3.new(0, 250, 0)
					CollisionClone.Position = Collision.Position - Vector3.new(0, 250, 0)
				else
					CollisionClone2.Position = HumanoidRootPart.Position


					CollisionClone.Position = HumanoidRootPart.Position+Vector3.new(0,GodmodeOffset, 0)
					Collision.Position = HumanoidRootPart.Position

				end
			elseif godmode == false and AvoidingFigure == false then

				CollisionClone2.Position = HumanoidRootPart.Position


				CollisionClone.Position = HumanoidRootPart.Position+Vector3.new(0,GodmodeOffset,0)
				Collision.Position = HumanoidRootPart.Position
			end
			if godmode == false and AvoidingFigure == false then
				CollisionClone2.Position = HumanoidRootPart.Position


				CollisionClone.Position = HumanoidRootPart.Position+Vector3.new(0,GodmodeOffset,0)
				Collision.Position = HumanoidRootPart.Position
			end

			




			onStep()



			local ray = Ray.new(HumanoidRootPart.CFrame.Position, HumanoidRootPart.CFrame.LookVector * 0.25)
			local part = workspace:FindPartOnRay(ray)

			if Toggles.AutoRoomsIgnoreA60 and Toggles.AutoRoomsIgnoreA60.Value and Floor == "Rooms" then
				Toggles.Toggle250:SetValue(true)
			end









			if  Toggles.ACM.Value and Floor ~= "Fools" and OldHotel == false and MinesAnticheatBypassActive == false   or Options.AnticheatManipulation:GetState() == true and Floor ~= "Fools" and OldHotel == false and MinesAnticheatBypassActive == false then
				if acmcooldown == false then

					Character:PivotTo(Character:GetPivot()*CFrame.new(0,0,2500))

					Humanoid.HipHeight = 0

				end

			else
				Humanoid.HipHeight = 3







			end





			if RequireCheck == true then
				if Toggles.NoCameraShake.Value then
					Main_Game.csgo = CFrame.new()
				end
				
			end



			if Toggles.GodmodeFigure.Value and AvoidingFigure == true and Floor ~= "Fools" and OldHotel == false then
				RemotesFolder.Crouch:FireServer(true)

				CollisionClone.CanCollide = false	
				Collision.Position = HumanoidRootPart.Position+(CurrentRoom == 50 and Vector3.new(0,20,0) or Vector3.new(0,13.5,0))
				CollisionClone.Position = HumanoidRootPart.Position	
			end

			if Toggles.GodmodeFigure.Value then
				if game.Workspace.CurrentRooms:FindFirstChild(Player:GetAttribute("CurrentRoom")):FindFirstChild("FigureSetup") then
					local FigureSetup = game.Workspace.CurrentRooms:FindFirstChild(Player:GetAttribute("CurrentRoom")):WaitForChild("FigureSetup")					
					local Figure = Floor == "Fools" and FigureSetup.FigureRagdoll or OldHotel == true and FigureSetup:FindFirstChild("FigureRagdoll") or FigureSetup:FindFirstChild("FigureRig")  
					if Player:DistanceFromCharacter(Figure.Torso.Position) < 20 then
						AvoidingFigure = true
					else

						AvoidingFigure = false
					end
				elseif game.Workspace.CurrentRooms:FindFirstChild(Player:GetAttribute("CurrentRoom")):FindFirstChild("FigureRig") then
					local Figure = game.Workspace.CurrentRooms:FindFirstChild(Player:GetAttribute("CurrentRoom")):WaitForChild("FigureRig")
					if Player:DistanceFromCharacter(Figure.Torso.Position) < 20 then
						AvoidingFigure = true
					else

						AvoidingFigure = false
					end

				else

					AvoidingFigure = false
				end

			end

		end)	

		local AutoPaintingsCooldown = false
		local AutoPaintingsConnection = RunService.RenderStepped:Connect(function()
			if AutoPaintingsCooldown == false then


				local Prop = Character:FindFirstChild("Prop")
				local PlacingDownCorrectly = false
				local Paintings = workspace:WaitForChild("CurrentRooms"):FindFirstChild(Player:GetAttribute("CurrentRoom")):WaitForChild("Assets"):FindFirstChild("Paintings")
				if not Paintings or not Toggles.AutoPaintings.Value then return end
				AutoPaintingsCooldown = true
				for i,Slot in pairs(Paintings:WaitForChild("Slots"):GetChildren()) do




					local Empty = false
					local Prompt = Slot:WaitForChild("PropPrompt")
					local SlotProp = Slot:FindFirstChild("Prop")

					if Player:DistanceFromCharacter(Slot.Position) <= Prompt.MaxActivationDistance then




						if Prop and Slot:GetAttribute("Hint") == Prop:GetAttribute("Hint") or not Prop and SlotProp and Slot:GetAttribute("Hint") ~= SlotProp:GetAttribute("Hint")  then	

							forcefireproximityprompt(Prompt)
						end








					end







				end

				task.wait(0.15)

				for i,Slot in pairs(Paintings:WaitForChild("Slots"):GetChildren()) do




					local Empty = false
					local Prompt = Slot:WaitForChild("PropPrompt")
					local SlotProp = Slot:FindFirstChild("Prop")

					if Player:DistanceFromCharacter(Slot.Position) <= Prompt.MaxActivationDistance then








						if SlotProp and Slot:GetAttribute("Hint") ~= SlotProp:GetAttribute("Hint") and Player:DistanceFromCharacter(Slot.Position) <= Prompt.MaxActivationDistance and not Prop then

							forcefireproximityprompt(Prompt)
						end




					end







				end

				task.wait(0.15)
				AutoPaintingsCooldown = false
			end
		end)

		local CameraRoomConnection = RunService.RenderStepped:Connect(function()
			if workspace.CurrentCamera.CameraSubject ~= Humanoid and workspace.CurrentCamera.CameraSubject then
				local ViewPlayer = Players:GetPlayerFromCharacter(workspace.CurrentCamera.CameraSubject.Parent)
				Player:SetAttribute("CurrentRoom", (ViewPlayer and ViewPlayer:GetAttribute("CurrentRoom") or Player:GetAttribute("CurrentRoom")))
			end
		end)

		game.Players.LocalPlayer.CharacterAdded:Connect(function(NewCharacter)

			CollisionClone:Destroy()
			CollisionClone2:Destroy()
			task.wait(0.25)
			Character = NewCharacter


			Collision = NewCharacter:WaitForChild("Collision")	
			MainWeld = Collision:WaitForChild("Weld")
			Collision.Position = HumanoidRootPart.Position

			CollisionClone = Collision:Clone()
			CollisionClone.Parent = NewCharacter
			CollisionClone.Name = ESPLibrary:GenerateRandomString()
			CollisionClone.Massless = true
			CollisionClone.CanQuery = false
			CollisionClone.CanCollide = false
			CollisionClone.Position = HumanoidRootPart.Position + Vector3.new(0,2.5,3)


			CollisionClone2 = Collision:Clone()
			CollisionClone2.Parent = NewCharacter
			CollisionClone2.Name = ESPLibrary:GenerateRandomString()
			CollisionClone2.Massless = true
			CollisionClone2.CanQuery = false
			CollisionClone2.CanCollide = false
			CollisionClone2.Position = HumanoidRootPart.Position


			Humanoid = NewCharacter:WaitForChild("Humanoid")
			HumanoidRootPart = NewCharacter:WaitForChild("HumanoidRootPart")
			CollisionCrouch = Collision:FindFirstChild("CollisionCrouch") or nil



			if NewCharacter:GetAttribute("SpeedBoost") == nil then
				NewCharacter:SetAttribute("SpeedBoost",0)
			end
			if NewCharacter:GetAttribute("SpeedBoostExtra") == nil then
				NewCharacter:SetAttribute("SpeedBoostExtra",0)
			end
			if NewCharacter:GetAttribute("SpeedBoostBehind") == nil then
				NewCharacter:SetAttribute("SpeedBoostBehind",0)
			end
			if CollisionClone:FindFirstChild("CollisionCrouch") then
				CollisionClone.CollisionCrouch:Destroy()
			end
			if CollisionClone2:FindFirstChild("CollisionCrouch") then
				CollisionClone2.CollisionCrouch:Destroy()
			end	
			
			if flytoggle == true then
				fly.flyBody.Parent = Collision
			end

			RunService.Heartbeat:Wait()
			
			for i,part in pairs(Character:GetDescendants()) do
				if part:IsA("BasePart") then
					if part ~= CollisionCrouch and part ~= Collision and part ~= CollisionClone and part ~= CollisionClone2 then

						part.CanCollide = false
						part:GetPropertyChangedSignal("CanCollide"):Connect(function()
							part.CanCollide = false
						end)

					end
				end
			end
			
			for i,Obj2 in pairs(Character:GetDescendants()) do

				if Obj2:IsA("BasePart") and Obj2.Name ~= "Collision" then
					if Floor == "Fools" or OldHotel == true then
						Obj2.CanTouch = not AvoidingFigure
					end
				end


				if Obj2.Name == "Handle"and string.find(Obj2.Parent.ClassName, "Accessory") or Obj2.Name == "Head" then
					if Obj2:IsA("BasePart") then

						local Connection = RunService.RenderStepped:Connect(function()
							if Obj2 then
								Obj2.Transparency = (thirdp and 0 or 1)
								Obj2.LocalTransparencyModifier = (thirdp and 0 or 1)
							end
						end)
						Obj2.Destroying:Connect(function()
							Connection:Disconnect()
						end)
					end
				end
			end
			
			if RequireCheck == true then
				Main_Game = game.Players.LocalPlayer.PlayerGui:WaitForChild("MainUI").Initiator.Main_Game
			end
			Modules = game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules

			Modules = game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules
			EntityModules = game.ReplicatedStorage.ClientModules.EntityModules
			Screech = Modules:FindFirstChild("Screech") or Modules:FindFirstChild("Screech_")

			Dread = Instance.new("Folder")
			if Modules:FindFirstChild("A90") then
				A90 = Modules.A90
			end
			if Modules:FindFirstChild("Dread") then
				Dread = Modules.Dread
			end
			Timothy = Modules.SpiderJumpscare




			if AntiScreech == true then
				Screech.Name = "Screech_"
			end

			if Toggles.AntiDread.Value and Dread then
				Dread.Name = "Dread_"
			end
			if Toggles.AntiA90.Value and A90 then
				A90.Name = "A90_"
			end


			if Toggles.AntiTimothy and Timothy then
				Timothy.Name = "SpiderJumpscare_"
			end

			if Toggles.NoAccell.Value then
				for i,part in pairs(NewCharacter:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CustomPhysicalProperties = CustomPhysicalProperties
					end
				end
			end
			for i,room in pairs(game.Workspace:FindFirstChild("CurrentRooms"):GetChildren()) do
				if tonumber(room.Name) == (CurrentRoom) then
					Player:SetAttribute("CurrentRoom",room.Name)
				end
			end

			SpeedConnection:Disconnect()
			MainConnection:Disconnect()
			CharacterInstanceAddedConnection:Disconnect()
			RunService.Heartbeat:Wait()
			game.Workspace.CurrentCamera = game.Workspace:WaitForChild("Camera")
			SpeedBypass()


			SCCooldown = false
			AnticheatBypassConnection = Character:GetAttributeChangedSignal("Climbing"):Connect(function()
				if MinesBypass == true  then
					if Character:GetAttribute("Climbing") == true then
						task.wait()
						Character:SetAttribute("Climbing",false)

						Notify({Title = "Anticheat Bypass", Description = "Successfully bypassed the Anticheat!", Reason = "It will only last until the next cutscene!"})
						MinesAnticheatBypassActive = true
						Sound()
					
					end
				end
			end)	

			SpeedConnection = RunService.RenderStepped:Connect(function()

				if Character ~= nil then
					if SCCooldown == false then
						SCCooldown = true
						local CrouchNerf = 0




						if Collision and Collision.CollisionGroup == "PlayerCrouching" then
							CrouchNerf = 5
						else
							CrouchNerf = 0

						end
						if SpeedBoostEnabled == true then
							RunService.Heartbeat:Wait()
							if not CollisionClone or Character:GetAttribute("SpeedBoostExtra") == nil then return end
							local num = 15 + (Character:GetAttribute("SpeedBoost") + Character:GetAttribute("SpeedBoostBehind") + Character:GetAttribute("SpeedBoostExtra") + SpeedBoost - CrouchNerf)
							Humanoid.WalkSpeed = num

						end

						task.wait()
						SCCooldown = false
					end
				end
			end)
			CharacterInstanceAddedConnection = Character.DescendantAdded:Connect(function(inst)
				if inst:IsA("Sound") and inst.Name == "Sound" then
					inst.Volume = (Toggles.RemoveFootstepSounds.Value and 0 or inst.Volume)
				end	
			end)



			FOVTweenTime = 0
			MainConnectionCooldown = false

			MainConnection = game["Run Service"].RenderStepped:Connect(function()
				if not CollisionClone or Character:GetAttribute("SpeedBoostExtra") == nil or game.Workspace.CurrentCamera.CameraSubject ~= Humanoid then return end
				if AntiFH == true then
					if RemotesFolder:FindFirstChild("Crouch") then
						RemotesFolder.Crouch:FireServer(true)
					end	
				else
					if RemotesFolder:FindFirstChild("Crouch") then
						RemotesFolder.Crouch:FireServer(Collision.CollisionGroup == "PlayerCrouching" and true or false)
					end
				end

				local function u2()



					if Character:WaitForChild("Humanoid").MoveDirection == Vector3.new(0, 0, 0) then

						return Character:WaitForChild("Humanoid").MoveDirection

					else


					end
					local v12 = (game.Workspace.CurrentCamera.CFrame * CFrame.new((CFrame.new(game.Workspace.CurrentCamera.CFrame.p, game.Workspace.CurrentCamera.CFrame.p + Vector3.new(game.Workspace.CurrentCamera.CFrame.lookVector.x, 0, game.Workspace.CurrentCamera.CFrame.lookVector.z)):VectorToObjectSpace(Humanoid.MoveDirection)))).p - game.Workspace.CurrentCamera.CFrame.p;
					if v12 == Vector3.new() then
						return v12
					end
					return v12.unit
				end






				

				if thirdp == true then


					game.Workspace.CurrentCamera.CFrame = game.Workspace.CurrentCamera.CFrame * CFrame.new(ThirdPersonX,ThirdPersonY,ThirdPersonZ)
				end
				if EnableFOV == true then	

					if RequireCheck == true then
						Main_Game.fovtarget = fov
						if Humanoid.WalkSpeed > 15 + SpeedBoost then
							game.Workspace.CurrentCamera.FieldOfView = fov
						end
					else
						if game.Workspace.CurrentCamera.FieldOfView == fov then
							FOVTweenTime = 0
						end
						if FOVTweenTime == 0 then

							game.Workspace.CurrentCamera.FieldOfView = fov
						end
					end


				end

				if Toggles.ForwardTeleport.Value or Options.ForwardTeleportKey:GetState() == true then
					bypassActive = true
				end
				if not Toggles.ForwardTeleport.Value and Options.ForwardTeleportKey:GetState() == false then
					bypassActive = false
				end

				if workspace:FindFirstChild("Eyes") and AntiEyes == true then
					if Floor == "Fools" or OldHotel == true then
						RemotesFolder.MotorReplication:FireServer(0, -650, 0, false)
					end
				end

				if game.Workspace:FindFirstChild("Eyes") and Floor ~= "Fools" and OldHotel == false and AntiEyes == true or game.Workspace:FindFirstChild("BackdoorLookman") and AntiLookman == true then


					RemotesFolder.MotorReplication:FireServer(-650)


				end


				if fb == true  then
					local lighting = game:GetService("Lighting")
					game:GetService("TweenService"):Create(lighting,TweenInfo.new(1,Enum.EasingStyle.Exponential),{Ambient = Ambience}):Play()
				elseif Floor == "Fools" or OldHotel == true then
					local lighting = game:GetService("Lighting")
					game:GetService("TweenService"):Create(lighting,TweenInfo.new(1,Enum.EasingStyle.Exponential),{Ambient = OriginalAmbience}):Play()

				end
				if fly.enabled == true then
					local velocity = Vector3.zero

					velocity = u2()


					fly.flyBody.Velocity = velocity * (flyspeed * 10)



				end



				if Toggles.AutoEatCandies and Toggles.AutoEatCandies.Value then
					if Player.Backpack:FindFirstChild("Candy") then
						local CharacterCandy = Character:FindFirstChild("Candy")
						local Candy = Player.Backpack:FindFirstChild("Candy")
						if CharacterCandy then
							if CharacterCandy:GetAttribute("CandyID") == "CandyCurious" and Options.AutoEatCandiesIgnoreList.Value["Volatile Starlight"] or CharacterCandy:GetAttribute("CandyID") == "CandyRed" and Options.AutoEatCandiesIgnoreList.Value["Can-Die"] then
								if Candy:GetAttribute("CandyID") == "CandyCurious" and not Options.AutoEatCandiesIgnoreList.Value["Volatile Starlight"] or Candy:GetAttribute("CandyID") == "CandyRed" and not Options.AutoEatCandiesIgnoreList.Value["Can-Die"] then
									Humanoid:EquipTool(Candy)
								elseif Candy:GetAttribute("CandyID") ~= "CandyCurious" and Candy:GetAttribute("CandyID") ~= "CandyRed" then
									Humanoid:EquipTool(Candy)
								end
							end
						elseif not CharacterCandy then
							if Candy:GetAttribute("CandyID") == "CandyCurious" and not Options.AutoEatCandiesIgnoreList.Value["Volatile Starlight"] or Candy:GetAttribute("CandyID") == "CandyRed" and not Options.AutoEatCandiesIgnoreList.Value["Can-Die"] then
								Humanoid:EquipTool(Candy)
							elseif Candy:GetAttribute("CandyID") ~= "CandyCurious" and Candy:GetAttribute("CandyID") ~= "CandyRed" then
								Humanoid:EquipTool(Candy)
							else
								Candy.Name = "Candy_"
								task.wait(1)
								Candy.Name = "Candy"
							end			

						end
					end
					if Character:FindFirstChild("Candy") then
						local Candy = Character:FindFirstChild("Candy")
						if Candy then
							if Candy:GetAttribute("CandyID") == "CandyCurious" and not Options.AutoEatCandiesIgnoreList.Value["Volatile Starlight"] or Candy:GetAttribute("CandyID") == "CandyRed" and not Options.AutoEatCandiesIgnoreList.Value["Can-Die"] then
								Candy:WaitForChild("Remote"):FireServer()
							elseif Candy:GetAttribute("CandyID") ~= "CandyCurious" and Candy:GetAttribute("CandyID") ~= "CandyRed" then
								Candy:WaitForChild("Remote"):FireServer()
							end
						end
					end
				end



				if RemoveHideVignette == true and OldHotel == false then
					if Player.PlayerGui:FindFirstChild("MainUI") then
						Player.PlayerGui.MainUI.MainFrame.HideVignette.Visible = false
					end
				end


				Humanoid.JumpHeight = JumpBoost
				if godmode == true then
					if CollisionClone2 then
						if Floor ~= "Fools" and OldHotel == false then 



							if AvoidingFigure == false then
								RemotesFolder.Crouch:FireServer(true)

								CollisionClone.CanCollide = false	
								Collision.Position = HumanoidRootPart.Position-Vector3.new(0,GodmodeOffset,0)

								CollisionClone.Position = HumanoidRootPart.Position
							end
						end
					else








					end
				else


				end

				CollisionClone2.Position = HumanoidRootPart.Position
				if  Floor == "Fools" or OldHotel == true then
					if game.Workspace:FindFirstChild("AmbushMoving") and godmode == true or AvoidingFigure == true or game.Workspace:FindFirstChild("RushMoving") and godmode == true then

						Collision.Position = HumanoidRootPart.Position + Vector3.new(0, 250, 0)
						CollisionClone.Position = Collision.Position - Vector3.new(0, 250, 0)
					else
						CollisionClone2.Position = HumanoidRootPart.Position


						CollisionClone.Position = HumanoidRootPart.Position+Vector3.new(0,GodmodeOffset,0)
						Collision.Position = HumanoidRootPart.Position

					end
				elseif godmode == false and AvoidingFigure == false then

					CollisionClone2.Position = HumanoidRootPart.Position


					CollisionClone.Position = HumanoidRootPart.Position+Vector3.new(0,GodmodeOffset,0)
					Collision.Position = HumanoidRootPart.Position
				end
				if godmode == false and AvoidingFigure == false then



					CollisionClone.Position = HumanoidRootPart.Position+Vector3.new(0,GodmodeOffset,0)
					Collision.Position = HumanoidRootPart.Position
				end

				CollisionClone2.Position = HumanoidRootPart.Position









				local ray = Ray.new(HumanoidRootPart.CFrame.Position, HumanoidRootPart.CFrame.LookVector * 0.25)
				local part = workspace:FindPartOnRay(ray)

				if Toggles.AutoRoomsIgnoreA60.Value and Floor == "Rooms" then
					Toggles.Toggle250:SetValue(true)
				end









				if  Toggles.ACM.Value and Floor ~= "Fools" and OldHotel == false and MinesAnticheatBypassActive == false   or Options.AnticheatManipulation:GetState() == true and Floor ~= "Fools" and OldHotel == false and MinesAnticheatBypassActive == false then
					if acmcooldown == false then

						Character:PivotTo(Character:GetPivot()*CFrame.new(0,0,2500))

						Humanoid.HipHeight = 0

					end

				else
					Humanoid.HipHeight = 3







				end


				onStep()


				if RequireCheck == true then
					if Toggles.NoCameraShake.Value then
						Main_Game.csgo = CFrame.new()
					end
					
				end



				if Toggles.GodmodeFigure.Value and AvoidingFigure == true and OldHotel == false and Floor ~= "Fools" then
					RemotesFolder.Crouch:FireServer(true)

					CollisionClone.CanCollide = false	
					Collision.Position = HumanoidRootPart.Position+(CurrentRoom == 50 and Vector3.new(0,20,0) or Vector3.new(0,13.5,0))
					CollisionClone.Position = HumanoidRootPart.Position	
				end

				if Toggles.GodmodeFigure.Value then
					if game.Workspace.CurrentRooms:FindFirstChild(Player:GetAttribute("CurrentRoom")):FindFirstChild("FigureSetup") then
						local FigureSetup = game.Workspace.CurrentRooms:FindFirstChild(Player:GetAttribute("CurrentRoom")):WaitForChild("FigureSetup")					
						local Figure = Floor == "Fools" and FigureSetup.FigureRagdoll or OldHotel == true and FigureSetup:FindFirstChild("FigureRagdoll") or FigureSetup:FindFirstChild("FigureRig")  
						if Player:DistanceFromCharacter(Figure.Torso.Position) < 20 then
							AvoidingFigure = true
						else

							AvoidingFigure = false
						end
					elseif game.Workspace.CurrentRooms:FindFirstChild(Player:GetAttribute("CurrentRoom")):FindFirstChild("FigureRig") then
						local Figure = game.Workspace.CurrentRooms:FindFirstChild(Player:GetAttribute("CurrentRoom")):WaitForChild("FigureRig")
						if Player:DistanceFromCharacter(Figure.Torso.Position) < 20 then
							AvoidingFigure = true
						else

							AvoidingFigure = false
						end

					else

						AvoidingFigure = false
					end

				end

			end)	
		end)


		local CameraChildConnection = workspace.CurrentCamera.ChildAdded:Connect(function(Child)
			if Child.Name == "GlitchScreech" and Toggles.AntiScreech.Value then
				Child:Destroy()
			end
		end)





		if Character:GetAttribute("SpeedBoost") == nil then
			Character:SetAttribute("SpeedBoost",0)
		end
		if Character:GetAttribute("SpeedBoostExtra") == nil then
			Character:SetAttribute("SpeedBoostExtra",0)
		end
		if Character:GetAttribute("SpeedBoostBehind") == nil then
			Character:SetAttribute("SpeedBoostBehind",0)
		end


		local BreakerConnection = game["Run Service"].RenderStepped:Connect(function(Delta)

			if game.Workspace.CurrentRooms:FindFirstChild("100")  then

				if workspace.CurrentRooms["100"]:FindFirstChild("ElevatorBreaker") then
					if AutoBreaker == true then
						SolveBreakerBox()

					end
				end
			end

		end)



		Library.NotifySide = "Left"
		if Library.IsMobile then
			Library.NotifySide = "Right"	
		end






		if HumanoidRootPart.CustomPhysicalProperties ~= nil then
			CustomPhysicalProperties = PhysicalProperties.new(100, HumanoidRootPart.CustomPhysicalProperties.Friction, HumanoidRootPart.CustomPhysicalProperties.Elasticity, HumanoidRootPart.CustomPhysicalProperties.FrictionWeight, HumanoidRootPart.CustomPhysicalProperties.ElasticityWeight)
		end

		SaveManager:LoadAutoloadConfig()

		for i,part in pairs(Character:GetDescendants()) do
			if part:IsA("BasePart") then
				if part ~= CollisionCrouch and part ~= Collision and part ~= CollisionClone and part ~= CollisionClone2 then
					
					part.CanCollide = false
part:GetPropertyChangedSignal("CanCollide"):Connect(function()
						part.CanCollide = false
end)

				end
			end
		end
		
		local NoclipConnection = RunService.RenderStepped:Connect(function()
			task.wait(0.1)
			Collision.CollisionGroup = (Character:GetAttribute("Crouching") == true and "PlayerCrouching" or "Player")
			HumanoidRootPart.CanCollide = false
		
			
			


			Collision.CanCollide = false

			if noclip == true then
				if Collision:FindFirstChild("CollisionCrouch") then
					Collision:FindFirstChild("CollisionCrouch").CanCollide = false
				end
				Collision.CanCollide = false
				CollisionClone2.CanCollide = false

				CollisionClone.CanCollide = false
			end
			if Collision.CollisionGroup ~= "PlayerCrouching" and noclip == false then
				CollisionClone.CanCollide = true
				Collision.CanCollide = false
				CollisionClone2.CanCollide = true
				if Collision:FindFirstChild("CollisionCrouch") then
					Collision:FindFirstChild("CollisionCrouch").CanCollide = true
				end
			end
			if godmode == true and noclip == false and Collision.CollisionGroup ~= "PlayerCrouching" then
				if Collision:FindFirstChild("CollisionCrouch") then
					Collision:FindFirstChild("CollisionCrouch").CanCollide = false
				end
				CollisionClone2.CanCollide = true
				Collision.CanCollide = false
			end
			if Collision.CollisionGroup == "PlayerCrouching" and noclip == false then
				Collision.CanCollide = false

				if Collision:FindFirstChild("CollisionCrouch") then
					Collision:FindFirstChild("CollisionCrouch").CanCollide = true
				end
				CollisionClone.CanCollide = false
				CollisionClone2.CanCollide = false


			end
			if bypassActive then
				Collision.CanCollide = false

				if Collision:FindFirstChild("CollisionCrouch") then
					Collision:FindFirstChild("CollisionCrouch").CanCollide = false
				end
				CollisionClone.CanCollide = false
				CollisionClone2.CanCollide = false


			end
		end)

		Toggles.Noclip:SetValue(false)

		local Unloading = false


		function Unload()
			if Unloading == false then
				Unloading = true


				Connection1:Disconnect()


				MainConnection:Disconnect()
				SpeedConnection:Disconnect()
				FigureConnection:Disconnect()
				Connection5:Disconnect()
				
				textgui:Destroy()
				tracergui:Destroy()


				PathfindingFolder:Destroy()

				GoldConnection:Disconnect()

				AutoPadlockConnection:Disconnect()

				AutoPaintingsConnection:Disconnect()

				NAC:Disconnect()
				
			
				NotifierConnection:Disconnect()
				BreakerConnection:Disconnect()

				CameraRoomConnection:Disconnect()

				Toggles.AutoRooms:SetValue(false)
				Screech.Name = "Screech"
				for i,Connection in pairs(Connections) do
					Connection:Disconnect()			
				end
				if A90 then
					A90.Name = "A90"
				end
				Timothy.Name = "SpiderJumpscare"
				if Dread then
					Dread.Name = "Dread"
				end
				if Void then
					Void.Name = "Void"
				end
				if Jumpscares then
					Jumpscares.Name = "Jumpscares"
				end
				Halt.Name = "Shade"
				if Collision.CollisionGroup ~= "PlayerCrouching" then
					if RemotesFolder:FindFirstChild("Crouch") then
						RemotesFolder.Crouch:FireServer(false)
					end
				end
				Glitch.Name = "Glitch"
				EnableFOV = false

				Collision.Position = HumanoidRootPart.Position
				Collision.CanCollide = true
				CollisionClone:Destroy()
				CollisionClone2:Destroy()

				PathfindingFolder:Destroy()
				Character:SetAttribute("SpeedBoost",0)
				Character:SetAttribute("SpeedBoostBehind",0)
				Character:SetAttribute("SpeedBoostExtra",0)

				CollisionClone:Destroy()
				for i,ui in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
					if ui.Name == "Tracers" then
						ui:Destroy()
					end

				end
				for i,inst in pairs(game.Workspace:GetDescendants()) do
					inst:SetAttribute("ESP",false)



				end
				game.Workspace.CurrentCamera.FieldOfView = fov
				game:GetService("TweenService"):Create(game.Workspace.CurrentCamera,TweenInfo.new(1,Enum.EasingStyle.Exponential),{FieldOfView = 70}):Play()
				game:GetService("TweenService"):Create(game.Lighting,TweenInfo.new(1,Enum.EasingStyle.Exponential),{Ambient = OriginalAmbience}):Play()


				Humanoid.WalkSpeed = 15

				Library:Unload()
				ESPLibrary:Unload()
				Library = nil

				getgenv().JSHUB = false
				getgenv().Library = nil

			else
				Notify({Title = "Error",Description = ScriptName .. " is already unloading."})	
				Sound()
			end
		end	


		task.wait()

		local MenuSettings = Tabs.UISettings:AddLeftGroupbox("Settings")
		local Contributors = Tabs.UISettings:AddRightGroupbox("Credits")
		MenuSettings:AddButton('Unload', function() Unload() end):AddButton('Reload', function() Unload() loadstring(scriptlink)() end)
		MenuSettings:AddDivider()
		MenuSettings:AddLabel('GUI Toggle Keybind'):AddKeyPicker('MenuKeybind', { Default = 'RightControl', NoUI = true, Text = 'GUI Toggle keybind' })

		-- I set NoUI so it does not show up in the keybinds menu

		MenuSettings:AddToggle('KeybindMenu', {
			Text = 'Show Keybinds',
			Default = false, -- Default value (true / false)
			Tooltip = 'Toggles the Keybind Menu, showing all Keybinds and their status.', -- Information shown when you hover over the toggle

			Callback = function(Value)
				Library.KeybindFrame.Visible = Value
			end

		})



		Contributors:AddLabel("bocaj11104 - Creator",true)
		Contributors:AddLabel("thehuntersolo1 - Scripted the Forward Teleport feature ",true)
		Contributors:AddLabel("feargeorge - Scripted a few things here and there (pog) ",true)
		Contributors:AddDivider()
		Contributors:AddLabel("i_m_h_i_m__ - Helped with a lot of testing in early development",true)

		Library:SetWatermarkVisibility(true)

		
		
		Library.ShowCustomCursor = false


		MenuSettings:AddToggle("CustomCursor", {
			Text = "Custom Cursor",
			Default = true,
			Tooltip= "Show the Library's Custom Cursor",
			Callback = function(value) Library.ShowCustomCursor = value end
		})
		Library.ShowCustomCursor = false
		task.wait()
		Library.ShowCustomCursor = Toggles.CustomCursor.Value

		ThemeManager:SetLibrary(Library)
		SaveManager:SetLibrary(Library)
		SaveManager:IgnoreThemeSettings()




		ThemeManager:SetFolder(ScriptName)
		SaveManager:SetFolder(ScriptName .. "/Doors")

		ThemeManager:ApplyToTab(UISettings)
		SaveManager:BuildConfigSection(UISettings)

		
		AddMinesTab()
		AddRoomsTab()
		AddBackdoorTab()
		AddFoolsTab()
		AddBeforePlusTab()
		AddRetroTab()



		Automation:AddToggle('AutoEatCandies', {
			Text = 'Auto Eat Candies',
			Default = false, -- Default value (true / false)
			Tooltip = 'Automatically eat any candies you are holding', -- Information shown when you hover over the toggle

			Callback = function(Value)



			end
		}):AddKeyPicker('AutoEatCandiesKey', {


			Default = 'K', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
			SyncToggleState = true,


			-- You can define custom Modes but I have never had a use for it.
			Mode = 'Toggle', -- Modes: Always, Toggle, Hold

			Text = 'Auto Eat Candies', -- Text to display in the keybind menu
			NoUI = false, -- Set to true if you want to hide from the Keybind menu,

			-- Occurs when the keybind is clicked, Value is `true`/`false`
			Callback = function(Value)

			end,

			-- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
			ChangedCallback = function(New)
			end
		})
		Automation:AddDropdown("AutoEatCandiesIgnoreList", 
			{ Values = {'Volatile Starlight','Can-Die'}, 
				Default = 0, 
				Multi = true, 
				Text = "Candy Ignore List", 

			})
		
		Library:Toggle()
		
		
		DoorsNotify({Title = ScriptName, Description = "Successfully loaded in " .. math.floor(tonumber(tick() - LoadingTime)*1000)/1000 .. " seconds.", Image = "http://www.roblox.com/asset/?id=14562122532"})
		
		SaveManager:LoadAutoloadConfig()

	end

else
end
