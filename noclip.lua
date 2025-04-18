-- Script de Noclip
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local noclip = true

game:GetService("RunService").Stepped:Connect(function()
    if noclip and character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)
