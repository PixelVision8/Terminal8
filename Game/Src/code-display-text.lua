
--[[
  Pixel Vision 8 - New Template Script
  Copyright (C) 2017, Pixel Vision 8 (http://pixelvision8.com)
  Created by Jesse Freeman (@jessefreeman)

  This project was designed to display some basic instructions when you create
  a new game.  Simply delete the following code and implement your own Init(),
  Update() and Draw() logic.

  Learn more about making Pixel Vision 8 games at https://www.gitbook.com/@pixelvision8
]]--

local display = Display()

function CreateTextDisplay(rect)

  local data = {}

  data.rect = rect
  data.lines = {}
  data.colorOffsets = {}
  data.currentLine = 1
  data.totalLines = 0
  data.textDelay = .02
  data.pauseDelay = 1000
  data.textTime = 0
  data.currentChar = 0
  data.totalChars = 0
  data.nextY = rect.y
  data.drawText = false
  data.paused = false

  return data

end

function UpdateTextDisplay(data, timeDelta)

  data.textTime = data.textTime + timeDelta

  if(data.paused == true) then

    if(Key(Keys.Enter) == true and data.textTime > data.pauseDelay) then

      data.paused = false

      ClearTextDisplay(data)

    end

    return

  end

  if(data.drawText == true) then

    -- Check to see if the enter key is pressed
    if(Key(Keys.Enter) == true and data.currentLine > data.startLine + 1) then

      -- Loop through all of the lines while drawText is true
      while data.drawText and data.paused == false do

        -- Draw the next line
        DrawNextLine(data)

      end

    end

  end


end

function DrawTextDisplay(data)

  if(data.drawText == true and data.paused == false) then

    if(data.textTime > data.textDelay) then

      data.textTime = 0

      DrawNextLine(data)

    end

  end

end

function DrawNextLine(data)
  local line = data.lines[data.currentLine]
  local colorOffset = data.colorOffsets[data.currentLine]
  -- print("offsets", dump(data.colorOffsets))
  
  local char = line:sub(data.currentChar, data.currentChar)

  DrawText(char, data.currentChar * 8, data.nextY, DrawMode.TilemapCache, "large", colorOffset[data.currentChar])

  data.currentChar = data.currentChar + 1

  if(data.currentChar > #line) then
    data.currentChar = 0
    data.currentLine = data.currentLine + 1

    if(data.currentLine > #data.lines) then
      data.drawText = false
    end

    data.nextY = data.nextY + 8

    if(data.drawText == true and data.nextY > (data.rect.y + (data.rect.h - 16))) then

      if(data.paused == false) then

        data.paused = true

        DrawText("...", data.rect.x, data.nextY, DrawMode.TilemapCache, "large", 15)

        -- reset some of the text display's values
        data.nextY = data.rect.y
        data.startLine = data.currentLine
        data.textTime = 0

      end

    end

  end
end

function ClearTextDisplay(data)
  DrawRect(data.rect.x, data.rect.y, data.rect.w, data.rect.h, 0, DrawMode.TilemapCache)

end

function DisplayText(data, text, clear)

  -- clear = clear or true

  -- see if text should be cleared
  if(clear == true) then
    ClearTextDisplay(data)
    data.lines = {}
    data.colorOffsets = {}
    data.currentLine = 1
    data.nextY = data.rect.y
  end

  data.startLine = data.currentLine

  -- Before we can split the lines, we need to create the color map and replace the tokens since each one has additional characters that would throw off the wrapping logic
  local newText, colors = colorizeText(text, 15)

  -- We are going to render the message in a box as tiles. To do this, we need to wrap the text, then split it into lines and draw each line.
  local wrap = WordWrap(newText, (data.rect.w / 8) - 2)

  -- Get the lines
  local newLines = SplitLines(wrap)

  print("lines", dump(newLines))

  local offset = 0

  -- Add the lines
  for i = 1, #newLines do

    -- Get the line
    local line = newLines[i]

    -- Add it to the lines table
    table.insert(data.lines, line)

    -- Since lua doesn't have a way to splice or get a range of values in an array, we need to do this manually
    local colorOffsets = {}

    for j = 1, #line do
      table.insert(colorOffsets, colors[j + offset])
    end

    offset = offset + #line + 1-- +1 for the new line

    table.insert(data.colorOffsets, colorOffsets)

  end

  -- Update the total lines
  data.totalLines = #data.lines

  -- Reset the next y value


  -- Reset the text counter
  -- data.currentLine = 1
  data.currentChar = 1

  -- Start the drawing process
  data.drawText = true
  data.textTime = 0
  data.textDelay = .02

end
