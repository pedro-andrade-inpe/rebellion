
function RebellionPerson(model)
	return Agent{
		timeInJail = 0,
		init = function(self)
			local rand = Random()
			if rand:number(0, 1) < model.rebelProbability then
				self.state = REBEL
			else
				self.state = QUIET
			end
			self.riskAversion = rand:number(0, 1)
			self.grievance = rand:number(0, 1) * (1 - model.governmentLegitimacy)
			self.execute = self.normalExecute
		end,
		jailExecute = function(self)
			self.timeInJail = self.timeInJail - 1
			if self.timeInJail == 0 then
				selfCell = cs:getEmptyCell()
				self:enter(selfCell)
				self.state = QUIET
				self.execute = self.normalExecute
			end
		end,
		normalExecute = function(self)
			local countCops = 0
			local countRebels = 0
			local countQuiets = 0
			selfCell = self:getCell()
			forEachNeighbor(selfCell, function(cell, neigh)
				if neigh.state == COP then
					countCops = countCops + 1
				elseif neigh.state == REBEL then
					countRebels = countRebels + 1
				else
					countQuiets = countQuiets + 1
				end
			end)

			-- Update world states statistics
			doConditionalCountWorldStatistics(rebelsCount, copsCount, quietsCount)

			arrestProbability = 0
			if countCops > countRebels then
				arrestProbability = 0.99
			end

			if self.grievance - self.riskAversion * arrestProbability > model.rebellingThreshold then
				self.state = REBEL
			else
				self.state = QUIET
			end
			self:getCell().state = self.state
			-- The person tries to move
			local neededAmountHomologs = math.floor((model.visibilityRange ^ 2)/2 + 1)
			if (self.state == QUIET and countQuiets < neededAmountHomologs) or (self.state == REBEL and countRebels < neededAmountHomologs) then
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

