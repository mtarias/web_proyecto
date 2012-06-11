# encoding: utf-8
class User < ActiveRecord::Base
  has_many :user_taxes, :class_name => 'UserTax', :dependent => :destroy
  has_many :pictures
  has_many :picture_comments
  has_many :event_comments
  has_many :groups
  has_many :group_members
  has_many :guests, :dependent => :destroy
  has_many :events, :through => :guests
  accepts_nested_attributes_for :event_comments, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :guests, :allow_destroy => true, :reject_if => :all_blank
  attr_accessible :email, :password, :password_confirmation, :facebook, :twitter, :name, :time_zone, :locale
  validates :email,  :presence => true, :uniqueness => true
  validates :password,  :presence => true, :length => {:within => 6..40}
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
   	:message    => ' debe ser válido'
  validates_confirmation_of :password

  def self.login(email, password)
    user = self.find_by_email(email)
    if user && password == user.password
      user
    else
      false
    end
  end

  def self.search(search)
    if search
      list = []
      list |= User.where(:email => search)
      list |= User.where(:name => search)
    else
      Array.new
    end
  end

end
