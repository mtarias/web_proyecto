class UserTax < ActiveRecord::Base
  belongs_to :user
  belongs_to :tax
  validates :amount_user, :presence => true
  attr_accessible :amount_user, :tax_id

  def self.user_commit(user_id, tax_id)
  	self.where(:tax_id => tax_id).where(:user_id => user_id)
  end

  def self.all_commits(tax_id)
  	sum = 0
  	self.where(:tax_id => tax_id).each do |c|
  		sum += c.amount_user
  	end
  	sum
  end
end
