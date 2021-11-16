
# Directions
| Up | Right | Down | Left | 
|-------|------|-------|------|
| North | East | South | West | 

# Actions
| Name | Function | Help |
| -------- | ------- | --- |
| Open | Open | Opens an item
| Close | Close | Closes an item
| Start | Start | Starts the game
| Go | Go | Moves in a direction
| Examine | Examine | Examines an item
| Use | Use | Uses an item
| Look | Look | Looks around

# Items
Here is a list of all of the items in the game.

## Gun

This is a standard issue hand gun. You need ammo in order to use it unless you plan on throwing it at enemies?

| Property | Value |
| -------- | ------- |
| Name | Pistol 
| Type | Gun 
| Needs | Ammo
| Value | 1
| Message | In the shadows you see something shimmer. It looks like a gun has been left on the floor. 
| Take | You take the gun. Remember to point it away from you before using it.
| Success | You fired the gun. The gun's ammo indicator now reads ${bullets}.
| Failure | You tried to fire the gun but it was empty.
 
## Ammo

A box full of ammo. You'll need a gun to use these.

| Property | Value |
| -------- | ------- |
| Name | Pistol Bullets 
| Type | Ammo 
| Needs | Pistol
| Value | 2
| Message | You see an ammo box laying on the floor. 
| Take | You found a box of gun ammo. If you have a gun, you'll be able to shoot it.
| Success | You load the ammo into the gun and it now has ${bullets} bullets.
| Failure | This can only be used with a gun.

# Nouns Text
| Name | Help |
| -------- | ------- |
| Terminal | A device containing text to be read
| Map | A device that tells you where you are