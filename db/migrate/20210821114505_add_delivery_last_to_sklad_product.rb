class AddDeliveryLastToSkladProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :sklad_products, :delivery_last, :datetime
  end
end
