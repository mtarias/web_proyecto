class Tax < ActiveRecord::Base
  belongs_to :event
  has_many :user_tax
  validates :amount, :presence => true
  validates :name,  :presence => true
  attr_accessible :amount, :name
end
