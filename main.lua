
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
    Tracers = {},
    Frames = {},
    Connections = {},
    Billboards = {},
    ColorTable = {},
    Font = Enum.Font.Oswald,
    ConnectionsTable = {},
    Objects = {},
    HighlightedObjects = {},
    RemoveIfNotVisible = true,
    Rainbow = false,
    UseBillboards = true,
    TextTransparency = 0,
    FillTransparency = 0.75,
    OutlineTransparency = 0,
    FadeTime = 0,
    TextSize = 20
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
    ObjectsFolder.Parent = MainFolder

    
    pcall(ProtectGui,ScreenGui)
    pcall(ProtectGui,OtherGui)
    
    -- Functions --
    
    function Library:GenerateRandomString()
        local Characters = "abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ!$<>{}[]()-_%*~@:;"
        --local Characters = "1234567890abcdefghijklmnopqrstuvqxyz"
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
       local Segment1 = GenerateSegment() .. "-"
       local Segment2 = GenerateSegment() .. "-"
       local Segment3 = GenerateSegment() .. "-"
       local Segment4 = GenerateSegment() .. "-"
       local Segment5 = GenerateSegment() .. "-"
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
    Objects[Object] = ObjectFolder
     if Library.UseBillboards == true then
         TextLabel.Parent = BillboardGui
     else
        TextLabel.Parent = TextFrame
     end
     local Connection = RunService.RenderStepped:Connect(function()
 
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
 
     Object.Destroying:Connect(function()
     Library:RemoveESP(Object)
     end)
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
        Library.Font = Number
        for i,Label in pairs(Labels) do
            Label.FOnt = Font
        end
        end

    function Library:UpdateObjectText(Object,Text)
    local ObjectTable = Objects[Object]
    if ObjectTable then
    ObjectTable.TextLabel.Text = Text
    end
end
    
   

    
    function Library:RemoveESP(Object)

   ConnectionsTable[Object]:Disconnect()
   ConnectionsTable[Object] = nil

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
    if TextFrame then
    TextFrame:Destroy()
    end
    if BillboardGui then
    BillboardGui:Destroy()
    end
    end
    

   
    
    
    function Library:Unload()
    for i,Element in pairs(Elements) do
       
            Element:Destroy()
        
end
for i,Connection in pairs(ConnectionsTable) do
    Connection:Disconnect()
end
ScreenGui:Destroy()
OtherGui:Destroy()
end
    -- Finishing Touches --
    
    ObjectsFolder.Name = Library:GenerateRandomString()
    MainFolder.Name = Library:GenerateRandomString()
    ScreenGui.Name = Library:GenerateRandomString()
   OtherGui.Name = Library:GenerateRandomString()
   HighlightsFolder.Name = Library:GenerateRandomString()
   BillboardsFolder.Name = Library:GenerateRandomString()
   getgenv().ESPLibrary = Library
    
    
    
