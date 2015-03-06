
--- Create a CellularSpace for the Rebellion Model.
-- @param visibilityRadius Radius used to create the neighborhood for the CellularSpace.
-- @param grid A table with two values, width and height, to define the CellularSpace.
RebellionCellularSpace = function(model)
	local baseCell = Cell{
		state = EMPTY
	}

	local cs = CellularSpace{
		instance = baseCell,
		xdim = model.grid.width,
		ydim = model.grid.height,
		persons = 0,
		cops = 0,
		quietd = 0,
		rebeld = 0,
		jaileds = 0,
		rebellionSituations = 0,
		repressiveSituations = 0,
		utopicSituations = 0,
		resetWorldStatistics = function(self)
			self.rebellionSituations = 0
			self.repressiveSituations = 0
			self.utopicSituations = 0
		end,
		getEmptyCell = function(self)
			local t = Trajectory{select = function(cell) return cell.state == EMPTY end}
			return t:sample()
		end,
		--- Try to find a random cell in the world with a type specified by condition
		randomWorldTypeCell = function(self, condition)
			local count = 0
			cells = {}
			forEachCell(self, function(cell)
				if condition(cell) then
					count = count + 1
					cells[count] = cell
				end
			end)
			verify(count > 0, "randomWorldTypeCell haven't found anything")
			return cells[getRandomInclusiveInteger(1, count)]
		end
	}

	cs:createNeighborhood{
		strategy = "mxn",
		m = model.visibilityRadius,
	}

	return cs
end


