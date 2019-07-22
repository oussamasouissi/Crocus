class CreateCommandeProduit < ActiveRecord::Migration[6.0]
  def change
    create_table :commande_produits do |t|
      t.integer :commande_id
      t.integer :produit_id


    end
  end
end
