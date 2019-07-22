class Produit < ActiveRecord::Base
  belongs_to :categorie
  has_many :commande_produits
  has_many :commandes, through: :commande_produits
  has_one_attached :image
 
end
