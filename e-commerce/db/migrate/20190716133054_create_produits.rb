class CreateProduits < ActiveRecord::Migration[6.0]
  def change
    create_table :produits do |t|
       t.string :nomProduit
      t.float :prix
      t.integer :qteStock
      t.string :image
      t.string :marque
      t.string :remise
      t.references :categorie, null: false, foreign_key: true
      t.timestamps
    end

  end
end
