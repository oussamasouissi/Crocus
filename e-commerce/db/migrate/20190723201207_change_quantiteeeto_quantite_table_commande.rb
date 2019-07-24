class ChangeQuantiteeetoQuantiteTableCommande < ActiveRecord::Migration[6.0]
  def change
    rename_column :commandes ,:quantité , :quantite
  end
end
