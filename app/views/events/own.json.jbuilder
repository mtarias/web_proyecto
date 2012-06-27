json.events @events do |json, e|
	json.name e.name
	json.date e.date
	json.place e.place
	json.is_private e.is_private
	json.description e.description
	json.created_at e.created_at
	json.updated_at e.updated_at
end