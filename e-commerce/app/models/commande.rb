class Commande < ApplicationRecord
    belongs_to :user
    has_many :commande_produits
    has_many :produits, through: :commande_produits
    validates  :quantite, presence: true
    validates  :user_id, presence: true


end