local Creator = require("../Creator")
local New = Creator.New
local Tween = Creator.Tween

local Element = {}

function Element:New(Config)
    local Section = {
        __type = "Section",
        Title = Config.Title or "Section",
        TextXAlignment = Config.TextXAlignment or "Left",
        TextSize = Config.TextSize or 19,
        UIElements = {},
    }

    Section.UIElements.Main = New("TextLabel", {
        BackgroundTransparency = 1,
        TextXAlignment = Section.TextXAlignment,
        AutomaticSize = "Y",
        TextSize = Section.TextSize,
        ThemeTag = {
            TextColor3 = "Text",
        },
        FontFace = Font.new(Creator.Font, Enum.FontWeight.SemiBold),
        Parent = Config.Parent,
        Size = UDim2.new(1,0,0,0),
        Text = Section.Title,
    }, {
        New("UIPadding", {
            PaddingTop = UDim.new(0,4),
            PaddingBottom = UDim.new(0,2),
        })
    })

    -- Section.UIElements.Main:GetPropertyChangedSignal("TextBounds"):Connect(function()
    --     Section.UIElements.Main.Size = UDim2.new(1,0,0,Section.UIElements.Main.TextBounds.Y)
    -- end)

    function Section:SetTitle(Title)
        Section.UIElements.Main.Text = Title
    end

    function Section:Destroy()
        Section.UIElements.Main.AutomaticSize = "None"
        Section.UIElements.Main.Size = UDim2.new(1,0,0,Section.UIElements.Main.TextBounds.Y)

        Tween(Section.UIElements.Main, .1, {TextTransparency = 1}):Play()
        task.wait(.1)
        Tween(Section.UIElements.Main, .15, {Size = UDim2.new(1,0,0,0)}, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut):Play()
    end

    -- Hypothetical AddToggle function (Corrected Again!)
    function Section:AddToggle(Config, ParentFrame)
        local Toggle = {}

        Toggle.MainFrame = New("Frame", {
            Size = UDim2.new(0.5, -5, 1, 0),  -- Half the width, minus some padding
            Position = UDim2.new(Config.Position or 0, 0, 0, 0), -- Use config position or default to 0
            Parent = ParentFrame, -- Use the parent frame passed in
            BackgroundColor3 = Color3.fromRGB(255,255,255),
            BackgroundTransparency = 0.9
        })

        -- Icon (Left)
        Toggle.Icon = New("ImageLabel", {
            Size = UDim2.new(0, 24, 1, 0),  -- Size of the icon
            Position = UDim2.new(0, 0, 0, 0),  -- Position on the left
            Parent = Toggle.MainFrame,
            BackgroundColor3 = Color3.fromRGB(255,255,255),
            BackgroundTransparency = 1,
            Image = Config.Icon or "",  -- Icon image
        })

        -- Label (Middle)
        Toggle.TextLabel = New("TextLabel", {
            Size = UDim2.new(0.6, 0, 1, 0),  -- Size of the label
            Position = UDim2.new(0, 24, 0, 0),  -- Position to the right of the icon
            Parent = Toggle.MainFrame,
            BackgroundColor3 = Color3.fromRGB(255,255,255),
            BackgroundTransparency = 1,
            Text = Config.Title or "Toggle Title",  -- Use the Title from Config
            TextXAlignment = Enum.TextXAlignment.Left,
        })

        -- Toggle Switch (Right)
        Toggle.Switch = New("ImageButton", {
            Size = UDim2.new(0, 40, 1, 0),  -- Size of the toggle switch
            Position = UDim2.new(1, -45, 0, 0),  -- Position on the right
            Parent = Toggle.MainFrame,
            BackgroundColor3 = Color3.fromRGB(255,255,255),
            BackgroundTransparency = 1,
            Image = "rbxassetid://...",  -- Replace with your switch image asset ID
        })
    end

    Section.AddToggle = Section.AddToggle
    return Section.__type, Section
end

return Element
