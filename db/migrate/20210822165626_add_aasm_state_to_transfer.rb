class AddAasmStateToTransfer < ActiveRecord::Migration[6.1]
  def change
    add_column :transfers, :aasm_state, :string
  end
end
