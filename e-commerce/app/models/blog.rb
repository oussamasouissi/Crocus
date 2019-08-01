class Blog < ApplicationRecord
  has_one_attached :image
  belongs_to :categorie

  scope :countCategorieArticle, -> (cat) { where(categorie_id: cat).count() }
end
