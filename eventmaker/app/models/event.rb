class Event < ActiveRecord::Base
  attr_accessible :date, :description, :is_private, :name, :place
end
