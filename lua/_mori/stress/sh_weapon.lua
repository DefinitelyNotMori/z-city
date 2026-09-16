mori = mori or {}

-- Returns eye-angle delta for ADS stress shake (Angle or nil)
function mori.GetAimStressWobble(ply, organism, zoomK, oldsights)
	if oldsights then return nil end
	organism = organism or (IsValid(ply) and ply.organism) or {}
	if not hg.organism or not hg.organism.GetStressEffect then return nil end

	local stressFX = hg.organism.GetStressEffect(organism)
	if stressFX <= 0.05 then return nil end

	zoomK = math.max(zoomK or 0, 0.25)
	local breathMul = organism.holdingbreath and 0.2 or 1
	local wobbleAmt = stressFX * zoomK * breathMul * 0.055
	local stressWobble = AngleRand(-wobbleAmt, wobbleAmt)
	stressWobble[3] = 0
	return stressWobble, zoomK
end

function mori.GetRecoilStressMul(org)
	if not org or not hg.organism or not hg.organism.GetStressEffect then return 1 end
	return 1 + math.min(hg.organism.GetStressEffect(org) * 0.28, 0.2)
end

function mori.GetSprayStressMul(org)
	if not org or not hg.organism or not hg.organism.GetStressEffect then return 1 end
	return 1 + math.min(hg.organism.GetStressEffect(org) * 0.35, 0.25)
end
