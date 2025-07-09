--Freedom Mode
coroutine.wrap(function()
if game:GetService("ReplicatedStorage").GameData.Floor.Value == "Hotel" then
while true do
wait(0.0005)
workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value]:FindFirstChild("Door"):FindFirstChild("Door").Material = "Brick"
workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value]:FindFirstChild("Door"):FindFirstChild("Door"):FindFirstChild("Sign").Material = "Ice"
end
end
end)()
