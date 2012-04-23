class User < ActiveRecord::Base
  has_many :user_taxs
  has_many :pictures
  has_many :picture_comments
  has_many :event_comments
  has_many :groups
  has_many :group_members
  has_many :user_events
  attr_accessible :email, :password, :facebook, :twitter
end
