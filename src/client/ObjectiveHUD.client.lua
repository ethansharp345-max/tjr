-- Minimal client objective and pickup feedback HUD.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local updateEvent = ReplicatedStorage:WaitForChild("ObjectiveUpdate")

local gui = Instance.new("ScreenGui")
gui.Name = "ObjectiveHUD"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local function makeLabel(name, size, position, textSize)
	local label = Instance.new("TextLabel")
	label.Name = name
	label.Size = size
	label.Position = position
	label.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
	label.BackgroundTransparency = 0.25
	label.BorderSizePixel = 0
	label.TextColor3 = Color3.fromRGB(235, 235, 235)
	label.Font = Enum.Font.GothamMedium
	label.TextSize = textSize
	label.TextWrapped = true
	label.Visible = false
	label.Parent = gui
	return label
end

local objectiveLabel = makeLabel("Objective", UDim2.fromOffset(360, 64), UDim2.new(0, 20, 0, 20), 18)
objectiveLabel.TextXAlignment = Enum.TextXAlignment.Left
objectiveLabel.Text = "Objective: Explore the building"
objectiveLabel.Visible = true

local messageLabel = makeLabel("Message", UDim2.fromOffset(360, 48), UDim2.new(0.5, -180, 0.82, 0), 18)

local function showMessage(text)
	messageLabel.Text = text
	messageLabel.Visible = true
	messageLabel.TextTransparency = 0
	messageLabel.BackgroundTransparency = 0.25
	local fade = TweenService:Create(messageLabel, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 2), {
		TextTransparency = 1,
		BackgroundTransparency = 1,
	})
	fade:Play()
	fade.Completed:Once(function()
		messageLabel.Visible = false
	end)
end

updateEvent.OnClientEvent:Connect(function(messageType, text)
	if typeof(text) ~= "string" then
		return
	end
	if messageType == "objective" then
		objectiveLabel.Text = "Objective: " .. text
	elseif messageType == "message" then
		showMessage(text)
	end
end)
