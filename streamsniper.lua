local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

if shared.STREAM_SNIPER then
    pcall(function() shared.STREAM_SNIPER:Destroy() end)
end

local Screenguini = Instance.new("ScreenGui")
Screenguini.Name = HttpService:GenerateGUID(false)
Screenguini.Parent = CoreGui
Screenguini.ResetOnSpawn = false
shared.STREAM_SNIPER = Screenguini

-- [ Animation Settings (Apple Style Springs) ] --
local tSmooth = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local tFast = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- [ UI Construction ] --
local MainView = Instance.new("Frame")
MainView.Name = "MacWindow"
MainView.Parent = Screenguini
MainView.BackgroundColor3 = Color3.fromRGB(30, 30, 32)
MainView.BackgroundTransparency = 0.05 -- Sleek, almost solid dark mode
MainView.Position = UDim2.new(0.5, -200, 0.5, -150)
MainView.Size = UDim2.new(0, 400, 0, 300)
MainView.ClipsDescendants = true
MainView.AnchorPoint = Vector2.new(0.5, 0.5)

local UICorner_Main = Instance.new("UICorner")
UICorner_Main.CornerRadius = UDim.new(0, 12)
UICorner_Main.Parent = MainView

local UIStroke_Main = Instance.new("UIStroke")
UIStroke_Main.Color = Color3.fromRGB(255, 255, 255)
UIStroke_Main.Transparency = 0.85
UIStroke_Main.Parent = MainView

-- Entry Animation (Scale & Fade)
MainView.Size = UDim2.new(0, 380, 0, 280)
MainView.BackgroundTransparency = 1
TweenService:Create(MainView, TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(0, 400, 0, 300)}):Play()
TweenService:Create(MainView, tSmooth, {BackgroundTransparency = 0.05}):Play()

-- Top Bar (Draggable)
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainView
TitleBar.BackgroundTransparency = 1
TitleBar.Size = UDim2.new(1, 0, 0, 40)

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Size = UDim2.new(1, 0, 1, 0)
TitleText.Font = Enum.Font.GothamMedium
TitleText.Text = "Marcus Stream Sniper"
TitleText.TextColor3 = Color3.fromRGB(220, 220, 220)
TitleText.TextSize = 13

-- macOS Traffic Lights
local TrafficContainer = Instance.new("Frame")
TrafficContainer.Parent = TitleBar
TrafficContainer.BackgroundTransparency = 1
TrafficContainer.Position = UDim2.new(0, 15, 0.5, -6)
TrafficContainer.Size = UDim2.new(0, 60, 0, 12)

local function createTrafficLight(name, color, xPos, hoverIcon)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = TrafficContainer
    btn.BackgroundColor3 = color
    btn.Position = UDim2.new(0, xPos, 0, 0)
    btn.Size = UDim2.new(0, 12, 0, 12)
    btn.Text = hoverIcon
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.TextSize = 10
    btn.TextTransparency = 1
    btn.Font = Enum.Font.GothamBold
    btn.AutoButtonColor = false
    
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, tFast, {TextTransparency = 0.3}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, tFast, {TextTransparency = 1}):Play()
    end)
    
    return btn
end

local BtnClose = createTrafficLight("Close", Color3.fromRGB(255, 95, 86), 0, "×")
local BtnMin = createTrafficLight("Min", Color3.fromRGB(255, 189, 46), 20, "-")
local BtnMax = createTrafficLight("Max", Color3.fromRGB(39, 201, 63), 40, "+")

BtnClose.MouseButton1Click:Connect(function()
    TweenService:Create(MainView, tFast, {Size = UDim2.new(0, 380, 0, 280), BackgroundTransparency = 1}):Play()
    task.wait(0.15)
    Screenguini:Destroy()
end)

local isMinimized = false
BtnMin.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    local targetHeight = isMinimized and 40 or 300
    TweenService:Create(MainView, tSmooth, {Size = UDim2.new(0, 400, 0, targetHeight)}):Play()
end)

-- Content Area
local Content = Instance.new("Frame")
Content.Parent = MainView
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 0, 0, 40)
Content.Size = UDim2.new(1, 0, 1, -40)

local function createMacInput(title, yPos, placeholder)
    local label = Instance.new("TextLabel")
    label.Parent = Content
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 20, 0, yPos)
    label.Size = UDim2.new(0, 150, 0, 15)
    label.Font = Enum.Font.Gotham
    label.Text = title
    label.TextColor3 = Color3.fromRGB(150, 150, 150)
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left

    local box = Instance.new("TextBox")
    box.Parent = Content
    box.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
    box.BackgroundTransparency = 0.5
    box.Position = UDim2.new(0, 20, 0, yPos + 20)
    box.Size = UDim2.new(0, 180, 0, 32)
    box.Font = Enum.Font.Gotham
    box.PlaceholderColor3 = Color3.fromRGB(90, 90, 90)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.TextSize = 13
    box.ClearTextOnFocus = false
    
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)
    local stroke = Instance.new("UIStroke", box)
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.9
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    box.Focused:Connect(function()
        TweenService:Create(stroke, tFast, {Transparency = 0.5, Color = Color3.fromRGB(10, 132, 255)}):Play()
        TweenService:Create(box, tFast, {BackgroundTransparency = 0.2}):Play()
    end)
    box.FocusLost:Connect(function()
        TweenService:Create(stroke, tFast, {Transparency = 0.9, Color = Color3.fromRGB(255, 255, 255)}):Play()
        TweenService:Create(box, tFast, {BackgroundTransparency = 0.5}):Play()
    end)

    return box
end

local UserInputBox = createMacInput("Target Identifier", 10, "Username or User ID")
local PlaceInputBox = createMacInput("Place ID (Optional)", 70, "Defaults to current")

-- Avatar Display
local AvatarBg = Instance.new("Frame")
AvatarBg.Parent = Content
AvatarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AvatarBg.BackgroundTransparency = 0.6
AvatarBg.Position = UDim2.new(0, 240, 0, 15)
AvatarBg.Size = UDim2.new(0, 80, 0, 80)
Instance.new("UICorner", AvatarBg).CornerRadius = UDim.new(1, 0)

local AvatarImg = Instance.new("ImageLabel")
AvatarImg.Parent = AvatarBg
AvatarImg.BackgroundTransparency = 1
AvatarImg.Size = UDim2.new(1, 0, 1, 0)
AvatarImg.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
Instance.new("UICorner", AvatarImg).CornerRadius = UDim.new(1, 0)

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = Content
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 220, 0, 105)
StatusLabel.Size = UDim2.new(0, 120, 0, 15)
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.Text = "Awaiting Target"
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.TextSize = 12

-- Action Button
local StartBtn = Instance.new("TextButton")
StartBtn.Parent = Content
StartBtn.BackgroundColor3 = Color3.fromRGB(10, 132, 255)
StartBtn.Position = UDim2.new(0, 20, 0, 200)
StartBtn.Size = UDim2.new(1, -40, 0, 36)
StartBtn.Font = Enum.Font.GothamSemibold
StartBtn.Text = "Initialize Routing"
StartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StartBtn.TextSize = 13
StartBtn.AutoButtonColor = false
Instance.new("UICorner", StartBtn).CornerRadius = UDim.new(0, 6)

StartBtn.MouseEnter:Connect(function()
    TweenService:Create(StartBtn, tFast, {BackgroundColor3 = Color3.fromRGB(40, 150, 255)}):Play()
end)
StartBtn.MouseLeave:Connect(function()
    TweenService:Create(StartBtn, tFast, {BackgroundColor3 = Color3.fromRGB(10, 132, 255)}):Play()
end)

-- Smooth Custom Drag
local dragging, dragInput, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainView.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainView.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- [ Logic System ] --
local searching = false
local confirm = false
local fetchRequest = (request or http_request or (http and http.request) or syn.request)

local function HttpGet(url)
    return pcall(HttpService.JSONDecode, HttpService, game:HttpGet(url))
end

local function UpdateStatus(text, resetTime)
    StatusLabel.Text = text
    if resetTime then
        task.delay(resetTime, function()
            if StatusLabel.Text == text and not searching then
                StatusLabel.Text = "Awaiting Target"
            end
        end)
    end
end

local function getServers(id, cursor)
    local url = "https://games.roblox.com/v1/games/".. id .."/servers/Public?limit=100"
    if cursor then url = url .. "&cursor=".. cursor end
    return HttpGet(url)
end

local function fetchThumbs(tokens)
    local payload = {
        Url = "https://thumbnails.roblox.com/v1/batch",
        Headers = { ["Content-Type"] = "application/json" },
        Method = "POST",
        Body = {}
    }
    for _, token in ipairs(tokens) do
        table.insert(payload.Body, {
            requestId = "0:".. token ..":AvatarHeadshot:150x150:png:regular",
            type = "AvatarHeadShot", targetId = 0, token = token, format = "png", size = "150x150"
        })
    end
    payload.Body = HttpService:JSONEncode(payload.Body)
    local result = fetchRequest(payload)
    local s, data = pcall(HttpService.JSONDecode, HttpService, result.Body)
    return s, data and data.data or data
end

StartBtn.MouseButton1Click:Connect(function()
    if not fetchRequest then return UpdateStatus("Executor unsupported", 3) end

    if searching then
        searching = false
        StartBtn.Text = "Initialize Routing"
        UpdateStatus("Aborted", 3)
        return
    end

    searching = true
    StartBtn.Text = "Abort Routing"
    UpdateStatus("Resolving...")

    local s, Username, UserId = pcall(function()
        local userId = tonumber(UserInputBox.Text) or Players:GetUserIdFromNameAsync(UserInputBox.Text)
        return Players:GetNameFromUserIdAsync(userId), userId
    end)

    if not s then
        searching = false
        StartBtn.Text = "Initialize Routing"
        return UpdateStatus("Invalid Target", 3)
    end

    local tSuccess, tUrl = pcall(Players.GetUserThumbnailAsync, Players, UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
    AvatarImg.Image = tSuccess and tUrl or "rbxasset://textures/ui/GuiImagePlaceholder.png"

    UpdateStatus("Fetching Matrix...")
    local ts, response = HttpGet("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. UserId .. "&format=Png&size=150x150&isCircular=false")
    local thumbnail = ts and response['data'] and response['data'][1] and response['data'][1].imageUrl

    if not thumbnail then
        searching = false
        StartBtn.Text = "Initialize Routing"
        return UpdateStatus("Thumbnail fail", 3)
    end

    local placeId = tonumber(PlaceInputBox.Text)
    if PlaceInputBox.Text:gsub("%s", "") == "" then placeId = game.PlaceId end
    if not placeId then searching = false; StartBtn.Text = "Initialize Routing"; return UpdateStatus("Invalid Place ID", 3) end
    
    UpdateStatus("Scanning...")
    local cursor = nil
    local searched, maxSearchs = 0, 0

    while searching do
        if not Screenguini.Parent then break end
        local success, result = getServers(placeId, cursor)
        
        if success and result and result.data then
            local servers = result.data
            cursor = result.nextPageCursor
            maxSearchs = maxSearchs + #servers

            for index, server in ipairs(servers) do
                if not searching then break end
                if server.playerTokens then
                    local fs, thumbs = fetchThumbs(server.playerTokens)
                    if fs and thumbs then
                        for _, playerThumb in ipairs(thumbs) do
                            if playerThumb.imageUrl == thumbnail then
                                searching = false
                                StartBtn.Text = "Initialize Routing"
                                UpdateStatus("Target Locked.")
                                TeleportService:TeleportToPlaceInstance(placeId, server.id)
                                return
                            end
                        end
                    end
                end
                searched = searched + 1
                UpdateStatus(searched.."/"..maxSearchs.." Checked")
                if index % 15 == 0 then task.wait(0.1) end -- Throttled to prevent 429
            end
            if not cursor then break end
        else
            searching = false
            StartBtn.Text = "Initialize Routing"
            return UpdateStatus("API Rate Limited", 4)
        end
        task.wait(0.1)
    end
    
    if searching then
        searching = false
        StartBtn.Text = "Initialize Routing"
        UpdateStatus("Target Absent", 4)
    end
end)
