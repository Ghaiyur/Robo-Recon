# Robo Recon
 A top down shooter

## Dev log

- [x] Sprites
    - [x] Added background
    - [x] Added player 
- [x] Player movement 
    - [x] Checks if the key is pressed love.keyboard.isDown
        - [x] and then any operations can be performed under that func
        - [x] increase or decrease x and y of the player 
    - [x] Added player.speed
- [x] Delta time
    - [x] mul dt to speed to accomodate framerate drops 
- [] Player Rotation
    - [x] angle * (pi/180) radian value
    - [x] Offset the center of the sprite using sprites.player:getHeight()/2 and sprites.player:getWidth()/2
    - 