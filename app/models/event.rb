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

  def isgoing?(user_id)
    guests = Guest.find(:all, :conditions => [ 'user_id = ? AND event_id = ? AND is_going= ? ',user_id,
     self.id , true ] )
    guests.size>0 
  end
end
