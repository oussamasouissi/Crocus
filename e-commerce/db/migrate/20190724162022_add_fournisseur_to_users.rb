class AddFournisseurToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :description, :string
    add_column :users, :nomSociete, :string
    add_column :users, :status , :string
    add_column :users, :numFournisseur, :string
  end
end
