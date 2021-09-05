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
- [x] Player Rotation
    - [x] angle * (pi/180) radian value
    - [x] Offset the center of the sprite using sprites.player:getHeight()/2 and sprites.player:getWidth()/2
- [x] Face the mouse
    - [x] atan2(y1-y2,x1-x2)
    - [x] just add pi to reverse stuff
- [x] Enemies
    - [x] Create zombie spawn
    - [x] Tables of zombies
    - love.keypressed(key) just activates the function once , whereas isDown keeps checking if the key has been pressed or not 
- [x] Enemy Rotation
    - [x] Created Zombie player angle finder
    - [x] Make sure to handle the offset of the sprites 
- [x] Enemy Movement 
    - [x] Would be slightly similar to player movement, but their movmeent is constanly towards the player
    - [x] Use Unit circle to make zombie go in same direction as player
        - [x] to get the x of the zom to player use cos (zomplayerangle)
        - [x] to get the y of the zom to player use sin (zomplayerangle)
    - [x] To Make sure the increase of pos towards player has speed , multiple it with zom speed and then also multiple it with delta time to accomodate for frame drops
- [x] Collision
    - [x] Use the distance between again to check how far two sprite objects are from each other 
    - [x] and if the zombie comes within certain pxlen then set zombies to zero
- [x] Shooting projectiles
    - [x] Create bullets table and single bullets
    - [x] For bullet movement create in update a for loop slighlty similar to zombies
- [] Scaling Sprities