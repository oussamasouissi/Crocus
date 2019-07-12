class AddUserNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :UserName, :string
  end
end
