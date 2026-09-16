hg = hg or {}
hg.organism = hg.organism or {}

function hg.organism.GetRawStress(org)
	if not org or org.otrub then return 0 end

	local fear = math.max(tonumber(org.fear) or 0, 0)
	local adren = math.Clamp((tonumber(org.adrenaline) or 0) / 2.5, 0, 1)
	local heartbeat = tonumber(org.heartbeat) or 70
	local hb = math.Clamp((heartbeat - 95) / 90, 0, 1)
	local shock = math.Clamp((tonumber(org.shock) or 0) / 50, 0, 1)

	return math.Clamp(fear * 0.5 + adren * 0.22 + hb * 0.18 + shock * 0.1, 0, 1)
end

-- High recoilmul (civilian) -> full effect; trained (low) -> muted
function hg.organism.GetInexperience(org)
	if not org then return 1 end
	local rm = tonumber(org.recoilmul) or 1
	return math.Clamp(math.Remap(rm, 0.45, 1.05, 0.12, 1), 0.12, 1)
end

function hg.organism.GetStressEffect(org)
	return hg.organism.GetRawStress(org) * hg.organism.GetInexperience(org)
end

function hg.organism.UpdateStress(org)
	if not org then return 0 end

	local prev = org.stress or 0
	local stress = hg.organism.GetRawStress(org)
	org.stress_prev = prev
	org.stress = stress
	org.stress_effect = stress * hg.organism.GetInexperience(org)

	return stress
end

function hg.stressed(ply)
	if not IsValid(ply) or not ply.organism then return end
	local stress = ply.organism.stress
	if not stress then
		stress = hg.organism.GetRawStress(ply.organism)
	end
	return (stress or 0) > 0.45
end
