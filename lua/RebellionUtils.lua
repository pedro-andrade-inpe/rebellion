
EMPTY = 0
REBEL = 1
QUIET = 2
COP   = 3


function RebellionUtils(model)
	return {
		critical = {
		CRITICAL_NUM_REBELLION = math.floor((VISIBILITY_RANGE ^ 2) * PEOPLE_DENSITY * INITIAL_REBEL_PROB + 1)
		CRITICAL_NUM_REPRESSIVE = math.floor((VISIBILITY_RANGE ^ 2) * COPS_DENSITY + 1)
		CRITICAL_NUM_UTOPIC = math.floor((VISIBILITY_RANGE ^ 2) * PEOPLE_DENSITY * (1 - INITIAL_REBEL_PROB) + 1)

		CRITICAL_NUM_REBELLION_SITUATIONS = math.floor(DIMENSION / VISIBILITY_RANGE) ^ 2
		CRITICAL_NUM_REPRESSIVE_SITUATIONS = math.floor(DIMENSION / VISIBILITY_RANGE) ^ 2
		CRITICAL_NUM_UTOPIC_SITUATIONS = math.floor(DIMENSION / VISIBILITY_RANGE) ^ 2
		},
		NEEDED_AMOUNT_HOMOLOGS = math.floor((VISIBILITY_RANGE ^ 2)/2 + 1),       -- Amount of neighboors for the agent to decide to stay
		REBELLING_THRESHOLD = 0.1       -- Fixed value for the QUIET to/from Rebel transition
	}
end

function getRandomInclusiveInteger(startN, endN)
    local num = math.floor(rand:number(startN, endN + 1))
    if num > endN then  -- avoid strange situations
        num = endN
    end
    return num
end

-- Try to find a random cell in the neighborhood with a type specified by condition
function tryMoveToTypeNeighCell(agent, condition)
    currentCell = agent:getCell()
    destinationCell = currentCell:getNeighborhood():sample()
    if condition(destinationCell) then
        agent:move(destinationCell)
        destinationCell.state = agent.state
        currentCell.state = EMPTY
    end
end

