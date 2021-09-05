function love.load()

    -- Assets
    sprites = {}
    sprites.background = love.graphics.newImage('sprites/background.png')
    sprites.bullet = love.graphics.newImage('sprites/bullet.png')
    sprites.player = love.graphics.newImage('sprites/player.png')
    sprites.zombie = love.graphics.newImage('sprites/zombie.png')
    -- Player pos
    player = {}
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2
    player.speed = 2.5
end

function love.update()
    -- Right movement
    if love.keyboard.isDown('d') then
        player.x = player.x + player.speed
    end
    -- left movement
    if love.keyboard.isDown('a') then
        player.x = player.x - player.speed
    end
    -- up movement
    if love.keyboard.isDown('w') then
        player.y = player.y - player.speed
    end
    -- down movement
    if love.keyboard.isDown('s') then
        player.y = player.y + player.speed
    end
    
end

function love.draw()
    --Draw the background
    love.graphics.draw(sprites.background,0,0)

    -- Draw Player
    love.graphics.draw(sprites.player,player.x,player.y)
end