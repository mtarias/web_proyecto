class User < ActiveRecord::Base
  has_many :user_events
  has_many :events , :through => user_events
  has_many :user_taxs
  has_many :taxs , :through => user_taxs
  has_many :pictures
  has_many :picture_comments
  attr_accessible :email, :facebook_id, :password, :twitter_id
end
