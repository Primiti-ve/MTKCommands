return {
    Name = "fling",
    Description = "Flings a player or set of players.",
    Group = "DefaultAdmin",
    Args = {
        {
            Type = "players",
            Name = "players",
            Description = "The players to fling.",
        },
        {
            Type = "number",
            Name = "force",
            Description = "The force to fling the players with."
        }
    },

    ClientRun = function(_Context, Players: { Player }, Force: number)
        Force = math.clamp(Force, 0, 5000)
    
        local Velocity = Vector3.new(math.random(Force / 2, Force), math.random(Force / 2, Force), math.random(Force / 2, Force))
    
        for _, Player in pairs(Players) do
            if Player.Character then
                local HumanoidRootPart = Player.Character:FindFirstChild("HumanoidRootPart")
                local Humanoid = Player.Character:FindFirstChild("Humanoid")
    
                Humanoid.Sit = true
                HumanoidRootPart.AssemblyLinearVelocity = Velocity
            end
        end
    
        return ("Flung %d players."):format(#Players)
    end
}