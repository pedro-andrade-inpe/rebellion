

Rebellion = Model{
	iterations = 365,
	delay = 1,
	display = {
		map = {"all", "cops", "people", "copsAndRebels"}
		worldStates = true,
		peopleTypes = true
	},
	governmentLegitimacy = 0.25,
	initialRebelProbability = 0.3,
	maxJailTime = 10,
	visibilityRadius = 2,
	copsSuperiority = 2,
	grid = {
		width = 40,
		height = 40
	},
	initialDensity = {
		cops = 0.04,
		people = 0.7
	},
	check = function(model)
		verify(model.initialDensity.cops + model.initialDensity.people < 0.9, "Sum of initial density too high. It should be less than 0.9.")
	end,
	build = function(model)
		model.cs        = RebellionCellularSpace(model)
		model.cop       = RebellionCop(model)
		model.person    = RebellionPerson(model)
		model.socCops   = RebellionCopsSociety(model)
		model.socPeople = RebellionPeopleSociety(model)
		model.env       = RebellionEnvironment(model)
		model.timer     = RebellionTimer(model)
		RebellionObserver(model)
	end
}

