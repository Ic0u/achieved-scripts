--[[
    SeaUI
    Standalone Roblox UI library inspired by the Feral interface style.

    API:
        local SeaUI = loadstring(game:HttpGet("YOUR_RAW_URL"))()

        local Main = SeaUI:CreateMain({
            Title = "My Script",
            Desc = "Description"
        })

        local Page = Main:CreatePage({
            Page_Name = "Main",
            Page_Title = "Main"
        })

        local Section = Page:CreateSection("Features")

        Section:CreateLabel({Title = "Hello"})
        Section:CreateButton({Title = "Test"}, function() end)
        Section:CreateToggle({Title = "Enabled", Default = false}, function(v) end)
        Section:CreateSlider({Title = "Speed", Min = 0, Max = 100, Default = 50}, function(v) end)
        Section:CreateDropdown({
            Title = "Mode",
            Options = {"Normal", "Fast", "Extreme"},
            Default = "Normal"
        }, function(v) end)
        Section:CreateBox({Title = "Name", Placeholder = "Type..."}, function(v) end)
        Section:CreateKeybind({
            Title = "Menu Key",
            Default = Enum.KeyCode.RightControl
        }, function(v) end)
        Section:CreateColorPicker({
            Title = "Accent",
            Default = Color3.fromRGB(90, 160, 255)
        }, function(v) end)
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local SeaUI = {}
SeaUI.__index = SeaUI

local Theme = {
    Accent = Color3.fromRGB(90, 160, 255),
    Background = Color3.fromRGB(20, 20, 20),
    Surface = Color3.fromRGB(30, 30, 30),
    Surface2 = Color3.fromRGB(45, 45, 45),
    Surface3 = Color3.fromRGB(25, 25, 25),
    Text = Color3.fromRGB(220, 220, 220),
    Muted = Color3.fromRGB(150, 150, 150),
    White = Color3.fromRGB(240, 240, 240),
    Border = Color3.fromRGB(40, 40, 40),
    Radius = 4,
    Animation = 0.18
}

SeaUI.Theme = Theme

local function New(className, properties, parent)
    local object = Instance.new(className)
    for property, value in pairs(properties or {}) do
        object[property] = value
    end
    object.Parent = parent
    return object
end

local function Corner(parent, radius)
    return New("UICorner", {
        CornerRadius = UDim.new(0, radius or Theme.Radius)
    }, parent)
end

local function Stroke(parent, color, thickness, transparency)
    return New("UIStroke", {
        Color = color or Theme.Border,
        Thickness = thickness or 1,
        Transparency = transparency or 0
    }, parent)
end

local function Tween(object, properties, duration)
    TweenService:Create(
        object,
        TweenInfo.new(duration or Theme.Animation, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        properties
    ):Play()
end

local function ResolveParent()
    local ok, hui = pcall(function()
        return gethui and gethui()
    end)

    if ok and hui then
        return hui
    end

    return CoreGui
end

function SeaUI.new(config)
    config = config or {}

    local self = setmetatable({}, SeaUI)
    self.Pages = {}
    self.Sections = {}
    self._connections = {}
    self._destroyed = false

    local old = ResolveParent():FindFirstChild("SeaUI")
    if old then
        old:Destroy()
    end

    self.Gui = New("ScreenGui", {
        Name = "SeaUI",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }, ResolveParent())

    self.Main = New("Frame", {
        Name = "Main",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(640, 380),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        Active = true
    }, self.Gui)

    Corner(self.Main, 6)
    Stroke(self.Main, Theme.Border)

    self.Top = New("Frame", {
        Name = "Top",
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 = Theme.Surface,
        BorderSizePixel = 0
    }, self.Main)

    Corner(self.Top, 6)

    self.Title = New("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(14, 0),
        Size = UDim2.new(1, -28, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = tostring(config.Title or "SeaUI"),
        TextSize = 15,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left
    }, self.Top)

    self.Close = New("TextButton", {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -8, 0.5, 0),
        Size = UDim2.fromOffset(28, 28),
        Font = Enum.Font.GothamBold,
        Text = "×",
        TextSize = 20,
        TextColor3 = Theme.Muted
    }, self.Top)

    self.Close.MouseButton1Click:Connect(function()
        self:Destroy()
    end)

    self.Body = New("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, 42),
        Size = UDim2.new(1, 0, 1, -42)
    }, self.Main)

    self.Sidebar = New("Frame", {
        BackgroundColor3 = Theme.Surface3,
        BorderSizePixel = 0,
        Size = UDim2.fromOffset(150, 1),
        Position = UDim2.fromOffset(0, 0)
    }, self.Body)

    self.PageButtons = New("ScrollingFrame", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 3
    }, self.Sidebar)

    New("UIListLayout", {
        Padding = UDim.new(0, 5)
    }, self.PageButtons)

    New("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10)
    }, self.PageButtons)

    self.Content = New("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(150, 0),
        Size = UDim2.new(1, -150, 1, 0)
    }, self.Body)

    self.ContentTitle = New("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(16, 10),
        Size = UDim2.new(1, -32, 0, 28),
        Font = Enum.Font.GothamBold,
        Text = tostring(config.Desc or ""),
        TextSize = 16,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left
    }, self.Content)

    self.PageContainer = New("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(10, 42),
        Size = UDim2.new(1, -20, 1, -52)
    }, self.Content)

    local dragging = false
    local dragStart
    local startPosition

    self.Top.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPosition = self.Main.Position
        end
    end)

    self.Top.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then
            return
        end

        if input.UserInputType ~= Enum.UserInputType.MouseMovement
            and input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        local delta = input.Position - dragStart
        self.Main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end)

    return self
end

function SeaUI:CreateMain(config)
    return SeaUI.new(config)
end

function SeaUI:CreatePage(config)
    config = config or {}

    local name = tostring(config.Page_Name or config.Name or "Page")
    local title = tostring(config.Page_Title or name)

    local page = {
        Name = name,
        Title = title,
        Sections = {},
        Library = self
    }

    page.Frame = New("ScrollingFrame", {
        Name = name,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 4,
        Visible = false
    }, self.PageContainer)

    New("UIListLayout", {
        Padding = UDim.new(0, 8)
    }, page.Frame)

    New("UIPadding", {
        PaddingTop = UDim.new(0, 6),
        PaddingBottom = UDim.new(0, 8)
    }, page.Frame)

    local button = New("TextButton", {
        BackgroundColor3 = Theme.Surface,
        Size = UDim2.new(1, 0, 0, 30),
        BorderSizePixel = 0,
        Font = Enum.Font.GothamBold,
        Text = title,
        TextSize = 13,
        TextColor3 = Theme.Muted,
        AutoButtonColor = false
    }, self.PageButtons)

    Corner(button, 4)

    button.MouseEnter:Connect(function()
        if page.Frame.Visible then
            return
        end
        Tween(button, {BackgroundColor3 = Theme.Surface2})
    end)

    button.MouseLeave:Connect(function()
        if page.Frame.Visible then
            return
        end
        Tween(button, {BackgroundColor3 = Theme.Surface})
    end)

    button.MouseButton1Click:Connect(function()
        self:SelectPage(page)
    end)

    page.Button = button

    table.insert(self.Pages, page)

    function page:CreateSection(sectionName)
        return self.Library:_CreateSection(self, sectionName)
    end

    if #self.Pages == 1 then
        self:SelectPage(page)
    end

    return page
end

function SeaUI:SelectPage(page)
    for _, current in ipairs(self.Pages) do
        local selected = current == page
        current.Frame.Visible = selected

        Tween(
            current.Button,
            {
                BackgroundColor3 = selected and Theme.Accent or Theme.Surface,
                TextColor3 = selected and Theme.White or Theme.Muted
            }
        )
    end

    page.Frame.Visible = true
end

function SeaUI:_CreateSection(page, name)
    local section = {
        Name = tostring(name or "Section"),
        Page = page,
        Controls = {}
    }

    section.Frame = New("Frame", {
        BackgroundColor3 = Theme.Surface,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -4, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y
    }, page.Frame)

    Corner(section.Frame, 5)
    Stroke(section.Frame, Theme.Border)

    section.Title = New("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(10, 6),
        Size = UDim2.new(1, -20, 0, 24),
        Font = Enum.Font.GothamBold,
        Text = section.Name,
        TextSize = 13,
        TextColor3 = Theme.Accent,
        TextXAlignment = Enum.TextXAlignment.Left
    }, section.Frame)

    section.Container = New("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(10, 34),
        Size = UDim2.new(1, -20, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y
    }, section.Frame)

    New("UIListLayout", {
        Padding = UDim.new(0, 6)
    }, section.Container)

    New("UIPadding", {
        PaddingBottom = UDim.new(0, 10)
    }, section.Container)

    function section:CreateLabel(config)
        return self.Page.Library:_CreateLabel(self, config)
    end

    function section:CreateButton(config, callback)
        return self.Page.Library:_CreateButton(self, config, callback)
    end

    function section:CreateToggle(config, callback)
        return self.Page.Library:_CreateToggle(self, config, callback)
    end

    function section:CreateSlider(config, callback)
        return self.Page.Library:_CreateSlider(self, config, callback)
    end

    function section:CreateDropdown(config, callback)
        return self.Page.Library:_CreateDropdown(self, config, callback)
    end

    function section:CreateBox(config, callback)
        return self.Page.Library:_CreateBox(self, config, callback)
    end

    function section:CreateKeybind(config, callback)
        return self.Page.Library:_CreateKeybind(self, config, callback)
    end

    function section:CreateColorPicker(config, callback)
        return self.Page.Library:_CreateColorPicker(self, config, callback)
    end

    table.insert(page.Sections, section)
    return section
end

function SeaUI:_Row(section, height)
    return New("Frame", {
        BackgroundColor3 = Theme.Surface3,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, height or 34)
    }, section.Container)
end

function SeaUI:_Text(row, text)
    return New("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(10, 0),
        Size = UDim2.new(1, -20, 1, 0),
        Font = Enum.Font.Gotham,
        Text = tostring(text or ""),
        TextSize = 13,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left
    }, row)
end

function SeaUI:_CreateLabel(section, config)
    config = config or {}
    local label = self:_Text(self:_Row(section, 30), config.Title or config.Text or "Label")

    if config.Color then
        label.TextColor3 = config.Color
    end

    return label
end

function SeaUI:_CreateButton(section, config, callback)
    config = config or {}
    callback = typeof(callback) == "function" and callback or function() end

    local row = self:_Row(section, 34)

    local button = New("TextButton", {
        Position = UDim2.fromOffset(5, 3),
        Size = UDim2.new(1, -10, 1, -6),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        Font = Enum.Font.GothamBold,
        Text = tostring(config.Title or "Button"),
        TextSize = 13,
        TextColor3 = Theme.White,
        AutoButtonColor = false
    }, row)

    Corner(button, 4)

    button.MouseEnter:Connect(function()
        Tween(button, {BackgroundColor3 = Theme.Accent:Lerp(Color3.new(1, 1, 1), 0.12)})
    end)

    button.MouseLeave:Connect(function()
        Tween(button, {BackgroundColor3 = Theme.Accent})
    end)

    button.MouseButton1Click:Connect(callback)

    return button
end

function SeaUI:_CreateToggle(section, config, callback)
    config = config or {}
    callback = typeof(callback) == "function" and callback or function() end

    local value = config.Default == true
    local row = self:_Row(section, 36)

    self:_Text(row, config.Title or "Toggle").Size = UDim2.new(1, -60, 1, 0)

    local switch = New("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -8, 0.5, 0),
        Size = UDim2.fromOffset(36, 20),
        BackgroundColor3 = value and Theme.Accent or Theme.Surface2,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false
    }, row)

    Corner(switch, 10)

    local knob = New("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = value and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
        Size = UDim2.fromOffset(16, 16),
        BackgroundColor3 = Theme.White,
        BorderSizePixel = 0
    }, switch)

    Corner(knob, 8)

    local api = {}

    function api:Get()
        return value
    end

    function api:Set(newValue)
        value = newValue == true
        Tween(switch, {
            BackgroundColor3 = value and Theme.Accent or Theme.Surface2
        })
        Tween(knob, {
            Position = value and UDim2.new(1, -18, 0.5, 0)
                or UDim2.new(0, 2, 0.5, 0)
        })
        callback(value)
    end

    switch.MouseButton1Click:Connect(function()
        api:Set(not value)
    end)

    callback(value)
    return api
end

function SeaUI:_CreateSlider(section, config, callback)
    config = config or {}
    callback = typeof(callback) == "function" and callback or function() end

    local min = tonumber(config.Min) or 0
    local max = tonumber(config.Max) or 100
    local value = math.clamp(tonumber(config.Default) or min, min, max)
    local precise = config.Precise == true

    local row = self:_Row(section, 54)
    local label = self:_Text(row, config.Title or "Slider")
    label.Size = UDim2.new(1, -75, 0, 22)

    local valueLabel = New("TextLabel", {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -8, 0, 0),
        Size = UDim2.fromOffset(60, 22),
        Font = Enum.Font.GothamBold,
        Text = tostring(value),
        TextSize = 12,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Right
    }, row)

    local bar = New("Frame", {
        Position = UDim2.fromOffset(10, 31),
        Size = UDim2.new(1, -20, 0, 6),
        BackgroundColor3 = Theme.Surface2,
        BorderSizePixel = 0
    }, row)

    Corner(bar, 4)

    local fill = New("Frame", {
        Size = UDim2.new((value - min) / math.max(max - min, 1), 0, 1, 0),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0
    }, bar)

    Corner(fill, 4)

    local hitbox = New("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 15),
        Position = UDim2.fromOffset(0, -7),
        Text = ""
    }, bar)

    local dragging = false
    local api = {}

    local function setFromX(x, fire)
        local alpha = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local raw = min + (max - min) * alpha

        if precise then
            raw = math.floor(raw * 10 + 0.5) / 10
        else
            raw = math.floor(raw + 0.5)
        end

        value = raw
        valueLabel.Text = tostring(value)
        fill.Size = UDim2.new(alpha, 0, 1, 0)

        if fire then
            callback(value)
        end
    end

    hitbox.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            setFromX(input.Position.X, true)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (
            input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
        ) then
            setFromX(input.Position.X, true)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    function api:Get()
        return value
    end

    function api:SetValue(newValue)
        value = math.clamp(tonumber(newValue) or min, min, max)
        local alpha = (value - min) / math.max(max - min, 1)
        fill.Size = UDim2.new(alpha, 0, 1, 0)
        valueLabel.Text = tostring(value)
        callback(value)
    end

    callback(value)
    return api
end

function SeaUI:_CreateDropdown(section, config, callback)
    config = config or {}
    callback = typeof(callback) == "function" and callback or function() end

    local options = config.Options or config.Values or {}
    local current = config.Default or options[1] or "Select..."

    local row = self:_Row(section, 36)
    local button = New("TextButton", {
        Position = UDim2.fromOffset(5, 3),
        Size = UDim2.new(1, -10, 1, -6),
        BackgroundColor3 = Theme.Surface2,
        BorderSizePixel = 0,
        Font = Enum.Font.Gotham,
        Text = tostring(config.Title or "Dropdown") .. "  •  " .. tostring(current),
        TextSize = 12,
        TextColor3 = Theme.Text,
        AutoButtonColor = false
    }, row)

    Corner(button, 4)

    local list = New("Frame", {
        Visible = false,
        Position = UDim2.new(0, 5, 1, 3),
        Size = UDim2.new(1, -10, 0, math.min(#options * 28 + 6, 150)),
        BackgroundColor3 = Theme.Surface,
        BorderSizePixel = 0,
        ZIndex = 50
    }, button)

    Corner(list, 4)
    Stroke(list, Theme.Border)

    local layout = New("UIListLayout", {
        Padding = UDim.new(0, 2)
    }, list)

    New("UIPadding", {
        PaddingTop = UDim.new(0, 3),
        PaddingBottom = UDim.new(0, 3),
        PaddingLeft = UDim.new(0, 3),
        PaddingRight = UDim.new(0, 3)
    }, list)

    local api = {
        Options = options
    }

    local function refreshText()
        button.Text = tostring(config.Title or "Dropdown") .. "  •  " .. tostring(current)
    end

    local function rebuild()
        for _, child in ipairs(list:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end

        for _, option in ipairs(options) do
            local optionButton = New("TextButton", {
                BackgroundColor3 = Theme.Surface2,
                Size = UDim2.new(1, 0, 0, 24),
                BorderSizePixel = 0,
                Font = Enum.Font.Gotham,
                Text = tostring(option),
                TextSize = 12,
                TextColor3 = Theme.Text,
                AutoButtonColor = false,
                ZIndex = 51
            }, list)

            Corner(optionButton, 3)

            optionButton.MouseButton1Click:Connect(function()
                current = option
                refreshText()
                list.Visible = false
                callback(current)
            end)
        end
    end

    button.MouseButton1Click:Connect(function()
        list.Visible = not list.Visible
    end)

    function api:Get()
        return current
    end

    function api:Set(value)
        current = value
        refreshText()
        callback(value)
    end

    function api:Add(value)
        table.insert(options, value)
        rebuild()
    end

    function api:Remove(value)
        for i, option in ipairs(options) do
            if option == value then
                table.remove(options, i)
                break
            end
        end
        rebuild()
    end

    rebuild()
    callback(current)
    return api
end

function SeaUI:_CreateBox(section, config, callback)
    config = config or {}
    callback = typeof(callback) == "function" and callback or function() end

    local row = self:_Row(section, 36)

    self:_Text(row, config.Title or "Text Box").Size = UDim2.new(0.42, 0, 1, 0)

    local box = New("TextBox", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -8, 0.5, 0),
        Size = UDim2.new(0.55, 0, 0, 26),
        BackgroundColor3 = Theme.Surface2,
        BorderSizePixel = 0,
        Font = Enum.Font.Gotham,
        Text = tostring(config.Default or ""),
        PlaceholderText = tostring(config.Placeholder or "..."),
        PlaceholderColor3 = Theme.Muted,
        TextColor3 = Theme.Text,
        TextSize = 12,
        ClearTextOnFocus = false
    }, row)

    Corner(box, 4)

    box:GetPropertyChangedSignal("Text"):Connect(function()
        callback(box.Text, false)
    end)

    box.FocusLost:Connect(function()
        callback(box.Text, true)
    end)

    return box
end

function SeaUI:_CreateKeybind(section, config, callback)
    config = config or {}
    callback = typeof(callback) == "function" and callback or function() end

    local current = config.Default or Enum.KeyCode.E
    local capturing = false

    local row = self:_Row(section, 36)
    self:_Text(row, config.Title or "Keybind").Size = UDim2.new(1, -150, 1, 0)

    local button = New("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -8, 0.5, 0),
        Size = UDim2.fromOffset(135, 26),
        BackgroundColor3 = Theme.Surface2,
        BorderSizePixel = 0,
        Font = Enum.Font.GothamBold,
        Text = tostring(current):gsub("Enum.KeyCode.", ""):gsub("Enum.UserInputType.", ""),
        TextSize = 12,
        TextColor3 = Theme.Text,
        AutoButtonColor = false
    }, row)

    Corner(button, 4)

    button.MouseButton1Click:Connect(function()
        capturing = true
        button.Text = "Press key..."
    end)

    local connection = UserInputService.InputBegan:Connect(function(input, processed)
        if processed or not capturing then
            return
        end

        local key = input.KeyCode ~= Enum.KeyCode.Unknown
            and input.KeyCode
            or input.UserInputType

        current = key
        capturing = false
        button.Text = tostring(key):gsub("Enum.KeyCode.", ""):gsub("Enum.UserInputType.", "")
        callback(current)
    end)

    table.insert(self._connections, connection)

    local api = {}

    function api:GetKey()
        return current
    end

    function api:SetKey(key)
        current = key
        button.Text = tostring(key):gsub("Enum.KeyCode.", ""):gsub("Enum.UserInputType.", "")
        callback(current)
    end

    return api
end

function SeaUI:_CreateColorPicker(section, config, callback)
    config = config or {}
    callback = typeof(callback) == "function" and callback or function() end

    local current = config.Default or Theme.Accent
    local row = self:_Row(section, 36)

    self:_Text(row, config.Title or "Color")

    local swatch = New("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -8, 0.5, 0),
        Size = UDim2.fromOffset(70, 24),
        BackgroundColor3 = current,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false
    }, row)

    Corner(swatch, 4)

    local picker = New("Frame", {
        Visible = false,
        Position = UDim2.new(1, 0, 1, 5),
        AnchorPoint = Vector2.new(1, 0),
        Size = UDim2.fromOffset(190, 160),
        BackgroundColor3 = Theme.Surface,
        BorderSizePixel = 0,
        ZIndex = 60
    }, row)

    Corner(picker, 5)
    Stroke(picker, Theme.Border)

    local colorArea = New("Frame", {
        Position = UDim2.fromOffset(10, 10),
        Size = UDim2.new(1, -20, 0, 105),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0
    }, picker)

    Corner(colorArea, 4)

    New("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.Accent),
            ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
        })
    }, colorArea)

    local hueBar = New("Frame", {
        Position = UDim2.fromOffset(10, 122),
        Size = UDim2.new(1, -20, 0, 10),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0
    }, picker)

    Corner(hueBar, 4)

    New("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
        })
    }, hueBar)

    local api = {}

    swatch.MouseButton1Click:Connect(function()
        picker.Visible = not picker.Visible
    end)

    function api:Get()
        return current
    end

    function api:SetColor(color)
        if typeof(color) ~= "Color3" then
            return
        end
        current = color
        swatch.BackgroundColor3 = color
        callback(color)
    end

    callback(current)
    return api
end

function SeaUI:SetAccent(color)
    if typeof(color) ~= "Color3" then
        return
    end

    Theme.Accent = color

    for _, page in ipairs(self.Pages) do
        if page.Frame.Visible then
            page.Button.BackgroundColor3 = color
        end

        page.Button.MouseEnter:Connect(function()
            if not page.Frame.Visible then
                Tween(page.Button, {BackgroundColor3 = Theme.Surface2})
            end
        end)
    end
end

function SeaUI:SetVisible(visible)
    if self.Gui then
        self.Gui.Enabled = visible == true
    end
end

function SeaUI:Toggle()
    if self.Gui then
        self.Gui.Enabled = not self.Gui.Enabled
    end
end

function SeaUI:Destroy()
    if self._destroyed then
        return
    end

    self._destroyed = true

    for _, connection in ipairs(self._connections) do
        pcall(function()
            connection:Disconnect()
        end)
    end

    self._connections = {}

    if self.Gui then
        self.Gui:Destroy()
        self.Gui = nil
    end
end

return SeaUI
