class PictureComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :picture
  attr_accessible :comment
end
