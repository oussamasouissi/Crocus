class AddCategorieType < ActiveRecord::Migration[6.0]
  def change
    add_column :categories , :categorieType , :string
  end
end
