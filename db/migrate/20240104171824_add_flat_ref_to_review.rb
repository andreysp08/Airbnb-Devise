class AddFlatRefToReview < ActiveRecord::Migration[7.1]
  def change
    add_reference :reviews, :flat, foreign_key: true
  end
end
