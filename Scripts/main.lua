-- TadpolePlus Mod for Subnautica 2
-- Enhances the Tadpole and its chassis with custom speed, handling, and inventory settings.

local CONFIG = require("config")

print("[TadpolePlus] Mod loaded.")

local BuffedChassisData = {}

local function buffChassisDataAsset(assetPath, config)
    if BuffedChassisData[assetPath] then return end

    local chassisData = StaticFindObject(assetPath)
    if not chassisData or not chassisData:IsValid() then return end

    pcall(function() chassisData.MaxSwimAcceleration = config.Acceleration end)
    pcall(function() chassisData.MaxWalkAcceleration = config.Acceleration end)
    pcall(function() chassisData.AngularAcceleration = chassisData.AngularAcceleration * config.TurnMultiplier end)
    pcall(function() chassisData.StrafeSpeedModifier = chassisData.StrafeSpeedModifier * config.TurnMultiplier end)

    if config.RemoveSpeedDebuff then
        local ok, effects = pcall(function() return chassisData.GrantedEffects end)
        if ok and effects then
            local goodEffects = {}
            for i = 1, #effects do
                local effect = effects[i]
                local effectName = ""
                pcall(function() effectName = tostring(effect:GetPathName()) end)

                local lower = effectName:lower()
                if not string.find(lower, "speed") and not string.find(lower, "slow") and not string.find(lower, "debuff") then
                    table.insert(goodEffects, effect)
                end
            end

            pcall(function()
                effects:Clear()
                for _, effect in ipairs(goodEffects) do
                    effects:Add(effect)
                end
            end)
        end
    end

    BuffedChassisData[assetPath] = true
end

local function modifyInventory(chassis, config)
    if not chassis:IsValid() then return end

    local inventoryComp = chassis.UWEInventory
    if not inventoryComp or not inventoryComp:IsValid() then return end

    local okSet = pcall(function()
        inventoryComp:SetMaxItems(config.InventoryMaxItems)
    end)
    if not okSet then
        inventoryComp.MaxItems = config.InventoryMaxItems
    end

    inventoryComp.Columns = config.InventoryColumns
end

local function buffTadpoleSpeed(tadpole)
    if not tadpole:IsValid() then return end

    local config = CONFIG.BaseTadpole

    local movementSet = tadpole.MovementSetComponent
    if movementSet and movementSet:IsValid() then
        pcall(function() movementSet:SetBaseSwimSpeed(config.Speed) end)
        pcall(function() movementSet:SetBaseWalkSpeed(config.Speed) end)
        pcall(function() movementSet:SetRotationSpeedMultiplier(config.TurnMultiplier) end)
    end

    local moveComp = tadpole.CharMoveComp
    if moveComp and moveComp:IsValid() then
        moveComp.MaxAcceleration = config.Acceleration
        moveComp.MaxSwimAcceleration = config.Acceleration
        moveComp.BrakingDecelerationSwimming = config.Acceleration * 0.5
    end

    ExecuteWithDelay(2000, function()
        if tadpole:IsValid() then
            buffTadpoleSpeed(tadpole)
        end
    end)
end

local function applyExistingVehicleBuffs()
    buffChassisDataAsset("/Game/Data/VehicleChassis/DA_Haul_TadpoleChassis.DA_Haul_TadpoleChassis", CONFIG.Haul)
    buffChassisDataAsset("/Game/Data/VehicleChassis/DA_ScoutRay_TadpoleChassis.DA_ScoutRay_TadpoleChassis", CONFIG.ScoutRay)

    local ok, hauls = pcall(function() return FindAllOf("BP_Haul_TadpoleChassis_C") end)
    if ok and hauls then
        for _, haul in ipairs(hauls) do
            if haul:IsValid() then
                modifyInventory(haul, CONFIG.Haul)
            end
        end
    end

    local okScout, scouts = pcall(function() return FindAllOf("BP_ScoutRay_TadpoleChassis_C") end)
    if okScout and scouts then
        for _, scout in ipairs(scouts) do
            if scout:IsValid() then
                modifyInventory(scout, CONFIG.ScoutRay)
            end
        end
    end

    local okTadpoles, tadpoles = pcall(function() return FindAllOf("BP_Tadpole_C") end)
    if okTadpoles and tadpoles then
        for _, tp in ipairs(tadpoles) do
            if tp:IsValid() then
                buffTadpoleSpeed(tp)
            end
        end
    end
end

NotifyOnNewObject("/Game/Blueprints/Vehicle/Tadpole/BP_Haul_TadpoleChassis.BP_Haul_TadpoleChassis_C", function(CreatedObject)
    buffChassisDataAsset("/Game/Data/VehicleChassis/DA_Haul_TadpoleChassis.DA_Haul_TadpoleChassis", CONFIG.Haul)
    ExecuteWithDelay(500, function()
        if CreatedObject:IsValid() then
            modifyInventory(CreatedObject, CONFIG.Haul)
        end
    end)
end)

NotifyOnNewObject("/Game/Blueprints/Vehicle/Tadpole/BP_ScoutRay_TadpoleChassis.BP_ScoutRay_TadpoleChassis_C", function(CreatedObject)
    buffChassisDataAsset("/Game/Data/VehicleChassis/DA_ScoutRay_TadpoleChassis.DA_ScoutRay_TadpoleChassis", CONFIG.ScoutRay)
    ExecuteWithDelay(500, function()
        if CreatedObject:IsValid() then
            modifyInventory(CreatedObject, CONFIG.ScoutRay)
        end
    end)
end)

NotifyOnNewObject("/Game/Blueprints/Vehicle/BP_Tadpole.BP_Tadpole_C", function(CreatedObject)
    ExecuteWithDelay(500, function()
        if CreatedObject:IsValid() then
            buffTadpoleSpeed(CreatedObject)
        end
    end)
end)

NotifyOnNewObject("/Game/Blueprints/Core/BP_SN2PlayerCharacter.BP_SN2PlayerCharacter_C", function()
    ExecuteWithDelay(5000, applyExistingVehicleBuffs)
end)
