json.array! @users do |json, user|
	json.name user.name
	json.language user.locale
	json.timezone user.time_zone
end