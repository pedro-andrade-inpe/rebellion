
function RebellionCopsSociety(model)
	return Society{
		instance = model.cop,
		quantity = math.floor(#model.cs * model.density.cops)
	}
end

