--local hasar = {
	--Pistoller
  --  [-619010992] = 50, -- WEAPON_MACHINEPISTOL
    -- [-1076751822] = 16, -- SNS PISTOL
   -- [-771403250] = 30, -- HEAVY PISTOL
    -- [1593441988] = 15, -- COMBAT PISTOL
    -- [453432689] = 18, -- PISTOL 
    -- [-1716589765] = 15, -- PISTOL .50
   -- [137902532] = 15, -- VINTAGEPISTOL
    -- [584646201] = 16, -- AP PISTOL

    --SMG
    -- [171789620] = 38, -- COMBAT PDW
    -- [736523883] = 32, -- SMG
    -- [2024373456] = 32, -- SMG MK2
    -- [-270015777] = 33, -- ASSAULT SMG
    -- [324215364] = 31, -- MICRO SMG
    -- [-1121678507] = 32, -- MINISMG
    -- [3219281620] = 20,

    --Taarruz
    -- [-1357824103] = 44, -- ADVANCED RIFLE
    -- [-1063057011] = 42, -- SPECAIAL RIFLE
    -- [-1074790547] = 40, -- ASSAULT RIFLE
    -- [-2084633992] = 42, -- CARBINE RIFLE
--}

local recoils = {
	[416676503] = 0.34,
	[-957766203] = 0.22,
	[970310034] = 0.17,  
}

Citizen.CreateThread(function()
	while true do 
    Citizen.Wait(0)
        local ply = PlayerPedId()
        SetPedSuffersCriticalHits(ply, false)

        if IsPedArmed(ply, 6) then
			DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        elseif IsPedArmed(ply, 1) then
            N_0x4757f00bc6323cfe(GetHashKey("WEAPON_FLASHLIGHT"), 0.1)   
        else
            N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.35)
		end
		
        if IsPedShooting(ply) then      
            local _,wep = GetCurrentPedWeapon(ply)
            local _,cAmmo = GetAmmoInClip(ply, wep)
			
		--	if hasar[wep] and hasar[wep] ~= 0 then
              --  yenihasar = ((hasar[wep]/100)*25)/10
               -- print(yenihasar)
			--	N_0x4757f00bc6323cfe(wep, yenihasar)
			--end
			
            local GamePlayCam = GetFollowPedCamViewMode()
            local Vehicled = IsPedInAnyVehicle(ply, false)
            local MovementSpeed = math.ceil(GetEntitySpeed(ply))

            if MovementSpeed > 69 then
                MovementSpeed = 69
            end
            Citizen.Wait(50)
            local _,wep = GetCurrentPedWeapon(ply)
            if wep ~= 126349499 then
                local group = GetWeapontypeGroup(wep)
                local p = GetGameplayCamRelativePitch()
                local cameraDistance = #(GetGameplayCamCoord() - GetEntityCoords(ply))

                local recoil = math.random(100,140+MovementSpeed)/100
                local rifle = false

                if group == 970310034 then
                    rifle = true
                end

                if cameraDistance < 5.3 then
                    cameraDistance = 1.5
                else
                    if cameraDistance < 8.0 then
                        cameraDistance = 4.0
                    else
                        cameraDistance = 7.0
                    end
                end

                if Vehicled then
                    recoil = recoil + (recoil * cameraDistance)
                else
                    recoil = recoil * 0.8
                end

                if GamePlayCam == 4 then
                    recoil = recoil * 0.7
                    if rifle then
                        recoil = recoil * 0.1
                    end
                end

                if rifle then
                    recoil = recoil * 0.7
                end

                local rightleft = math.random(4)
                local h = GetGameplayCamRelativeHeading()
                local hf = math.random(10,40+MovementSpeed)/100

                if Vehicled then
                    hf = hf * 2.0
                end

                if rightleft == 1 then
                    SetGameplayCamRelativeHeading(h+hf)
                elseif rightleft == 2 then
                    SetGameplayCamRelativeHeading(h-hf)
                end 
            
                local set = p+recoil

                SetGameplayCamRelativePitch(set,0.8)   
            end 	       	
        end
        
	end
end)