class FlatPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
      # scope.where(user: user)
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def map?
    true
  end

  def update?
    record.user == user
    # record: the restaurant passed to the `authorize` method
    # user: the `current_user` signed in with Devise
  end

  def destroy?
    record.user == user
  end

  def autocomplete?
    true
  end

  def mybookings?
    true
  end
end
