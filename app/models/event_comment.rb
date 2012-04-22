class EventComment < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  attr_accessible :comment
end
