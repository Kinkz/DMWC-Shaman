local DMW = DMW
local Shaman = DMW.Rotations.SHAMAN
local Rotation = DMW.Helpers.Rotation
local Setting = DMW.Helpers.Rotation.Setting
local Player, HP, Buff, Debuff, Spell, Target, Talent, Item, GCD, CDs, HUD, Enemy20Y, Enemy20YC, Enemy30Y, Enemy30YC

local function Locals()
    Player = DMW.Player
    HP = Player.HP
    Buff = Player.Buffs
    Debuff = Player.Debuffs
    Spell = Player.Spells
    Talent = Player.Talents
    Item = Player.Items
    Target = Player.Target or false
    HUD = DMW.Settings.profile.HUD
    CDs = Player:CDs() and Target and Target.TTD > 5 and Target.Distance < 5
    Enemy20Y, Enemy20YC = Player:GetEnemies(20)
    Enemy30Y, Enemy30YC = Player:GetEnemies(30)
    hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant = GetWeaponEnchantInfo()
end

--------------
-- 5 Sec Rule--
--------------
local function FiveSecond()
    if FiveSecondRuleTime == nil then FiveSecondRuleTime = DMW.Time end
    local FiveSecondRuleCount = DMW.Time - FiveSecondRuleTime
    if FiveSecondRuleCount > 6.5 then FiveSecondRuleTime = DMW.Time end
    if Setting("Five Second Rule") and ((FiveSecondRuleCount) >= Setting("Five Second Cutoff") or (FiveSecondRuleCount <= 0.4)) then return true end
    -- print(FiveSecondRuleCount)
end

local function DEF()
    ------------------
    --- Defensives ---
    ------------------
    -- In Combat healing
    if Setting("In Combat Heal") and HP < Setting("Lesser Heal HP") and Player.Combat and not Player.Moving then
        if Spell.LesserHealingWave:Known() then
            if Spell.LesserHealingWave:Cast(Player) then return true end
        elseif Spell.HealingWave:Cast(Player) then
            return true
        end
    end
    if Setting("OOC Healing") and not Player.Combat and not Player.Moving and HP <= Setting("OOC Healing Percent HP") and Player.PowerPct > Setting("OOC Healing Percent Mana") 
    then if Spell.HealingWave:Cast(Player) then return true end end
end


function Shaman.Rotation()
   Locals()
   if OOC() then return true end
   if DEF() then return true end
    
    -- Auto Target Quest Units
    if Setting("Auto Target Quest Units") and Player:AutoTargetQuest(20, true) then return true end
    -- Auto Target
    if Player.Combat and Setting("Auto Target") and Player:AutoTarget(20, true) then return true end 

    -- Rockbiter
    if Setting("Rockbiter Weapon") and Spell.RockbiterWeapon:Known() and not hasMainHandEnchant and Spell.RockbiterWeapon:Cast(Player) then return true end 
    
    -- Lightning Shield
    if Setting("Lightning Shield") and Spell.LightningShield:Known() then
        if Buff.LightningShield:Remain() < 30 and Spell.LightningShield:Cast(Player) then return true end
    elseif Setting("Lightning Shield") and Spell.ImprovedLightningShield:Known() then
        if Buff.ImprovedLightningShield:Remain() < 300 and Spell.ImprovedLightningShield:Cast(Player) then return true end
    end

    ----------------------------------------------------
    -- Enhance DPS Rotation ----------------------------
    ----------------------------------------------------
    if Target and Target.ValidEnemy
    then
        -- EarthShock
       if Setting("Earth Shock") and Target.Distance <= 20 and Player.PowerPct > Setting("Earth Shock Mana") and Target.TTD > 1 then
           if Spell.EarthShock:Cast(Target) then return true end 
       end

       --Flame Shock
       if Setting("Flame Shock") and Target.Distance <= 20 and Player.PowerPct > Setting("Flame Shock Mana") and Target.TTD > 8  and not Debuff.FlameShock:Exist(Target) and Target.CreatureType ~= "Totem" and Target.CreatureType ~= "Elemental" then
           if Spell.FlameShock:Cast(Target) then return true end
       end

       -- Stormstrike
       if Setting("Stormstrike") and Spell.Stormstrike:Cast(Target) then return true end 

       -- Autoattack
       if Setting("Auto Attack") and Target.Distance <= 5 then StartAttack() end
       
       --Lightning Bolt
       if Setting("Lightning Bolt") and not Player.Combat and Target.Facing and Target.Distance >= 20 and not Player.Moving  and not Spell.LightningBolt:LastCast() then
          if Spell.LightningBolt:Cast(Target, 1) then return true end
       end
    end
      
end
