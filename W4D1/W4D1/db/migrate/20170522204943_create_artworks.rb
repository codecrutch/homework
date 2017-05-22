class CreateArtworks < ActiveRecord::Migration
  def change
    create_table :artworks do |t|
      t.string :title, null: false
      t.string :image_url, null: false
      t.integer :artist_id, null: false

      t.timestamps null: false
      t.references :user
    end

    add_index :artworks, [:artist_id, :title], unique: true
    add_index :artworks, :artist_id
  end
end
