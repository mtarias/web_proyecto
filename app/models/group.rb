class Group < ActiveRecord::Base
  has_many :group_members
  belongs_to :user
  attr_accessible :group_name
end
