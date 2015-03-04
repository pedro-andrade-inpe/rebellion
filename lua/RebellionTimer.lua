
function RebellionTimer(model)
	local t = Timer {
		Event{priority = -1, action = function()
			print("day", "rebel", "repress", "utopic")
			print("-------------------------------")
			return false
		end},
		Event{action = call(model.cs, "resetWorldStatistics")},
		Event{priority = 1, action = model.socCops},
		Event{priority = 2, action = model.socPeople},
		Event{priority = 4, action = model.cs},
		Event{priority = 5, action = function(event)
			local worldState = decideOnWorldStatisticsAlarms()
			local rebellionStateString = ""
			local repressiveStateString = ""
			local utopicStateString = ""
			if worldState.rebellionState  then rebellionStateString = "x"  end
			if worldState.repressiveState then repressiveStateString = "x" end
			if worldState.utopicState     then utopicStateString = "x"     end
			print(event:getTime(), rebellionStateString, repressiveStateString, utopicStateString)
		end},
		Event{priority = 6, action = function(event)
			delay(model.delay)
		end}
	}
	return t
end

