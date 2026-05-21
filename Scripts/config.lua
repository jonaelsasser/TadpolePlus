-- TadpolePlus Configuration File
-- Adjust these values to customize your vehicle performance and inventory sizes.

local CONFIG = {
    -- Base Tadpole Settings (when no chassis is attached)
    BaseTadpole = {
        Speed = 1200.0,           -- Target MaxSwimSpeed (Vanilla is ~1200)
        Acceleration = 2000.0,    -- Target Acceleration (Vanilla is ~2000)
        TurnMultiplier = 1.0      -- Rotation Speed Multiplier (Vanilla is 1.0)
    },
    
    -- Haul Chassis Settings (The cargo variant)
    Haul = {
        InventoryMaxItems = 40,  -- Total number of inventory slots (Vanilla is 30)
        InventoryColumns = 5,     -- Number of columns in the inventory grid (Vanilla is 5)
        Acceleration = 3000.0,    -- Chassis Handling Acceleration
        TurnMultiplier = 1.5,     -- Chassis Strafe/Turn Multiplier
        RemoveSpeedDebuff = false  -- If true, completely strips the vanilla speed penalty
    },
    
    -- ScoutRay Chassis Settings (The scanner/scout variant)
    ScoutRay = {
        InventoryMaxItems = 30,   -- Total number of inventory slots (Default is usually smaller)
        InventoryColumns = 5,     -- Number of columns in the inventory grid
        Acceleration = 2300.0,    -- Chassis Handling Acceleration
        TurnMultiplier = 1.0,     -- Chassis Strafe/Turn Multiplier
        RemoveSpeedDebuff = false  -- If true, completely strips the vanilla speed penalty
    }
}

return CONFIG
