class Event < ActiveRecord::Base
  has_many :user_events
  attr_accessible :date, :description, :is_private, :name, :place
end
