
function RebellionPeopleSociety(model)
	return Society{
		instance = model.person,
		quantity = math.floor(#model.cs * model.density.people)
	}
end

