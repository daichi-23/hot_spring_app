class CreateOnsens < ActiveRecord::Migration[6.1]
  def change
    create_table :onsens do |t|
      t.string :onsen_name, null: false
      t.string :onsen_image
      t.text :onsen_introduction, null: false
      t.bigint :user_id
      t.string :address, null: false
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
