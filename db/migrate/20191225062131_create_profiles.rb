class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :content
      t.string :region
      t.text   :website
      t.integer :user_id
      t.timestamps
    end
  end
end
