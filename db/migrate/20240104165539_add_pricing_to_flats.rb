class AddPricingToFlats < ActiveRecord::Migration[7.1]
  def change
    add_column :flats, :pricing, :decimal
  end
end
