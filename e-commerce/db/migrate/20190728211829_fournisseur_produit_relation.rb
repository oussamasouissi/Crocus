class FournisseurProduitRelation < ActiveRecord::Migration[6.0]
  def change
    add_reference :produits , :user
  end
end
