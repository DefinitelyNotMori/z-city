mori = mori or {}

mori.phrases = {
	heartbeat_stress = {
		"Fuck... Feels like my heart's about to jump out...",
		"My heart's pounding so hard I can hear it...",
		"Shit— breathe. Just breathe. Heart's going crazy...",
		"Thump-thump-thump... I can't calm down...",
		"God, my chest... everything's racing...",
	},
	acute_pain_stress = {
		"Aah! Fuck-fuck-fuck! That hurts! Aaaagh!",
		"AAH— shit! Make it stop!",
		"Nngh— FUCK! That burned!",
		"Aaaagh! Oh god oh god—",
		"Shit! Shit! That— AAAH!",
	},
	panic_stress = {
		"I can't think— I can't THINK—",
		"Hands won't stop shaking...",
		"Everything's too loud— too fast—",
		"I need to get out. I need to get out NOW.",
		"Please please please don't die don't die...",
		"My vision's tunneling— fuck—",
	},
	stress_relief = {
		"Fuuuh... okay. Okay. Still here...",
		"Alright... heart's slowing down a bit...",
		"Shit... that was close. Breathe...",
		"Okay. I'm okay. I'm... mostly okay.",
		"Finally... a second to think...",
	},
}

function mori.PickPhrase(key)
	local list = mori.phrases and mori.phrases[key]
	if not list or #list == 0 then return "" end
	return list[math.random(#list)]
end
