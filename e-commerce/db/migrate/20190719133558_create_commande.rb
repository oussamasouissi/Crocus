class CreateCommande < ActiveRecord::Migration[6.0]
  def change
    create_table :commandes do |t|
      t.string   :etat
      t.integer  :quantité
      t.integer  :user_id

      t.timestamps

    end
  end
end
