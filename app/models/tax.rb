class Tax < ActiveRecord::Base
  belongs_to :event
  has_many :user_tax
  attr_accessible :amount, :name
end
