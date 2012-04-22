class UserTax < ActiveRecord::Base
  belongs_to :user
  belongs_to :tax
  attr_accessible :amount_user
end
