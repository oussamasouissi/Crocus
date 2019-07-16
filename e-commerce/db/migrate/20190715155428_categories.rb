class Categories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories
    add_column :categories, :nomCategorie , :string
  end
end
