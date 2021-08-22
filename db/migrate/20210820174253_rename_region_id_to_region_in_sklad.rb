class RenameRegionIdToRegionInSklad < ActiveRecord::Migration[6.1]
  def change
    rename_column :sklads, :region_id, :region
    change_column :sklads, :region, :string
  end
end
