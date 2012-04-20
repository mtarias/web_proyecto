class Picture < ActiveRecord::Base
  belongs_to :user
  has_many :picture_comments
  attr_accessible :description, :name, :path
end
