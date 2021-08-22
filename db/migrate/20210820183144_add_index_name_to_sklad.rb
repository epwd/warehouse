class AddIndexNameToSklad < ActiveRecord::Migration[6.1]
  def change
    add_index :sklads, :name, unique: true
  end
end
