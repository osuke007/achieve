class Ability
  include CanCan::Ability

  def initialize(user)
    if user && user.admin?
         can :access, :rails_admin   # grant access to rails_admin
         can :manage, :all           # allow superadmins to do anything
    end
      # user ||= User.new # guest user (not logged in)
      # if user.admin?
      #   can :manage, :all
      # else
      #   can :read, :all
      # end
  end
end
