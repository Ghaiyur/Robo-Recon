-- ================================================================================================
-- LOAD
-- ================================================================================================

function love.load()
    
    -- Randomsize seed
    math.randomseed(os.time())
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
    -- Bullets
    bullets = {}
    -- Game state
    gameState = 1 --1 is main menu, 2 is game
    maxTime= 2
    timer = maxTime
    -- Font
    MyFont = love.graphics.newFont(35) 

end

-- ================================================================================================
-- UPDATE
-- ================================================================================================


function love.update(dt)

    -- Player Movement
    -- Right movement
    if gameState == 2 then
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
    end

    -- Zombie Movement
    for i,z in ipairs(zombies) do
        z.x = z.x + (math.cos(zombiePlayerAngle(z)) * z.speed * dt)
        z.y = z.y + (math.sin(zombiePlayerAngle(z)) * z.speed * dt)

        -- Zombie Collison with player
        if distanceBetween(z.x,z.y,player.x,player.y) < 30 then
            for i,z in ipairs(zombies) do
                zombies[i] = nil
                gameState = 1
                player.x = love.graphics.getWidth()/2
                player.y = love.graphics.getHeight()/2
            end
        end
    end

    -- Bullet Movement
    for i,b in ipairs(bullets) do
        b.x = b.x + (math.cos(b.direction) * b.speed * dt)
        b.y = b.y + (math.sin(b.direction) * b.speed * dt)
    end
    
    -- Delete Bullet
    for i=#bullets,1,-1 do  -- #table gives the count basically len(table)
        local b = bullets[i]
        if b.x < 0 or b.y < 0 or b.x > love.graphics.getWidth() or b.y > love.graphics.getHeight() or b.dead == true then
            table.remove(bullets,i)
        end
    end

    -- Compare zomb to bullet
    for i,z in ipairs(zombies) do
        for j,b in ipairs(bullets) do
            if distanceBetween(z.x,z.y,b.x,b.y) < 20 then -- Using distance between two objects, if less tahn 15px then set flag to dead
                z.dead = true
                b.dead = true
            end
        end
    end

    -- Deleting Zombies
    for i=#zombies,1,-1 do
        local z = zombies[i]
        if z.dead == true then
            table.remove(zombies,i)
        end
    end

    -- Timer will start counting down, and when it reaches 0 it spawns a zombie and resets
    if gameState == 2 then
        timer = timer - dt
        if timer <= 0 then
            spawnZombie()
            maxTime = 0.95 * maxTime
            timer = maxTime
        end
    end

end
-- ================================================================================================
-- DRAW
-- ================================================================================================
function love.draw()

    --Draw the background
    love.graphics.draw(sprites.background,0,0)

    if gameState == 1 then
        love.graphics.setFont(MyFont)
        love.graphics.printf('Click anywhere to begin!',0,50,love.graphics.getWidth(),'center')
    end

    -- Draw Player
    love.graphics.draw(sprites.player,player.x,player.y,playerMouseAngle(),nil,nil,sprites.player:getWidth()/2,sprites.player:getHeight()/2)

    -- Draw Zombies
    for i,z in ipairs(zombies) do
        love.graphics.draw(sprites.zombie,z.x,z.y,zombiePlayerAngle(z),nil,nil,sprites.zombie:getWidth()/2,sprites.zombie:getHeight()/2)
    end

    -- Draw Bullets
    for i,b in ipairs(bullets) do
        love.graphics.draw(sprites.bullet,b.x,b.y,nil,0.3,0.3,sprites.bullet:getWidth()/2,sprites.bullet:getHeight()/2)
    end

end
-- ================================================================================================
-- Extra Functions
-- ================================================================================================


-- Objects Spawners

-- Zombie Spawner on space
function love.keypressed(key)
    if key == 'space' then
        spawnZombie()
    end
end

-- Bullet Spawner
function love.mousepressed(x,y,button)
    if button == 1 and gameState == 2 then -- Can only shoot when gamestate 2
        spawnBullet()
    elseif button ==1 and gameState == 1 then
        gameState = 2
        maxTime = 2
    end
end

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
    zombie.x = 0
    zombie.y = 0
    zombie.speed = 160
    zombie.dead = false

    -- Mechanics for edge spawn
    local side = math.random(1,4)
    if side == 1 then -- Left side
        zombie.x = -30
        zombie.y = math.random(0,love.graphics.getHeight())
    elseif side == 2 then -- Right side
        zombie.x = love.graphics.getWidth() + 30
        zombie.y = math.random(0,love.graphics.getHeight())
    elseif side == 3 then --Top side
        zombie.x = math.random(0,love.graphics.getWidth())
        zombie.y = -30
    elseif side == 4 then -- Bottom side
        zombie.x = math.random(0,love.graphics.getWidth())
        zombie.y = love.graphics.getHeight() + 30
    end

    table.insert(zombies,zombie)
end

-- Spawn Bullets
function spawnBullet()
    local bullet = {}
    bullet.x = player.x
    bullet.y = player.y
    bullet.speed = 500
    bullet.direction = playerMouseAngle()
    bullet.dead = false
    table.insert(bullets,bullet)
end

-- Distance Between two points
function distanceBetween(x1,y1,x2,y2)
    return math.sqrt((x2-x1)^2 + (y2-y1)^2)
end