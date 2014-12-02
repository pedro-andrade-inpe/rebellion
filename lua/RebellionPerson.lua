
function RebellionPerson(model)
	return Agent{
		timeInJail = 0,
		init = function(self)
			rand = Random()
			if rand:number(0,1) < model.initialRebelProbability then
				self.state = REBEL
			else
				self.state = QUIET
			end
			self.riskAversion = rand:number(0, 1)
			self.grievance = rand:number(0, 1) * (1 - model.governmentLegitimacy)
			self.execute = self.normalExecute,
		end,
		jailExecute = function(self)
			self.timeInJail = self.timeInJail - 1
			if self.timeInJail == 0 then
				selfCell = randomWorldTypeCell(cs, function(cell) return cell.state == EMPTY end)
				self:enter(selfCell)
				-- Setting an state, anyway it could be changed down 
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
			if (self.state == QUIET) and (countQuiets < NEEDED_AMOUNT_HOMOLOGS)
				or (self.state == REBEL) and (countRebels < NEEDED_AMOUNT_HOMOLOGS) then
				tryMoveToTypeNeighCell(self, function(cell) return cell.state == EMPTY end)
			end
		end
	}
end

