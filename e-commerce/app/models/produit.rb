class Produit < ActiveRecord::Base
  belongs_to :categorie
  has_one_attached :image
end
