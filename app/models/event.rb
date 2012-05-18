class Event < ActiveRecord::Base
  has_many :taxs;
  has_many :guests
  has_many :event_comments
  has_many :picture
  attr_accessible :date, :description, :is_private, :name, :place
  validates :name,  :presence => true
  validates :date,  :presence => true
  validate :event_date_cannot_be_in_the_past
  validates :place, :presence => true
  accepts_nested_attributes_for :guests, 
               :allow_destroy => true, :reject_if => :all_blank

  def isgoing?(user_id)
    guests = Guest.find(:all, :conditions => [ 'user_id = ? AND event_id = ? AND is_going= ? ',user_id,
     self.id , true ] )
    guests.size>0 
  end

  def event_date_cannot_be_in_the_past
    if !date.blank? and date < DateTime.current
      errors.add(:date, " debe ser en el futuro")
    end
  end

  def self.future_events
    self.where("date > ?", DateTime.current).order("date ASC")
  end

  def self.past_events
    self.where("date < ?", DateTime.current).order("date DESC")
  end
end
