print("=== TESTE ATTACKNPC ===")

local player = game.Players.LocalPlayer
local char = player.Character
local root = char:WaitForChild("HumanoidRootPart")

-- Acha o primeiro NPC
local enemies = workspace:FindFirstChild("Enemies")
if not enemies then print("Sem Enemies") return end

local npc = nil
for _, v in pairs(enemies:GetChildren()) do
    if v:IsA("Model") and v:FindFirstChildOfClass("Humanoid") and v.Humanoid.Health > 0 then
        npc = v
        break
    end
end

if not npc then print("Sem NPC vivo") return end
print("NPC:", npc.Name)

-- Testa teleporte direto
print("Antes:", root.Position)
root.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
task.wait(0.5)
print("Depois:", root.Position)
print("NPC:", npc.HumanoidRootPart.Position)
print("Distância:", (root.Position - npc.HumanoidRootPart.Position).Magnitude)

-- Testa ataque com clique
print("Tentando atacar...")
game:GetService("VirtualUser"):CaptureController()
game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
task.wait(0.5)
game:GetService("VirtualUser"):Button1Up(Vector2.new(1280, 672))
print("Ataque enviado")

-- Testa keypress (do Delta)
if keypress then
    print("keypress existe!")
    keypress(0x51)  -- Q
    task.wait(0.1)
    keyrelease(0x51)
    print("Q pressionado")
else
    print("keypress NÃO existe")
end

-- Testa mouse1click (do Delta)
if mouse1click then
    print("mouse1click existe!")
    mouse1click()
    print("Clique enviado")
else
    print("mouse1click NÃO existe")
end

print("=== FIM ===")
