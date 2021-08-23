class AddConsignmentToDelivery < ActiveRecord::Migration[6.1]
  def change
    add_column :deliveries, :consignment, :bigint
  end
end
