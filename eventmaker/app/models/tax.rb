class Tax < ActiveRecord::Base
  has_many :user_tax
  attr_accessible :amount, :name
end
