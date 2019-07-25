class AddMatriculeFiscaleToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :matriculeFiscale, :string
  end
end
