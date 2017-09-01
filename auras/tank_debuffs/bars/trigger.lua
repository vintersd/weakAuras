-- Trigger state updater
function(allstates)
    for _, v in pairs(allstates) do
        v.show = false;
        v.changed = true;
    end
    for unit in aura_env.GroupMembers() do
        if UnitIsVisible(unit) and UnitGroupRolesAssigned(unit)=="TANK" then
            allstates[unit] = allstates[unit] or {};
            local state = allstates[unit];
            -- Get player name/class
            state.name = string.sub(UnitName(unit),1,4)
            local _, class = UnitClass(unit)
            local _,_,_,classColor = GetClassColor(class)
            state.name = string.format("|c%s%s|r", classColor, state.name)

            -- Get debuff information
            for i=1,40 do
                local name, _, icon, count, _, duration, expires, source, _, _, spellID, _, _, _, _, timeMod, value1, value2, value3 = UnitDebuff(unit, i)
                if spellID and aura_env.debuffs[spellID] then

                    local timeLeft = (expires - GetTime()) / timeMod
                    local tanking = nil
                    if UnitExists(source) and not UnitIsDead(source) then
                        tanking,_,_,_,_ = UnitDetailedThreatSituation(unit,source)
                    end
                    local stacksTooHigh = aura_env.debuffs[spellID] > 0 and count >= aura_env.debuffs[spellID] or aura_env.debuffs[spellID]==1
                    local exploding = aura_env.debuffs[spellID] == -1
                    local needsTaunt = tanking and (stacksTooHigh or exploding)
                    -- update display
                    if tanking then
                        state.name = string.format(">%s<",state.name)
                    end
                    state.ID = unit
                    state.show = true
                    state.changed = true
                    state.icon = icon
                    state.progressType = "static"
                    state.value = timeLeft
                    state.total = duration
                    state.stacks = count
                    state.needsTaunt = needsTaunt
                    state.exploding = exploding
                    state.tanking = tanking
                    state.timeLeft = string.format("%.1f",state.value)
                end
            end
        end
    end
    return true
end
