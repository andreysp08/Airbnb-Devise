class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.new
    # end
  end

  def create?
    is_guest?
  end

  def new?
    is_guest?
  end

  private

  def is_guest?
    record.flat.user != user
  end
end
