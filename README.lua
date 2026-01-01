local button = script.Parent
local player = game.Players.LocalPlayer

button.MouseButton1Click:Connect(function()
    button.Text = "Меняем..."
    button.BackgroundColor3 = Color3.fromRGB(100, 100, )
    local remote = game.ReplicatedStorage:FindFirstChild("SkipMusic")
    if remote then
        remote:FireServer()
    end
    
    task.wait(1)
    button.Text = "Пропустить трек"
    button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
end
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local skipEvent = Instance.new("RemoteEvent")
skipEvent.Name = "SkipMusic"
skipEvent.Parent = ReplicatedStorage

local musicList = {
    1837826677, 1839845585, 1843404001 -- Твои ID
}

local backgroundMusic = Instance.new("Sound")
backgroundMusic.Name = "GlobalMusic"
backgroundMusic.Parent = game.Workspace
backgroundMusic.Volume = 0.4

local function playNext()
    local randomId = musicList[math.random(1, #musicList)]
    backgroundMusic.SoundId = "rbxassetid://" .. randomId
    backgroundMusic:Play()
end

skipEvent.OnServerEvent:Connect(function(player)
    print(player.Name .. " пропустил трек")
    playNext()
end)

task.spawn(function()
    while true do
        if not backgroundMusic.IsPlaying then
            playNext()
        end
        backgroundMusic.Ended:Wait()
    end
end
