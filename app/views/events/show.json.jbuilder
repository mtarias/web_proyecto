json.name @event.name
json.date @event.date
json.place @event.place
json.is_private @event.is_private
json.description @event.description
json.created_at @event.created_at
json.updated_at @event.updated_at

json.going @going do |json, i|
	json.name i.user.name
end

json.waiting_answer @waiting_answer do |json, i|
	json.name i.user.name
end

json.user_commit @user_commit do |json, commit|
	json.name commit.tax.name
	json.amount_commited commit.amount_user
end

json.remaining_taxes @remaining_taxes do |json, tax|
	json.name tax.name
	json.remaining_amount tax.remaining_amount
end
