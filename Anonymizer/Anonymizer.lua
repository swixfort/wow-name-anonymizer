CAPsyeudonyms = {}
ChatAnonymizer = {}
local mod = ChatAnonymizer
mod.loglevel = {
  info = {
    name = "INFO",
    level = 0
  },
  debug = {
    name = "DEBUG",
    level = 1
  }
}
mod.log_output_level = mod.loglevel.info.level

mod.currentRealm = GetRealmName()

function mod:log(text, level)
  level = level or mod.loglevel.debug
  if level.level <= mod.log_output_level then
    DEFAULT_CHAT_FRAME:AddMessage(level.name .. ' -- ' .. text)
    return true
  end
  return false
end

function mod:setPseudonym(value, player)
  mod:log('Adding pseudonym ' .. value .. ' for player ' .. player, mod.loglevel.info)
  CAPsyeudonyms[player] = value
end

function mod:onChatMessage(event, msg, author, ...)
  local args = { ... }
  if not CAPsyeudonyms[author] then
    local localizedClass, englishClass, localizedRace, englishRace, sex, name, realm = GetPlayerInfoByGUID(args[10])
    local pseudonym = localizedClass .. math.random(1000, 9999)
    mod:setPseudonym(pseudonym, author)
  end

  return false, gsub(msg, author, CAPsyeudonyms[author]), CAPsyeudonyms[author], ...
end

function mod:init()
  ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", mod.onChatMessage)
  --ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", mod.onChatMessage)
  ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", mod.onChatMessage)
  ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", mod.onChatMessage)
  ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", mod.onChatMessage)
  ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", mod.onChatMessage)
  ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", mod.onChatMessage)
  ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", mod.onChatMessage)
  ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", mod.onChatMessage)
end

mod:init()
