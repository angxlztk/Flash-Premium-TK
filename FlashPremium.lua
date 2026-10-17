--[[
    Flash Premium TK
    Creador: angxlz
    Key: tk_angxlz
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local KEY = "tk_angxlz"

local speeds = {
	Lento = 28,
	Medio = 220,
	Rapido = 380
}

local currentSpeed = "Medio"
local speedValue = speeds.Medio
local flashEnabled = false
local highJumpEnabled = false
local pushEnabled = false
local minimized = false
local pushConnection = nil

-- ==================== KEY ====================
local keyGui = Instance.new("ScreenGui")
keyGui.Name = "FlashKey"
keyGui.ResetOnSpawn = false
keyGui.Parent = player:WaitForChild("PlayerGui")

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 300, 0, 185)
keyFrame.Position = UDim2.new(0.5, -150, 0.5, -92)
keyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
keyFrame.BorderSizePixel = 0
keyFrame.Parent = keyGui
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 12)

local keyStroke = Instance.new("UIStroke")
keyStroke.Color = Color3.fromRGB(255, 130, 40)
keyStroke.Thickness = 1.5
keyStroke.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 40)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "FLASH PREMIUM TK"
keyTitle.TextColor3 = Color3.fromRGB(255, 150, 50)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 18
keyTitle.Parent = keyFrame

local keySub = Instance.new("TextLabel")
keySub.Size = UDim2.new(1, 0, 0, 20)
keySub.Position = UDim2.new(0, 0, 0, 38)
keySub.BackgroundTransparency = 1
keySub.Text = "Ingresa tu key"
keySub.TextColor3 = Color3.fromRGB(160, 160, 170)
keySub.Font = Enum.Font.Gotham
keySub.TextSize = 13
keySub.Parent = keyFrame

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.85, 0, 0, 34)
keyBox.Position = UDim2.new(0.075, 0, 0, 68)
keyBox.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
keyBox.Text = ""
keyBox.PlaceholderText = "Key aquí..."
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
keyBox.Parent = keyFrame
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 8)

local keyBtn = Instance.new("TextButton")
keyBtn.Size = UDim2.new(0.85, 0, 0, 36)
keyBtn.Position = UDim2.new(0.075, 0, 0, 115)
keyBtn.BackgroundColor3 = Color3.fromRGB(255, 130, 40)
keyBtn.Text = "VERIFICAR"
keyBtn.TextColor3 = Color3.fromRGB(20, 20, 25)
keyBtn.Font = Enum.Font.GothamBold
keyBtn.TextSize = 14
keyBtn.Parent = keyFrame
Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0, 8)

local keyError = Instance.new("TextLabel")
keyError.Size = UDim2.new(1, 0, 0, 18)
keyError.Position = UDim2.new(0, 0, 1, -22)
keyError.BackgroundTransparency = 1
keyError.Text = ""
keyError.TextColor3 = Color3.fromRGB(255, 70, 70)
keyError.Font = Enum.Font.Gotham
keyError.TextSize = 12
keyError.Parent = keyFrame

-- ==================== FUNCIONES ====================
local function getHum()
	local char = player.Character
	if char then
		return char:FindFirstChildOfClass("Humanoid")
	end
end

local function getHRP()
	local char = player.Character
	if char then
		return char:FindFirstChild("HumanoidRootPart")
	end
end

local function applySettings()
	local hum = getHum()
	if not hum then return end

	hum.WalkSpeed = flashEnabled and speedValue or 16

	if highJumpEnabled then
		hum.JumpPower = 120
		pcall(function() hum.JumpHeight = 12 end)
	else
		hum.JumpPower = 50
		pcall(function() hum.JumpHeight = 7.2 end)
	end
end

local function startPush()
	if pushConnection then
		pushConnection:Disconnect()
	end

	pushConnection = RunService.Heartbeat:Connect(function()
		if not pushEnabled then return end
		local myHRP = getHRP()
		if not myHRP then return end

		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= player and plr.Character then
				local otherHRP = plr.Character:FindFirstChild("HumanoidRootPart")
				if otherHRP then
					local dist = (myHRP.Position - otherHRP.Position).Magnitude
					if dist < 11 then
						local dir = (otherHRP.Position - myHRP.Position).Unit
						pcall(function()
							otherHRP.AssemblyLinearVelocity = dir * 160 + Vector3.new(0, 110, 0)
						end)
					end
				end
			end
		end
	end)
end

local function stopPush()
	if pushConnection then
		pushConnection:Disconnect()
		pushConnection = nil
	end
end

-- ==================== MENÚ PRINCIPAL ====================
local function createMenu()
	local gui = Instance.new("ScreenGui")
	gui.Name = "FlashPremium"
	gui.ResetOnSpawn = false
	gui.Parent = player.PlayerGui

	local main = Instance.new("Frame")
	main.Size = UDim2.new(0, 200, 0, 260)
	main.Position = UDim2.new(0, 12, 0.3, 0)
	main.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
	main.BorderSizePixel = 0
	main.Active = true
	main.Draggable = true
	main.Parent = gui
	Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(255, 140, 40)
	stroke.Thickness = 1.4
	stroke.Parent = main

	-- Header
	local header = Instance.new("Frame")
	header.Size = UDim2.new(1, 0, 0, 36)
	header.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
	header.BorderSizePixel = 0
	header.Parent = main
	Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -38, 1, 0)
	title.Position = UDim2.new(0, 10, 0, 0)
	title.BackgroundTransparency = 1
	title.Text = "FLASH PREMIUM"
	title.TextColor3 = Color3.fromRGB(255, 160, 50)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 13
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = header

	local minBtn = Instance.new("TextButton")
	minBtn.Size = UDim2.new(0, 24, 0, 24)
	minBtn.Position = UDim2.new(1, -30, 0.5, -12)
	minBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
	minBtn.Text = "–"
	minBtn.TextColor3 = Color3.new(1,1,1)
	minBtn.Font = Enum.Font.GothamBold
	minBtn.TextSize = 15
	minBtn.Parent = header
	Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

	-- Content
	local content = Instance.new("Frame")
	content.Name = "Content"
	content.Size = UDim2.new(1, 0, 1, -36)
	content.Position = UDim2.new(0, 0, 0, 36)
	content.BackgroundTransparency = 1
	content.Parent = main

	local function makeBtn(txt, y)
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(0.88, 0, 0, 32)
		b.Position = UDim2.new(0.06, 0, 0, y)
		b.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
		b.Text = txt
		b.TextColor3 = Color3.fromRGB(220, 220, 230)
		b.Font = Enum.Font.Gotham
		b.TextSize = 12
		b.Parent = content
		Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
		return b
	end

	local flashBtn = makeBtn("FLASH: OFF", 12)
	local speedBtn = makeBtn("VELOCIDAD: MEDIO", 52)
	local jumpBtn = makeBtn("SALTO ALTO: OFF", 92)
	local pushBtn = makeBtn("EMPUJAR: OFF", 132)

	-- Crédito
	local credit = Instance.new("TextLabel")
	credit.Size = UDim2.new(1, 0, 0, 20)
	credit.Position = UDim2.new(0, 0, 1, -24)
	credit.BackgroundTransparency = 1
	credit.Text = "creador angxlz"
	credit.TextColor3 = Color3.fromRGB(255, 160, 50)
	credit.Font = Enum.Font.GothamBold
	credit.TextSize = 12
	credit.Parent = content

	-- Entrada
	main.Position = UDim2.new(0, -210, 0.3, 0)
	TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
		Position = UDim2.new(0, 12, 0.3, 0)
	}):Play()

	-- Botones
	flashBtn.MouseButton1Click:Connect(function()
		flashEnabled = not flashEnabled
		if flashEnabled then
			flashBtn.Text = "FLASH: ON"
			flashBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 30)
		else
			flashBtn.Text = "FLASH: OFF"
			flashBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
		end
		applySettings()
	end)

	speedBtn.MouseButton1Click:Connect(function()
		if currentSpeed == "Lento" then
			currentSpeed = "Medio"
			speedValue = speeds.Medio
		elseif currentSpeed == "Medio" then
			currentSpeed = "Rapido"
			speedValue = speeds.Rapido
		else
			currentSpeed = "Lento"
			speedValue = speeds.Lento
		end
		speedBtn.Text = "VELOCIDAD: " .. string.upper(currentSpeed)
		if flashEnabled then applySettings() end
	end)

	jumpBtn.MouseButton1Click:Connect(function()
		highJumpEnabled = not highJumpEnabled
		if highJumpEnabled then
			jumpBtn.Text = "SALTO ALTO: ON"
			jumpBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
		else
			jumpBtn.Text = "SALTO ALTO: OFF"
			jumpBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
		end
		applySettings()
	end)

	pushBtn.MouseButton1Click:Connect(function()
		pushEnabled = not pushEnabled
		if pushEnabled then
			pushBtn.Text = "EMPUJAR: ON"
			pushBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
			startPush()
		else
			pushBtn.Text = "EMPUJAR: OFF"
			pushBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
			stopPush()
		end
	end)

	minBtn.MouseButton1Click:Connect(function()
		minimized = not minimized
		if minimized then
			TweenService:Create(main, TweenInfo.new(0.2), {Size = UDim2.new(0, 200, 0, 36)}):Play()
			content.Visible = false
			minBtn.Text = "+"
		else
			TweenService:Create(main, TweenInfo.new(0.2), {Size = UDim2.new(0, 200, 0, 260)}):Play()
			content.Visible = true
			minBtn.Text = "–"
		end
	end)

	player.CharacterAdded:Connect(function()
		task.wait(1)
		applySettings()
	end)
end

-- Key check
keyBtn.MouseButton1Click:Connect(function()
	if string.lower(keyBox.Text) == string.lower(KEY) then
		keyGui:Destroy()
		createMenu()
	else
		keyError.Text = "Key incorrecta"
		keyBox.Text = ""
		task.delay(1.5, function()
			keyError.Text = ""
		end)
	end
end)

print("Flash Premium TK | creador angxlz")
