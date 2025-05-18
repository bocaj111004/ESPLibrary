ESP library by @bocaj11104 (discord):

```

local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/bocaj111004/ESPLibrary/refs/heads/main/main.lua"))() -- Loading the library

ESPLibrary:AddESP({
Object = Instance, -- The object you want to highlight
Text = string, -- What you want the text to say,
Color = Color3 -- The color of the esp to set.
})

ESPLibrary:RemoveESP(Instance) -- Removes esp from the object

ESPLibrary:SetTextSize(number) -- Sets the text size

ESPLibrary:SetFillTransparency(number) -- Sets the highlight's fill transparency

ESPLibrary:SetOutlineTransparency(number) -- Sets the outline transparency

ESPLibrary:SetTextTransparency(number) -- Sets the text transparency

ESPLibrary:SetTextOutlineTransparency(number) -- Sets the outline transparency for text

ESPLibrary:SetFadeTime(number) -- Sets the esp fade time

ESPLibrary:SetFont(Font) -- Sets the font of all text

ESPLibrary:SetRainbow(Boolean) -- Changes if the esp should be rainbow

ESPLibrary:SetShowDistance(Boolean) -- Sets whether the esp should show how far away it is

ESPlibrary:SetMatchColors(Boolean) -- Sets whether the fill color and outline color should be the same

ESPLibrary:SetOutlineColor(Color3) -- Sets the outline color for if MatchColors is false

ESPLibrary:UpdateObjectText(Instance, Text) -- Changed the text of an object if it is already highlighted

ESPLibrary:UpdateObjectColor(Instance, Color3) -- Changed the color of an object if it is already highlighted

ESPLibrary:SetTracers(Boolean) -- Sets whether tracers are currently visible

ESPLibrary:SetTracerOrigin(string) -- Sets where the tracers come from on the screen (Can only be either "Bottom, "Top", "Center" or "Mouse")

ESPLibrary:Unload() -- Unloads the library

Example Usage:

ESPLibrary:AddESP({
Object = game.Players.LocalPlayer.Character,
Text = game.Players.LocalPlayer.Character.Name,
Color = Color3.fromRGB(0,255,0)
})

