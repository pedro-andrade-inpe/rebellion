
function RebellionPeopleSociety(model)
	return Society{
		instance = model.people,
		quantity = math.floor(#model.cs * model.density.people)
	}
end

