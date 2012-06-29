class Event < ActiveRecord::Base
  has_many :taxes, :class_name => 'Tax', :dependent => :destroy
  has_many :guests
  has_many :event_comments, :dependent => :destroy
  has_many :pictures
  attr_accessible :date, :description, :is_private, :name, :place
  validates :name,  :presence => true
  validates :date,  :presence => true
  validate :event_date_cannot_be_in_the_past
  validates :place, :presence => true
  accepts_nested_attributes_for :guests, 
               :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :taxes

  def isgoing?(user_id)
    Guest.is_user_going(user_id, self.id)
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

  def admins_to_s
    list_admin = ""
    Guest.admins(self.id).each do |adm|
      user = User.find(adm.user_id)
      if list_admin.blank?
        list_admin = "#{user.name}"
      else
        list_admin = "#{list_admin}, #{user.name}"
      end
    end
    list_admin
  end

  def number_of_admins
    Guest.where(:event_id => self.id).where(:is_admin => true).size
  end
end
