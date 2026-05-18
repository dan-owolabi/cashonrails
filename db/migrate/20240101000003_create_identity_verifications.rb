class CreateIdentityVerifications < ActiveRecord::Migration[7.2]
  def change
    create_table :identity_verifications do |t|
      t.references :merchant, null: false, foreign_key: true
      t.references :admin_user, null: false, foreign_key: true
      t.string :id_type, null: false       # "bvn" or "nin"
      t.string :id_number, null: false
      t.string :full_name
      t.date :date_of_birth
      t.string :phone_number
      t.string :gender
      t.string :image_url
      t.string :status, default: "pending" # pending, verified, failed
      t.json :raw_response
      t.string :provider, default: "samson"

      t.timestamps
    end

    add_index :identity_verifications, [:id_type, :id_number]
    add_index :identity_verifications, :status
  end
end
