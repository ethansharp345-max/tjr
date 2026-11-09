-- Basic server-authoritative monster pursuit prototype.
-- Workspace must contain a Model named "Monster" with a Humanoid and HumanoidRootPart.

local Players = game:GetService("Players")
local PathfindingService = game:GetService("PathfindingService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local monster = Workspace:WaitForChild("Monster")
local humanoid = monster:WaitForChild("Humanoid")
local root = monster:WaitForChild("HumanoidRootPart")

local function readNumberAttribute(name, default)
	local value = monster:GetAttribute(name)
	return typeof(value) == "number" and value or default
end

local detectionRange = readNumberAttribute("DetectionRange", 65)
local attackRange = readNumberAttribute("AttackRange", 4)
local repathInterval = readNumberAttribute("RepathInterval", 1)
local patrolSpeed = readNumberAttribute("WalkSpeed", 12)
local chaseSpeed = readNumberAttribute("ChaseSpeed", 18)
local homePosition = root.Position

local function canSee(character)
	local targetRoot = character:FindFirstChild("HumanoidRootPart")
	if not targetRoot then
		return false
	end

	local offset = targetRoot.Position - root.Position
	if offset.Magnitude > detectionRange then
		return false
	end

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { monster }
	local result = Workspace:Raycast(root.Position, offset, params)
	return result ~= nil and result.Instance:IsDescendantOf(character)
end

local function getNearestVisibleCharacter()
	local bestCharacter = nil
	local bestDistance = detectionRange

	for _, player in Players:GetPlayers() do
		local character = player.Character
		local targetHumanoid = character and character:FindFirstChildOfClass("Humanoid")
		local targetRoot = character and character:FindFirstChild("HumanoidRootPart")
		if targetHumanoid and targetRoot and targetHumanoid.Health > 0 then
			local distance = (targetRoot.Position - root.Position).Magnitude
			if distance < bestDistance and canSee(character) then
				bestCharacter = character
				bestDistance = distance
			end
		end
	end

	return bestCharacter, bestDistance
end

local lastPathTime = 0
local function moveToward(destination)
	local now = os.clock()
	if now - lastPathTime < repathInterval then
		return
	end
	lastPathTime = now

	local path = PathfindingService:CreatePath({
		AgentRadius = 2,
		AgentHeight = 10,
		AgentCanJump = true,
	})

	local ok = pcall(function()
		path:ComputeAsync(root.Position, destination)
	end)
	if not ok or path.Status ~= Enum.PathStatus.Success then
		humanoid:MoveTo(destination)
		return
	end

	local waypoints = path:GetWaypoints()
	local nextWaypoint = waypoints[2]
	if nextWaypoint then
		if nextWaypoint.Action == Enum.PathWaypointAction.Jump then
			humanoid.Jump = true
		end
		humanoid:MoveTo(nextWaypoint.Position)
	else
		humanoid:MoveTo(destination)
	end
end

local attackCooldowns = {}
RunService.Heartbeat:Connect(function()
	if humanoid.Health <= 0 or not root.Parent then
		return
	end

	local character, distance = getNearestVisibleCharacter()
	if character then
		humanoid.WalkSpeed = chaseSpeed
		local targetRoot = character:FindFirstChild("HumanoidRootPart")
		local targetHumanoid = character:FindFirstChildOfClass("Humanoid")
		if targetRoot and targetHumanoid then
			moveToward(targetRoot.Position)
			if distance <= attackRange then
				local now = os.clock()
				local player = Players:GetPlayerFromCharacter(character)
				if player and now - (attackCooldowns[player] or 0) >= 3 then
					attackCooldowns[player] = now
					targetHumanoid.Health = 0 -- Replace with checkpoint/recovery behavior if desired.
				end
			end
		end
	else
		humanoid.WalkSpeed = patrolSpeed
		if (root.Position - homePosition).Magnitude > 5 then
			moveToward(homePosition)
		end
	end
end)
