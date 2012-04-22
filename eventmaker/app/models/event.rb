class Event < ActiveRecord::Base
  has_many :taxs;
  has_many :user_events
  has_many :event_comments
  has_many :picture
  attr_accessible :date, :description, :is_private, :name, :place
  validates :name,  :presence => true
  validates :date,  :presence => true
  validates :place, :presence => true
end
