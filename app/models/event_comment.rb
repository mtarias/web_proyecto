class EventComment < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  attr_accessible :comment
  accepts_nested_attributes_for :event, :allow_destroy => true
  accepts_nested_attributes_for :user, :allow_destroy => true
end
