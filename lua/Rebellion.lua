

Rebellion = Model{
	iterations = 365,
	delay = 1,
	display = {
		map = Choice{"all", "cops", "people", "copsAndRebels"},
		worldStates = true,
		peopleTypes = true
	},
	governmentLegitimacy = 0.25,
	rebelProbability = 0.3,
	maxJailTime = 10,
	visibilityRadius = 3,
	copsSuperiority = 2,
	rebellingThreshold = 1,
	grid = {
		width = 40,
		height = 40
	},
	density = {
		cops = 0.04,
		people = 0.7
	},
	check = function(model)
		verify(model.density.cops + model.density.people < 0.9, "Sum of initial density too high. It should be less than 0.9.")
	end,
	init = function(model)
		model.cs        = RebellionCellularSpace(model)
		model.cop       = RebellionCop(model)
		model.person    = RebellionPerson(model)
		model.socCops   = RebellionCopsSociety(model)
		model.socPeople = RebellionPeopleSociety(model)
		model.env       = RebellionEnvironment(model)
		model.timer     = RebellionTimer(model)
		RebellionObserver(model)
	end,
	interface = function()
		return{
			{"grid", "number"},
			{"density", "display"}
		}
	end
}

