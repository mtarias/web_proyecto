class Tax < ActiveRecord::Base
  belongs_to :event
  has_many :user_tax, :dependent => :destroy
  validates :amount, :presence => true
  validates :name,  :presence => true
  attr_accessible :amount, :name

  def needs_contributions?
  	UserTax.all_commits(:id) < self.amount
  end
end
