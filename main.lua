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

end

function love.update(dt)
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
    
end

function love.draw()
    --Draw the background
    love.graphics.draw(sprites.background,0,0)

    -- Draw Player
    love.graphics.draw(sprites.player,player.x,player.y,math.pi/2,nil,nil,sprites.player:getWidth()/2,sprites.player:getHeight()/2)
end