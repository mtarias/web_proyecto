class User < ActiveRecord::Base
  has_many :user_events
  has_many :user_tax
  attr_accessible :email, :facebook_id, :password, :twitter_id
end
