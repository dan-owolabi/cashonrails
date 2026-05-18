class CreateMerchants < ActiveRecord::Migration[7.2]
  def change
    create_table :merchants do |t|
      t.string :business_name, null: false
      t.string :status, default: "pending", null: false
      t.integer :business_id_number
      t.string :reviewed_by
      t.integer :confidence_score
      t.integer :attempts, default: 0

      t.timestamps
    end
  end
end
