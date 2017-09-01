function (allstates,event,...)

   if aura_env.debug then
      print("event detected")
   end

   -- Get event information
   local sourceId = select(1,...)
   local spellName = select(2,...)
   local spellId = select(5,...) or 0

   if aura_env.debug then
      print(sourceId,spellName,spellId)
   end

   -- Get player threat status
   local aggro = select(1,UnitDetailedThreatSituation("player",sourceId))
   local makeBar = (aura_env.spells[spellId] and (not aggro)) or debug

   if makeBar
      -- update display information
      local spell,_,_,icon,startTime,endTime,_ = UnitCastingInfo(sourceId)
      local castTime = endTime - startTime
      allstates[spellId] = allstates[spellId] or {}
      local state = allstates[spellId]
      state.progressType = "timed"
      state.duration = castTime * 0.001
      state.expirationTime = GetTime() + castTime*0.001
      state.autoHide = true
      state.icon = icon
      state.changed = true
      state.show = true
      state.target = UnitName(sourceId.."target") or ""
      state.name = spellName
      PlaySoundFile(aura_env.sound)

      if debug then
         local printstr = "Creating bar: %s casting %s on %s"
         print(string.format(printstr,sourceId,spellName,state.target))
      end

   end
   return true
end
