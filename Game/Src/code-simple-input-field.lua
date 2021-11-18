--[[
  Pixel Vision 8 - New Template Script
  Copyright (C) 2017, Pixel Vision 8 (http://pixelvision8.com)
  Created by Jesse Freeman (@jessefreeman)

  This project was designed to display some basic instructions when you create
  a new game.  Simply delete the following code and implement your own Init(),
  Update() and Draw() logic.

  Learn more about making Pixel Vision 8 games at https://www.gitbook.com/@pixelvision8
]]--

-- This returns a table representing the stat of the input field.
function CreateInputField(rect)

  local data = {
    text = "",
    suggestedTest = "",
    maxChars = math.floor(rect.w / 8),
    blinkTime = 0,
    blinkDelay = 400,
    blink = false,
    blinkChar = "_",
    inputTime = 0,
    inputDelay = 100,
    editing = true,
    rect = rect,
    spriteSize = {x = 8, y = 8},
    actions = {}
  }

  return data

end

-- Updates the input field and saves the state changes back to the data table.
function UpdateInputField(data, timeDelta)

  -- Save the timeDelta on the input field
  data.timeDelta = timeDelta

  if(data.editing == true) then
    
    -- if we are in edit mode, we need to update the cursor blink time
    data.blinkTime = data.blinkTime + data.timeDelta

    if(data.blinkTime > data.blinkDelay) then
      data.blinkTime = 0
      data.blink = not data.blink
    end
    
    -- Capture the user input
    CaptureInput(data)

    -- Capture any key inputs
    KeyCapture(data)

  end

  -- Redraw the display
  DrawInputField(data)

end

function DrawInputField(data)

  if(data.blink == true and data.editing == true) then

    local tmpX = data.rect.x + (#data.text * data.spriteSize.x)

    if(tmpX < data.rect.w) then
      DrawText(data.blinkChar, tmpX, data.rect.y, DrawMode.Sprite, "large", 15)
    end

  end

  if(data.invalid) then

    -- Reset the validation
    data.invalid = false

    -- Look for matches for the auto complete
    local matches = AutoComplete(data.text, gameState.autoComplete)

    -- Find the first suggestion
    data.suggestedTest = data.text

    -- Look to see if there is an auto complete match
    if( #matches > 0 ) then

      local match = matches[1]
      local suggestion = match:sub(#data.text + 1)

      if(#suggestion > 0) then
        suggestion = "{" .. suggestion .. ":5}"
      end
      -- Add the current text plus the rest of the first match while highlighting it.
      data.suggestedTest = data.suggestedTest .. suggestion

      if(data.suggestedTest == match) then
        data.suggestedTest = "{" .. data.suggestedTest .. ":11}"
      end
      
    end

    -- Clear the line
    DrawRect(data.rect.x, data.rect.y, data.rect.w, 8, 0, DrawMode.TilemapCache)

    -- Colorize the text
    local text, colorOffsets = colorizeText(data.suggestedTest, 6)

    -- Draw the text to the display
    DrawColoredText(text, data.rect.x, data.rect.y, DrawMode.TilemapCache, "large", colorOffsets)

  end

end

function KeyCapture(data)

  data.inputTime = data.inputTime + data.timeDelta

  if(data.inputTime > data.inputDelay) then

    data.inputTime = 0

    if(Key(Keys.Back)) then

      data.text = data.text:sub(0, #data.text - 1)

      data.invalid = true

    elseif(Key(Keys.Tab) and #data.suggestedTest > #data.text) then

      local matches = AutoComplete(data.text, gameState.autoComplete)

      if(#matches > 0) then

        data.text = matches[1]

      end

      data.invalid = true

    elseif(Key(Keys.Enter)) then

      SubmitText(data)

    end

  end

end


function CaptureInput(data)

  local lastInput = InputString()

  if(lastInput ~= "") then

    -- Loop through each of the characters to insert them
    for i = 1, #lastInput do

      if(#data.text < data.maxChars) then

        local char = lastInput:sub(i, i):lower()

        -- Look for any special characters in the char
        if(char:match("[^%w%s]") == nil) then

          -- Add the text to the display
          data.text = data.text .. char

          -- Invalidate the input field
          data.invalid = true

        end

      end

    end

  end

end

-- function ClearInputFieldBackground()
  
--   DrawRect(data.rect.x, data.rect.y, data.rect.w, 8, 0, DrawMode.TilemapCache)

-- end

function ClearInputField(data)

  data.text = ""

  data.invalid = true

end

function SubmitText(data)

  if(data.text == "") then
    return
  end

  local words = {}
  for word in data.text:gmatch("%w+") do table.insert(words, word) end

  print("Parse text - total words", #words)

  local actionName = words[1]

  if(data.actions[actionName] ~= nil) then
    print("Found action"..actionName)

    -- Remove the first word
    table.remove(words, 1)

    data.actions[actionName](words)

  end

  ClearInputField(data)

end

function RegisterAction(data, actionName, func)

  data.actions[actionName] = func

end
