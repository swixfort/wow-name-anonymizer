CAPsyeudonyms = {}
ChatAnonymizer = {}
local mod = ChatAnonymizer
mod.DEBUG = "DEBUG"
--local frame = CreateFrame("FRAME");
--frame:RegisterEvent("ADDON_LOADED");
--frame:RegisterEvent("PLAYER_LOGOUT");

--function frame:OnEvent(event, arg1)
--    if event == "ADDON_LOADED" and arg1 == "Anon" then
--        ChatFrame1:AddMessage('Logging: ADDON_LOADED')
--    end
--end
--frame:SetScript("OnEvent", frame.OnEvent);

mod.currentRealm = GetRealmName()

function mod:log(text, level)
    level = level or 'DEBUG'
    ChatFrame1:AddMessage(level .. ' -- ' .. text)
end


function mod:setPseudonym(value, player)
    mod:log('Adding pseudonym _' .. value .. '_ for player' .. player, "INFO")
    CAPsyeudonyms[player] = value
end

function mod:onChatMessage(event, msg, author, ...) --language, prefixedChannel, arg5, arg6, arg7, arg8, arg9, arg10, arg11, guid, arg13, isMobile, arg15, arg16, ...)
  mod:log("onChatMessage")
  mod:log("event: " .. event)
  mod:log("arg1: " .. msg)
  mod:log("arg2: " .. author) -- "Charname-Realm
  --mod:log("arg3: " .. language)
  --mod:log("arg4: " .. prefixedChannel) -- 4. Trade
  --mod:log("arg5: " .. arg5)
  --mod:log("arg6: " .. arg6)
  --mod:log("arg7: " .. arg7)
  --mod:log("arg8: " .. arg8) -- channel number
  --mod:log("arg9: " .. arg9) -- channel name without the number in front...
  --mod:log("arg10: " .. arg10)
  -- mod:log("arg11: " .. arg11) -- = function1 (self, event, ...)
  --mod:log("arg12: " .. guid)
  --mod:log("arg13: " .. arg13)
  --mod:log("arg14: " .. isMobile) -- bool
  --mod:log("arg15: " .. arg15) -- nil?
  -- mod:log("arg16: " .. arg16) -- nil?
    --if not CAPsyeudonyms[author] then
    --    mod:setPseudonym('Potzblitz', author)
    --end

    return false, gsub(msg, author, "HAHA"), CAPsyeudonyms[author], ...
end

function mod:init()
   ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", mod.onChatMessage)
   ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", mod.onChatMessage)
   --ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", mod.onChatMessage)
end

mod:init()