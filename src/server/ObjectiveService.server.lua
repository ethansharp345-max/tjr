-- Adds server-controlled prompts to tagged key and objective objects.
-- KeyItem instances: KeyId (string), optional DisplayName (string).
-- ObjectiveTrigger instances: ObjectiveId (string), ObjectiveText (string), optional RequiredKeyId (string).

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local updateEvent = ReplicatedStorage:FindFirstChild("ObjectiveUpdate")
if not updateEvent then
	updateEvent = Instance.new("RemoteEvent")
	updateEvent.Name = "ObjectiveUpdate"
	updateEvent.Parent = ReplicatedStorage
end

local function getPromptParent(instance)
	if instance:IsA("BasePart") then
		return instance
	end
	if instance:IsA("Model") then
		return instance.PrimaryPart or instance:FindFirstChildWhichIsA("BasePart", true)
	end
	return nil
end

local function ensurePrompt(instance, tagName)
	local promptParent = getPromptParent(instance)
	if not promptParent or promptParent:FindFirstChild("GamePrompt") then
		return
	end

	local prompt = Instance.new("ProximityPrompt")
	prompt.Name = "GamePrompt"
	prompt.ActionText = tagName == "KeyItem" and "Collect" or "Interact"
	prompt.ObjectText = instance:GetAttribute("DisplayName") or instance:GetAttribute("ObjectiveText") or instance.Name
	prompt.HoldDuration = 0.4
	prompt.MaxActivationDistance = 10
	prompt.RequiresLineOfSight = false
	prompt.Parent = promptParent

	prompt.Triggered:Connect(function(player)
		if tagName == "KeyItem" then
			local keyId = instance:GetAttribute("KeyId")
			if typeof(keyId) ~= "string" or keyId == "" then
				warn("KeyItem is missing its KeyId attribute:", instance:GetFullName())
				return
			end
			local attributeName = "HasKey_" .. keyId
			if player:GetAttribute(attributeName) then
				return
			end
			player:SetAttribute(attributeName, true)
			updateEvent:FireClient(player, "message", "Collected: " .. (instance:GetAttribute("DisplayName") or keyId))
		else
			local objectiveId = instance:GetAttribute("ObjectiveId")
			local objectiveText = instance:GetAttribute("ObjectiveText")
			if typeof(objectiveId) ~= "string" or objectiveId == "" or typeof(objectiveText) ~= "string" then
				warn("ObjectiveTrigger needs ObjectiveId and ObjectiveText attributes:", instance:GetFullName())
				return
			end
			if player:GetAttribute("ObjectiveCompleted_" .. objectiveId) then
				return
			end
			local requiredKeyId = instance:GetAttribute("RequiredKeyId")
			if typeof(requiredKeyId) == "string" and requiredKeyId ~= "" and not player:GetAttribute("HasKey_" .. requiredKeyId) then
				updateEvent:FireClient(player, "message", "You need the " .. requiredKeyId .. ".")
				return
			end

			player:SetAttribute("ObjectiveCompleted_" .. objectiveId, true)
			player:SetAttribute("CurrentObjective", objectiveText)
			updateEvent:FireClient(player, "objective", objectiveText)
		end
	end)
end

local function registerTag(tagName)
	for _, instance in CollectionService:GetTagged(tagName) do
		ensurePrompt(instance, tagName)
	end
	CollectionService:GetInstanceAddedSignal(tagName):Connect(function(instance)
		ensurePrompt(instance, tagName)
	end)
end

registerTag("KeyItem")
registerTag("ObjectiveTrigger")
