class DeleteImageAttributeProduct < ActiveRecord::Migration[6.0]
  def change
    remove_column :produits, :image
  end
end
