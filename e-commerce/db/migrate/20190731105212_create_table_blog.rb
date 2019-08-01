class CreateTableBlog < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.string :nom
      t.text :description
      t.references :categorie, null: false, foreign_key: true
      t.timestamps
    end
  end
end
