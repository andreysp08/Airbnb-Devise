class AddAvaliabilityToFlat < ActiveRecord::Migration[7.1]
  def change
    add_column :flats, :avaliability, :integer
  end
end
