class Guest < ActiveRecord::Base
  belongs_to :user 
  belongs_to :event
  attr_accessible :is_admin, :is_going

  def self.is_user_invited?(user, event)
  	!self.get_invitation(user, event).nil?
  end

  # Si existe una invitación, retorna su estado (true/false/nil)
  # Si no hay invitación, retorna nil
  def self.is_user_going(user, event)
  	invitation = self.get_invitation(user, event)
  	unless invitation.nil?
  		invitation.is_going
  	else
  		invitation
  	end
  end

  def self.get_invitation(user, event)
  	invitation = Guest.where(:user_id => user).where(:event_id => event).first
  end

  def self.admins(event)
    self.where(:event_id => event).where(:is_admin => true)
  end
end
