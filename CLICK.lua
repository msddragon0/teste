print("=== DEBUG DRONX ===")

-- 1. Verifica se está achando NPC
local player = game.Players.LocalPlayer
local character = player.Character
local rootPart = character:WaitForChild("HumanoidRootPart")

local enemiesFolder = workspace:FindFirstChild("Enemies")
if enemiesFolder then
    print("✅ Pasta Enemies existe. Total: " .. #enemiesFolder:GetChildren())
    for _, npc in pairs(enemiesFolder:GetChildren()) do
        if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 and npc:FindFirstChild("HumanoidRootPart") then
            local dist = (rootPart.Position - npc.HumanoidRootPart.Position).Magnitude
            print("   NPC: " .. npc.Name .. " | Dist: " .. math.floor(dist) .. " | HP: " .. npc.Humanoid.Health)
        end
    end
else
    warn("❌ Pasta Enemies NÃO EXISTE")
end

-- 2. Testa teleporte manual
local primeiroNPC = nil
if enemiesFolder then
    for _, npc in pairs(enemiesFolder:GetChildren()) do
        if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 and npc:FindFirstChild("HumanoidRootPart") then
            primeiroNPC = npc
            break
        end
    end
end

if primeiroNPC then
    print("🚀 Teleportando pra cima de: " .. primeiroNPC.Name)
    rootPart.CFrame = primeiroNPC.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
    task.wait(1)
    local dist = (rootPart.Position - primeiroNPC.HumanoidRootPart.Position).Magnitude
    print("   Distância depois de teleportar: " .. math.floor(dist))
    print("   Sua posição: " .. tostring(rootPart.Position))
    print("   Posição do NPC: " .. tostring(primeiroNPC.HumanoidRootPart.Position))
else
    warn("❌ Nenhum NPC encontrado pra teleportar")
end

-- 3. Testa hook de ataque
local ok, CbFw2 = pcall(function()
    local CbFw = debug.getupvalues(require(player.PlayerScripts.CombatFramework))
    return CbFw[2]
end)

if ok and CbFw2 then
    print("✅ Hook CbFw2 carregado")
    if CbFw2.activeController then
        print("   ✅ activeController existe")
        print("   ✅ blades: " .. tostring(#CbFw2.activeController.blades))
        if CbFw2.activeController.attack then
            print("   ✅ Função attack existe")
        else
            warn("   ❌ Função attack NÃO existe")
        end
    else
        warn("   ❌ activeController é NIL")
    end
else
    warn("❌ Hook CbFw2 falhou: " .. tostring(CbFw2))
end

-- 4. Verifica stats
local stats = player.Data:FindFirstChild("Stats")
if stats then
    print("=== STATS ===")
    for _, s in pairs(stats:GetChildren()) do
        print("   " .. s.Name .. ": " .. tostring(s.Value))
    end
else
    warn("❌ Data.Stats não encontrado")
end

print("=== FIM DO DEBUG ===")
