--[[
  Pixel Vision 8 - New Template Script
  Copyright (C) 2017, Pixel Vision 8 (http://pixelvision8.com)
  Created by Jesse Freeman (@jessefreeman)

  This project was designed to display some basic instructions when you create
  a new game.  Simply delete the following code and implement your own Init(),
  Update() and Draw() logic.

  Learn more about making Pixel Vision 8 games at https://www.gitbook.com/@pixelvision8
]]--

string.lpad = function(str, len, char)
  if char == nil then char = ' ' end
  return string.rep(char, len - #str) .. str
end

table.indexOf = function( t, object )
  if "table" == type( t ) then
    for i = 1, #t do
      if object == t[i] then
        return i
      end
    end
    return - 1
  else
    error("table.indexOf expects table for first argument, " .. type(t) .. " given")
  end
end

function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"'..k..'"' end
      s = s .. '['..k..'] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

function AutoComplete(text, options)

  local matches = {}

  -- TODO should we always default to an option?
  if(text == "") then
    return matches
  end

  for k, v in pairs(options) do
    
    if(string.find(v, text, 1, true) == 1) then
      table.insert(matches, v)
    end

  end

  return matches

end

function string.replaceTokens(text, data)
  
  -- pass the text and data to the `colorizeText()` function and only save the returned text since coloring is ignored.
  local text = colorizeText(text, 0, data)

  -- Return the text
  return text

end

function colorizeText(text, defaultColor, tokens)

  -- local tokens = {}
  local newText = ""
  local colors = {}

  local token = ""
  local inToken = false
  local inColor = false

  local colorString = ""

  for i = 1, #text do

    local char = string.sub(text, i, i)

    -- Look to see if we are at the start of a token
    if char == "{" then

        inToken = true

    -- Look to see if we are at the end of a token
    elseif char == "}" then

      if(tokens ~= nil) then
      
        token = tokens[token] or token

      elseif(colorString == "") then
        
        -- This is a special case to take into account for a token in the text or just come characters wrapped in open and closed brakes
        colorString = tostring(defaultColor)
        token = "{" .. token .. "}"

      end

      -- Time to apply the color so convert the color string into a number  
      local color = tonumber(colorString)

      -- Add the token to the text
      newText = newText .. token

      -- Add the color to the colors table for each character in the token
      for j = 1, #token do
        table.insert(colors, color)
      end

      -- Reset all of the flags since we are out of a token now
      inToken = false
      inColor = false
      token = ""
      colorString = ""

    -- Look to see if we have a colon and are inside of a token
    elseif char == ":" and inToken then

      -- Flag that we are now in a color
      inColor = true

    elseif inColor then

      -- Add the character to the color string
      colorString = colorString .. char

    else

      -- Look to see if we are inside of a token
      if inToken then

        -- Add the character to the token
        token = token .. char

      else

        -- Add the character to the newText
        newText = newText .. char

        -- Add the default color to the colors table
        table.insert(colors, defaultColor)

      end

    end

  end

  return newText, colors

end