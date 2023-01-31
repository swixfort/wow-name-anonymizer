-- Define a table to store the player's pseudonym
local pseudonyms = {}

-- Define a function to handle chat messages
local function OnChatMessage(event, message, sender, ...)
  -- Check if the sender has a pseudonym defined
  if pseudonyms[sender] then
    -- Replace the sender's name with their pseudonym
    message = string.gsub(message, sender, pseudonyms[sender])
  end

  -- Return the modified message
  return false, message, sender, ...
end

-- Register the OnChatMessage function as a handler for the "CHAT_MSG_SAY" event
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", OnChatMessage)

-- Define a function to set the player's pseudonym
local function SetPseudonym(name)
  -- Store the pseudonym for the player in the pseudonyms table
  pseudonyms[UnitName("player")] = name
end

-- Example usage: Set the player's pseudonym to "Anonymouse"
SetPseudonym("Anonymouse")
