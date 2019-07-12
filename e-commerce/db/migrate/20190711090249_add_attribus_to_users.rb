class AddAttribusToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :Name, :string
    add_column :users, :CIN, :string
    add_column :users, :téléphone, :string
    add_column :users, :adresse, :string
    add_column :users, :code_postal, :string
    add_column :users, :sexe, :string
    add_column :users, :roles, :string
  end
end
