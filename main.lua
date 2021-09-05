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
    player.y = love.graphics.getHeight() /2
    
end

function love.update()
    
end

function love.draw()
    --Draw the background
    love.graphics.draw(sprites.background,0,0)

    -- Draw Player
    love.graphics.draw(sprites.player,player.x,player.y)
end