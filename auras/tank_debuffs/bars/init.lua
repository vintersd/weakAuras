-- Use this to loop through group members
function aura_env.GroupMembers(reversed, forceParty)
    local unit  = (not forceParty and IsInRaid()) and 'raid' or 'party'
    local numGroupMembers = forceParty and GetNumSubgroupMembers()  or GetNumGroupMembers()
    local i = reversed and numGroupMembers or (unit == 'party' and 0 or 1)
    return function()
        local ret
        if i == 0 and unit == 'party' then
            ret = 'player'
        elseif i <= numGroupMembers and i > 0 then
            ret = unit .. i
        end
        i = i + (reversed and -1 or 1)
        return ret
    end
end

-- Debuff whitelist
aura_env.debuffs = {
    [209973] =-1, -- Ablating Explosion
    [209615] = 3, -- Ablation
    [209971] = 2, -- Ablative Pulse
    [215458] = 2, -- Annihilated
    [206641] = 2, -- Arcane Slash
    [211659] = 6, -- Arcane Tether
    [209158] = 3, -- Blackening Soul
    [230201] = 1, -- Burden of Pain
    [231363] =-1, -- Burning Armor
    [206607] = 9, -- Chronometric Particles
    [206651] = 3, -- Darkening Soul
    [236494] = 2, -- Desolated
    [236550] = 1, -- Discorporate
    [210984] = 2, -- Eye of Fate
    [208230] = 1, -- Feast of Blood
    [245509] = 5, -- Felclaws
    [205984] =-1, -- Gravitational Pull
    [231998] = 5, -- Jagged Abrasion
    [239264] = 2, -- Lunar Fire
    [234264] = 0, -- Melted Armor
    [197943] = 0, -- Overwhelm
    [218503] = 6, -- Recursive Strikes
    [197942] = 0, -- Rend Flesh
    [206677] = 5, -- Searing Brand
    [204463] =-1, -- Volatile Rot
    [181157] = 4, -- test
    [209858] = 15, -- Necrotic Rot
}
