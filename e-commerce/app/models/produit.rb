class Produit < ActiveRecord::Base
  belongs_to :categorie
  has_one_attached :image
  def prixApresRemise(produit)

     produit.prix - (produit.prix * produit.remise / 100)
  end
  scope :filtreMarque, -> (marque) { where marque: marque }
  scope :filtreCrPrix, ->  { order(prix: :asc) }
  scope :filtreDcrPrix, ->  { order(prix: :desc) }


end
