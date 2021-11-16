--[[
  Pixel Vision 8 - New Template Script
  Copyright (C) 2017, Pixel Vision 8 (http://pixelvision8.com)
  Created by Jesse Freeman (@jessefreeman)

  This project was designed to display some basic instructions when you create
  a new game.  Simply delete the following code and implement your own Init(),
  Update() and Draw() logic.

  Learn more about making Pixel Vision 8 games at https://www.gitbook.com/@pixelvision8
]]--

local randomItems = 
{
  {
    name = "gun",
    needs = "ammo",
    value = 1,
    message = "In the shadows you see something shimmer. It looks like a gun has been left on the floor.",
    examine = "This is a standard issue hand gun. You need ammo in order to use it unless you plan on throwing it at enemies?",
    take = "You found a gun. Remember to point it away from you before using it.",
    use = function(state)

      local message = "You fired the gun."

      -- TODO need to reduce ammo

      local ammo = ItemInInventory("ammo", state)

      ammo.value = ammo.value - 1

      message = message .. " The gun's ammo indicator now reads ".. ammo.value .."."

      if(ammo.value == 0) then
        RemoveItemFromInventory("ammo", state)

        message = message .. " You are now out of ammo."
      end


      return message
    end
  },
  {
    name = "ammo",
    needs = "gun",
    value = 2,
    message = "You see an ammo box laying on the floor.",
    examine = "A box full of ammo. You'll need a gun to use these.",
    take = "You found a box of gun ammo. If you have a gun, you'll be able to shoot it.",
    use = function()
      return "This can only be used with a gun."
    end
  },
  {
    name = "health",
    message = "On the wall is a health kit.",
    examine = "This portable health kit will heal you.",
    take = "You took the health kit. You can use it any time to restore your health.",
    use = function()
      return "You use the health"
    end
  },
  {
    name = "key",
    needs = "finger",
    message = "You see a key hanging from a hook on the wall.",
    examine = "This is a special key. It will unlock the escape pod but it is coded to a person's DNA.",
    take = "You have picked up the key but you will need the person who owns it to use it on the escape pod door.",
    use = function(state)

      if(state.currentRoom.lastRoom == true) then

        state.gameActive = false

        -- TODO end the game and display all the stats
        return "You place the severed finger on the key and it activates. You can now activate the escape pod and live to fight another day."
      else
        return "There is no where you can use this key. Look for the escape pod room."
      end

    end
  },
  {
    name = "bone",
    message = "Sitting in a small pool of blood is a long bone.",
    examine = "It's a bone, you think it may be human. It can also be used as a weapon in a pinch.",
    take = "Against your better judgement, you pick up the bone and take it with you.",
    use = function(state)
      local message = "You swing the bone with all of your strength."

      local bone = ItemInInventory("bone", state)

      print("Use bone", bone)

      -- TODO call attach here

      message = message .. " The bone breaks from the impact."

      RemoveItemFromInventory("bone", state)

      return message
    end
  },
  {
    name = "finger",
    message = "On the floor is a finger.",
    examine = "You don't know who's finger this is but it may be useful later on.",
    take = "You decide to take the finger with you. Who knows, maybe you will find the rest of them somewhere else on the ship",
    use = function(state)

      local message = "You're not sure what to do with the finger?"

      return message

    end
  }
}


function DecorateRooms(map)

  local rooms = map.roomIndex

  SetStartEndPositions(map)

  -- Create a reference to the generic descriptions
  local descriptionIDs = {}

  for i = 1, #textTemplates.genericRoomDescriptions do
    table.insert(descriptionIDs, i)
  end

  -- TODO Add items to the rooms (Need to make sure its not duplicate or in start/end)

  local itemIDs = {}

  -- Skip first item but build a table to reference each item we need
  for i = 2, #randomItems do
    table.insert(itemIDs, i)
  end

  repeat

    local roomID = math.random( #rooms )
    local tmpRoom = rooms[roomID]

    if(tmpRoom.item == nil and tmpRoom.lastRoom ~= true) then
      local tmpItem = randomItems[itemIDs[1]]
      tmpRoom.item = tmpItem
      -- print("Add Item", tmpItem.name, "room", roomID)
      table.remove(itemIDs, 1)
    end

  until( #itemIDs == 0 )

  local terminalIDs = {}

  for i = 2, #textTemplates.terminalMessages do
    table.insert(terminalIDs, i)
  end

  repeat

    local roomID = math.random( #rooms )
    local tmpRoom = rooms[roomID]

    if(tmpRoom.terminal == nil and tmpRoom.lastRoom ~= true) then
      local terminalMessage = textTemplates.terminalMessages[terminalIDs[1]]
      tmpRoom.terminal = terminalMessage
      -- print("Add Item", tmpItem.name, "room", roomID)
      table.remove(terminalIDs, 1)
    end

  until( #terminalIDs == 0 )

  -- TODO Need to go through and find a start room

  -- TODO need to go through and find the main rooms

  -- Loop through all of the rooms and add details to describe them

  for i = 1, #rooms do

    local room = rooms[i]

    -- print("Room", i, room.message)

    -- Look to see if the room has a message
    if(room.message == nil) then
      -- Add the room id to the description if debug mode is true
      -- if(debug == true) then
      room.title = "ROOM #" .. tostring(room.id) .. " ("..tostring(room.pos.x)..","..tostring(room.pos.y) ..")"
      -- end

      -- Find a random message
      local messageID = math.random( #descriptionIDs )

      -- print("messageID", messageID, #descriptionIDs)

      -- Add the message to the room's message
      room.message = textTemplates.genericRoomDescriptions[descriptionIDs[messageID]]

      -- Remove the description from the list
      table.remove(descriptionIDs, messageID)

    end



    -- Add direction messages
    -- AddDirectionMessage(room)


    -- room.
    -- print("Room", room.id, room.north, room.east, room.south, room.west)

  end

end

function GetMessage(room)

  -- Tell the player if they have been in the room before or make the message blank
  local message = room.visited and textTemplates.specialMessages.visited or ""

  -- Add the room's message
  message = message .. room.message

  -- See if there is a terminal
  if(room.terminal) then
    message = message .. textTemplates.specialMessages.terminal
  end

  -- Add the item's message
  if(room.item ~= nil) then
    message = message .. " " .. room.item.message
  end

  -- Add direction message
  message = message .. AddDirectionMessage(room)

  return message

end

function SetStartEndPositions(map)

  local rooms = map.roomIndex

  local roomID = math.random( #rooms )

  local lastRoom = rooms[roomID]

  DecorateLastRoom(lastRoom)

  -- TODO need to make sure you don't start in the last room

  map.firstRoom = map.roomIndex[1]

  -- Add the first random item to the start room
  map.firstRoom.item = randomItems[1]

  map.firstRoom.terminal = textTemplates.specialMessages.firstTerminal
  -- table.remove(randomItems, 1)

  -- TODO need to attempt to walk backwards through the rooms and find a random start position

end

function DecorateLastRoom(room)

  room.lastRoom = true

  -- TODO this is for debugging
  room.title = "LAST ROOM"

  
  room.message = textTemplates.specialMessages.lastRoom

end

function AddDirectionMessage(room)

  local directions = {}

  if(room.north ~= nil) then

    table.insert(directions, "north")

  end

  if(room.east ~= nil) then

    table.insert(directions, "east")

  end

  if(room.south ~= nil) then
    table.insert(directions, "south")

  end

  if(room.west ~= nil) then

    table.insert(directions, "west")

  end

  local directionMessage = " There is a door to the " .. directions[1]

  -- Remove the first item
  table.remove(directions, 1)

  local total = #directions

  for i = 1, total do

    directionMessage = directionMessage .. ", "

    if(i == total) then
      directionMessage = directionMessage .. "and "
    end

    directionMessage = directionMessage .. directions[i]

  end

  directionMessage = directionMessage .. "."

  return directionMessage

end
