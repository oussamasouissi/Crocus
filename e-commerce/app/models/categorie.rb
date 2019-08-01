class Categorie < ApplicationRecord
has_many :produits , dependent: :destroy
has_many :blogs , dependent: :destroy
end
