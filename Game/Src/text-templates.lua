local textTemplates ={
    intro = ">TERMINAL\n\n\nTerminal is the empty shell of a text adventure game I am going to try to build in 48 hours, maybe 72 if I run into problems completing the compo.\n\n\nVisit 'pixelvision8.com' to learn about my Fantasy Console.",
    actions = {
        open = "open",
        close = "close",
        start = "start",
        go = "go",
        take = "take",
        examine = "examine",
        use = "use",
        look = "look"
    },
    actionErrors = {
        startFirst = "Start a game first.",
        closeMap = "Close map first.",
        closeTerminal = "Close the terminal first.",
        cantOpen = "You can not open that.",
        cantClose = "You can not close that.",
        cantMove = "You can't go that way.",
        cantLook = "You can't look at that.",
        cantTake = "You can't take that",
        cantExamine = "You can't examine that.",
        cantUse = "You can't use that.",
        need = "You need ${item} to use this."
    },
    mapKey = {
        title = "   MAP           STATS\n\n",
        room = "#",
        visited = " ",
        lastRoom = "X",
        currentRoom = "@",
    },
    inventory = {
        title = "\n\nINVENTORY\n\n"
    },
    stats = {
        health = "health",
        rooms = "rooms",
        steps = "steps ",
        kills = "kills ",
        saved = "saved "
    },
    directions = {
        north = "north",
        south = "south",
        east = "east",
        west = "west"
    },
    terminalMessages = {
        "This is the text for terminal 1.",
        "This is the text for terminal 2.",
        "This is the text for terminal 3.",
        "This is the text for terminal 4."
    },
    genericRoomDescriptions = {
        "You are in a small room.",
        "You are in a large room.",
        "You are in a room full of machines.",
        "You are in a room full of boxes.",
        "You are in a room full of trash.",
        "You are in a room that stinks.",
        "You are in a room that has an echo.",
        "You are in a room without lights.",
        "You are in a room that looks exactly like the last one.",
        "You are in a room that has a low ceiling.",
        "You are in a room that has a high ceiling.",
        "You are in a room with a busted pipe.",
        "You are in a room that has no windows.",
        "You are in a room with a glowing wall.",
        "You are in a room with a glowing floor.",
        "You are in a room with a glowing ceiling.",
        "You are in a room with loud noises.",
        "You are in a silent room.",
        "You are in an empty room.",
        "You are in a room with a small window.",
        "You are in a room with a large window.",
        "You are in a room that has a hole in the floor.",
        "You are in a room that has a hole in the wall.",
        "You are in a room that has a hole in the ceiling.",
        "You are in a room that has scorch marks on the floor.",
        "You are in a room that has scorch marks on the wall.",
        "You are in a room that has scorch marks on the ceiling.",
        "You are in a room that has blood on the floor.",
        "You are in a room that has blood on the wall.",
        "You are in a room that has blood on the ceiling.",
    },
    specialMessages = {
        visited = "It looks like you've been in this room before. ",
        terminal = " On the wall is a terminal.",
        firstTerminal = "This is the first terminal in the game.",
        lastRoom = "You can finish the game in this room.",
        door = " There is a door to the ",
        roomTitle = "ROOM #${roomId} (${roomX},${roomY})"
    }
}


return textTemplates