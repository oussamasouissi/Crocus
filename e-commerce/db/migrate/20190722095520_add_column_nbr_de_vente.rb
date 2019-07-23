class AddColumnNbrDeVente < ActiveRecord::Migration[6.0]
  def change
    add_column :produits ,:nbrDeVente , :integer ,:default => 0
  end
end
