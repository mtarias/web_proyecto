class Guest < ActiveRecord::Base
  belongs_to :user 
  belongs_to :event
  attr_accessible :is_admin, :is_going
end
