local DMW = DMW
DMW.Rotations.SHAMAN = {}
local Shaman = DMW.Rotations.SHAMAN
local UI = DMW.UI

function Shaman.Settings()
    UI.AddHeader("Personal Healing")
       UI.AddToggle("Combat Healing", nil, true)
       UI.AddRange("Combat Percent HP", nil, 0, 100, 1, 45)
       UI.AddToggle("OOC Healing", nil, true)
	    UI.AddRange("OOC Healing Percent HP", nil, 0, 100, 1, 50)
	    UI.AddRange("OOC Healing Percent Mana", nil, 0, 100, 1, 50)

    UI.AddHeader("Totem Management") 
       UI.AddToggle("Strength of Earth Totem", false)

    UI.AddHeader("Utility")
       UI.AddToggle("Auto Target", "Auto target units when in combat and target dead/missing", false)
       UI.AddToggle("Auto Target Quest Units", nil, true)
       UI.AddToggle("Lightning Shield", nil, true)
       UI.AddToggle("Rockbiter Weapon", nil, true)

    UI.AddHeader("Opener")
       UI.AddToggle("Lightning Bolt","Rank 1 to pull", nil, true)
    
    UI.AddHeader("DPS") 
       UI.AddToggle("Stormstrike",nil,true)
       UI.AddToggle("Earth Shock", nil, true)
       UI.AddRange("Earth Shock Mana", nil, 0, 100, 1, 50)
       UI.AddToggle("Flame Shock", nil, true)
       UI.AddRange("Flame Shock Mana", nil, 0, 100, 1, 50)
       UI.AddToggle("Lightning Bolt In Combat","Use Lightning Bolt until you reach the set Mana Percent (low levels leveling)", nil, false)
       UI.AddRange("Lightning Bolt Mana Percent", nil, 0, 100, 1, 85)  
       UI.AddToggle("Auto Attack", nil, true) 
end