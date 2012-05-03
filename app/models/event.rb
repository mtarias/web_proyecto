class Event < ActiveRecord::Base
  has_many :taxs;
  has_many :guests
  has_many :event_comments
  has_many :picture
  attr_accessible :date, :description, :is_private, :name, :place
  validates :name,  :presence => true
  validates :date,  :presence => true
  validates :place, :presence => true
  accepts_nested_attributes_for :guests, 
               :allow_destroy => true, :reject_if => :all_blank
end
