class AddColumnDetailsTableProduit < ActiveRecord::Migration[6.0]
  def change
    add_column :produits ,:details , :string 
  end
end
