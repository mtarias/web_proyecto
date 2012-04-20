class User < ActiveRecord::Base
  attr_accessible :email, :facebook_id, :password, :twitter_id
end
