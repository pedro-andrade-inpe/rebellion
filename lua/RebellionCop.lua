
function RebellionCop(agent)
	return Agent{
		state = COP,
		init = function(self)
			rand = Rand()
			tolerance = rand:number(0, 1)
		end,
		jail = function(self, agent)
			local r = Random()
			agent.timeInJail = r:integer(0, model.maxJailTime)
			agent.state = JAIL
			if agent.timeInJail > 0 then
				agent:leave()
				agent.execute = agent.executeJail
			end
		end,
		execute = function(self)
			local rebelsCount = 0
			local rebelsCells = {}
			local copsCount = 0
			local quietsCount = 0
			forEachNeighbor(self:getCell(), function(cell, neigh)
				if neigh.state == COP then
					copsCount = copsCount + 1
				elseif neigh.state == REBEL then
					rebelsCount = rebelsCount + 1
					rebelsCells[rebelsCount] = neigh
				elseif neigh.state == QUIET then
					quietsCount = quietsCount + 1
				end
			end)

			-- Update world states statistics
			doConditionalCountWorldStatistics(rebelsCount, copsCount, quietsCount)
			---------------------------------
			if rebelsCount / (copsCount + 1) <= model.copsSuperiority then
				if rebelsCount > 0 then
					-- Choose the victim
					local r = Random()
					local victimCell = r:sample(rebelsCells)
					-- Imprison it
					local victimAgent = victimCell:getAgent()
					local randNumTolerance = rand:number(0, 1)
					if randNumTolerance < self.tolerance then
						self:jail(victimAgent)
						self:getCell().state = EMPTY
						self:move(victimCell)
						victimCell.state = COP
						return
					end
				end

			    local currentCell = self:getCell()
			    local destinationCell = currentCell:getNeighborhood():sample()
			    if destinationCell.state == EMPTY then
			        self:move(destinationCell)
			        destinationCell.state = self.state
			        currentCell.state = EMPTY
			    end	
			end
		end
	}
end

