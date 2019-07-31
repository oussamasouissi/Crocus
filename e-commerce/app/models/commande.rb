class Commande < ApplicationRecord
    belongs_to :user
    has_many :commande_produits , dependent: :destroy
    has_many :produits, through: :commande_produits
    validates  :quantite, presence: true
    validates  :user_id, presence: true

    scope :this_month, -> { where(created_at: Time.now.beginning_of_month..Time.now.end_of_month) }
    scope :countOrderByMonthYear,  -> (m,y) { where( "cast(strftime('%m',created_at) as int) = ?", m).where("cast(strftime('%Y',created_at) as int) = ?", y).count()}
    scope :countCommandeAnnee, -> (y) { where("cast(strftime('%Y',created_at) as int) = ?", y).count()}

    def self.calculPourcentagePassageCommande (countCurrentYear,countLastYear)
        ((countCurrentYear.to_f/countLastYear.to_f)-1 ) *100
    end

end