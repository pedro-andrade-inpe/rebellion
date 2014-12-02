
function RebellionEnvironment(model)
	local e = Environment{
		model.cs,
		model.socPeople,
		model.socCops
	}

	e:createPlacement{strategy = "random", max = 1}

	forEachAgent(model.socCops, function(agent)
		agent:getCell().state = agent.state
	end)

	forEachAgent(model.socPeople, function(agent)
		agent:getCell().state = agent.state
	end)

	return e
end

