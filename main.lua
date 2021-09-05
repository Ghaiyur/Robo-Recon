function love.load()

    -- Assets
    sprites = {}
    sprites.background = love.graphics.newImage('sprites/background.png')
    sprites.bullet = love.graphics.newImage('sprites/bullet.png')
    sprites.player = love.graphics.newImage('sprites/player.png')
    sprites.zombie = love.graphics.newImage('sprites/zombie.png')
    -- Player pos and spd
    player = {}
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2
    player.speed = 180
    --Zombies
    zombies = {}

end

function love.update(dt)

    -- Player Movement
    -- Right movement
    if love.keyboard.isDown('d') then
        player.x = player.x + player.speed*dt -- Mul dt top the speed change to accomodate framedrops
    end
    -- left movement
    if love.keyboard.isDown('a') then
        player.x = player.x - player.speed*dt
    end
    -- up movement
    if love.keyboard.isDown('w') then
        player.y = player.y - player.speed*dt
    end
    -- down movement
    if love.keyboard.isDown('s') then
        player.y = player.y + player.speed*dt
    end

    -- Zombie Movement
    for i,z in ipairs(zombies) do
        z.x = z.x + (math.cos(zombiePlayerAngle(z)) * z.speed * dt)
        z.y = z.y + (math.sin(zombiePlayerAngle(z)) * z.speed * dt)
    end
    
end

function love.draw()

    --Draw the background
    love.graphics.draw(sprites.background,0,0)

    -- Draw Player
    love.graphics.draw(sprites.player,player.x,player.y,playerMouseAngle(),nil,nil,sprites.player:getWidth()/2,sprites.player:getHeight()/2)

    -- Draw Zombies
    for i,z in ipairs(zombies) do
        love.graphics.draw(sprites.zombie,z.x,z.y,zombiePlayerAngle(z),nil,nil,sprites.zombie:getWidth()/2,sprites.zombie:getHeight()/2)
    end

end

-- Extra Functions

-- Player facing the mouse
function playerMouseAngle()
    return math.atan2(player.y-love.mouse.getY(),player.x-love.mouse.getX()) + math.pi
end

-- Zombie player angle using same formula
function zombiePlayerAngle(enemy)
    return math.atan2(player.y-enemy.y,player.x-enemy.x)
end

-- Spawn Zombies
function spawnZombie()
    local zombie = {}
    zombie.x = math.random(0,love.graphics.getWidth())
    zombie.y = math.random(0,love.graphics.getHeight())
    zombie.speed = 100
    table.insert(zombies,zombie)
end