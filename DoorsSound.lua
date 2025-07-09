--666

local function updateDoorSounds(room)
    local door = room.Door.Door
    door.Open.SoundId = "rbxassetid://7792948465" -- 😋
    door.Unlock.SoundId = "rbxassetid://7792948465" --🐛
    door.SlamOpen.SoundId = "rbxassetid://7792948465" --。
end

updateDoorSounds(workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value])

coroutine.wrap(function()
    game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
        wait(0.5)
        updateDoorSounds(workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value])
    end)
end)()
