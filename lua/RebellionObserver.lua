
function RebellionObserver(model)
	if model.display.map == "all" then
		Map{
			subject = model.cs,
			select = "state",
			title = "All agents",
			values = {EMPTY, REBEL, QUIET, COP},
			colors = {"white", "red", "green", "black"}
		}
	elseif model.display.map == "cops" then
		Map{
			subject = model.cs,
			select = "state",
			title = "Cops",
			values = {EMPTY, REBEL, QUIET, COP},
			colors = {"white", "white", "white", "black"}
		}
	elseif model.display.map == "people" then
		Map{
			subject = model.cs,
			select = "state",
			title = "People",
			values = {EMPTY, REBEL, QUIET, COP},
			colors = {"white", "red", "green", "white"}
		}
	elseif model.display.map == "copsAndRebels" then
		Map{
			subject = model.cs,
			select = "state",
			title = "Cops and Rebels",
			values = {EMPTY, REBEL, QUIET, COP},
			colors = {"white", "red", "white", "black"}
		}
	end

	if model.display.peopleTypes then
		Chart{
			subject = model.cs,
			select = {"rebels", "jaileds", "quiets"},
			title = "Number of quiets, rebels and jailed",
			xLabel = "days",
			yLabel = "people",
			colors = {"red", "black", "green"}
		}
	end

	if model.display.worldStates then
		Chart{
			subject = model.cs,
			select = {"rebellionSituations", "repressiveSituations", "utopicSituations"},
			title = "Rebellion World States",
			xLabel = "days",
			yLabel = "amount",
			colors = {"red", "black", "green"}
		}
	end
end

