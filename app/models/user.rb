class User < ActiveRecord::Base
  has_many :user_taxs
  has_many :pictures
  has_many :picture_comments
  has_many :event_comments
  has_many :groups
  has_many :group_members
  has_many :user_events
  attr_accessible :email, :password, :facebook, :twitter
  validates :email,  :presence => true, :uniqueness => true
  validates :password,  :presence => true, :length => {:within => 6..40}
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
   	:message    => ' debe ser valido'
end
