-- Maykizin Script com Noclip, Speed, Fly e botão de fechar
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Maykizin Script",
    SubTitle = "Noclip, Speed, Fly e mais",
    TabWidth = 160,
    Size = UDim2.fromOffset(500, 320),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local MainTab = Window:AddTab({ Title = "Principal", Icon = "zap" })
local Options = Fluent.Options

-- Noclip
local noclipAtivo = false
local noclipConexao
MainTab:AddToggle("ToggleNoclip", {
    Title = "Ativar Noclip",
    Default = false
}):OnChanged(function(state)
    noclipAtivo = state
    if state then
        noclipConexao = game:GetService("RunService").Stepped:Connect(function()
            if noclipAtivo and game.Players.LocalPlayer.Character then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide then
                        v.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConexao then noclipConexao:Disconnect() end
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = true end
        end
    end
end)

-- Speed
MainTab:AddToggle("ToggleSpeed", {
    Title = "Ativar Velocidade",
    Default = false
}):OnChanged(function(state)
    local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = state and 75 or 16
end)

-- Fly
local flying = false
local flyCon
MainTab:AddToggle("ToggleFly", {
    Title = "Ativar Fly",
    Default = false
}):OnChanged(function(state)
    flying = state
    local plr = game.Players.LocalPlayer
    local char = plr.Character or plr.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.zero
    bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bv.Name = "MaykizinFly"
    bv.Parent = hrp

    if flyCon then flyCon:Disconnect() end
    if state then
        flyCon = game:GetService("RunService").Heartbeat:Connect(function()
            local dir = Vector3.zero
            local uis = game:GetService("UserInputService")
            if uis:IsKeyDown(Enum.KeyCode.W) then dir += hrp.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.S) then dir -= hrp.CFrame.LookVector end
            if uis:IsKeyDown(Enum.KeyCode.A) then dir -= hrp.CFrame.RightVector end
            if uis:IsKeyDown(Enum.KeyCode.D) then dir += hrp.CFrame.RightVector end
            if uis:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
            if uis:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.new(0,1,0) end
            bv.Velocity = dir * 60
        end)
    else
        if char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart:FindFirstChild("MaykizinFly") then
            char.HumanoidRootPart.MaykizinFly:Destroy()
        end
        if flyCon then flyCon:Disconnect() end
    end
end)

-- Botão de fechar
MainTab:AddButton({
    Title = "Fechar Script",
    Description = "Desativa a GUI e para tudo",
    Callback = function()
        if noclipConexao then noclipConexao:Disconnect() end
        if flyCon then flyCon:Disconnect() end
        Window:Destroy()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Maykizin",
            Text = "Script encerrado!",
            Duration = 4
        })
    end
})

-- Interface e salvamento
InterfaceManager:SetLibrary(Fluent)
SaveManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("MaykizinScript")
SaveManager:SetFolder("MaykizinScript/Teste")
InterfaceManager:BuildInterfaceSection(MainTab)
SaveManager:BuildConfigSection(MainTab)
Window:SelectTab(1)

Fluent:Notify({
    Title = "Maykizin Script",
    Content = "Noclip, Fly e Speed prontos!",
    Duration = 6
})

SaveManager:LoadAutoloadConfig()6, -2.06384709e-09, -0.0894274712)
