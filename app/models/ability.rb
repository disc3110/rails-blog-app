class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all # start by defining rules for all users, also not logged ones
    return unless user.role == 'admin' || user.role == 'default'

    can :create, Post
    can :create, Comment
    can :manage, Post, author_id: user.id # if the user is logged in can manage it's own posts
    can :manage, Comment, author_id: user.id # logged in users can also create comments
    return unless user.role == 'admin' # if the user is a manager we give additional permissions

    can :manage, :all # like managing all comments in the website
  end
end
