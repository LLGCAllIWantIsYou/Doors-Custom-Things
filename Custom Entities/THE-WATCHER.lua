function GetRoom()
    local gruh = workspace.CurrentRooms
    return gruh:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
end

local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local tweenservice = game:GetService("TweenService")
local runService = game:GetService("RunService")


function LoadCustomInstance(source, parent)
    local model

    local function NormalizeGitHubURL(url)
        if url:match("^https://github.com/.+%.rbxm$") and not url:find("?raw=true") then
            return url .. "?raw=true"
        end
        return url
    end

    while task.wait() and not model do
        if tonumber(source) then
            local success, result = pcall(function()
                return game:GetObjects("rbxassetid://" .. tostring(source))[1]
            end)
            if success and result then
                model = result
            end
        elseif typeof(source) == "string" and source:match("%.rbxm") then
            local url = NormalizeGitHubURL(source)
            local success, result = pcall(function()
                local filename = "temp_" .. math.random(100000, 999999) .. ".rbxm"
                local content = game:HttpGet(url)
                if writefile and (getcustomasset or getsynasset) and isfile and delfile then
                    writefile(filename, content)
                    local assetFunc = getcustomasset or getsynasset
                    local obj = game:GetObjects(assetFunc(filename))[1]
                    delfile(filename)
                    return obj
                else
                    warn("File APIs are not available.")
                    return nil
                end
            end)
            if success and result then
                model = result
            end
        else
            break
        end

        if model then
            model.Parent = parent or workspace
            for _, obj in ipairs(model:GetDescendants()) do
                if obj:IsA("Script") or obj:IsA("LocalScript") then
                    obj:Destroy()
                end
            end
            pcall(function()
                model:SetAttribute("LoadedByExecutor", true)
            end)
        end
    end

    return model
end

local spawnCount = 0
local maxSpawns = 5

while spawnCount < maxSpawns do

    local s = LoadCustomInstance("https://github.com/fnaclol/sussy-bois/blob/main/TheWatcher.rbxm?raw=true", workspace)
    if not s then
        warn("Failed to load the model.")
        break
    end


    local rootPart = s:FindFirstChildWhichIsA("BasePart")
    if not rootPart then
        warn("No BasePart found in the model.")
        s:Destroy()
        break
    end

  
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPartPlayer = character:FindFirstChild("HumanoidRootPart")
    if not rootPartPlayer then break end

    local randomDirection = Vector3.new(math.random(-1, 1), 0, math.random(-1, 1)).Unit
    local spawnPos = rootPartPlayer.CFrame + randomDirection * 5
    rootPart.CFrame = spawnPos

 
    task.wait(1)

 
    local isLooking = false
    local timeNotLooking = 0
    local timeLooking = 0
    local entityLoaded = false

  
    task.spawn(function()
        entityLoaded = true
        while s.Parent ~= nil do
            task.wait(0.1)

            local _, onScreen = workspace.CurrentCamera:WorldToViewportPoint(rootPart.Position)

            if onScreen then
                timeLooking += 0.1
                timeNotLooking = 0

                if timeLooking >= 3 then
                    print("Player looked at the entity for 3 seconds. Entity despawned.")
                    s.Parent = nil
                    break
                end
            else
                timeNotLooking += 0.1
                timeLooking = 0

                if timeNotLooking >= 3 then
                    print("Player didn't look at the entity for 3 seconds. Player takes damage.")
                    character.Humanoid.Health = character.Humanoid.Health - 25
                    s.Parent = nil
                    break
                end
            end
        end
    end)

    repeat task.wait() until entityLoaded

    repeat task.wait() until not s.Parent or character.Humanoid.Health <= 0

    if s.Parent then
        s.Parent = nil
    end

    spawnCount += 1
    print("Spawn count: " .. spawnCount .. "/" .. maxSpawns)

    task.wait(2)
end

print("All spawns completed.")
