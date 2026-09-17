mori = mori or {}

local cv_enabled = CreateClientConVar("mori_indoor_hearing", "1", true, false, "Deafening/muffle from gunshots in enclosed spaces", 0, 1)
-- How "closed" the space must be (EmitShoot traces 16 directions, score 0..16)
local cv_minInside = CreateClientConVar("mori_indoor_min", "8", true, false, "Min enclosure score (0-16) to count as indoor shot", 1, 16)

-- used by weapon EmitShoot: apply shoot tinnitus when firing in a closed room
function mori.ShouldIndoorShootDeaf(insideVal, wep, hadEarProtection)
	if not cv_enabled:GetBool() then return false end
	if hadEarProtection then return false end
	if IsValid(wep) and (wep.Supressor or wep.NoWINCHESTERFIRE) then return false end
	return (insideVal or 0) >= cv_minInside:GetFloat()
end

-- Extra tinnitus weight for enclosed shots (on top of stock formula)
function mori.IndoorShootTinnitusAdd(insideVal, wep)
	if not mori.ShouldIndoorShootDeaf(insideVal, wep, false) then return 0 end
	-- more enclosed = harder ringing (soft: muffling + ring, not full mute)
	return (insideVal or 0) * 0.4
end
