class ChangeProductRemiseAttributeType < ActiveRecord::Migration[6.0]
  def change
    change_column  :produits, :remise , :integer
  end
end
