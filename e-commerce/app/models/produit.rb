class Produit < ActiveRecord::Base
  belongs_to :categorie
  has_many :commande_produits , dependent: :destroy
  has_many :commandes, through: :commande_produits
  has_one_attached :image

  def prixApresRemise(produit)

     produit.prix - (produit.prix * produit.remise / 100)
  end

  def countViewPlusPlus(oldcountview)

    oldcountview+1
  end
  scope :filtreMarque, -> (marque) { where marque: marque }
  scope :filtreCrPrix, ->  { order(prix: :asc) }
  scope :filtreDcrPrix, ->  { order(prix: :desc) }
  scope :filtreDcrCreation, ->  { order(created_by: :desc) }

end
