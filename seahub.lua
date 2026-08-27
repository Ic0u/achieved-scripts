--[[
    Feral UI
    Cleaned and organized extraction from the provided deobfuscated source.

    Notes
    -----
    * The original control logic is intentionally preserved.
    * External helpers and state referenced by this block are still required
      (for example values such as L_841, L_622, L_626, and related helpers).
    * Variable names inside individual controls remain mostly untouched where
      a safe semantic rename could not be proven from the source alone.
    * Public API preserved:
        FeralUI.CreatePage(config)
        page.CreateSection(name)
        section.CreateToggle(config)
        section.CreateButton(config)
        section.CreateSlider(config)
        section.CreateDropdown(config)
        section.CreateBox(config)
        section.CreateLabel(config)
        section.CreateKeybind(config)
        section.CreateBind(config)
        section.CreateAccountTable(config)
]]

-- ============================================================
-- Public Library State
-- ============================================================

local FeralUI = {}
local pageTabIndex = -1
local pageLayoutIndex = -1
local pageDirection = 1

-- ------------------------------------------------------------
-- Page Creation
-- ------------------------------------------------------------
FeralUI.CreatePage = function(L_1099)
    local L_1100 = tostring(L_1099.Page_Name)
    local L_1101 = L_1100
    local L_1102 = tostring(L_1099.Page_Title)
    pageLayoutIndex = pageLayoutIndex + 1
    pageTabIndex = pageTabIndex + 1
    local L_1103 = Instance.new(L_32)
    local L_1104 = Instance.new(L_32)
    local L_1105 = Instance.new("UICorner")
    local L_1106 = Instance.new(L_32)
    local L_1107 = Instance.new(L_32)
    local L_1108 = Instance.new("UICorner")
    local L_1109 = Instance.new(L_32)
    local L_1110 = Instance.new("TextLabel")
    local L_1111 = Instance.new("TextButton")
    L_1103.Name = L_1100 .. "_Control"
    L_1103.Parent = L_841
    L_1103.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    L_1103.BackgroundTransparency = 1
    L_1103.Size = UDim2.new(1, -10, 0, 25)
    L_1103.LayoutOrder = pageTabIndex
    L_1104.Parent = L_1103
    L_1104.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    L_1104.BackgroundTransparency = 1
    L_1104.Position = UDim2.new(0, 5, 0, 0)
    L_1104.Size = UDim2.new(1, -5, 1, 0)
    L_1105.CornerRadius = UDim.new(0, 4)
    L_1105.Name = "TabNameCorner"
    L_1105.Parent = L_1104
    L_1106.Name = "Line"
    L_1106.Parent = L_1104
    L_1106.AnchorPoint = Vector2.new(0, 0.5)
    L_1106.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    L_1106.BackgroundTransparency = 1
    L_1106.Position = UDim2.new(0, 0, 0.5, 0)
    L_1106.Size = UDim2.new(0, 14, 1, 0)
    L_1107.Name = "PageInLine"
    L_1107.Parent = L_1106
    L_1107.AnchorPoint = Vector2.new(0.5, 0.5)
    L_1107.BorderSizePixel = 0
    L_1107.Position = UDim2.new(0.5, 0, 0.5, 0)
    L_1107.Size = UDim2.new(1, -10, 0, 0)
    L_1107.BackgroundColor3 = getgenv().UIColor["Page Selected Color"]
    table.insert(L_639["Page Selected Color"], function()
        L_1107.BackgroundColor3 = getgenv().UIColor["Page Selected Color"]
        return
    end)
    L_1108.Name = "LineCorner"
    L_1108.Parent = L_1107
    L_1109.Name = "TabTitleContainer"
    L_1109.Parent = L_1104
    L_1109.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    L_1109.BackgroundTransparency = 1
    L_1109.Position = UDim2.new(0, 15, 0, 0)
    L_1109.Size = UDim2.new(1, -15, 1, 0)
    L_1110.Name = "GUITextColor"
    L_1110.Parent = L_1109
    L_1110.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    L_1110.BackgroundTransparency = 1
    L_1110.Size = UDim2.new(1, 0, 1, 0)
    L_1110.Font = Enum.Font.GothamBold
    L_1110.Text = L_1100
    L_1110.TextColor3 = Color3.fromRGB(230, 230, 230)
    L_1110.TextSize = 14
    L_1110.TextXAlignment = Enum.TextXAlignment.Left
    L_1110.TextColor3 = getgenv().UIColor["GUI Text Color"]
    table.insert(L_639["GUI Text Color"], function()
        L_1110.TextColor3 = getgenv().UIColor["GUI Text Color"]
        return
    end)
    L_1111.Name = "PageButton"
    L_1111.Parent = L_1103
    L_1111.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    L_1111.BackgroundTransparency = 1
    L_1111.Size = UDim2.new(1, 0, 1, 0)
    L_1111.Font = Enum.Font.SourceSans
    L_1111.Text = ""
    L_1111.TextColor3 = Color3.fromRGB(0, 0, 0)
    L_1111.TextSize = 14
    local L_1112 = Instance.new(L_32)
    local L_1113 = Instance.new("UICorner")
    local L_1114 = Instance.new("TextLabel")
    local L_1115 = Instance.new("ScrollingFrame")
    local L_1116 = Instance.new("UIListLayout")
    local L_1117 = pageDirection
    pageDirection = pageDirection + 1
    L_1112.Name = "Page" .. L_1117
    L_1112.Parent = L_844
    L_1112.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
    L_1112.Position = UDim2.new(0, 190, 0, 30)
    L_1112.Size = UDim2.new(0, 435, 0, 325)
    L_1112.LayoutOrder = pageLayoutIndex
    table.insert(L_639["Background 1 Color"], function()
        L_1112.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
        return
    end)
    L_1112.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
    table.insert(L_639["Background 1 Transparency"], function()
        L_1112.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
        return
    end)
    L_1113.CornerRadius = UDim.new(0, 4)
    L_1113.Parent = L_1112
    L_1114.Name = "GUITextColor"
    L_1114.Parent = L_1112
    L_1114.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    L_1114.BackgroundTransparency = 1
    L_1114.Position = UDim2.new(0, 5, 0, 0)
    L_1114.Size = UDim2.new(1, 0, 0, 25)
    L_1114.Font = Enum.Font.GothamBold
    L_1114.Text = L_1102
    L_1114.TextSize = 16
    L_1114.TextXAlignment = Enum.TextXAlignment.Left
    L_1114.TextColor3 = getgenv().UIColor["GUI Text Color"]
    table.insert(L_639["GUI Text Color"], function()
        L_1114.TextColor3 = getgenv().UIColor["GUI Text Color"]
        return
    end)
    L_1115.Name = "PageList"
    L_1115.Parent = L_1112
    L_1115.Active = true
    L_1115.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    L_1115.BackgroundTransparency = 1
    L_1115.BorderColor3 = Color3.fromRGB(27, 42, 53)
    L_1115.BorderSizePixel = 0
    L_1115.Position = UDim2.new(0, 5, 0, 30)
    L_1115.Size = UDim2.new(1, -10, 1, -30)
    L_1115.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
    L_1115.ScrollBarThickness = 5
    L_1115.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
    L_1116.Name = "Pagelistlayout"
    L_1116.Parent = L_1115
    L_1116.SortOrder = Enum.SortOrder.LayoutOrder
    L_1116.Padding = UDim.new(0, 5)
    L_1116:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        L_1115.CanvasSize = UDim2.new(0, 0, 0, L_1116.AbsoluteContentSize.Y + 5)
        return
    end)
    local L_1118 = Instance.new(L_32)
    local L_1119 = Instance.new("UICorner")
    local L_1120 = Instance.new(L_32)
    local L_1121 = Instance.new("ImageLabel")
    local L_1122 = Instance.new("TextButton")
    local L_1123 = Instance.new("TextBox")
    L_1118.Name = "Background2"
    L_1118.Parent = L_1112
    L_1118.AnchorPoint = Vector2.new(1, 0)
    L_1118.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
    L_1118.Position = UDim2.new(1, -5, 0, 5)
    L_1118.Size = UDim2.new(0, 20, 0, 20)
    L_1118.ClipsDescendants = true
    table.insert(L_639["Background 2 Color"], function()
        L_1118.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
        return
    end)
    L_1119.CornerRadius = UDim.new(0, 2)
    L_1119.Name = "PageSearchCorner"
    L_1119.Parent = L_1118
    L_1120.Name = "SearchFrame"
    L_1120.Parent = L_1118
    L_1120.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    L_1120.BackgroundTransparency = 1
    L_1120.Size = UDim2.new(0, 20, 0, 20)
    L_1121.Name = "SearchIcon"
    L_1121.Parent = L_1120
    L_1121.AnchorPoint = Vector2.new(0.5, 0.5)
    L_1121.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    L_1121.BackgroundTransparency = 1
    L_1121.Position = UDim2.new(0.5, 0, 0.5, 0)
    L_1121.Size = UDim2.new(0, 16, 0, 16)
    L_1121.Image = "rbxassetid://8154282545"
    L_1121.ImageColor3 = getgenv().UIColor["Search Icon Color"]
    table.insert(L_639["Search Icon Color"], function()
        L_1121.ImageColor3 = getgenv().UIColor["Search Icon Color"]
        return
    end)
    L_1122.Name = "active"
    L_1122.Parent = L_1120
    L_1122.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    L_1122.BackgroundTransparency = 1
    L_1122.Size = UDim2.new(1, 0, 1, 0)
    L_1122.Font = Enum.Font.SourceSans
    L_1122.Text = ""
    L_1122.TextColor3 = Color3.fromRGB(0, 0, 0)
    L_1122.TextSize = 14
    L_1123.Name = "TextColorPlaceholder"
    L_1123.Parent = L_1118
    L_1123.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    L_1123.BackgroundTransparency = 1
    L_1123.Position = UDim2.new(0, 30, 0, 0)
    L_1123.Size = UDim2.new(1, -30, 1, 0)
    L_1123.Font = Enum.Font.GothamBold
    L_1123.Text = ""
    L_1123.TextSize = 14
    L_1123.TextXAlignment = Enum.TextXAlignment.Left
    L_1123.PlaceholderText = "Search Section name"
    L_1123.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
    L_1123.TextColor3 = getgenv().UIColor[L_34]
    table.insert(L_639["Placeholder Text Color"], function()
        L_1123.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
        return
    end)
    table.insert(L_639[L_34], function()
        L_1123.TextColor3 = getgenv().UIColor[L_34]
        return
    end)
    local L_1124 = false
    L_1122.MouseEnter:Connect(function()
        L_733:Create(L_1121, TweenInfo.new(getgenv().UIColor["Tween Animation 3 Speed"]), { ImageColor3 = getgenv().UIColor["Search Icon Highlight Color"] }):Play()
        return
    end)
    L_1122.MouseLeave:Connect(function()
        L_733:Create(L_1121, TweenInfo.new(getgenv().UIColor["Tween Animation 3 Speed"]), { ImageColor3 = getgenv().UIColor["Search Icon Color"] }):Play()
        return
    end)
    L_1122.MouseButton1Click:Connect(function()
        L_732.ButtonEffect()
        return
    end)
    L_1123.Focused:Connect(function()
        L_732.ButtonEffect()
        return
    end)
    L_1122.MouseButton1Click:Connect(function()
        L_1124 = not L_1124
        local L_1125 = L_1124 and UDim2.new(0, 175, 0, 20) or UDim2.new(0, 20, 0, 20)
        game.TweenService:Create(L_1118, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), { Size = L_1125 }):Play()
        return
    end)
    local L_1128 = function()
        for L_1126, L_1127 in next, L_1115:GetChildren() do
            if not L_1127:IsA("UIListLayout") then
                L_1127.Visible = false
            end
        end
        return
    end
    local L_1131 = function()
        for L_1129, L_1130 in pairs(L_1115:GetChildren()) do
            if not L_1130:IsA("UIListLayout") and string.find(string.lower(L_1130.Name), string.lower(L_1123.Text)) then
                L_1130.Visible = true
            end
        end
        return
    end
    L_1123:GetPropertyChangedSignal("Text"):Connect(function()
        L_1128()
        L_1131()
        return
    end)
    for L_1132, L_1133 in pairs(L_841:GetChildren()) do
        if not L_1133:IsA("UIListLayout") and L_1132 == 2 then
            L_1133.Frame.Line.PageInLine.Size = UDim2.new(1, -10, 1, -10)
            oldlay = L_1133.LayoutOrder
            oldobj = L_1133
        end
    end
    L_1111.MouseButton1Click:Connect(function()
        L_732.ButtonEffect()
        if tostring(L_845.CurrentPage) == L_1112.Name then
            return
        end
        local L_1134 = getgenv().UIColor["Tween Animation 1 Speed"] or 0.25
        local L_1135 = TweenInfo.new(L_1134, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        for L_1136, L_1137 in ipairs(L_841:GetChildren()) do
            if L_1137:IsA(L_32) and L_1137:FindFirstChild(L_32) then
                local L_1138 = L_1137.Frame:FindFirstChild("Line")
                if L_1138 and L_1138:FindFirstChild("PageInLine") then
                    local L_1139 = L_1138.PageInLine
                    L_733:Create(L_1139, L_1135, { Size = UDim2.new(1, -10, 0, 0), Position = UDim2.new(0.5, 0, 1, 0), AnchorPoint = Vector2.new(0.5, 1) }):Play()
                end
            end
        end
        L_733:Create(L_1107, L_1135, { Size = UDim2.new(1, -10, 1, -10), Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5) }):Play()
        for L_1140, L_1141 in ipairs(L_844:GetChildren()) do
            if L_1141:IsA(L_32) then
                L_1141.Visible = L_1141 == L_1112
            end
        end
        local L_1142 = L_1112:FindFirstChild("PageList")
        if L_1142 and L_1142:IsA("ScrollingFrame") then
            L_1142.CanvasPosition = Vector2.new(0, 0)
        end
        L_845:JumpTo(L_1112)
        return
    end)
    return {
        
-- ------------------------------------------------------------
-- Section Creation
-- ------------------------------------------------------------
CreateSection = function(L_1143, L_1144)
            local L_1145 = tostring(L_1143)
            local L_1146 = true
            if L_1144 ~= nil then
                L_1146 = game.PlaceId == 11424731604
            end
            if not L_1146 then
                return {
                    
-- ------------------------------------------------------------
-- Toggle Control
-- ------------------------------------------------------------
CreateToggle = function()
                        return {
                            SetStage = function()
                                return
                            end,
                            SetKeybind = function()
                                return
                            end,
                            GetKeybind = function()
                                return nil
                            end
                        }
                    end,
                    
-- ------------------------------------------------------------
-- Button Control
-- ------------------------------------------------------------
CreateButton = function()
                        return
                    end,
                    
-- ------------------------------------------------------------
-- Label Control
-- ------------------------------------------------------------
CreateLabel = function()
                        return {
                            SetText = function()
                                return
                            end,
                            SetColor = function()
                                return
                            end
                        }
                    end,
                    
-- ------------------------------------------------------------
-- Dropdown Control
-- ------------------------------------------------------------
CreateDropdown = function()
                        return {
                            ClearText = function()
                                return
                            end,
                            GetNewList = function()
                                return
                            end,
                            rf = function()
                                return
                            end
                        }
                    end,
                    
-- ------------------------------------------------------------
-- Bind Control
-- ------------------------------------------------------------
CreateBind = function()
                        return
                    end,
                    
-- ------------------------------------------------------------
-- Text Box Control
-- ------------------------------------------------------------
CreateBox = function()
                        return {
                            SetValue = function()
                                return
                            end
                        }
                    end,
                    
-- ------------------------------------------------------------
-- Slider Control
-- ------------------------------------------------------------
CreateSlider = function()
                        return {
                            SetValue = function()
                                return
                            end
                        }
                    end
                }
            end
            local L_1147 = Instance.new(L_32)
            local L_1148 = Instance.new("UICorner")
            local L_1149 = Instance.new(L_32)
            local L_1150 = Instance.new("TextLabel")
            local L_1151 = Instance.new(L_32)
            local L_1152 = Instance.new("UIGradient")
            local L_1153 = Instance.new("UIListLayout")
            L_1147.Name = L_1143 .. "_Dot"
            L_1147.Parent = L_1115
            L_1147.Size = UDim2.new(0, 415, 0, 100)
            L_1147.BackgroundColor3 = getgenv().UIColor["Background 3 Color"]
            table.insert(L_639["Background 3 Color"], function()
                L_1147.BackgroundColor3 = getgenv().UIColor["Background 3 Color"]
                return
            end)
            L_1147.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
            table.insert(L_639["Background 1 Transparency"], function()
                L_1147.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                return
            end)
            L_1148.CornerRadius = UDim.new(0, 4)
            L_1148.Parent = L_1147
            L_1149.Name = "Topsec"
            L_1149.Parent = L_1147
            L_1149.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
            L_1149.BackgroundTransparency = 1
            L_1149.Size = UDim2.new(0, 415, 0, 30)
            L_1150.Name = "Sectiontitle"
            L_1150.Parent = L_1149
            L_1150.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
            L_1150.BackgroundTransparency = 1
            L_1150.Size = UDim2.new(1, 0, 1, 0)
            L_1150.Font = Enum.Font.GothamBold
            L_1150.Text = L_1143
            L_1150.TextSize = 14
            L_1150.TextColor3 = getgenv().UIColor["Section Text Color"]
            table.insert(L_639["Section Text Color"], function()
                L_1150.TextColor3 = getgenv().UIColor["Section Text Color"]
                return
            end)
            L_1151.Name = "Linesec"
            L_1151.Parent = L_1149
            L_1151.AnchorPoint = Vector2.new(0.5, 1)
            L_1151.BorderSizePixel = 0
            L_1151.Position = UDim2.new(0.5, 0, 1, -2)
            L_1151.Size = UDim2.new(1, -10, 0, 2)
            L_1151.BackgroundColor3 = getgenv().UIColor["Section Underline Color"]
            table.insert(L_639["Section Underline Color"], function()
                L_1151.BackgroundColor3 = getgenv().UIColor["Section Underline Color"]
                return
            end)
            L_1152.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(0.51, 0.02), NumberSequenceKeypoint.new(1, 1) })
            L_1152.Parent = L_1151
            L_1153.Name = "SectionList"
            L_1153.Parent = L_1147
            L_1153.SortOrder = Enum.SortOrder.LayoutOrder
            L_1153.Padding = UDim.new(0, 5)
            L_1153:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                L_1147.Size = UDim2.new(1, -5, 0, L_1153.AbsoluteContentSize.Y + 5)
                return
            end)
            return {
                CreateToggle = function(L_1154, L_1155)
                    local L_1156 = tostring(L_1154.Title)
                    local L_1157 = L_1154.Desc
                    local L_1158 = L_1154.Default
                    local L_1159 = L_1154.Keybind or false
                    local L_1160 = L_1154.DefaultKey or nil
                    local L_1161 = L_1154.Textbox or false
                    local L_1162 = L_1154.TextboxPlaceholder or "Enter value..."
                    local L_1163 = L_1154.TextboxDefault or ""
                    local L_1164 = L_1154.TextboxCallback or function()
                        return
                    end
                    local L_1165 = L_1154.Requirements ~= nil
                    local L_1166 = L_1154.Requirements or {}
                    local L_1167 = L_1154.RequirementUpdateInterval or 1
                    local L_1168 = L_1155 or function()
                        return
                    end
                    local L_1169 = Instance.new(L_32)
                    local L_1170 = Instance.new(L_32)
                    local L_1171 = Instance.new("ImageLabel")
                    local L_1172 = Instance.new("ImageLabel")
                    local L_1173 = Instance.new("TextLabel")
                    local L_1174 = Instance.new("TextLabel")
                    local L_1175 = Instance.new(L_32)
                    local L_1176 = Instance.new("UICorner")
                    local L_1177 = Instance.new("TextButton")
                    local L_1178 = Instance.new("UIListLayout")
                    local L_1179 = Instance.new(L_32)
                    local L_1180 = Instance.new("TextButton")
                    local L_1181 = Instance.new("UICorner")
                    local L_1182 = Instance.new("UIStroke")
                    local L_1183 = Instance.new(L_32)
                    local L_1184 = Instance.new("TextBox")
                    local L_1185 = Instance.new("UICorner")
                    local L_1186 = Instance.new("UIStroke")
                    local L_1187 = Instance.new(L_32)
                    local L_1188 = Instance.new(L_32)
                    local L_1189 = Instance.new("UIListLayout")
                    local L_1190 = {}
                    L_1169.Name = "ToggleFrame"
                    L_1169.Parent = L_1147
                    L_1169.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1169.BackgroundTransparency = 1
                    L_1169.Position = UDim2.new(0, 0, 0.300000012, 0)
                    L_1169.Size = UDim2.new(1, 0, 0, 0)
                    L_1169.AutomaticSize = Enum.AutomaticSize.Y
                    L_1170.Name = "TogFrame1"
                    L_1170.Parent = L_1169
                    L_1170.AnchorPoint = Vector2.new(0.5, 0.5)
                    L_1170.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1170.BackgroundTransparency = 1
                    L_1170.Position = UDim2.new(0.5, 0, 0.5, 0)
                    L_1170.Size = UDim2.new(1, -10, 0, 0)
                    L_1170.AutomaticSize = Enum.AutomaticSize.Y
                    L_1171.Name = "checkbox"
                    L_1171.Parent = L_1170
                    L_1171.AnchorPoint = Vector2.new(1, 0.5)
                    L_1171.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1171.BackgroundTransparency = 1
                    L_1171.Position = UDim2.new(1, -5, 0.5, 3)
                    L_1171.Size = UDim2.new(0, 25, 0, 25)
                    L_1171.Image = "rbxassetid://4552505888"
                    L_1171.ImageColor3 = getgenv().UIColor["Toggle Border Color"]
                    L_1171.ZIndex = 3
                    table.insert(L_639["Toggle Border Color"], function()
                        L_1171.ImageColor3 = getgenv().UIColor["Toggle Border Color"]
                        return
                    end)
                    L_1172.Name = "check"
                    L_1172.Parent = L_1171
                    L_1172.AnchorPoint = Vector2.new(0, 1)
                    L_1172.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1172.BackgroundTransparency = 1
                    L_1172.Position = UDim2.new(0, 0, 1, 0)
                    L_1172.Image = "rbxassetid://4555411759"
                    L_1172.ImageColor3 = getgenv().UIColor["Toggle Checked Color"]
                    L_1172.ZIndex = 3
                    table.insert(L_639["Toggle Checked Color"], function()
                        L_1172.ImageColor3 = getgenv().UIColor["Toggle Checked Color"]
                        return
                    end)
                    if L_1159 then
                        L_1179.Name = "KeybindFrame"
                        L_1179.Parent = L_1170
                        L_1179.AnchorPoint = Vector2.new(1, 0.5)
                        L_1179.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                        L_1179.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                        L_1179.Position = UDim2.new(1, -35, 0.5, 3)
                        L_1179.Size = UDim2.new(0, 45, 0, 20)
                        L_1179.ZIndex = 2
                        table.insert(L_639["Background 1 Color"], function()
                            L_1179.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                            return
                        end)
                        table.insert(L_639["Background 1 Transparency"], function()
                            L_1179.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                            return
                        end)
                        L_1181.CornerRadius = UDim.new(0, 4)
                        L_1181.Parent = L_1179
                        L_1182.Name = "KeybindBorder"
                        L_1182.Parent = L_1179
                        L_1182.Color = getgenv().UIColor["Toggle Border Color"]
                        L_1182.Thickness = 1
                        L_1182.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                        table.insert(L_639["Toggle Border Color"], function()
                            L_1182.Color = getgenv().UIColor["Toggle Border Color"]
                            return
                        end)
                        L_1180.Name = "KeybindButton"
                        L_1180.Parent = L_1179
                        L_1180.BackgroundTransparency = 1
                        L_1180.Size = UDim2.new(1, 0, 1, 0)
                        L_1180.Font = Enum.Font.GothamBold
                        L_1180.Text = L_1160 or "..."
                        L_1180.TextColor3 = getgenv().UIColor[L_34]
                        L_1180.TextSize = 10
                        L_1180.TextWrapped = true
                        L_1180.ZIndex = 2
                        table.insert(L_639[L_34], function()
                            L_1180.TextColor3 = getgenv().UIColor[L_34]
                            return
                        end)
                    end
                    if L_1161 then
                        L_1183.Name = "TextboxFrame"
                        L_1183.Parent = L_1170
                        L_1183.AnchorPoint = Vector2.new(1, 0.5)
                        L_1183.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                        L_1183.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                        L_1183.Position = UDim2.new(1, L_1159 and -85 or -35, 0.5, 3)
                        L_1183.Size = UDim2.new(0, 60, 0, 20)
                        L_1183.ZIndex = 2
                        table.insert(L_639["Background 1 Color"], function()
                            L_1183.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                            return
                        end)
                        table.insert(L_639["Background 1 Transparency"], function()
                            L_1183.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                            return
                        end)
                        L_1185.CornerRadius = UDim.new(0, 4)
                        L_1185.Parent = L_1183
                        L_1186.Name = "TextboxBorder"
                        L_1186.Parent = L_1183
                        L_1186.Color = getgenv().UIColor["Toggle Border Color"]
                        L_1186.Thickness = 1
                        L_1186.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                        table.insert(L_639["Toggle Border Color"], function()
                            L_1186.Color = getgenv().UIColor["Toggle Border Color"]
                            return
                        end)
                        L_1184.Name = "TextboxInput"
                        L_1184.Parent = L_1183
                        L_1184.BackgroundTransparency = 1
                        L_1184.Position = UDim2.new(0, 6, 0, 0)
                        L_1184.Size = UDim2.new(1, -12, 1, 0)
                        L_1184.Font = Enum.Font.Gotham
                        L_1184.PlaceholderText = L_1162
                        L_1184.Text = L_1163
                        L_1184.TextColor3 = getgenv().UIColor[L_34]
                        L_1184.PlaceholderColor3 = getgenv().UIColor["Toggle Desc Color"]
                        L_1184.TextSize = 12
                        L_1184.TextXAlignment = Enum.TextXAlignment.Left
                        L_1184.ClearTextOnFocus = false
                        L_1184.ZIndex = 2
                        table.insert(L_639[L_34], function()
                            L_1184.TextColor3 = getgenv().UIColor[L_34]
                            return
                        end)
                        table.insert(L_639["Toggle Desc Color"], function()
                            L_1184.PlaceholderColor3 = getgenv().UIColor["Toggle Desc Color"]
                            return
                        end)
                        L_1184.FocusLost:Connect(function(L_1191)
                            if L_1191 then
                                L_1164(L_1184.Text)
                            end
                            return
                        end)
                    end
                    local L_1192 = 5
                    if L_1157 then
                        L_1192 = 0
                        L_1173.Name = "ToggleDesc"
                        L_1173.Parent = L_1170
                        L_1173.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                        L_1173.BackgroundTransparency = 1
                        L_1173.Position = UDim2.new(0, 15, 0, 20)
                        L_1173.Size = UDim2.new(1, (L_1159 and -90 or -50) - (L_1161 and 70 or 0), 0, 0)
                        L_1173.Font = Enum.Font.GothamBlack
                        L_1173.Text = L_1157
                        L_1173.TextSize = 13
                        L_1173.TextWrapped = true
                        L_1173.TextXAlignment = Enum.TextXAlignment.Left
                        L_1173.RichText = true
                        L_1173.AutomaticSize = Enum.AutomaticSize.Y
                        L_1173.TextColor3 = getgenv().UIColor["Toggle Desc Color"]
                        table.insert(L_639["Toggle Desc Color"], function()
                            L_1173.TextColor3 = getgenv().UIColor["Toggle Desc Color"]
                            return
                        end)
                    else
                        L_1173.Text = ""
                    end
                    L_1174.Name = "TextColor"
                    L_1174.Parent = L_1170
                    L_1174.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1174.BackgroundTransparency = 1
                    L_1174.Position = UDim2.new(0, 10, 0, L_1192)
                    L_1174.Size = UDim2.new(1, -10, 0, 20)
                    L_1174.Font = Enum.Font.GothamBlack
                    L_1174.Text = L_1156
                    L_1174.TextSize = 14
                    L_1174.TextXAlignment = Enum.TextXAlignment.Left
                    L_1174.TextYAlignment = Enum.TextYAlignment.Center
                    L_1174.RichText = true
                    L_1174.AutomaticSize = Enum.AutomaticSize.Y
                    L_1174.TextColor3 = getgenv().UIColor[L_34]
                    table.insert(L_639[L_34], function()
                        L_1174.TextColor3 = getgenv().UIColor[L_34]
                        return
                    end)
                    L_1175.Name = "Background1"
                    L_1175.Parent = L_1170
                    L_1175.Size = UDim2.new(1, 0, 1, 6)
                    L_1175.ZIndex = 0
                    L_1175.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                    table.insert(L_639["Background 1 Color"], function()
                        L_1175.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                        return
                    end)
                    L_1175.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                    table.insert(L_639["Background 1 Transparency"], function()
                        L_1175.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                        return
                    end)
                    L_1176.CornerRadius = UDim.new(0, 4)
                    L_1176.Name = "ToggleCorner"
                    L_1176.Parent = L_1175
                    L_1177.Name = "ToggleButton"
                    L_1177.Parent = L_1170
                    L_1177.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1177.BackgroundTransparency = 1
                    L_1177.Size = UDim2.new(1, 0, 1, 6)
                    L_1177.Font = Enum.Font.SourceSans
                    L_1177.Text = ""
                    L_1177.TextColor3 = Color3.fromRGB(0, 0, 0)
                    L_1177.TextSize = 14
                    L_1178.Name = "ToggleList"
                    L_1178.Parent = L_1169
                    L_1178.HorizontalAlignment = Enum.HorizontalAlignment.Center
                    L_1178.SortOrder = Enum.SortOrder.LayoutOrder
                    L_1178.VerticalAlignment = Enum.VerticalAlignment.Center
                    L_1178.Padding = UDim.new(0, 0)
                    local L_1193 = true
                    local L_1194 = nil
                    if L_1165 and #L_1166 > 0 then
                        L_1176.CornerRadius = UDim.new(0, 4)
                        L_1187.Name = "RequirementsContainer"
                        L_1187.Parent = L_1170
                        L_1187.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                        L_1187.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                        L_1187.Size = UDim2.new(1, 0, 0, 0)
                        L_1187.AutomaticSize = Enum.AutomaticSize.Y
                        L_1187.Position = UDim2.new(0, 0, 1, 4)
                        L_1187.ZIndex = 0
                        table.insert(L_639["Background 1 Color"], function()
                            L_1187.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                            return
                        end)
                        table.insert(L_639["Background 1 Transparency"], function()
                            L_1187.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                            return
                        end)
                        local L_1195 = Instance.new("UICorner")
                        L_1195.CornerRadius = UDim.new(0, 4)
                        L_1195.Parent = L_1187
                        L_1188.Name = "RequirementsInner"
                        L_1188.Parent = L_1187
                        L_1188.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        L_1188.BackgroundTransparency = 0.85
                        L_1188.Size = UDim2.new(1, -12, 0, 0)
                        L_1188.AutomaticSize = Enum.AutomaticSize.Y
                        L_1188.Position = UDim2.new(0, 6, 0, 6)
                        L_1188.ZIndex = 1
                        local L_1196 = Instance.new("UICorner")
                        L_1196.CornerRadius = UDim.new(0, 3)
                        L_1196.Parent = L_1188
                        local L_1197 = Instance.new("UIPadding")
                        L_1197.PaddingTop = UDim.new(0, 6)
                        L_1197.PaddingBottom = UDim.new(0, 6)
                        L_1197.PaddingLeft = UDim.new(0, 8)
                        L_1197.PaddingRight = UDim.new(0, 8)
                        L_1197.Parent = L_1188
                        local L_1198 = Instance.new("UIPadding")
                        L_1198.PaddingBottom = UDim.new(0, 6)
                        L_1198.Parent = L_1187
                        L_1189.Name = "RequirementsLayout"
                        L_1189.Parent = L_1188
                        L_1189.FillDirection = Enum.FillDirection.Vertical
                        L_1189.HorizontalAlignment = Enum.HorizontalAlignment.Left
                        L_1189.SortOrder = Enum.SortOrder.LayoutOrder
                        L_1189.Padding = UDim.new(0, 4)
                        for L_1199, L_1200 in ipairs(L_1166) do
                            local L_1201 = Instance.new(L_32)
                            L_1201.Name = "Req_" .. L_1200
                            L_1201.Parent = L_1188
                            L_1201.BackgroundTransparency = 1
                            L_1201.Size = UDim2.new(1, 0, 0, 16)
                            L_1201.LayoutOrder = L_1199
                            local L_1202 = Instance.new("ImageLabel")
                            L_1202.Name = "Icon"
                            L_1202.Parent = L_1201
                            L_1202.BackgroundTransparency = 1
                            L_1202.Size = UDim2.new(0, 14, 0, 14)
                            L_1202.Position = UDim2.new(0, 0, 0.5, 0)
                            L_1202.AnchorPoint = Vector2.new(0, 0.5)
                            L_1202.Image = "rbxassetid://7072725342"
                            L_1202.ImageColor3 = Color3.fromRGB(255, 85, 85)
                            L_1202.ZIndex = 2
                            local L_1203 = Instance.new("TextLabel")
                            L_1203.Name = "Text"
                            L_1203.Parent = L_1201
                            L_1203.BackgroundTransparency = 1
                            L_1203.Size = UDim2.new(1, -22, 1, 0)
                            L_1203.Position = UDim2.new(0, 20, 0, 0)
                            L_1203.Font = Enum.Font.Gotham
                            L_1203.Text = L_1200
                            L_1203.TextSize = 11
                            L_1203.TextXAlignment = Enum.TextXAlignment.Left
                            L_1203.TextColor3 = getgenv().UIColor["Toggle Desc Color"]
                            L_1203.ZIndex = 2
                            table.insert(L_639["Toggle Desc Color"], function()
                                L_1203.TextColor3 = getgenv().UIColor["Toggle Desc Color"]
                                return
                            end)
                            L_1190[L_1200] = { Frame = L_1201, Icon = L_1202, Text = L_1203, Met = false }
                        end
                        local L_1208 = function()
                            local L_1204 = true
                            for L_1205, L_1206 in pairs(L_1190) do
                                local L_1207 = RequirementsTracker:Check(L_1205)
                                L_1206.Met = L_1207
                                if L_1207 then
                                    L_1206.Icon.Image = "rbxassetid://7072706620"
                                    L_1206.Icon.ImageColor3 = Color3.fromRGB(85, 255, 127)
                                else
                                    L_1206.Icon.Image = "rbxassetid://7072725342"
                                    L_1206.Icon.ImageColor3 = Color3.fromRGB(255, 85, 85)
                                    L_1204 = false
                                end
                            end
                            L_1193 = L_1204
                            if not L_1204 then
                                L_1171.ImageTransparency = 0.5
                                L_1172.ImageTransparency = 0.5
                            else
                                L_1171.ImageTransparency = 0
                                L_1172.ImageTransparency = 0
                            end
                            return
                        end
                        L_1208()
                        L_1194 = task.spawn(function()
                            while true do
                                task.wait(L_1167)
                                if not L_1169 or not L_1169.Parent then
                                    break
                                end
                                L_1208()
                            end
                            return
                        end)
                    end
                    local L_1209 = L_1160
                    local L_1210 = false
                    local L_1215 = function(L_1211)
                        if L_1165 and (#L_1166 > 0 and L_1211 and not L_1193) then
                            return
                        end
                        local L_1212 = L_1211 and UDim2.new(1, -4, 1, -4) or UDim2.new(0, 0, 0, 0)
                        local L_1213 = L_1211 and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0, 0, 1, 0)
                        local L_1214 = L_1211 and Vector2.new(0.5, 0.5) or Vector2.new(0, 1)
                        game.TweenService:Create(L_1172, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), { Size = L_1212, Position = L_1213, AnchorPoint = L_1214 }):Play()
                        L_1168(L_1211)
                        return
                    end
                    if L_1168 then
                        L_1215(L_1158)
                    end
                    L_1177.MouseButton1Click:Connect(function()
                        L_732.ButtonEffect()
                        return
                    end)
                    L_1177.MouseButton1Down:Connect(function()
                        if L_1165 and (#L_1166 > 0 and not L_1158 and not L_1193) then
                            return
                        end
                        L_1158 = not L_1158
                        L_1215(L_1158)
                        return
                    end)
                    if L_1159 then
                        local L_1216 = game:GetService("UserInputService")
                        L_1180.MouseButton1Click:Connect(function()
                            if not L_1210 then
                                L_1210 = true
                                L_1180.Text = "..."
                                local L_1217 = nil
                                L_1217 = L_1216.InputBegan:Connect(function(L_1218, L_1219)
                                    if not L_1219 and L_1218.UserInputType == Enum.UserInputType.Keyboard then
                                        local L_1220 = L_1218.KeyCode.Name
                                        L_1209 = L_1220
                                        L_1180.Text = L_1220
                                        L_1210 = false
                                        L_1217:Disconnect()
                                    end
                                    return
                                end)
                            end
                            return
                        end)
                        L_1216.InputBegan:Connect(function(L_1221, L_1222)
                            if not L_1222 and (not L_1210 and L_1221.UserInputType == Enum.UserInputType.Keyboard and L_1209 and L_1221.KeyCode.Name == L_1209) then
                                if L_1165 and #L_1166 > 0 and not L_1158 and not L_1193 then
                                    return
                                end
                                L_1158 = not L_1158
                                L_1215(L_1158)
                            end
                            return
                        end)
                    end
                    local L_1229 = {
                        SetStage = function(L_1223)
                            L_1215(L_1223)
                            return
                        end,
                        SetKeybind = function(L_1224)
                            if L_1159 then
                                L_1209 = L_1224
                                L_1180.Text = L_1224 or "NONE"
                            end
                            return
                        end,
                        GetKeybind = function()
                            return L_1209
                        end,
                        SetTextboxValue = function(L_1225)
                            if L_1161 then
                                L_1184.Text = L_1225
                            end
                            return
                        end,
                        GetTextboxValue = function()
                            if L_1161 then
                                return L_1184.Text
                            end
                            return nil
                        end,
                        AreRequirementsMet = function()
                            return L_1193
                        end,
                        GetRequirements = function()
                            local L_1226 = {}
                            for L_1227, L_1228 in pairs(L_1190) do
                                L_1226[L_1227] = L_1228.Met
                            end
                            return L_1226
                        end,
                        Destroy = function()
                            if L_1194 then
                                task.cancel(L_1194)
                            end
                            L_1169:Destroy()
                            return
                        end
                    }
                    local L_1230 = L_626(L_1101, L_1145, L_1156)
                    L_622.Toggles[L_1230] = {
                        Get = function()
                            return L_1158
                        end,
                        Set = function(L_1231)
                            local L_1232 = not not L_1231
                            if L_1158 == L_1232 then
                                return
                            end
                            if L_1165 and #L_1166 > 0 and L_1232 and not L_1193 then
                                return
                            end
                            L_1158 = L_1232
                            L_1215(L_1158)
                            return
                        end
                    }
                    return L_1229
                end,
                
-- ------------------------------------------------------------
-- Account Table Control
-- ------------------------------------------------------------
CreateAccountTable = function(L_1233, L_1234)
                    local L_1235 = tostring(L_1233.Title) or "Account Manager"
                    local L_1236 = L_1233.Default or {}
                    local L_1237 = L_1234 or function()
                        return
                    end
                    local L_1238 = L_1233.EnableConfigBinding ~= false
                    local L_1239 = L_1233.OnAccountSelect
                    local L_1240 = L_626(L_1101, L_1145, L_1235)
                    local L_1241 = {}
                    if type(L_1236) == "table" then
                        for L_1242, L_1243 in pairs(L_1236) do
                            if type(L_1243) == "table" then
                                table.insert(L_1241, { username = L_1242, link = L_1243.link or "", config = L_1243.config or "" })
                            else
                                table.insert(L_1241, { username = L_1242, link = L_1243, config = "" })
                            end
                        end
                    end
                    local L_1244 = game:GetService("TweenService")
                    local L_1245 = getgenv().UIColor["Tween Animation 2 Speed"]
                    local L_1246 = Instance.new(L_32)
                    local L_1247 = Instance.new("UICorner")
                    L_1246.Name = L_1235 .. "_Wrapper"
                    L_1246.Parent = L_1147
                    L_1246.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    L_1246.BackgroundTransparency = 1
                    L_1246.Position = UDim2.new(0, 0, 0, 0)
                    L_1246.Size = UDim2.new(1, 0, 0, 280)
                    L_1246.ClipsDescendants = true
                    local L_1248 = Instance.new(L_32)
                    local L_1249 = Instance.new("UICorner")
                    L_1248.Name = "Background1"
                    L_1248.Parent = L_1246
                    L_1248.AnchorPoint = Vector2.new(0.5, 0.5)
                    L_1248.Position = UDim2.new(0.5, 0, 0.5, 0)
                    L_1248.Size = UDim2.new(1, -10, 1, 0)
                    L_1248.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                    L_1248.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                    table.insert(L_639["Background 1 Color"], function()
                        L_1248.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                        return
                    end)
                    table.insert(L_639["Background 1 Transparency"], function()
                        L_1248.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                        return
                    end)
                    L_1249.CornerRadius = UDim.new(0, 4)
                    L_1249.Parent = L_1248
                    local L_1250 = Instance.new("TextLabel")
                    local L_1251 = Instance.new("TextButton")
                    L_1250.Name = "Title"
                    L_1250.Parent = L_1248
                    L_1250.BackgroundTransparency = 1
                    L_1250.Position = UDim2.new(0, 10, 0, 5)
                    L_1250.Size = UDim2.new(1, -40, 0, 25)
                    L_1250.Font = Enum.Font.GothamBlack
                    L_1250.Text = L_1235
                    L_1250.TextSize = 14
                    L_1250.TextXAlignment = Enum.TextXAlignment.Left
                    L_1250.TextColor3 = getgenv().UIColor[L_34]
                    table.insert(L_639[L_34], function()
                        L_1250.TextColor3 = getgenv().UIColor[L_34]
                        return
                    end)
                    L_1251.Name = "Minimize"
                    L_1251.Parent = L_1248
                    L_1251.BackgroundTransparency = 1
                    L_1251.Position = UDim2.new(1, -30, 0, 5)
                    L_1251.Size = UDim2.new(0, 25, 0, 25)
                    L_1251.Font = Enum.Font.GothamBold
                    L_1251.Text = "-"
                    L_1251.TextSize = 18
                    L_1251.TextColor3 = getgenv().UIColor[L_34]
                    table.insert(L_639[L_34], function()
                        L_1251.TextColor3 = getgenv().UIColor[L_34]
                        return
                    end)
                    local L_1252 = Instance.new(L_32)
                    local L_1253 = Instance.new("UICorner")
                    L_1252.Name = "ContentArea"
                    L_1252.Parent = L_1248
                    L_1252.BackgroundColor3 = getgenv().UIColor["Background 3 Color"]
                    L_1252.Position = UDim2.new(0, 5, 0, 35)
                    L_1252.Size = UDim2.new(1, -10, 1, -40)
                    table.insert(L_639["Background 3 Color"], function()
                        L_1252.BackgroundColor3 = getgenv().UIColor["Background 3 Color"]
                        return
                    end)
                    L_1253.CornerRadius = UDim.new(0, 4)
                    L_1253.Parent = L_1252
                    local L_1254 = Instance.new("ScrollingFrame")
                    local L_1255 = Instance.new("UIListLayout")
                    L_1254.Name = "List"
                    L_1254.Parent = L_1252
                    L_1254.Active = true
                    L_1254.BackgroundTransparency = 1
                    L_1254.BorderSizePixel = 0
                    L_1254.Position = UDim2.new(0, 5, 0, 5)
                    L_1254.Size = UDim2.new(1, -10, 1, -80)
                    L_1254.ScrollBarThickness = 2
                    L_1254.CanvasSize = UDim2.new(0, 0, 0, 0)
                    L_1254.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
                    L_1254.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
                    L_1255.Parent = L_1254
                    L_1255.SortOrder = Enum.SortOrder.LayoutOrder
                    L_1255.Padding = UDim.new(0, 4)
                    L_1255:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                        L_1254.CanvasSize = UDim2.new(0, 0, 0, L_1255.AbsoluteContentSize.Y + 5)
                        return
                    end)
                    local L_1256 = Instance.new(L_32)
                    L_1256.Parent = L_1252
                    L_1256.BackgroundTransparency = 1
                    L_1256.AnchorPoint = Vector2.new(0, 1)
                    L_1256.Position = UDim2.new(0, 5, 1, -5)
                    L_1256.Size = UDim2.new(1, -10, 0, 65)
                    local L_1265 = function(L_1257, L_1258, L_1259, L_1260)
                        local L_1261 = Instance.new(L_32)
                        local L_1262 = Instance.new("UICorner")
                        local L_1263 = Instance.new("TextBox")
                        local L_1264 = Instance.new(L_32)
                        L_1261.Name = L_1257 .. L_32
                        L_1261.Parent = L_1256
                        L_1261.BackgroundColor3 = getgenv().UIColor["Background Main Color"]
                        L_1261.Position = L_1259
                        L_1261.Size = L_1260
                        table.insert(L_639["Background Main Color"], function()
                            L_1261.BackgroundColor3 = getgenv().UIColor["Background Main Color"]
                            return
                        end)
                        L_1262.CornerRadius = UDim.new(0, 4)
                        L_1262.Parent = L_1261
                        L_1263.Parent = L_1261
                        L_1263.BackgroundTransparency = 1
                        L_1263.Size = UDim2.new(1, -10, 1, 0)
                        L_1263.Position = UDim2.new(0, 5, 0, 0)
                        L_1263.Font = Enum.Font.GothamBold
                        L_1263.Text = ""
                        L_1263.PlaceholderText = L_1258
                        L_1263.TextSize = 12
                        L_1263.TextXAlignment = Enum.TextXAlignment.Left
                        L_1263.TextColor3 = getgenv().UIColor[L_34]
                        L_1263.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
                        table.insert(L_639[L_34], function()
                            L_1263.TextColor3 = getgenv().UIColor[L_34]
                            return
                        end)
                        table.insert(L_639["Placeholder Text Color"], function()
                            L_1263.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
                            return
                        end)
                        L_1264.Parent = L_1261
                        L_1264.BackgroundColor3 = getgenv().UIColor["Box Highlight Color"]
                        L_1264.BackgroundTransparency = 1
                        L_1264.Position = UDim2.new(0, 0, 1, -2)
                        L_1264.Size = UDim2.new(1, 0, 0, 2)
                        table.insert(L_639["Box Highlight Color"], function()
                            L_1264.BackgroundColor3 = getgenv().UIColor["Box Highlight Color"]
                            return
                        end)
                        L_1263.Focused:Connect(function()
                            L_732.ButtonEffect()
                            L_1244:Create(L_1264, TweenInfo.new(0.3), { BackgroundTransparency = 0 }):Play()
                            return
                        end)
                        L_1263.FocusLost:Connect(function()
                            L_1244:Create(L_1264, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
                            return
                        end)
                        return L_1263
                    end
                    local L_1266 = L_1265("User", "Username", UDim2.new(0, 0, 0, 0), UDim2.new(0.35, 0, 0, 30))
                    local L_1267 = L_1265("Link", "PS Code", UDim2.new(0.35, 5, 0, 0), UDim2.new(0.65, -45, 0, 30))
                    local L_1268 = L_1265("Config", "Config Name (optional)", UDim2.new(0, 0, 0, 35), UDim2.new(1, -45, 0, 30))
                    local L_1269 = Instance.new("TextButton")
                    local L_1270 = Instance.new("UICorner")
                    L_1269.Name = "AddBtn"
                    L_1269.Parent = L_1256
                    L_1269.AnchorPoint = Vector2.new(1, 0)
                    L_1269.Position = UDim2.new(1, 0, 0, 0)
                    L_1269.Size = UDim2.new(0, 35, 0, 65)
                    L_1269.BackgroundColor3 = getgenv().UIColor["Button Color"]
                    L_1269.Text = "+"
                    L_1269.Font = Enum.Font.GothamBold
                    L_1269.TextSize = 18
                    L_1269.TextColor3 = getgenv().UIColor[L_34]
                    table.insert(L_639["Button Color"], function()
                        L_1269.BackgroundColor3 = getgenv().UIColor["Button Color"]
                        return
                    end)
                    table.insert(L_639[L_34], function()
                        L_1269.TextColor3 = getgenv().UIColor[L_34]
                        return
                    end)
                    L_1270.CornerRadius = UDim.new(0, 4)
                    L_1270.Parent = L_1269
                    L_1269.MouseEnter:Connect(function()
                        L_1244:Create(L_1269, TweenInfo.new(0.2), { BackgroundTransparency = 0.2 }):Play()
                        return
                    end)
                    L_1269.MouseLeave:Connect(function()
                        L_1244:Create(L_1269, TweenInfo.new(0.2), { BackgroundTransparency = 0 }):Play()
                        return
                    end)
                    local L_1291 = function(L_1271, L_1272, L_1273, L_1274)
                        local L_1275 = Instance.new(L_32)
                        local L_1276 = Instance.new("UICorner")
                        local L_1277 = Instance.new("TextLabel")
                        local L_1278 = Instance.new("TextLabel")
                        local L_1279 = Instance.new("TextLabel")
                        local L_1280 = Instance.new("TextButton")
                        local L_1281 = Instance.new("UICorner")
                        local L_1282 = Instance.new("TextButton")
                        local L_1283 = Instance.new("UICorner")
                        L_1275.Name = L_1271
                        L_1275.Parent = L_1254
                        L_1275.LayoutOrder = L_1274
                        L_1275.Size = UDim2.new(1, 0, 0, 50)
                        L_1275.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                        table.insert(L_639["Background 1 Color"], function()
                            L_1275.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                            return
                        end)
                        L_1276.CornerRadius = UDim.new(0, 4)
                        L_1276.Parent = L_1275
                        L_1277.Parent = L_1275
                        L_1277.BackgroundTransparency = 1
                        L_1277.Position = UDim2.new(0, 8, 0, 4)
                        L_1277.Size = UDim2.new(1, -80, 0, 16)
                        L_1277.Font = Enum.Font.GothamBold
                        L_1277.Text = L_1271
                        L_1277.TextSize = 13
                        L_1277.TextXAlignment = Enum.TextXAlignment.Left
                        L_1277.TextColor3 = getgenv().UIColor[L_34]
                        table.insert(L_639[L_34], function()
                            L_1277.TextColor3 = getgenv().UIColor[L_34]
                            return
                        end)
                        L_1278.Parent = L_1275
                        L_1278.BackgroundTransparency = 1
                        L_1278.Position = UDim2.new(0, 8, 0, 20)
                        L_1278.Size = UDim2.new(0.5, -10, 0, 14)
                        L_1278.Font = Enum.Font.Gotham
                        L_1278.Text = L_1272 and L_1272 ~= "" and "PS: " .. L_1272 or "No PS Code"
                        L_1278.TextSize = 10
                        L_1278.TextXAlignment = Enum.TextXAlignment.Left
                        L_1278.TextColor3 = getgenv().UIColor["Toggle Desc Color"]
                        table.insert(L_639["Toggle Desc Color"], function()
                            L_1278.TextColor3 = getgenv().UIColor["Toggle Desc Color"]
                            return
                        end)
                        L_1279.Parent = L_1275
                        L_1279.BackgroundTransparency = 1
                        L_1279.Position = UDim2.new(0, 8, 0, 34)
                        L_1279.Size = UDim2.new(0.6, -10, 0, 14)
                        L_1279.Font = Enum.Font.Gotham
                        L_1279.Text = L_1273 and L_1273 ~= "" and "Config: " .. L_1273 or "No Config"
                        L_1279.TextSize = 10
                        L_1279.TextXAlignment = Enum.TextXAlignment.Left
                        L_1279.TextColor3 = L_1273 and L_1273 ~= "" and Color3.fromRGB(100, 200, 100) or getgenv().UIColor["Toggle Desc Color"]
                        if L_1238 and (L_1273 and L_1273 ~= "") then
                            L_1282.Parent = L_1275
                            L_1282.AnchorPoint = Vector2.new(1, 0.5)
                            L_1282.Position = UDim2.new(1, -40, 0.5, 0)
                            L_1282.Size = UDim2.new(0, 30, 0, 30)
                            L_1282.BackgroundColor3 = Color3.fromRGB(60, 140, 60)
                            L_1282.Text = "+"
                            L_1282.Font = Enum.Font.GothamBold
                            L_1282.TextSize = 16
                            L_1282.TextColor3 = Color3.fromRGB(255, 255, 255)
                            L_1283.CornerRadius = UDim.new(0, 4)
                            L_1283.Parent = L_1282
                            L_1282.MouseEnter:Connect(function()
                                L_1244:Create(L_1282, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(80, 180, 80) }):Play()
                                return
                            end)
                            L_1282.MouseLeave:Connect(function()
                                L_1244:Create(L_1282, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(60, 140, 60) }):Play()
                                return
                            end)
                            L_1282.MouseButton1Click:Connect(function()
                                L_732.ButtonEffect()
                                if getgenv().FeralConfig and getgenv().FeralConfig.Load then
                                    local L_1284, L_1285 = getgenv().FeralConfig.Load(L_1273)
                                    if L_1284 then
                                        if L_731 and L_731.CreateNoti then
                                            L_731.CreateNoti({ Title = "Config", Desc = "Loaded \"" .. L_1273 .. "\" for " .. L_1271, ShowTime = 4 })
                                        end
                                    elseif L_731 and L_731.CreateNoti then
                                        L_731.CreateNoti({ Title = "Config", Desc = "Failed to load: " .. tostring(L_1285), ShowTime = 4 })
                                    end
                                end
                                if L_1239 then
                                    L_1239(L_1271, L_1272, L_1273)
                                end
                                return
                            end)
                        end
                        L_1280.Parent = L_1275
                        L_1280.AnchorPoint = Vector2.new(1, 0.5)
                        L_1280.Position = UDim2.new(1, -5, 0.5, 0)
                        L_1280.Size = UDim2.new(0, 30, 0, 30)
                        L_1280.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
                        L_1280.Text = "X"
                        L_1280.Font = Enum.Font.GothamBold
                        L_1280.TextSize = 14
                        L_1280.TextColor3 = Color3.fromRGB(255, 255, 255)
                        L_1281.CornerRadius = UDim.new(0, 4)
                        L_1281.Parent = L_1280
                        L_1280.MouseEnter:Connect(function()
                            L_1244:Create(L_1280, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(230, 80, 80) }):Play()
                            return
                        end)
                        L_1280.MouseLeave:Connect(function()
                            L_1244:Create(L_1280, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(200, 60, 60) }):Play()
                            return
                        end)
                        L_1280.MouseButton1Click:Connect(function()
                            L_732.ButtonEffect()
                            L_1275:Destroy()
                            for L_1286, L_1287 in ipairs(L_1241) do
                                if L_1287.username == L_1271 then
                                    table.remove(L_1241, L_1286)
                                    break
                                end
                            end
                            local L_1288 = {}
                            for L_1289, L_1290 in ipairs(L_1241) do
                                L_1288[L_1290.username] = { link = L_1290.link, config = L_1290.config }
                            end
                            L_1237(L_1288)
                            return
                        end)
                        return
                    end
                    local L_1298 = function()
                        for L_1292, L_1293 in pairs(L_1254:GetChildren()) do
                            if L_1293:IsA(L_32) then
                                L_1293:Destroy()
                            end
                        end
                        table.sort(L_1241, function(L_1294, L_1295)
                            return L_1294.username:lower() < L_1295.username:lower()
                        end)
                        for L_1296, L_1297 in ipairs(L_1241) do
                            L_1291(L_1297.username, L_1297.link, L_1297.config, L_1296)
                        end
                        return
                    end
                    L_1269.MouseButton1Click:Connect(function()
                        L_732.ButtonEffect()
                        local L_1299 = L_1266.Text
                        local L_1300 = L_1267.Text
                        local L_1301 = L_1268.Text
                        if L_1299:gsub(" ", "") ~= "" then
                            for L_1302, L_1303 in ipairs(L_1241) do
                                if L_1303.username == L_1299 then
                                    return
                                end
                            end
                            table.insert(L_1241, { username = L_1299, link = L_1300, config = L_1301 })
                            L_1298()
                            L_1266.Text = ""
                            L_1267.Text = ""
                            L_1268.Text = ""
                            local L_1304 = {}
                            for L_1305, L_1306 in ipairs(L_1241) do
                                L_1304[L_1306.username] = { link = L_1306.link, config = L_1306.config }
                            end
                            L_1237(L_1304)
                        end
                        return
                    end)
                    local L_1307 = false
                    local L_1308 = UDim2.new(1, 0, 0, 280)
                    local L_1309 = UDim2.new(1, 0, 0, 35)
                    L_1251.MouseButton1Click:Connect(function()
                        L_732.ButtonEffect()
                        L_1307 = not L_1307
                        L_1251.Text = L_1307 and "+" or "-"
                        local L_1310 = L_1307 and L_1309 or L_1308
                        L_1244:Create(L_1246, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = L_1310 }):Play()
                        if L_1307 then
                            L_1252.Visible = false
                        else
                            L_1252.Visible = true
                        end
                        return
                    end)
                    L_1251.MouseEnter:Connect(function()
                        L_1244:Create(L_1251, TweenInfo.new(0.2), { TextColor3 = getgenv().UIColor["Button Color"] }):Play()
                        return
                    end)
                    L_1251.MouseLeave:Connect(function()
                        L_1244:Create(L_1251, TweenInfo.new(0.2), { TextColor3 = getgenv().UIColor[L_34] }):Play()
                        return
                    end)
                    L_1298()
                    if L_1238 then
                        task.spawn(function()
                            task.wait(0.5)
                            local L_1311 = game:GetService("Players").LocalPlayer
                            if L_1311 then
                                for L_1312, L_1313 in ipairs(L_1241) do
                                    if L_1313.username == L_1311.Name and L_1313.config and L_1313.config ~= "" then
                                        if getgenv().FeralConfig and getgenv().FeralConfig.Load then
                                            local L_1314, L_1315 = getgenv().FeralConfig.Load(L_1313.config)
                                            if L_1314 and L_731 and L_731.CreateNoti then
                                                L_731.CreateNoti({ Title = "Config", Desc = "Auto-loaded \"" .. L_1313.config .. "\" for " .. L_1313.username, ShowTime = 4 })
                                            end
                                        end
                                        return
                                    end
                                end
                            end
                            return
                        end)
                    end
                    L_622.Toggles[L_1240] = {
                        Get = function()
                            local L_1316 = {}
                            for L_1317, L_1318 in ipairs(L_1241) do
                                L_1316[L_1318.username] = { link = L_1318.link, config = L_1318.config }
                            end
                            return L_1316
                        end,
                        Set = function(L_1319)
                            if type(L_1319) == "table" then
                                L_1241 = {}
                                for L_1320, L_1321 in pairs(L_1319) do
                                    if type(L_1321) == "table" then
                                        table.insert(L_1241, { username = L_1320, link = L_1321.link or "", config = L_1321.config or "" })
                                    else
                                        table.insert(L_1241, { username = L_1320, link = L_1321, config = "" })
                                    end
                                end
                                L_1298()
                            end
                            return
                        end
                    }
                    return {
                        Add = function(L_1322, L_1323, L_1324)
                            table.insert(L_1241, { username = L_1322, link = L_1323, config = L_1324 or "" })
                            L_1298()
                            return
                        end,
                        Get = function()
                            return L_1241
                        end,
                        GetAccountConfig = function(L_1325)
                            for L_1326, L_1327 in ipairs(L_1241) do
                                if L_1327.username == L_1325 then
                                    return L_1327.config
                                end
                            end
                            return nil
                        end,
                        LoadConfigForCurrentPlayer = function()
                            local L_1328 = game:GetService("Players").LocalPlayer
                            if L_1328 then
                                for L_1329, L_1330 in ipairs(L_1241) do
                                    if L_1330.username == L_1328.Name and L_1330.config and L_1330.config ~= "" and getgenv().FeralConfig and getgenv().FeralConfig.Load then
                                        return getgenv().FeralConfig.Load(L_1330.config)
                                    end
                                end
                            end
                            return false, "No config found for current player"
                        end
                    }
                end,
                CreateButton = function(L_1331, L_1332)
                    local L_1333 = L_1331.Title
                    local L_1334 = L_1332 or function()
                        return
                    end
                    local L_1335 = Instance.new(L_32)
                    local L_1336 = Instance.new(L_32)
                    local L_1337 = Instance.new("UICorner")
                    local L_1338 = Instance.new("TextLabel")
                    local L_1339 = Instance.new("TextButton")
                    L_1335.Name = L_1333 .. "dot"
                    L_1335.Parent = L_1147
                    L_1335.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1335.BackgroundTransparency = 1
                    L_1335.Position = UDim2.new(0, 0, 0.300000012, 0)
                    L_1335.Size = UDim2.new(1, 0, 0, 25)
                    L_1336.Name = "ButtonBG"
                    L_1336.Parent = L_1335
                    L_1336.AnchorPoint = Vector2.new(0.5, 0.5)
                    L_1336.Position = UDim2.new(0.5, 0, 0.5, 0)
                    L_1336.Size = UDim2.new(1, -10, 1, 0)
                    L_1336.BackgroundColor3 = getgenv().UIColor["Button Color"]
                    table.insert(L_639["Button Color"], function()
                        L_1336.BackgroundColor3 = getgenv().UIColor["Button Color"]
                        return
                    end)
                    L_1336.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                    table.insert(L_639["Background 1 Transparency"], function()
                        L_1336.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                        return
                    end)
                    L_1337.CornerRadius = UDim.new(0, 4)
                    L_1337.Name = "ButtonCorner"
                    L_1337.Parent = L_1336
                    L_1338.Name = "TextColor"
                    L_1338.Parent = L_1336
                    L_1338.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1338.BackgroundTransparency = 1
                    L_1338.Position = UDim2.new(0, 10, 0, 0)
                    L_1338.Size = UDim2.new(1, -10, 1, 0)
                    L_1338.Font = Enum.Font.GothamBlack
                    L_1338.Text = L_1333
                    L_1338.TextSize = 14
                    L_1338.TextXAlignment = Enum.TextXAlignment.Left
                    L_1338.TextColor3 = getgenv().UIColor[L_34]
                    table.insert(L_639[L_34], function()
                        L_1338.TextColor3 = getgenv().UIColor[L_34]
                        return
                    end)
                    L_1339.Name = "Button"
                    L_1339.Parent = L_1336
                    L_1339.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1339.BackgroundTransparency = 1
                    L_1339.Size = UDim2.new(1, 0, 1, 0)
                    L_1339.Font = Enum.Font.SourceSans
                    L_1339.Text = ""
                    L_1339.TextColor3 = Color3.fromRGB(0, 0, 0)
                    L_1339.TextSize = 14
                    L_1339.MouseButton1Click:Connect(function()
                        L_732.ButtonEffect()
                        return
                    end)
                    L_1339.MouseButton1Down:Connect(function()
                        L_1334()
                        return
                    end)
                    return
                end,
                CreateLabel = function(L_1340)
                    local L_1341 = tostring(L_1340.Title)
                    local L_1342 = Instance.new(L_32)
                    local L_1343 = Instance.new(L_32)
                    local L_1344 = Instance.new("UICorner")
                    local L_1345 = Instance.new("TextLabel")
                    L_1342.Name = "LabelFrame"
                    L_1342.Parent = L_1147
                    L_1342.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1342.BackgroundTransparency = 1
                    L_1342.Position = UDim2.new(0, 0, 0, 0)
                    L_1342.Size = UDim2.new(1, 0, 0, 0)
                    L_1342.AutomaticSize = Enum.AutomaticSize.Y
                    L_1343.Name = "LabelBG"
                    L_1343.Parent = L_1342
                    L_1343.AnchorPoint = Vector2.new(0.5, 0)
                    L_1343.Position = UDim2.new(0.5, 0, 0, 0)
                    L_1343.Size = UDim2.new(1, -10, 0, -10)
                    L_1343.BackgroundColor3 = getgenv().UIColor["Label Color"]
                    L_1343.AutomaticSize = Enum.AutomaticSize.Y
                    table.insert(L_639["Label Color"], function()
                        L_1343.BackgroundColor3 = getgenv().UIColor["Label Color"]
                        return
                    end)
                    L_1343.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                    table.insert(L_639["Background 1 Transparency"], function()
                        L_1343.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                        return
                    end)
                    L_1344.CornerRadius = UDim.new(0, 4)
                    L_1344.Name = "LabelCorner"
                    L_1344.Parent = L_1343
                    L_1345.Name = "TextColor"
                    L_1345.Parent = L_1343
                    L_1345.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1345.BackgroundTransparency = 1
                    L_1345.Position = UDim2.new(0, 10, 0, 3)
                    L_1345.Size = UDim2.new(1, -20, 1, 0)
                    L_1345.Font = Enum.Font.GothamBlack
                    L_1345.Text = L_1341
                    L_1345.TextSize = 14
                    L_1345.TextXAlignment = Enum.TextXAlignment.Left
                    L_1345.AutomaticSize = Enum.AutomaticSize.Y
                    L_1345.TextWrapped = true
                    L_1345.TextColor3 = getgenv().UIColor[L_34]
                    table.insert(L_639[L_34], function()
                        L_1345.TextColor3 = getgenv().UIColor[L_34]
                        return
                    end)
                    return {
                        SetText = function(L_1346)
                            L_1345.Text = L_1346
                            return
                        end,
                        SetColor = function(L_1347)
                            L_1345.TextColor3 = L_1347
                            return
                        end
                    }
                end,
                CreateDropdown = function(L_1348, L_1349)
                    local L_1350 = tostring(L_1348.Title)
                    local L_1351 = L_1348.List or {}
                    local L_1352 = L_1348.Search or false
                    local L_1353 = L_1348.Selected or false
                    local L_1354 = L_1348.Default
                    local L_1355 = L_1349 or function()
                        return
                    end
                    local L_1360 = function(L_1356)
                        if type(L_1356) ~= "table" then
                            return false
                        end
                        local L_1357 = 0
                        for L_1358, L_1359 in pairs(L_1356) do
                            if type(L_1358) ~= "number" then
                                return false
                            end
                            L_1357 = L_1357 + 1
                        end
                        return L_1357 == #L_1356
                    end
                    local L_1361 = Instance.new(L_32)
                    local L_1362 = Instance.new(L_32)
                    local L_1363 = Instance.new("UICorner")
                    local L_1364 = Instance.new(L_32)
                    local L_1365 = Instance.new("UICorner")
                    local L_1366 = Instance.new("ImageLabel")
                    local L_1367 = Instance.new("TextButton")
                    local L_1368 = Instance.new(L_32)
                    local L_1369 = Instance.new("ScrollingFrame")
                    local L_1370 = Instance.new(L_32)
                    local L_1371 = Instance.new("UIListLayout")
                    local L_1372
                    if L_1352 then
                        L_1372 = Instance.new("TextBox")
                        L_1367.Visible = false
                    else
                        L_1372 = Instance.new("TextLabel")
                    end
                    L_1361.Name = L_1350 .. "DropdownFrame"
                    L_1361.Parent = L_1147
                    L_1361.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1361.BackgroundTransparency = 1
                    L_1361.Position = UDim2.new(0, 0, 0.473684222, 0)
                    L_1361.Size = UDim2.new(1, 0, 0, 25)
                    L_1362.Name = "Background1"
                    L_1362.Parent = L_1361
                    L_1362.AnchorPoint = Vector2.new(0.5, 0.5)
                    L_1362.Position = UDim2.new(0.5, 0, 0.5, 0)
                    L_1362.Size = UDim2.new(1, -10, 1, 0)
                    L_1362.ClipsDescendants = true
                    L_1362.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                    table.insert(L_639["Background 1 Color"], function()
                        L_1362.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                        return
                    end)
                    L_1362.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                    table.insert(L_639["Background 1 Transparency"], function()
                        L_1362.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                        return
                    end)
                    L_1363.CornerRadius = UDim.new(0, 4)
                    L_1363.Name = "Dropdowncorner"
                    L_1363.Parent = L_1362
                    L_1364.Name = "Background2"
                    L_1364.Parent = L_1362
                    L_1364.Size = UDim2.new(1, 0, 0, 25)
                    L_1364.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                    table.insert(L_639["Background 2 Color"], function()
                        L_1364.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                        return
                    end)
                    L_1364.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                    table.insert(L_639["Background 1 Transparency"], function()
                        L_1364.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                        return
                    end)
                    L_1365.CornerRadius = UDim.new(0, 4)
                    L_1365.Parent = L_1364
                    L_1372.Name = "TextColorPlaceholder"
                    L_1372.Parent = L_1364
                    L_1372.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1372.BackgroundTransparency = 1
                    L_1372.Position = UDim2.new(0, 10, 0, 0)
                    L_1372.Size = UDim2.new(1, -40, 1, 0)
                    L_1372.Font = Enum.Font.GothamBlack
                    L_1372.Text = ""
                    L_1372.TextSize = 14
                    L_1372.TextXAlignment = Enum.TextXAlignment.Left
                    L_1372.ClipsDescendants = true
                    L_1372.TextColor3 = getgenv().UIColor[L_34]
                    table.insert(L_639[L_34], function()
                        L_1372.TextColor3 = getgenv().UIColor[L_34]
                        return
                    end)
                    if L_1352 then
                        L_1372.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
                        table.insert(L_639["Placeholder Text Color"], function()
                            L_1372.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
                            return
                        end)
                    end
                    L_1366.Name = "ImgDrop"
                    L_1366.Parent = L_1364
                    L_1366.AnchorPoint = Vector2.new(1, 0.5)
                    L_1366.BackgroundTransparency = 1
                    L_1366.Position = UDim2.new(1, -6, 0.5, 0)
                    L_1366.Size = UDim2.new(0, 15, 0, 15)
                    L_1366.Image = "rbxassetid://6954383209"
                    L_1366.ImageColor3 = getgenv().UIColor["Dropdown Icon Color"]
                    table.insert(L_639["Dropdown Icon Color"], function()
                        L_1366.ImageColor3 = getgenv().UIColor["Dropdown Icon Color"]
                        return
                    end)
                    L_1367.Name = "DropdownButton"
                    L_1367.Parent = L_1364
                    L_1367.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1367.BackgroundTransparency = 1
                    L_1367.Size = UDim2.new(1, 0, 1, 0)
                    L_1367.Font = Enum.Font.GothamBold
                    L_1367.Text = ""
                    L_1367.TextColor3 = Color3.fromRGB(230, 230, 230)
                    L_1367.TextSize = 14
                    L_1368.Name = "Dropdownlisttt"
                    L_1368.Parent = L_1362
                    L_1368.BackgroundTransparency = 1
                    L_1368.BorderSizePixel = 0
                    L_1368.Position = UDim2.new(0, 0, 0, 25)
                    L_1368.Size = UDim2.new(1, 0, 0, 25)
                    L_1369.Name = "DropdownScroll"
                    L_1369.Parent = L_1368
                    L_1369.Active = true
                    L_1369.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1369.BackgroundTransparency = 1
                    L_1369.BorderSizePixel = 0
                    L_1369.Size = UDim2.new(1, 0, 1, 0)
                    L_1369.ScrollBarThickness = 5
                    L_1370.Name = "ScrollContainer"
                    L_1370.Parent = L_1369
                    L_1370.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1370.BackgroundTransparency = 1
                    L_1370.Position = UDim2.new(0, 5, 0, 5)
                    L_1370.Size = UDim2.new(1, -15, 1, -5)
                    L_1371.Name = "ScrollContainerList"
                    L_1371.Parent = L_1370
                    L_1371.SortOrder = Enum.SortOrder.LayoutOrder
                    L_1371:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                        L_1369.CanvasSize = UDim2.new(0, 0, 0, 10 + L_1371.AbsoluteContentSize.Y + 5)
                        return
                    end)
                    local L_1373 = false
                    local L_1374 = {}
                    local L_1375 = {}
                    local L_1376 = L_1351
                    local L_1377 = nil
                    if L_1353 then
                        if L_1360(L_1376) then
                            local L_1378 = {}
                            for L_1379, L_1380 in ipairs(L_1376) do
                                L_1378[L_1380] = false
                            end
                            L_1376 = L_1378
                        else
                            for L_1381, L_1382 in pairs(L_1376) do
                                L_1376[L_1381] = not not L_1382
                            end
                        end
                    end
                    local L_1383
                    L_1383 = function()
                        for L_1384, L_1385 in ipairs(L_1370:GetChildren()) do
                            if L_1385:IsA(L_32) then
                                L_1385:Destroy()
                            end
                        end
                        L_1375 = {}
                        if not L_1353 then
                            for L_1386, L_1387 in ipairs(L_1376) do
                                local L_1388 = tostring(L_1387)
                                local L_1389 = L_1388:lower()
                                table.insert(L_1375, L_1389)
                                local L_1390 = Instance.new(L_32)
                                local L_1391 = Instance.new("UICorner")
                                local L_1392 = Instance.new(L_32)
                                local L_1393 = Instance.new(L_32)
                                local L_1394 = Instance.new("UICorner")
                                local L_1395 = Instance.new(L_32)
                                local L_1396 = Instance.new("TextButton")
                                L_1390.Name = L_1389
                                L_1390.Parent = L_1370
                                L_1390.BackgroundTransparency = 1
                                L_1390.Size = UDim2.new(1, 0, 0, 25)
                                L_1391.CornerRadius = UDim.new(0, 4)
                                L_1391.Parent = L_1390
                                L_1392.Name = "Line"
                                L_1392.Parent = L_1390
                                L_1392.AnchorPoint = Vector2.new(0, 0.5)
                                L_1392.BackgroundTransparency = 1
                                L_1392.Position = UDim2.new(0, 0, 0.5, 0)
                                L_1392.Size = UDim2.new(0, 14, 1, 0)
                                L_1393.Name = "InLine"
                                L_1393.Parent = L_1392
                                L_1393.AnchorPoint = Vector2.new(0.5, 0.5)
                                L_1393.BorderSizePixel = 0
                                L_1393.Position = UDim2.new(0.5, 0, 0.5, 0)
                                L_1393.Size = UDim2.new(1, -10, 1, -10)
                                L_1393.BackgroundTransparency = L_1377 == L_1388 and 0 or 1
                                L_1393.BackgroundColor3 = getgenv().UIColor["Dropdown Selected Color"]
                                table.insert(L_639["Dropdown Selected Color"], function()
                                    L_1393.BackgroundColor3 = getgenv().UIColor["Dropdown Selected Color"]
                                    return
                                end)
                                L_1394.CornerRadius = UDim.new(0, 4)
                                L_1394.Parent = L_1393
                                L_1395.Name = "Dropvalcontainer"
                                L_1395.Parent = L_1390
                                L_1395.BackgroundTransparency = 1
                                L_1395.Position = UDim2.new(0, 15, 0, 0)
                                L_1395.Size = UDim2.new(1, -15, 1, 0)
                                L_1396.Name = "TextColor"
                                L_1396.Parent = L_1395
                                L_1396.BackgroundTransparency = 1
                                L_1396.Size = UDim2.new(1, 0, 1, 0)
                                L_1396.Font = Enum.Font.GothamBold
                                L_1396.Text = L_1388
                                L_1396.TextSize = 14
                                L_1396.TextXAlignment = Enum.TextXAlignment.Left
                                L_1396.TextColor3 = getgenv().UIColor[L_34]
                                table.insert(L_639[L_34], function()
                                    L_1396.TextColor3 = getgenv().UIColor[L_34]
                                    return
                                end)
                                L_1396.MouseButton1Click:Connect(function()
                                    L_732.ButtonEffect()
                                    L_1377 = L_1388
                                    if L_1352 then
                                        L_1372.PlaceholderText = L_1350 .. ": " .. L_1388
                                    else
                                        L_1372.Text = L_1350 .. ": " .. L_1388
                                    end
                                    L_1383()
                                    pcall(L_1355, L_1388)
                                    return
                                end)
                            end
                        else
                            for L_1397, L_1398 in pairs(L_1376) do
                                local L_1399 = tostring(L_1397)
                                local L_1400 = L_1399:lower()
                                table.insert(L_1375, L_1400)
                                local L_1401 = Instance.new(L_32)
                                local L_1402 = Instance.new("UICorner")
                                local L_1403 = Instance.new(L_32)
                                local L_1404 = Instance.new(L_32)
                                local L_1405 = Instance.new("UICorner")
                                local L_1406 = Instance.new(L_32)
                                local L_1407 = Instance.new("TextButton")
                                L_1401.Name = L_1400
                                L_1401.Parent = L_1370
                                L_1401.BackgroundTransparency = 1
                                L_1401.Size = UDim2.new(1, 0, 0, 25)
                                L_1402.CornerRadius = UDim.new(0, 4)
                                L_1402.Parent = L_1401
                                L_1403.Name = "Line"
                                L_1403.Parent = L_1401
                                L_1403.AnchorPoint = Vector2.new(0, 0.5)
                                L_1403.BackgroundTransparency = 1
                                L_1403.Position = UDim2.new(0, 0, 0.5, 0)
                                L_1403.Size = UDim2.new(0, 14, 1, 0)
                                L_1404.Name = "InLine"
                                L_1404.Parent = L_1403
                                L_1404.AnchorPoint = Vector2.new(0.5, 0.5)
                                L_1404.BorderSizePixel = 0
                                L_1404.Position = UDim2.new(0.5, 0, 0.5, 0)
                                L_1404.Size = UDim2.new(1, -10, 1, -10)
                                L_1404.BackgroundTransparency = L_1398 and 0 or 1
                                L_1404.BackgroundColor3 = getgenv().UIColor["Dropdown Selected Color"]
                                table.insert(L_639["Dropdown Selected Color"], function()
                                    L_1404.BackgroundColor3 = getgenv().UIColor["Dropdown Selected Color"]
                                    return
                                end)
                                L_1405.CornerRadius = UDim.new(0, 4)
                                L_1405.Parent = L_1404
                                L_1406.Name = "Dropvalcontainer"
                                L_1406.Parent = L_1401
                                L_1406.BackgroundTransparency = 1
                                L_1406.Position = UDim2.new(0, 15, 0, 0)
                                L_1406.Size = UDim2.new(1, -15, 1, 0)
                                L_1407.Name = "TextColor"
                                L_1407.Parent = L_1406
                                L_1407.BackgroundTransparency = 1
                                L_1407.Size = UDim2.new(1, 0, 1, 0)
                                L_1407.Font = Enum.Font.GothamBold
                                L_1407.Text = L_1399
                                L_1407.TextSize = 14
                                L_1407.TextXAlignment = Enum.TextXAlignment.Left
                                L_1407.TextColor3 = getgenv().UIColor[L_34]
                                table.insert(L_639[L_34], function()
                                    L_1407.TextColor3 = getgenv().UIColor[L_34]
                                    return
                                end)
                                L_1407.MouseButton1Click:Connect(function()
                                    L_732.ButtonEffect()
                                    L_1376[L_1397] = not L_1376[L_1397]
                                    L_1404.BackgroundTransparency = L_1376[L_1397] and 0 or 1
                                    pcall(L_1355, L_1397, L_1376[L_1397])
                                    return
                                end)
                            end
                        end
                        return
                    end
                    if not L_1353 then
                        if L_1354 ~= nil then
                            local L_1408 = tostring(L_1354)
                            L_1377 = L_1408
                            if L_1352 then
                                L_1372.PlaceholderText = L_1350 .. ": " .. L_1408
                            else
                                L_1372.Text = L_1350 .. ": " .. L_1408
                            end
                            pcall(L_1355, L_1408)
                        elseif L_1352 then
                            L_1372.PlaceholderText = L_1350 .. ": "
                        else
                            L_1372.Text = L_1350 .. ": "
                        end
                    else
                        if type(L_1354) == "table" then
                            if L_1360(L_1354) then
                                for L_1409, L_1410 in ipairs(L_1354) do
                                    if L_1376[L_1410] ~= nil then
                                        L_1376[L_1410] = true
                                        pcall(L_1355, L_1410, true)
                                    end
                                end
                            else
                                for L_1411, L_1412 in pairs(L_1354) do
                                    if L_1376[L_1411] ~= nil then
                                        L_1376[L_1411] = not not L_1412
                                        pcall(L_1355, L_1411, L_1376[L_1411])
                                    end
                                end
                            end
                        end
                        L_1372.Text = L_1350 .. ": "
                    end
                    L_1383()
                    if L_1352 then
                        L_1372.Changed:Connect(function()
                            local L_1413 = L_1372.Text:lower()
                            for L_1414, L_1415 in ipairs(L_1370:GetChildren()) do
                                if L_1415:IsA(L_32) then
                                    L_1415.Visible = L_1413 == "" or L_1415.Name:find(L_1413, 1, true)
                                end
                            end
                            return
                        end)
                    end
                    local L_1419 = function()
                        L_1373 = not L_1373
                        local L_1416 = L_1373 and UDim2.new(1, 0, 0, 170) or UDim2.new(1, 0, 0, 0)
                        local L_1417 = L_1373 and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 25)
                        local L_1418 = L_1373 and 90 or 0
                        L_733:Create(L_1368, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), { Size = L_1416 }):Play()
                        L_733:Create(L_1361, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), { Size = L_1417 }):Play()
                        L_733:Create(L_1366, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), { Rotation = L_1418 }):Play()
                        return
                    end
                    L_1367.MouseButton1Click:Connect(function()
                        L_732.ButtonEffect()
                        L_1419()
                        return
                    end)
                    if L_1352 then
                        L_1372.Focused:Connect(function()
                            L_732.ButtonEffect()
                            L_1419()
                            return
                        end)
                    end
                    local L_1430 = {
                        rf = L_1383,
                        ClearText = function(L_1420)
                            if not L_1353 then
                                if L_1352 then
                                    L_1372.PlaceholderText = L_1350 .. ": "
                                else
                                    L_1372.Text = L_1350 .. ": "
                                end
                                L_1377 = nil
                            else
                                L_1372.Text = L_1350 .. ": "
                                for L_1421, L_1422 in pairs(L_1376) do
                                    L_1376[L_1421] = false
                                end
                                L_1383()
                            end
                            return
                        end,
                        GetNewList = function(L_1423, L_1424)
                            L_1373 = false
                            L_733:Create(L_1368, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), { Size = UDim2.new(1, 0, 0, 0) }):Play()
                            L_733:Create(L_1361, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), { Size = UDim2.new(1, 0, 0, 25) }):Play()
                            L_733:Create(L_1366, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), { Rotation = 0 }):Play()
                            if L_1353 then
                                if L_1360(L_1424) then
                                    local L_1425 = {}
                                    for L_1426, L_1427 in ipairs(L_1424) do
                                        L_1425[L_1427] = false
                                    end
                                    L_1376 = L_1425
                                else
                                    for L_1428, L_1429 in pairs(L_1424) do
                                        L_1424[L_1428] = false
                                    end
                                    L_1376 = L_1424
                                end
                            else
                                L_1376 = L_1424 or {}
                            end
                            L_1377 = nil
                            L_1383()
                            return
                        end
                    }
                    local L_1431 = L_626(L_1101, L_1145, L_1350)
                    if not L_1353 then
                        L_622.Dropdowns[L_1431] = {
                            Get = function()
                                return L_1377
                            end,
                            Set = function(L_1432)
                                if not L_1432 then
                                    return
                                end
                                local L_1433 = tostring(L_1432)
                                local L_1434 = false
                                for L_1435, L_1436 in ipairs(L_1376) do
                                    if tostring(L_1436) == L_1433 then
                                        L_1434 = true
                                        break
                                    end
                                end
                                if not L_1434 then
                                    return
                                end
                                L_1377 = L_1433
                                if L_1352 then
                                    L_1372.PlaceholderText = L_1350 .. ": " .. L_1433
                                else
                                    L_1372.Text = L_1350 .. ": " .. L_1433
                                end
                                L_1383()
                                pcall(L_1355, L_1433)
                                return
                            end
                        }
                    else
                        L_622.Dropdowns[L_1431] = {
                            Get = function()
                                local L_1437 = {}
                                for L_1438, L_1439 in pairs(L_1376) do
                                    L_1437[L_1438] = not not L_1439
                                end
                                return L_1437
                            end,
                            Set = function(L_1440)
                                if type(L_1440) ~= "table" then
                                    return
                                end
                                for L_1441, L_1442 in pairs(L_1440) do
                                    if L_1376[L_1441] ~= nil then
                                        L_1376[L_1441] = not not L_1442
                                    end
                                end
                                L_1383()
                                for L_1443, L_1444 in pairs(L_1376) do
                                    pcall(L_1355, L_1443, L_1444)
                                end
                                return
                            end
                        }
                    end
                    return L_1430
                end,
                CreateBind = function(L_1445, L_1446)
                    local L_1447 = tostring(L_1445.Title) or ""
                    local L_1448 = L_1445.Key
                    local L_1449 = L_1445.Default or L_1445.Key
                    local L_1450 = tostring(L_1449):match("UserInputType") and "UserInputType" or "KeyCode"
                    local L_1451 = L_1446 or function()
                        return
                    end
                    local L_1452 = tostring(L_1448):gsub("Enum.UserInputType.", "")
                    local L_1453 = tostring(L_1452):gsub("Enum.KeyCode.", "")
                    local L_1454 = Instance.new(L_32)
                    local L_1455 = Instance.new("UICorner")
                    local L_1456 = Instance.new(L_32)
                    local L_1457 = Instance.new("UICorner")
                    local L_1458 = Instance.new("TextLabel")
                    local L_1459 = Instance.new("TextButton")
                    local L_1460 = Instance.new(L_32)
                    local L_1461 = Instance.new("UICorner")
                    local L_1462 = Instance.new("TextButton")
                    L_1454.Name = L_1447 .. "bguvl"
                    L_1454.Parent = L_1147
                    L_1454.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    L_1454.BackgroundTransparency = 1
                    L_1454.Position = UDim2.new(0, 0, 0.208333328, 0)
                    L_1454.Size = UDim2.new(1, 0, 0, 35)
                    L_1455.CornerRadius = UDim.new(0, 4)
                    L_1455.Name = "BindCorner"
                    L_1455.Parent = L_1454
                    L_1456.Name = "Background1"
                    L_1456.Parent = L_1454
                    L_1456.AnchorPoint = Vector2.new(0.5, 0.5)
                    L_1456.Position = UDim2.new(0.5, 0, 0.5, 0)
                    L_1456.Size = UDim2.new(1, -10, 1, 0)
                    L_1456.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                    table.insert(L_639["Background 1 Color"], function()
                        L_1456.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                        return
                    end)
                    L_1456.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                    table.insert(L_639["Background 1 Transparency"], function()
                        L_1456.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                        return
                    end)
                    L_1457.CornerRadius = UDim.new(0, 4)
                    L_1457.Name = "ButtonCorner"
                    L_1457.Parent = L_1456
                    L_1458.Name = "TextColor"
                    L_1458.Parent = L_1456
                    L_1458.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1458.BackgroundTransparency = 1
                    L_1458.Position = UDim2.new(0, 10, 0, 0)
                    L_1458.Size = UDim2.new(1, -10, 1, 0)
                    L_1458.Font = Enum.Font.GothamBlack
                    L_1458.Text = L_1447
                    L_1458.TextSize = 14
                    L_1458.TextXAlignment = Enum.TextXAlignment.Left
                    L_1458.TextColor3 = getgenv().UIColor[L_34]
                    table.insert(L_639[L_34], function()
                        L_1458.TextColor3 = getgenv().UIColor[L_34]
                        return
                    end)
                    L_1460.Name = "Background2"
                    L_1460.Parent = L_1456
                    L_1460.AnchorPoint = Vector2.new(1, 0.5)
                    L_1460.Position = UDim2.new(1, -5, 0.5, 0)
                    L_1460.Size = UDim2.new(0, 150, 0, 25)
                    L_1460.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                    table.insert(L_639["Background 2 Color"], function()
                        L_1460.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                        return
                    end)
                    L_1461.CornerRadius = UDim.new(0, 4)
                    L_1461.Name = "ButtonCorner"
                    L_1461.Parent = L_1460
                    L_1462.Name = "Bindkey"
                    L_1462.Parent = L_1460
                    L_1462.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1462.BackgroundTransparency = 1
                    L_1462.Size = UDim2.new(1, 0, 1, 0)
                    L_1462.Font = Enum.Font.GothamBold
                    L_1462.Text = tostring(L_1449):gsub("Enum.KeyCode.", "")
                    L_1462.TextSize = 14
                    L_1462.TextColor3 = getgenv().UIColor[L_34]
                    table.insert(L_639[L_34], function()
                        L_1462.TextColor3 = getgenv().UIColor[L_34]
                        return
                    end)
                    local L_1463 = { [Enum.UserInputType.MouseButton1] = "Mouse1", [Enum.UserInputType.MouseButton2] = "Mouse2", [Enum.UserInputType.MouseButton3] = "Mouse3" }
                    L_1462.MouseButton1Click:Connect(function()
                        L_732.ButtonEffect()
                        return
                    end)
                    L_1462.MouseButton1Click:Connect(function()
                        local L_1464 = nil
                        L_1462.Text = "..."
                        L_1464 = game:GetService("UserInputService").InputBegan:Connect(function(L_1465)
                            if L_1463[L_1465.UserInputType] then
                                L_1462.Text = L_1463[L_1465.UserInputType]
                                spawn(function()
                                    wait(0.1)
                                    L_1449 = L_1465.UserInputType
                                    L_1450 = "UserInputType"
                                    return
                                end)
                            elseif L_1465.KeyCode ~= Enum.KeyCode.Unknown then
                                L_1462.Text = tostring(L_1465.KeyCode):gsub("Enum.KeyCode.", "")
                                spawn(function()
                                    wait(0.1)
                                    L_1449 = L_1465.KeyCode
                                    L_1450 = "KeyCode"
                                    return
                                end)
                            end
                            L_1464:Disconnect()
                            return
                        end)
                        return
                    end)
                    game:GetService("UserInputService").InputBegan:Connect(function(L_1466)
                        if L_1449 == L_1466.UserInputType or L_1449 == L_1466.KeyCode then
                            L_1451(L_1449)
                        end
                        return
                    end)
                    return
                end,
                CreateBox = function(L_1467, L_1468)
                    local L_1469 = tostring(L_1467.Title) or ""
                    local L_1470 = tostring(L_1467.Placeholder) or ""
                    local L_1471 = L_1467.Default or false
                    local L_1472 = L_1467.Number or false
                    local L_1473 = L_1468 or function()
                        return
                    end
                    local L_1474 = Instance.new(L_32)
                    local L_1475 = Instance.new("UICorner")
                    local L_1476 = Instance.new(L_32)
                    local L_1477 = Instance.new("UICorner")
                    local L_1478 = Instance.new("TextLabel")
                    local L_1479 = Instance.new(L_32)
                    local L_1480 = Instance.new("UICorner")
                    local L_1481 = Instance.new("TextBox")
                    local L_1482 = Instance.new(L_32)
                    local L_1483 = Instance.new("UICorner")
                    L_1474.Name = "BoxFrame"
                    L_1474.Parent = L_1147
                    L_1474.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    L_1474.BackgroundTransparency = 1
                    L_1474.Position = UDim2.new(0, 0, 0.208333328, 0)
                    L_1474.Size = UDim2.new(1, 0, 0, 60)
                    L_1475.CornerRadius = UDim.new(0, 4)
                    L_1475.Name = "BoxCorner"
                    L_1475.Parent = L_1474
                    L_1476.Name = "Background1"
                    L_1476.Parent = L_1474
                    L_1476.AnchorPoint = Vector2.new(0.5, 0.5)
                    L_1476.Position = UDim2.new(0.5, 0, 0.5, 0)
                    L_1476.Size = UDim2.new(1, -10, 1, 0)
                    L_1476.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                    table.insert(L_639["Background 1 Color"], function()
                        L_1476.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                        return
                    end)
                    L_1476.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                    table.insert(L_639["Background 1 Transparency"], function()
                        L_1476.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                        return
                    end)
                    L_1477.CornerRadius = UDim.new(0, 4)
                    L_1477.Name = "ButtonCorner"
                    L_1477.Parent = L_1476
                    L_1478.Name = "TextColor"
                    L_1478.Parent = L_1476
                    L_1478.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1478.BackgroundTransparency = 1
                    L_1478.Position = UDim2.new(0, 10, 0, 0)
                    L_1478.Size = UDim2.new(1, -10, 0.5, 0)
                    L_1478.Font = Enum.Font.GothamBlack
                    L_1478.Text = L_1469
                    L_1478.TextSize = 14
                    L_1478.TextXAlignment = Enum.TextXAlignment.Left
                    L_1478.TextColor3 = getgenv().UIColor[L_34]
                    table.insert(L_639[L_34], function()
                        L_1478.TextColor3 = getgenv().UIColor[L_34]
                        return
                    end)
                    L_1479.Name = "Background2"
                    L_1479.Parent = L_1476
                    L_1479.AnchorPoint = Vector2.new(1, 0.5)
                    L_1479.ClipsDescendants = true
                    L_1479.Position = UDim2.new(1, -5, 0, 40)
                    L_1479.Size = UDim2.new(1, -10, 0, 25)
                    L_1479.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                    table.insert(L_639["Background 2 Color"], function()
                        L_1479.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                        return
                    end)
                    L_1480.CornerRadius = UDim.new(0, 4)
                    L_1480.Name = "ButtonCorner"
                    L_1480.Parent = L_1479
                    L_1481.Name = "TextColorPlaceholder"
                    L_1481.Parent = L_1479
                    L_1481.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1481.BackgroundTransparency = 1
                    L_1481.Position = UDim2.new(0, 5, 0, 0)
                    L_1481.Size = UDim2.new(1, -5, 1, 0)
                    L_1481.Font = Enum.Font.GothamBold
                    L_1481.PlaceholderText = L_1470
                    L_1481.Text = ""
                    L_1481.TextSize = 14
                    L_1481.TextXAlignment = Enum.TextXAlignment.Left
                    L_1481.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
                    L_1481.TextColor3 = getgenv().UIColor[L_34]
                    table.insert(L_639["Placeholder Text Color"], function()
                        L_1481.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
                        return
                    end)
                    table.insert(L_639[L_34], function()
                        L_1481.TextColor3 = getgenv().UIColor[L_34]
                        return
                    end)
                    L_1482.Name = "TextNSBoxLineeeee"
                    L_1482.Parent = L_1479
                    L_1482.BackgroundTransparency = 1
                    L_1482.Position = UDim2.new(0, 0, 1, -2)
                    L_1482.Size = UDim2.new(1, 0, 0, 6)
                    L_1482.BackgroundColor3 = getgenv().UIColor["Box Highlight Color"]
                    table.insert(L_639["Box Highlight Color"], function()
                        L_1482.BackgroundColor3 = getgenv().UIColor["Box Highlight Color"]
                        return
                    end)
                    L_1483.CornerRadius = UDim.new(1, 0)
                    L_1483.Parent = L_1482
                    L_1481.Focused:Connect(function()
                        L_733:Create(L_1482, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), { BackgroundTransparency = 0 }):Play()
                        return
                    end)
                    L_1481.Focused:Connect(function()
                        L_732.ButtonEffect()
                        return
                    end)
                    if L_1472 then
                        L_1481:GetPropertyChangedSignal("Text"):Connect(function()
                            if not tonumber(L_1481.Text) then
                                L_1481.PlaceholderText = L_1470
                                L_1481.Text = ""
                            end
                            return
                        end)
                    end
                    L_1481.FocusLost:Connect(function()
                        L_733:Create(L_1482, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), { BackgroundTransparency = 1 }):Play()
                        if L_1481.Text ~= "" then
                            L_1473(L_1481.Text)
                        end
                        return
                    end)
                    local L_1484 = {}
                    if L_1471 then
                        L_1481.Text = L_1471
                        L_1473(L_1471)
                    end
                    L_1484.SetValue = function(L_1485)
                        L_1481.Text = L_1485
                        L_1473(L_1485)
                        return
                    end
                    local L_1486 = L_626(L_1101, L_1145, L_1469)
                    L_622.Boxes[L_1486] = {
                        Get = function()
                            return L_1481.Text
                        end,
                        Set = function(L_1487)
                            L_1481.Text = tostring(L_1487 or "")
                            if L_1481.Text ~= "" then
                                L_1473(L_1481.Text)
                            end
                            return
                        end
                    }
                    return L_1484
                end,
                CreateSlider = function(L_1488, L_1489)
                    local L_1490 = tostring(L_1488.Title) or ""
                    local L_1491 = tonumber(L_1488.Min) or 0
                    local L_1492 = tonumber(L_1488.Max) or 100
                    local L_1493 = L_1488.Precise or false
                    local L_1494 = tonumber(L_1488.Default) or 0
                    local L_1495 = 400
                    local L_1496 = game:GetService("UserInputService")
                    local L_1497 = L_733 or game:GetService("TweenService")
                    local L_1498 = game.Players.LocalPlayer:GetMouse()
                    local L_1499 = typeof(L_1489) == "function" and L_1489 or function()
                        return
                    end
                    local L_1501 = function(L_1500)
                        task.spawn(L_1499, L_1500)
                        return
                    end
                    local L_1502 = Instance.new(L_32)
                    local L_1503 = Instance.new("UICorner")
                    local L_1504 = Instance.new(L_32)
                    local L_1505 = Instance.new("UICorner")
                    local L_1506 = Instance.new("TextLabel")
                    local L_1507 = Instance.new(L_32)
                    local L_1508 = Instance.new("TextButton")
                    local L_1509 = Instance.new("UICorner")
                    local L_1510 = Instance.new(L_32)
                    local L_1511 = Instance.new("UICorner")
                    local L_1512 = Instance.new(L_32)
                    local L_1513 = Instance.new("UICorner")
                    local L_1514 = Instance.new("TextBox")
                    L_1502.Name = L_1490 .. "buda"
                    L_1502.Parent = L_1147
                    L_1502.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    L_1502.BackgroundTransparency = 1
                    L_1502.Position = UDim2.new(0, 0, 0.208333328, 0)
                    L_1502.Size = UDim2.new(1, 0, 0, 50)
                    L_1503.CornerRadius = UDim.new(0, 4)
                    L_1503.Name = "SliderCorner"
                    L_1503.Parent = L_1502
                    L_1504.Name = "Background1"
                    L_1504.Parent = L_1502
                    L_1504.AnchorPoint = Vector2.new(0.5, 0.5)
                    L_1504.Position = UDim2.new(0.5, 0, 0.5, 0)
                    L_1504.Size = UDim2.new(1, -10, 1, 0)
                    L_1504.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                    table.insert(L_639["Background 1 Color"], function()
                        L_1504.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                        return
                    end)
                    L_1504.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                    table.insert(L_639["Background 1 Transparency"], function()
                        L_1504.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                        return
                    end)
                    L_1505.CornerRadius = UDim.new(0, 4)
                    L_1505.Name = "SliderBGCorner"
                    L_1505.Parent = L_1504
                    L_1506.Name = "TextColor"
                    L_1506.Parent = L_1504
                    L_1506.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1506.BackgroundTransparency = 1
                    L_1506.Position = UDim2.new(0, 10, 0, 0)
                    L_1506.Size = UDim2.new(1, -10, 0, 25)
                    L_1506.Font = Enum.Font.GothamBlack
                    L_1506.Text = L_1490
                    L_1506.TextSize = 14
                    L_1506.TextXAlignment = Enum.TextXAlignment.Left
                    L_1506.TextColor3 = getgenv().UIColor[L_34]
                    table.insert(L_639[L_34], function()
                        L_1506.TextColor3 = getgenv().UIColor[L_34]
                        return
                    end)
                    L_1507.Name = "SliderBar"
                    L_1507.Parent = L_1502
                    L_1507.AnchorPoint = Vector2.new(0.5, 0.5)
                    L_1507.Position = UDim2.new(0.5, 0, 0.5, 14)
                    L_1507.Size = UDim2.new(0, 400, 0, 6)
                    L_1507.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                    table.insert(L_639["Background 2 Color"], function()
                        L_1507.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                        return
                    end)
                    L_1508.Name = "SliderButton"
                    L_1508.Parent = L_1507
                    L_1508.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1508.BackgroundTransparency = 1
                    L_1508.Size = UDim2.new(1, 0, 1, 0)
                    L_1508.Font = Enum.Font.GothamBold
                    L_1508.Text = ""
                    L_1508.TextColor3 = Color3.fromRGB(230, 230, 230)
                    L_1508.TextSize = 14
                    L_1509.CornerRadius = UDim.new(1, 0)
                    L_1509.Name = "SliderBarCorner"
                    L_1509.Parent = L_1507
                    L_1510.Name = "Bar"
                    L_1510.BorderSizePixel = 0
                    L_1510.Parent = L_1507
                    L_1510.Size = UDim2.new(0, 0, 1, 0)
                    L_1510.BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
                    table.insert(L_639["Slider Line Color"], function()
                        L_1510.BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
                        return
                    end)
                    L_1511.CornerRadius = UDim.new(1, 0)
                    L_1511.Name = "BarCorner"
                    L_1511.Parent = L_1510
                    L_1512.Name = "Background2"
                    L_1512.Parent = L_1502
                    L_1512.AnchorPoint = Vector2.new(1, 0)
                    L_1512.Position = UDim2.new(1, -10, 0, 5)
                    L_1512.Size = UDim2.new(0, 150, 0, 25)
                    L_1512.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                    table.insert(L_639["Background 2 Color"], function()
                        L_1512.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                        return
                    end)
                    L_1513.CornerRadius = UDim.new(0, 4)
                    L_1513.Name = "Sliderbox"
                    L_1513.Parent = L_1512
                    L_1514.Name = "TextColor"
                    L_1514.Parent = L_1512
                    L_1514.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1514.BackgroundTransparency = 1
                    L_1514.Size = UDim2.new(1, 0, 1, 0)
                    L_1514.Font = Enum.Font.GothamBold
                    L_1514.Text = ""
                    L_1514.TextSize = 14
                    L_1514.TextColor3 = getgenv().UIColor[L_34]
                    table.insert(L_639[L_34], function()
                        L_1514.TextColor3 = getgenv().UIColor[L_34]
                        return
                    end)
                    L_1508.MouseEnter:Connect(function()
                        L_1497:Create(L_1510, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), { BackgroundColor3 = getgenv().UIColor["Slider Highlight Color"] }):Play()
                        return
                    end)
                    L_1508.MouseLeave:Connect(function()
                        L_1497:Create(L_1510, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), { BackgroundColor3 = getgenv().UIColor["Slider Line Color"] }):Play()
                        return
                    end)
                    if L_1494 then
                        if L_1494 <= L_1491 then
                            L_1494 = L_1491
                        elseif L_1492 <= L_1494 then
                            L_1494 = L_1492
                        end
                        L_1510.Size = UDim2.new(1 - (L_1492 - L_1494) / (L_1492 - L_1491), 0, 0, 6)
                        L_1514.Text = L_1494
                        L_1501(L_1494)
                    end
                    local L_1515 = nil
                    local L_1516 = nil
                    L_1508.MouseButton1Down:Connect(function()
                        local L_1517 = L_1493 and tonumber(string.format("%.1f", (L_1492 - L_1491) / L_1495 * L_1510.AbsoluteSize.X + L_1491)) or math.floor((L_1492 - L_1491) / L_1495 * L_1510.AbsoluteSize.X + L_1491)
                        L_1514.Text = L_1517
                        L_1501(L_1517)
                        L_1510.Size = UDim2.new(0, math.clamp(L_1498.X - L_1510.AbsolutePosition.X, 0, L_1495), 0, 6)
                        L_1515 = L_1498.Move:Connect(function()
                            local L_1518 = L_1493 and tonumber(string.format("%.1f", (L_1492 - L_1491) / L_1495 * L_1510.AbsoluteSize.X + L_1491)) or math.floor((L_1492 - L_1491) / L_1495 * L_1510.AbsoluteSize.X + L_1491)
                            L_1514.Text = L_1518
                            L_1501(L_1518)
                            L_1510.Size = UDim2.new(0, math.clamp(L_1498.X - L_1510.AbsolutePosition.X, 0, L_1495), 0, 6)
                            return
                        end)
                        L_1516 = L_1496.InputEnded:Connect(function(L_1519)
                            if L_1519.UserInputType == Enum.UserInputType.MouseButton1 then
                                local L_1520 = L_1493 and tonumber(string.format("%.1f", (L_1492 - L_1491) / L_1495 * L_1510.AbsoluteSize.X + L_1491)) or math.floor((L_1492 - L_1491) / L_1495 * L_1510.AbsoluteSize.X + L_1491)
                                L_1514.Text = L_1520
                                L_1501(L_1520)
                                L_1510.Size = UDim2.new(0, math.clamp(L_1498.X - L_1510.AbsolutePosition.X, 0, L_1495), 0, 6)
                                if L_1515 then
                                    L_1515:Disconnect()
                                end
                                if L_1516 then
                                    L_1516:Disconnect()
                                end
                            end
                            return
                        end)
                        return
                    end)
                    local L_1523 = function(L_1521)
                        local L_1522 = tonumber(L_1521)
                        if not L_1522 then
                            return
                        end
                        if L_1522 <= L_1491 then
                            L_1510.Size = UDim2.new(0, 0 * L_1495, 0, 6)
                            L_1514.Text = L_1491
                            L_1501(L_1491)
                        elseif L_1492 <= L_1522 then
                            L_1510.Size = UDim2.new(0, L_1492 / L_1492 * L_1495, 0, 6)
                            L_1514.Text = L_1492
                            L_1501(L_1492)
                        else
                            L_1510.Size = UDim2.new(1 - (L_1492 - L_1522) / (L_1492 - L_1491), 0, 0, 6)
                            L_1514.Text = L_1522
                            L_1501(L_1522)
                        end
                        return
                    end
                    L_1514.FocusLost:Connect(function()
                        L_1523(L_1514.Text)
                        return
                    end)
                    local L_1525 = {
                        SetValue = function(L_1524)
                            L_1523(L_1524)
                            return
                        end
                    }
                    local L_1526 = L_626(L_1101, L_1145, L_1490)
                    L_622.Sliders[L_1526] = {
                        Get = function()
                            return tonumber(L_1514.Text) or L_1491
                        end,
                        Set = function(L_1527)
                            L_1523(tonumber(L_1527) or L_1491)
                            return
                        end
                    }
                    return L_1525
                end,
                
-- ------------------------------------------------------------
-- Keybind Control
-- ------------------------------------------------------------
CreateKeybind = function(L_1528, L_1529)
                    local L_1530 = tostring(L_1528.Title) or "Keybind"
                    local L_1531 = L_1528.Default or Enum.KeyCode.E
                    local L_1532 = tostring(L_1531):match("UserInputType") and "UserInputType" or "KeyCode"
                    local L_1533 = L_1529 or function()
                        return
                    end
                    local L_1534 = Instance.new(L_32)
                    local L_1535 = Instance.new("UICorner")
                    local L_1536 = Instance.new(L_32)
                    local L_1537 = Instance.new("UICorner")
                    local L_1538 = Instance.new("TextLabel")
                    local L_1539 = Instance.new(L_32)
                    local L_1540 = Instance.new("UICorner")
                    local L_1541 = Instance.new("TextButton")
                    L_1534.Name = L_1530 .. "KeybindFrame"
                    L_1534.Parent = L_1147
                    L_1534.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    L_1534.BackgroundTransparency = 1
                    L_1534.Position = UDim2.new(0, 0, 0.208333328, 0)
                    L_1534.Size = UDim2.new(1, 0, 0, 35)
                    L_1535.CornerRadius = UDim.new(0, 4)
                    L_1535.Name = "KeybindCorner"
                    L_1535.Parent = L_1534
                    L_1536.Name = "Background1"
                    L_1536.Parent = L_1534
                    L_1536.AnchorPoint = Vector2.new(0.5, 0.5)
                    L_1536.Position = UDim2.new(0.5, 0, 0.5, 0)
                    L_1536.Size = UDim2.new(1, -10, 1, 0)
                    L_1536.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                    table.insert(L_639["Background 1 Color"], function()
                        L_1536.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                        return
                    end)
                    L_1536.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                    table.insert(L_639["Background 1 Transparency"], function()
                        L_1536.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                        return
                    end)
                    L_1537.CornerRadius = UDim.new(0, 4)
                    L_1537.Name = "KeybindBGCorner"
                    L_1537.Parent = L_1536
                    L_1538.Name = "TextColor"
                    L_1538.Parent = L_1536
                    L_1538.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1538.BackgroundTransparency = 1
                    L_1538.Position = UDim2.new(0, 10, 0, 0)
                    L_1538.Size = UDim2.new(1, -10, 1, 0)
                    L_1538.Font = Enum.Font.GothamBlack
                    L_1538.Text = L_1530
                    L_1538.TextSize = 14
                    L_1538.TextXAlignment = Enum.TextXAlignment.Left
                    L_1538.TextColor3 = getgenv().UIColor[L_34]
                    table.insert(L_639[L_34], function()
                        L_1538.TextColor3 = getgenv().UIColor[L_34]
                        return
                    end)
                    L_1539.Name = "Background2"
                    L_1539.Parent = L_1536
                    L_1539.AnchorPoint = Vector2.new(1, 0.5)
                    L_1539.Position = UDim2.new(1, -5, 0.5, 0)
                    L_1539.Size = UDim2.new(0, 150, 0, 25)
                    L_1539.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                    table.insert(L_639["Background 2 Color"], function()
                        L_1539.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                        return
                    end)
                    L_1540.CornerRadius = UDim.new(0, 4)
                    L_1540.Name = "KeybindButtonCorner"
                    L_1540.Parent = L_1539
                    L_1541.Name = "KeybindButton"
                    L_1541.Parent = L_1539
                    L_1541.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    L_1541.BackgroundTransparency = 1
                    L_1541.Size = UDim2.new(1, 0, 1, 0)
                    L_1541.Font = Enum.Font.GothamBold
                    L_1541.Text = tostring(L_1531):gsub("Enum.KeyCode.", ""):gsub("Enum.UserInputType.", "")
                    L_1541.TextSize = 14
                    L_1541.TextColor3 = getgenv().UIColor[L_34]
                    table.insert(L_639[L_34], function()
                        L_1541.TextColor3 = getgenv().UIColor[L_34]
                        return
                    end)
                    local L_1542 = { [Enum.UserInputType.MouseButton1] = "Mouse1", [Enum.UserInputType.MouseButton2] = "Mouse2", [Enum.UserInputType.MouseButton3] = "Mouse3" }
                    L_1541.MouseButton1Click:Connect(function()
                        L_732.ButtonEffect()
                        return
                    end)
                    L_1541.MouseButton1Click:Connect(function()
                        local L_1543 = nil
                        L_1541.Text = "..."
                        L_1543 = game:GetService("UserInputService").InputBegan:Connect(function(L_1544)
                            if L_1542[L_1544.UserInputType] then
                                L_1541.Text = L_1542[L_1544.UserInputType]
                                spawn(function()
                                    wait(0.1)
                                    L_1531 = L_1544.UserInputType
                                    L_1532 = "UserInputType"
                                    return
                                end)
                            elseif L_1544.KeyCode ~= Enum.KeyCode.Unknown then
                                L_1541.Text = tostring(L_1544.KeyCode):gsub("Enum.KeyCode.", "")
                                spawn(function()
                                    wait(0.1)
                                    L_1531 = L_1544.KeyCode
                                    L_1532 = "KeyCode"
                                    return
                                end)
                            end
                            L_1543:Disconnect()
                            return
                        end)
                        return
                    end)
                    game:GetService("UserInputService").InputBegan:Connect(function(L_1545)
                        if L_1531 == L_1545.UserInputType or L_1531 == L_1545.KeyCode then
                            L_1533(L_1531)
                        end
                        return
                    end)
                    local L_1547 = {
                        SetKey = function(L_1546)
                            L_1531 = L_1546
                            L_1541.Text = tostring(L_1546):gsub("Enum.KeyCode.", ""):gsub("Enum.UserInputType.", "")
                            return
                        end,
                        GetKey = function()
                            return L_1531
                        end
                    }
                    local L_1548 = L_626(L_1101, L_1145, L_1530)
                    L_622.Keybinds[L_1548] = {
                        Get = function()
                            return tostring(L_1531)
                        end,
                        Set = function(L_1549)
                            if not L_1549 then
                                return
                            end
                            local L_1550 = tostring(L_1549)
                            for L_1551, L_1552 in ipairs(Enum.KeyCode:GetEnumItems()) do
                                if L_1552.Name == L_1550 or "Enum.KeyCode." .. L_1552.Name == L_1550 then
                                    L_1531 = L_1552
                                    L_1541.Text = L_1552.Name
                                    return
                                end
                            end
                            for L_1553, L_1554 in ipairs(Enum.UserInputType:GetEnumItems()) do
                                if L_1554.Name == L_1550 or "Enum.UserInputType." .. L_1554.Name == L_1550 then
                                    L_1531 = L_1554
                                    L_1541.Text = L_1554.Name
                                    return
                                end
                            end
                            return
                        end
                    }
                    return L_1547
                end
            }
        end
    }
end
-- ============================================================
-- Compatibility Helpers
-- ============================================================

-- Optional lowercase alias for projects that prefer method-style naming.
FeralUI.createPage = FeralUI.CreatePage

return FeralUI
