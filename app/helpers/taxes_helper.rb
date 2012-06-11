module TaxesHelper
	def remaining_amount(tax)
		users_commitments = UserTax.where(:tax_id => tax.id)
		tax_commited = 0
		users_commitments.each do |c|
			tax_commited += c.amount_user
		end
		tax.amount - tax_commited
	end
end
