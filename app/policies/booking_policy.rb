class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    # end
  end

  # def index?
  #   # user_is_owner_of_booking?
  #   # user.present? && user.flats.exists?(id: params[:flat_id])
  # end

  def create?
    user_can_book_flat?
  end

  def update?
    user_is_owner_of_booking?
  end

  def destroy?
    user_is_owner_of_booking? || record.user == user
  end

  private

  def user_can_book_flat?
    record.flat.user != user
  end

  def user_is_owner_of_booking?
    user == record.flat.user
    # user == record&.flat&.user
  end
end
