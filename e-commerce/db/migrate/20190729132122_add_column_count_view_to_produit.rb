class AddColumnCountViewToProduit < ActiveRecord::Migration[6.0]
  def change
    add_column :produits , :countView , :bigint ,default: 0
  end
end
