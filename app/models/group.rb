class Group < ActiveRecord::Base
  has_many :group_members
  belongs_to :user
  attr_accessible :group_name

  def self.search(user_id, search)
  	Group.where(:user_id => user_id).where(['group_name LIKE ?', "%#{search}%"]).first
  end
end
